#!/bin/sh
# Disable Atom Auto-Update.sh
# Disables Atom's auto-update functionality to ease deployment

LoggedOnUser=$(logname)

FILE="/Users/$LoggedOnUser/.atom/init.coffee"
DEL_LINE="atom.config.set('core.automaticallyUpdate', true)"
ADD_LINE="atom.config.set('core.automaticallyUpdate', false)"

mkdir -p "/Users/$LoggedOnUser/.atom"

# Create file if it doesn't exist
if [ ! -e "${FILE}" ]; then
  touch "${FILE}"
fi

# Delete line if found
sed -i "" "/${DEL_LINE}/d" "${FILE}"

# Add line if not found
grep -q "${ADD_LINE}" "${FILE}" || echo "${ADD_LINE}" >> "${FILE}"
