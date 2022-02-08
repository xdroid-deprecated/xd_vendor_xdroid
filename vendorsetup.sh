export AOSP_REVISION=$(grep "default revision" ".repo/manifests/default.xml" | awk -F '/' '{print $3}' | awk -F '"' '{print $1}')

# Welcome Msg
echo -e ==========================================
echo 	 xd. xdroidOS Build Environtment
echo -e ==========================================
echo -e "AOSP Revision: $AOSP_REVISION"
