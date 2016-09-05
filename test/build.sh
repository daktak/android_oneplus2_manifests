#!/bin/bash
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
source build/envsetup.sh
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
export ANDROID_CCACHE_SIZE="50G"
export ANDROID_CCACHE_DIR="/pub/cm13/android/.ccache"
croot
#make clobber && make clean
lunch cm_oneplus2-userdebug
#brunch oneplus2
mka bacon
