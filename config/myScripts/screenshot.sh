#!/bin/bash
swaync-client -cp && sleep 0.7 && uwsm app -- grim -g "$(slurp)" - | swappy -f -
