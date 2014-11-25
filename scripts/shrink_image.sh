# script to download, shrink, and annotate images
# > get_photo.sh jones.jpg "Bob Jones" http://ex.com/photo.jpg
# leave off the url to do it locally, leave off the credit to not mark it

max_width=330
max_height=280
regex=".* \(JPEG\|PNG\|GIF\) \([0-9]*\)x\([0-9]*\).*"

outname=$1
credit=$2

[ "$outname" ] &&
identify $outname | sed -e "s/$regex/\1 \2x\3/g" && # check that this is an img
if [ `identify $outname | sed -e "s/$regex/\2/g"` -ge $max_width ]; then
  echo "making narrower"
  mogrify -geometry ${max_width}x $outname
fi &&
if [ `identify $outname | sed -e "s/$regex/\3/g"` -ge $max_height ]; then
  echo "making shorter"
  mogrify -geometry x$max_height $outname
fi
