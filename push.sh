#~/bin/sh
newfile=~/roms/omni-8.0.0-*-microg-oneplus5-HOMEMADE.zip
ftppass=`cat .repo/local_manifests/ftppassword`
lftp ftp://daktak:${ftppass}@192.168.43.1:12345 -e "cd roms; put ${newfile};  bye"

