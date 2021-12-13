#!/bin/sh

pkill -f nwg-wrapper;nwg-wrapper -l2 -s ~/.build/nwg-wrapper/nwg_wrapper/config/date-wttr.sh -r 6000 -c ~/.build/nwg-wrapper/nwg_wrapper/config/date-wttr.css -p right -mt 1000 -j center

