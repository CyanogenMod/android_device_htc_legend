#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := msm7k
TARGET_CPU_ABI := armeabi
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200
TARGET_BOOTLOADER_BOARD_NAME := legend

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RECOVERY := true

BOARD_USES_QCOM_LIBS := true
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_GENERIC_AUDIO := false

BOARD_VENDOR_QCOM_AMSS_VERSION := 4735
BOARD_VENDOR_USE_AKMD := akm8973

BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_SERVICE := btips

BOARD_GPS_LIBRARIES := libgps

USE_CAMERA_STUB := false
BOARD_USES_ECLAIR_LIBCAMERA := true

BOARD_WLAN_TI_STA_DK_ROOT := system/wlan/ti/wilink_6_1
BOARD_WLAN_DEVICE := tiwlan0
WIFI_DRIVER_MODULE_PATH := /system/lib/modules/tiwlan_drv.ko
WIFI_DRIVER_MODULE_NAME := tiwlan_drv
WIFI_FIRMWARE_LOADER := wlan_loader
WIFI_EXT_MODULE_PATH := /system/lib/modules/sdio.ko
WIFI_EXT_MODULE_NAME := sdio

BOARD_USE_HTC_USB_FUNCTION_SWITCH := true

BOARD_EGL_CFG := device/htc/legend/files/egl.cfg

WITH_JIT := true
ENABLE_JSC_JIT := true

BOARD_KERNEL_CMDLINE := no_console_suspend=1 console=null
BOARD_KERNEL_BASE := 0x12C00000

BOARD_RECOVERYIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00460000)
BOARD_BOOTIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00280000)
BOARD_SYSTEMIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x0f000000)
BOARD_USERDATAIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x0b920000)

BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_RECOVERY_UI_LIB := librecovery_ui_legend librecovery_ui_htc

TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_htc

TARGET_RELEASETOOLS_EXTENSIONS := device/htc/common
