#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := msm7k
TARGET_CPU_ABI := armeabi
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200
TARGET_BOOTLOADER_BOARD_NAME := legend
TARGET_HARDWARE_3D := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

BOARD_USES_QCOM_LIBS := true
BOARD_USES_QCOM_HARDWARE := true

BOARD_VENDOR_USE_AKMD := true
BOARD_USE_HTC_APPS := true
BOARD_USES_GENERIC_AUDIO := false
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

BOARD_KERNEL_CMDLINE := no_console_suspend=1 console=null
BOARD_KERNEL_BASE := 0x12C00000

BOARD_GPS_LIBRARIES := libgps librpc

USE_PV_WINDOWS_MEDIA := true

ENABLE_ANIMATED_GIF := true
ALLOW_LGPL := true
USE_CAMERA_STUB := false

BOARD_WLAN_TI_STA_DK_ROOT := system/wlan/ti/wilink_6_1
BOARD_WLAN_DEVICE := tiwlan0
WIFI_DRIVER_MODULE_PATH := /system/lib/modules/tiwlan_drv.ko
WIFI_DRIVER_MODULE_NAME := tiwlan_drv
WIFI_FIRMWARE_LOADER := wlan_loader
SDIO_DRIVER_MODULE_PATH := /system/lib/modules/sdio.ko
SDIO_DRIVER_MODULE_NAME := sdio

BOARD_EGL_CFG := vendor/htc/legend/files/egl.cfg

# TODO
#BOARD_BOOTIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00280000)
#BOARD_RECOVERYIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00500000)
#BOARD_SYSTEMIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x07500000)
#BOARD_USERDATAIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x04ac0000)
# The size of a block that can be marked bad.
#BOARD_FLASH_BLOCK_SIZE := 131072
