#!/bin/bash
swaync-client -cp && sleep 0.7 && grim -g "$(slurp)" - | tesseract - - -l eng+slv | wl-copy
