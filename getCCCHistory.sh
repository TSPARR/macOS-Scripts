#!/bin/bash
# getCCCHistory.sh
# Gets the history of the last 10 CCC tasks ran

"/Applications/Carbon Copy Cloner.app/Contents/MacOS/ccc" --history | tail -n 10 | column -t -s "|"
