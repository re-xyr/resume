stack run >index.html
echo "Generated HTML at index.html"
PDF_SCALE=1
if [ -n "$1" ]; then
  PDF_SCALE=$1
fi
PDF_RENDER_TIMEOUT=2000
if [ -n "$2" ]; then
  PDF_RENDER_TIMEOUT=$2
fi
echo "Rendering PDF at SCALE=$PDF_SCALE, RENDER_TIMEOUT=$PDF_RENDER_TIMEOUT"
node . index.html index.pdf $PDF_SCALE $PDF_RENDER_TIMEOUT
echo "Generated PDF at index.pdf"
