/*
  xvisbell: visual bell for X11

  Copyright 2015 Rian Hunter <rian@alum.mit.edu>

  Derived from pulseaudio/src/modules/x11/module-x11-bell.c
  Copyright 2004-2006 Lennart Poettering

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published
  by the Free Software Foundation; either version 3 of the License,
  or (at your option) any later version.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, sett <http://www.gnu.org/licenses/>.
 */

#include <X11/XKBlib.h>
#include <X11/Xlib.h>

#include <iostream>
#include <stdexcept>

#include <cstdlib>

#include <sys/select.h>
#include <sys/time.h>

const struct timeval window_timeout = {0, 100000};

// -1 means for w or h means screen width or height
struct {
  int x, y;
  int w, h;
} geometry = {0, 0, -1, 20};

bool operator<(const struct timeval & a,
               const struct timeval & b) {
  return timercmp(&a, &b, <);
}

struct timeval & operator+=(struct timeval & a, const struct timeval & b) {
  timeradd(&a, &b, &a);
  return a;
}

struct timeval operator-(const struct timeval & a,
                         const struct timeval & b) {
  struct timeval toret;
  timersub(&a, &b, &toret);
  return toret;
}

int main() {
  auto dpy = XOpenDisplay(nullptr);
  if (!dpy) {
    throw std::runtime_error("XOpenDisplay() error");
  }

  auto scr = XDefaultScreen(dpy);
  auto root = XRootWindow(dpy, scr);
  auto vis = XDefaultVisual(dpy, scr);

  auto major = XkbMajorVersion;
  auto minor = XkbMinorVersion;

  if (!XkbLibraryVersion(&major, &minor)) {
    throw std::runtime_error("XkbLibraryVersion() error");
  }

  major = XkbMajorVersion;
  minor = XkbMinorVersion;

  int xkb_event_base;
  if (!XkbQueryExtension(dpy, nullptr, &xkb_event_base,
                         nullptr, &major, &minor)) {
    throw std::runtime_error("XkbQueryExtension() error");
  }

  XkbSelectEvents(dpy, XkbUseCoreKbd, XkbBellNotifyMask, XkbBellNotifyMask);

  unsigned int auto_ctrls, auto_values;
  auto_ctrls = auto_values = XkbAudibleBellMask;

  XkbSetAutoResetControls(dpy, XkbAudibleBellMask, &auto_ctrls, &auto_values);
  XkbChangeEnabledControls(dpy, XkbUseCoreKbd, XkbAudibleBellMask, 0);

  XSetWindowAttributes attrs;
  attrs.background_pixel = WhitePixel(dpy, scr);
  attrs.override_redirect = True;
  attrs.save_under = True;

  auto x11_fd = ConnectionNumber(dpy);

  struct timeval future_wakeup;
  bool timeout_is_set = false;

  auto width = geometry.w < 0 ? DisplayWidth(dpy, scr) : geometry.w;
  auto height = geometry.h < 0 ? DisplayHeight(dpy, scr) : geometry.h;

  auto win = XCreateWindow(dpy, root, geometry.x, geometry.y,
                           width, height, 0,
                           XDefaultDepth(dpy, scr), InputOutput,
                           vis,
                           CWBackPixel | CWOverrideRedirect | CWSaveUnder,
                           &attrs);

  while (true) {
    struct timeval tv, *wait_tv = nullptr;

    fd_set in_fds;
    FD_ZERO(&in_fds);
    FD_SET(x11_fd, &in_fds);

    if (timeout_is_set) {
      // we really should use a monotonic clock here but
      // there isn't really a portable interface for that yet
      // in the future we can ifdef this for mac/linux
      struct timeval cur_time;
      if (gettimeofday(&cur_time, nullptr) < 0) {
        throw std::runtime_error("getttimeofday() error!");
      }

      // c++ magic, in your face linus!
      tv = (future_wakeup < cur_time
            ? timeval{0, 0}
            : future_wakeup - cur_time);
      wait_tv = &tv;
    }

    while (true) {
      if (select(x11_fd + 1, &in_fds, nullptr, nullptr, wait_tv) < 0) {
        if (errno == EINTR) continue;
        throw std::runtime_error("select() error!");
      }
      break;
    }

    if (timeout_is_set) {
      struct timeval cur_time;
      if (gettimeofday(&cur_time, nullptr) < 0) {
        throw std::runtime_error("getttimeofday() error!");
      }

      if (future_wakeup < cur_time) {
        // timeout fired
        XUnmapWindow(dpy, win);
        timeout_is_set = false;
      }
    }

    while (XPending(dpy)) {
      XEvent ev;
      XNextEvent(dpy, &ev);

      // TODO: handle resize events on root window

      // TODO: this reinterpret cast is not good
      if (reinterpret_cast<XkbEvent *>(&ev)->any.xkb_type != XkbBellNotify) {
        continue;
      }

      XMapRaised(dpy, win);

      // reset timeout
      timeout_is_set = true;
      if (gettimeofday(&future_wakeup, nullptr) < 0) {
        throw std::runtime_error("getttimeofday() error!");
      }
      future_wakeup += window_timeout;

      // ignore for now...
      // auto bne = reinterpret_cast<XkbBellNotifyEvent *>(&ev);
    }
  }
}

