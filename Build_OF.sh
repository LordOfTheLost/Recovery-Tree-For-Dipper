# Configure some default settings for the build
FDEVICE="dipper"
VOF="$( date +"%d.%m" ).21-(17)"
sudo chmod -R 777 scripts/OrangeFox/vendor/recovery
if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/maintainer.png ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/maintainer.png scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/images/Default/About; rm -f scripts/OrangeFox/device/xiaomi/$FDEVICE/maintainer.png; fi
if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/busybox ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/busybox scripts/OrangeFox/vendor/recovery/Files; rm -f scripts/OrangeFox/device/xiaomi/$FDEVICE/busybox; fi
if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/advanced.xml ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/advanced.xml scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/page; rm -f scripts/OrangeFox/device/xiaomi/$FDEVICE/advanced.xml; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxExtras/FFiles/OF_backup_settings.zip ]; then cp -f scripts/OrangeFox/vendor/recovery/FoxExtras/FFiles/OF_backup_settings.zip scripts/OrangeFox/vendor/recovery/FoxFiles; rm -f scripts/OrangeFox/vendor/recovery/FoxExtras/FFiles/OF_backup_settings.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/GoogleSans.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/GoogleSans.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue_Legacy.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue_Legacy.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/OF_initd.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/OF_initd.zip; fi
if [ -d scripts/OrangeFox/vendor/recovery/FoxFiles/AromaFM ]; then rm -rf scripts/OrangeFox/vendor/recovery/FoxFiles/AromaFM; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/Magisk.zip ]; then cp -f scripts/OrangeFox/vendor/recovery/FoxFiles/Magisk.zip scripts/OrangeFox/vendor/recovery/FoxFiles/unrootmagisk.zip; fi
cd scripts/OrangeFox
if [ -f device/xiaomi/$FDEVICE/prebuilt/Image.tar.xz ]; then tar -xf device/xiaomi/$FDEVICE/prebuilt/Image.tar.xz -C device/xiaomi/$FDEVICE/prebuilt; rm -f device/xiaomi/$FDEVICE/prebuilt/Image.tar.xz; fi

Default_Settings() {
# Other Settings
export PLATFORM_VERSION="16.1.0"
export PLATFORM_SECURITY_PATCH="2099-12-31"
export TW_DEFAULT_LANGUAGE="en"
#export FOX_R11=1
#export FOX_ADVANCED_SECURITY=0
export OF_USE_TWRP_SAR_DETECT=0
export OF_SUPPORT_PRE_FLASH_SCRIPT=0
#export OF_VANILLA_BUILD=1
export OF_CLASSIC_LEDS_FUNCTION=1
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1 # if you disable this, then enable the next line
#export OF_NO_MIUI_PATCH_WARNING=1
export OF_USE_NEW_MAGISKBOOT=1
export OF_CHECK_OVERWRITE_ATTEMPTS=1
export FOX_RESET_SETTINGS=1
export OF_FLASHLIGHT_ENABLE=1
export FOX_DISABLE_APP_MANAGER=0
#export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export FOX_USE_GREP_BINARY=0
export OF_RUN_POST_FORMAT_PROCESS=1

# BACKUP
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export OF_QUICK_BACKUP_LIST="/boot;/data;/system_root;/vendor;"

# Files
export FOX_REPLACE_BUSYBOX_PS=1
#export FOX_REMOVE_AAPT=1
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
#export FOX_USE_NANO_EDITOR=1
#export FOX_USE_TAR_BINARY=1
#export FOX_USE_ZIP_BINARY=1
#export FOX_DELETE_MAGISK_ADDON=1
#export FOX_USE_XZ_UTILS=1

# OTA for custom ROMs
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
export FOX_DELETE_AROMAFM=1
export FOX_DELETE_INITD_ADDON=1

# Encryption
export OF_PATCH_AVB20=1
export OF_OTA_RES_DECRYPT=1
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
export OF_KEEP_DM_VERITY=1
export OF_DISABLE_FORCED_ENCRYPTION=1
#export OF_KEEP_FORCED_ENCRYPTION=1

# Use system (ROM) fingerprint where available
#export OF_USE_SYSTEM_FINGERPRINT=1

# UI
export OF_CLOCK_POS=0
export OF_USE_LOCKSCREEN_BUTTON=1
export OF_SCREEN_H=2248
export OF_STATUS_H=90
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
#export OF_NO_SPLASH_CHANGE=1
#export OF_DISABLE_EXTRA_ABOUT_PAGE=1

# DEBUG MODE
export FOX_INSTALLER_DEBUG_MODE=0

# Compiler
export FOX_USE_LZMA_COMPRESSION=1
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export LC_ALL="C"
#export OF_DISABLE_KEYMASTER2=1
#export OF_LEGACY_SHAR512=1
#export FOX_JAVA8_PATH="/usr/lib/jvm/java-8-openjdk/jre/bin/java

# Fox Version
export FOX_VERSION=R11.1-$VOF
export FOX_BUILD_TYPE=Monthly

# MAINTAINER
export OF_MAINTAINER="Lord Of The Lost"
}

# build the project
Build() {
Default_Settings
# compile it
. build/envsetup.sh
add_lunch_combo omni_$FDEVICE-eng
add_lunch_combo omni_$FDEVICE-userdebug
lunch omni_$FDEVICE-eng && mka recoveryimage
}

# --- main --- #
Build
#
