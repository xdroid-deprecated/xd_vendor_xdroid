# AOSP Revision
export AOSP_REVISION=$(grep "default revision" ".repo/manifests/default.xml" | awk -F '/' '{print $3}' | awk -F '"' '{print $1}')
echo "=========================================="
echo "       xdroidOSS Build Environment        "
echo "=========================================="
echo "AOSP Revision: $AOSP_REVISION"
