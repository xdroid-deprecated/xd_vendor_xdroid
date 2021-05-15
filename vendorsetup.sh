export AOSP_REVISION=$(grep "default revision" ".repo/manifests/default.xml" | awk -F '/' '{print $3}' | awk -F '"' '{print $1}')
export SKIP_ABI_CHECKS=true

# Welcome Msg
echo "=========================================="
echo " xd. xdroidOS Build Environment "
echo "=========================================="
echo "AOSP Revision: $AOSP_REVISION"