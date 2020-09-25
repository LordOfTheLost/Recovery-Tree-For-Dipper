# configure some default settings for the build
Default_Settings() {
FDEVICE="dipper"
if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
export PLATFORM_VERSION="16.1.0"
export PLATFORM_SECURITY_PATCH="2099-12-31"
export TW_DEFAULT_LANGUAGE="en"
export OF_CLASSIC_LEDS_FUNCTION=1
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export FOX_USE_LZMA_COMPRESSION=1
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export OF_OTA_RES_DECRYPT=1
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1 # if you disable this, then enable the next line
#export OF_NO_MIUI_PATCH_WARNING=1
export FOX_REPLACE_BUSYBOX_PS=1
export OF_USE_NEW_MAGISKBOOT=1
export OF_KEEP_DM_VERITY=1  # enabled for R10.1
export OF_DISABLE_FORCED_ENCRYPTION=1  # enabled for R10.1 (A10)
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export OF_CHECK_OVERWRITE_ATTEMPTS=1

# OTA for custom ROMs
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1

#export OF_PATCH_AVB20=0

# Use system (ROM) fingerprint where available
export OF_USE_SYSTEM_FINGERPRINT=1

# Settings R11
export FOX_R11=1
#export FOX_ADVANCED_SECURITY=
export OF_USE_TWRP_SAR_DETECT=1
export OF_QUICK_BACKUP_LIST="/boot;/data;/system;/vendor;"
export FOX_VERSION=R11
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
export FOX_DELETE_AROMAFM=1
#export OF_VANILLA_BUILD=

# UI
export OF_CLOCK_POS=0
export OF_USE_LOCKSCREEN_BUTTON=1
export OF_SCREEN_H=2248
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
#export OF_NO_SPLASH_CHANGE=1
#export OF_DISABLE_EXTRA_ABOUT_PAGE=1

# Other
#export FOX_USE_TAR_BINARY=1
#export FOX_USE_ZIP_BINARY=1
export FOX_RESET_SETTINGS=1
export OF_FLASHLIGHT_ENABLE=1
#export OF_KEEP_FORCED_ENCRYPTION=1
#export OF_NO_TREBLE_COMPATIBILITY_CHECK=1

# Compiler 
#export OF_DISABLE_KEYMASTER2=1
#export OF_LEGACY_SHAR512=1

# Fox Version
export FOX_VERSION=R11.0-Build6

# Let's see what are our build VARs
if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
export | grep "FOX" >> $FOX_BUILD_LOG_FILE
export | grep "OF_" >> $FOX_BUILD_LOG_FILE
export | grep "TW_" >> $FOX_BUILD_LOG_FILE
export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
fi
fi
}

# build the project
Build() {
Default_Settings
# compile it
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export LC_ALL="C"
export OF_MAINTAINER="Lord Of The Lost"
lunch omni_dipper-eng && mka recoveryimage
}

# --- main --- #
Build
#
