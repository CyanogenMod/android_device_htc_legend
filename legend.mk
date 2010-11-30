#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Kernel Targets
ifeq ($(TARGET_PREBUILT_KERNEL),)
ifeq ($(TARGET_KERNEL_CONFIG),)
TARGET_PREBUILT_KERNEL := device/htc/legend/files/kernel
endif # TARGET_KERNEL_CONFIG
endif # TARGET_PREBUILT_KERNEL

DEVICE_PACKAGE_OVERLAYS := device/htc/legend/overlay


## (1) First, the most specific values, i.e. the aspects that are specific to GSM

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/legend/files/legend-keypad.kl:system/usr/keylayout/legend-keypad.kl \
    device/htc/legend/files/legend-keypad.kcm.bin:system/usr/keychars/legend-keypad.kcm.bin \
    device/htc/legend/files/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl

PRODUCT_COPY_FILES += \
    device/htc/legend/files/init.legend.rc:root/init.legend.rc

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.sf.lcd_density=160 \
    wifi.interface=tiwlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.ril.hsxpa=2 \
    ro.ril.def.agps.mode=2 \
    ro.ril.hsdpa.category=8 \
    ro.ril.hsupa.category=5 \
    ro.ril.disable.fd.plmn.prefix=23402,23410,23411 \
    ro.ril.enable.sdr=0 \
    ro.ril.enable.a52.HTC-ITA=1 \
    ro.ril.enable.a53.HTC-ITA=1 \
    ro.opengles.version=131072

# Default network type.
# 0 => WCDMA preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0

# For emmc phone storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.phone_storage = 0 

# This is a 512MB device, so 32mb heapsize
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=32m

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# Should make scrolling smoother
#PRODUCT_PROPERTY_OVERRIDES += \
#    windowsmgr.max_events_per_sec=60


## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/legend/legend-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    settings.display.autobacklight=1 \
    settings.display.brightness=143 \
    persist.service.mount.playsnd = 0 \
    ro.com.google.locationfeatures = 1 \
    ro.setupwizard.mode=OPTIONAL \
    ro.setupwizard.enable_bypass=1 \
    ro.media.dec.aud.wma.enabled=1 \
    ro.media.dec.vid.wmv.enabled=1 \
    dalvik.vm.dexopt-flags=m=y \
    net.bt.name=Android \
    ro.config.sync=yes

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \

PRODUCT_COPY_FILES += \
    device/htc/legend/files/etc/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_COPY_FILES += \
    device/htc/legend/files/etc/fstab:system/etc/fstab \
    device/htc/legend/files/etc/pvasflocal.cfg:system/etc/pvasflocal.cfg \
    device/htc/legend/files/etc/vold.fstab:system/etc/vold.fstab

PRODUCT_COPY_FILES += \
    device/htc/legend/files/modules/sdio.ko:system/lib/modules/sdio.ko \
    device/htc/legend/files/modules/tiwlan_drv.ko:system/lib/modules/tiwlan_drv.ko \
    device/htc/legend/files/modules/tiap_drv.ko:system/lib/modules/tiap_drv.ko \
    device/htc/legend/files/modules/cifs.ko:system/lib/modules/cifs.ko \
    device/htc/legend/files/modules/aufs.ko:system/lib/modules/aufs.ko \
    device/htc/legend/files/modules/aufs.ko:system/lib/modules/ipv6.ko

PRODUCT_COPY_FILES += \
    device/htc/legend/files/hw/gralloc.msm7k.so:/system/lib/hw/gralloc.msm7k.so

PRODUCT_PACKAGES += \
    librs_jni \
    sensors.legend \
    lights.legend

PRODUCT_LOCALES += mdpi

$(call inherit-product, device/common/gps/gps_eu_supl.mk)
$(call inherit-product, device/htc/common/common.mk)
$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := generic_legend
PRODUCT_DEVICE := legend
