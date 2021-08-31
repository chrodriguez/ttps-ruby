#!/bin/bash
set -eo pipefail

OUT=/tmp/out.mp4
NUM=${1:?Debe indicar la clase como numero}
FILE=/tmp/video-cover-processed.svg
PNGFILE=/tmp/video-cover-processed.png
sed "s/Categoría del contenido/Teoría/;s/Título del video/Clase $NUM/" video-cover.svg >  $FILE
inkscape -z -w 1920 -h 1080 $FILE -o $PNGFILE
echo Generated $FILE and $PNGFILE

