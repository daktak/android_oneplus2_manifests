#!/bin/bash 
#repo sync --force-broken --force-sync --no-clone-bundle --quiet

. build/envsetup.sh
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
export ANDROID_CCACHE_SIZE="50G"
export ANDROID_CCACHE_DIR="/pub/aokp/android/.ccache"
lunch aokp_oneplus2-userdebug
mka rainbowfarts 
#make clobber && make clean
