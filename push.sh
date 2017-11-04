#~/bin/sh
newfile=~/roms/omni-8.0.0-20171103-microg-oneplus5-HOMEMADE.zip
ftppass=`cat .repo/local_manifests/ftppassword`
lftp ftp://daktak:${ftppass}@192.168.1.140:12345 -e "cd roms; put ${newfile};  bye"

