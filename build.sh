#!/bin/bash 
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
#cd device/oneplus/oneplus5
#git fetch https://gerrit.omnirom.org/android_device_oneplus_oneplus5 refs/changes/68/26268/7 && git cherry-pick FETCH_HEAD
dev=$1
if [ -z ${dev} ]; then
  dev=oneplus5
fi
. build/envsetup.sh
#export PATH=/home/daktak/.gentoo/java-config-2/current-user-vm/bin:$PATH
export WITH_SU=true
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 1G
export ANDROID_CCACHE_SIZE="1G"
export ANDROID_CCACHE_DIR="/home/user/android/.ccache"
breakfast ${dev} 
if [ $? -ne 0 ]; then
  exit 1
fi
croot
#if [ -z $2 ]; then
#  mka org.cyanogenmod.platform-res -j2
#fi
#do custom apps first
#for n in `grep + .repo/local_manifests/enabled/device.patch | grep -v ++ | grep -v PRODUCT | grep -v @@ | grep -v device.mk | grep -v wpa | awk '{print $2}'`; do mka ${n}; done
brunch ${dev} > build.log
