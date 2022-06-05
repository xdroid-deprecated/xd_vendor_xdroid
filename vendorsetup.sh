export AOSP_REVISION=$(grep "default revision" ".repo/manifests/default.xml" | awk -F '/' '{print $3}' | awk -F '"' '{print $1}')
export XDROID_BUILD_TYPE=DEV

# Welcome Msg
echo "=========================================="
echo " xd. xdroidOS Build Environment "
echo "=========================================="
echo "AOSP Revision: $AOSP_REVISION"
