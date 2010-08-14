#!/bin/sh

DIRS="
bin
etc/firmware
etc/permissions
etc/wifi
lib/egl
lib/hw
lib/modules
"

for DIR in $DIRS; do
	mkdir -p proprietary/$DIR 2> /dev/null
done

cd proprietary || exit


FILES="
bin/akmd
bin/btipsd
bin/wpa_supplicant

etc/firmware/avpr.bts
etc/firmware/fmc_init_1273.2.bts
etc/firmware/fm_rx_init_1273.2.bts
etc/firmware/tiinit_7.2.31.bts
etc/firmware/vac_config.ini
etc/firmware/wl1271.bin
etc/firmware/yamato_pfp.fw
etc/firmware/yamato_pm4.fw
etc/wifi/Fw1273_CHIP.bin
etc/wifi/tiwlan.ini
etc/wifi/wpa_supplicant.conf
etc/agps_rm
etc/AudioFilter.csv
etc/AudioPara4.csv
etc/AudioPara4_WB.csv
etc/AudioPara_HTC_FR.csv
etc/AudioPara_HTC_WB_FR.csv
etc/AudioPreProcess.csv
etc/WP_0C0AESN.db
etc/WP_040CFRA.db
etc/WP_0401ARA.db
etc/WP_0404CHT.db
etc/WP_0405CSY.db
etc/WP_0407GER.db
etc/WP_0408GRK.db
etc/WP_0409WWE.db
etc/WP_0410ITA.db
etc/WP_0413NLD.db
etc/WP_0414NOR.db
etc/WP_0415PLK.db
etc/WP_0419RUS.db
etc/WP_0804CHS.db
etc/WP_0816PTG.db

lib/egl/libEGL_adreno200.so
lib/egl/libGLESv1_CM_adreno200.so
lib/egl/libGLESv2_adreno200.so
lib/hw/gralloc.msm7k.so
lib/modules/sdio.ko
lib/modules/tiwlan_drv.ko

lib/libaudioeq.so
lib/libAudioTrimmer.so
lib/libcamera.so
lib/libgps.so
lib/libgsl.so
lib/libhtc_acoustic.so
lib/libhtc_ril.so
lib/libinterstitial.so
lib/libmm-adspsvc.so
lib/libmmclient.so
lib/libmscompress.so
lib/libObexJniWrapper.so
lib/libOlaBase.so
lib/libOmxH264Dec.so
lib/libOmxMpeg4Dec.so
lib/libOmxVidEnc.so
lib/liboemcamera.so
lib/libomx_wmadec_sharedlibrary.so
lib/libomx_wmvdec_sharedlibrary.so
lib/libpvasfcommon.so
lib/libpvasflocalpbreg.so
lib/libpvasflocalpb.so
lib/libspeech.so
"


echo "Waiting for a device..."
adb wait-for-device

for FILE in $FILES; do
	adb pull system/$FILE $FILE
done
