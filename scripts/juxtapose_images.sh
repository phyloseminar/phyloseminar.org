
for i in $@; do
  mogrify -geometry x250 $@
done

if [ $# -ne 1 ]; then
  echo "making a montage"
  montage -geometry +0+0 $@ montage.jpg
fi
