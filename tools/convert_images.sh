#!/bin/bash

# Pre-Reqs MACOS
# brew install imagemagick to fetch the "convert" utility
# bash convert_images image.png

INPUT_IMAGE=$1
TEMP_IMAGE=/tmp/tmp_${INPUT_IMAGE}
OUTPUT_CODE=./converted_${INPUT_IMAGE}.txt
RESIZE_TARGET="10x10"

# Resize Image and get the Image Type
if [[ -f  ${INPUT_IMAGE} ]]; then
    # convert image.png -resize 10x10 /tmp/tmp_test
    convert ${INPUT_IMAGE} -resize ${RESIZE_TARGET} ${TEMP_IMAGE}
    IMG_TYPE=$(file --mime-type -b $INPUT_IMAGE)
else
    echo "Input Image: ${INPUT_IMAGE} not found"
    exit 1
fi

# Convert to base 64
if [[ -f ${TEMP_IMAGE} ]]; then
    # -output - prints to stdout
    # base64 -i /tmp/tmp_test -o -
    IMAGEBASE64=$(base64 -i "${TEMP_IMAGE}" -o -)
else
    echo "Temporally file:  ${TEMP_IMAGE} not found"
fi

# Generate code
#echo  "<img src=\"data:image/png;base64,${IMAGEBASE64}\" alt=\"Image\">" | tee ${OUTPUT_CODE}
echo  "lqip: \"data:${IMG_TYPE};base64,${IMAGEBASE64} alt: Image\"" | tee ${OUTPUT_CODE}

# Clean tmp
BASEIMG="$(basename ${TEMP_IMAGE})"
if [[ -f  ${TEMP_IMAGE} ]]; then
  find /tmp -type f -name "${BASEIMG}" -delete
fi