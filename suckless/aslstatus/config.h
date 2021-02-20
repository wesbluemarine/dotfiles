/* text to show if no value can be retrieved */
static const char unknown_str[] = "";

/* maximum output string length */
#define MAXLEN 256
/*
 * if you want to change buffer size for each segment,
 * then change `BUFF_SZ` in util.h
 */


/*
 * function            description                     argument (example)
 *
 * battery_perc        battery percentage              battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_state       battery charging state          battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_remaining   battery remaining HH:MM         battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * cpu_perc            cpu usage in percent            NULL
 * cpu_freq            cpu frequency in MHz            NULL
 * datetime            date and time                   format string (%F %T)
 * disk_free           free disk space in GB           mountpoint path (/)
 * disk_perc           disk usage in percent           mountpoint path (/)
 * disk_total          total disk space in GB          mountpoint path (/")
 * disk_used           used disk space in GB           mountpoint path (/)
 * entropy             available entropy               NULL
 * gid                 GID of current user             NULL
 * hostname            hostname                        NULL
 * ipv4                IPv4 address                    interface name (eth0)
 * ipv6                IPv6 address                    interface name (eth0)
 * kernel_release      `uname -r`                      NULL
 * keyboard_indicators caps/num lock indicators        format string (c?n?)
 *                                                     see keyboard_indicators.c
 * keymap              layout (variant) of current     NULL
 *                     keymap                          (interval must be 1)
 * load_avg            load average                    NULL
 * netspeed_rx         receive network speed           interface name (wlan0)
 * netspeed_tx         transfer network speed          interface name (wlan0)
 * num_files           number of files in a directory  path
 *                                                     (/home/foo/Inbox/cur)
 * ram_free            free memory in GB               NULL
 * ram_perc            memory usage in percent         NULL
 * ram_total           total memory size in GB         NULL
 * ram_used            used memory in GB               NULL
 * run_command         custom shell command            command (echo foo)
 * swap_free           free swap in GB                 NULL
 * swap_perc           swap usage in percent           NULL
 * swap_total          total swap size in GB           NULL
 * swap_used           used swap in GB                 NULL
 * temp                temperature in degree celsius   NULL on OpenBSD
 *                                                     NULL or thermal zone
 *                                                     on Linux
 *                                                     (hwmon0, hwmon1, etc.)
 *                                                     thermal zone on FreeBSD
 *                                                     (tz0, tz1, etc.)
 * uid                 UID of current user             NULL
 * uptime              system uptime                   NULL
 * username            username of current user        NULL
 * vol_perc            OSS/ALSA volume in percent      mixer file (/dev/mixer)
 * wifi_perc           WiFi signal in percent          interface name (wlan0)
 * wifi_essid          WiFi ESSID                      interface name (wlan0)
 *
 * EXTRA INFO:
 *
 * - every arg must ends with `END`
 *
 * - if you want to run function once (for example `hostname`),
 *   then set interval to `ONCE`
 *
 * EXTRA CONFIGS IN:
 *   - battery.c
 *   - volume.c
 */


/* for usleep */
#define SEC * 1000
#define MIN * 60 SEC

#define ONCE ((unsigned int) -1)  /* to run */
static const char IFC[] = "wlan0";  /* wifi interface */

/* temporarily to get sound percentage for pulseaudio */
static const char pulse_volume[] = "pactl subscribe | "
	"stdbuf -oL grep \"Event 'change' on sink #0\" | "
	"(read line && pamixer --get-volume-human; ps --ppid $$ -o pid= |"
	" xargs kill -9)";

static struct arg_t args[] = {

/* function		format			argument						interval (in ms) */
{ netspeed_rx,	"  %sB/s  ",	"enp5s0",						1 SEC,	END },
{ netspeed_tx,	" %sB/s  ",	"enp5s0",						1 SEC,	END },
{ disk_perc,	" %s%%  ",		"/",							1 SEC,	END },
{ temp,			" %s°C" ,		"hwmon1",						1 SEC,	END },
{ cpu_perc,		"%s%%  ",		NULL,							1 SEC,	END },
{ ram_perc,		" %s%%  ",		NULL,							1 SEC,	END },
{ run_command,	" %s ",		"pamixer --get-volume-human",	1,		END },
{ run_command, "%s",			"rec_notify ",					1 SEC,	END },
{ datetime,		" %s",			"%a %d %b %H:%M" },
};
