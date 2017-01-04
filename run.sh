#!/bin/bash
for dev in `cat .repo/local_manifests/device-priority.txt`; do 
.repo/local_manifests/do.sh ${dev} $1
if [ $? -ne 0 ]; then
  exit 1
fi
rm -rf out/target/product/${dev}
echo "$(tail -n +2 .repo/local_manifests/device-priority.txt)" > .repo/local_manifests/device-priority.txt
echo ${dev} >> .repo/local_manifests/device-priority.txt
done
