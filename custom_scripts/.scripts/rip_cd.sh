#! /bin/sh
# Inspired by https://github.com/ResponSySS/xcdda
#
# Written by whothey

reqsw_and_quit()
{
    echo "The following software is required:"
    echo " - cdrdao"
    echo " - cdparanoia"
    echo " - cuetools"

    exit 1;
}

check_required_software()
{
    local REQUIRED_PROG="cdrdao toc2cue cdparanoia cuetag.sh"

    # Check for all required programs
    for PROG in $REQUIRED_PROG; do
        echo -n "Checking for $PROG... "
        which $PROG || reqsw_and_quit;
    done;
}

check_required_software;

echo "Ripping..."

# Extract toc
cdrdao read-toc cd.toc
# TOC -> CUE
toc2cue cd.toc cd.cue
# Rip CD audio to WAV files
cdparanoia -B -L

# Convert WAV files to FLAC
for FILE in track*.wav; do
    ffmpeg -i $FILE ${FILE/\.wav/\.flac}
done;

# Tag FLAC files
cuetag.sh cd.cue track*.flac
