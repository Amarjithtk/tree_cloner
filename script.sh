#!/bin/bash

printf " \n Which rom you want to build today ? : "
read rom
repo init -u https://github.com/$rom/manifest -b pie
printf " \n how many cores does your cpu have ? : "
read cores
repo sync  --force-sync --current-branch --no-tags --no-clone-bundle --optimized-fetch --prune -j$cores

printf " \n Enter Your Device Tree link : "
read DT
printf "\n Enter Your Kernel Tree link : "
read KT
printf "\n Enter Your Vendor Tree link : "
read KT
git clone DT -b pie device/xiaomi/land
git clone KT -b pie kernel/xiaomi/msm8937
git clone VT -b pie vendor/xiaomi

printf "\n You want to clone hals or not : "
read B
if B=y
then
   cd hardware/qcom && rm -rf audio-caf display-caf media-caf && cd ../..
fi

if B=y
then
   git clone https://github.com/Xiaomi-Redmi3S-pie/display-caf.git -b 9.0 hardware/qcom/display-caf/msm8996 && git clone https://github.com/Xiaomi-Redmi3S-pie/media-caf.git -b 9.0 hardware/qcom/media-caf/msm8996 && git clone https://github.com/Xiaomi-Redmi3S-pie/audio-caf -b 9.0 hardware/qcom/audio-caf/msm8996.
fi

printf "\n your device name ? : "
read Device
printf "\n your rom name ? : "
read make
printf "\n what is your rom build command ? : "
read build
printf "\n You want to build directly ? : "
read S

if s=y
then
   . build/envsetup.sh && lunch $make_$Device-userdebug && $build -j12
fi

printf "\n Was everything perfect and ready to upload to sourceforge ? : "
read p

if p=yes
then
    . SF_uploader/sourceforge.sh

fi





