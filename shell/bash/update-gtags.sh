#!/bin/bash

# create gtags
echo "Creating GTAGS..."

# choose gtags path first
if [ -f "${DEST}/files" ]; then
    FILES="${DEST}/files"
    GTAGS="${DEST}/GTAGS"
    GPATH="${DEST}/GPATH"
    GRTAGS="${DEST}/GRTAGS"
# else
    # FILES="-R ."
fi

# process tags by langugage
echo "  |- generate ${TMP}"
${GTAGS_CMD} -f "${FILES}" "${TMP}" 

# replace old file
if [ -f "${TMP}" ]; then
    echo "  |- move ${TMP} to ${TARGET}"
    mv -f "${GTAGS}" "GTAGS"
    mv -f "${GPATH}" "GPATH"
    mv -f "${GRTAGS}" "GRTAGS"
fi
echo "  |- done!"
