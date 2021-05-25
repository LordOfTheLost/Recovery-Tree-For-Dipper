# Configure some default settings for the build
MMVOF="$1"; FDEVICE="dipper"; VOF="$( date +"%d.%m" ).21-(18)"; OFKP="prebuilt/Image.tar.xz"; FONTXML="scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/themes/font.xml"; ADVANCEDXML="scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/pages/advanced.xml"; INSTALLER="scripts/OrangeFox/vendor/recovery/installer/META-INF/com/google/android/update-binary"
sudo chmod -R 777 scripts/OrangeFox/vendor/recovery

Patch_OF_Settings() {
if [ -f scripts/OrangeFox/vendor/recovery/ADVANCEDXML ]; then touch scripts/OrangeFox/vendor/recovery/ADVANCEDXML; else sed -i "320,356 d" $ADVANCEDXML; touch scripts/OrangeFox/vendor/recovery/ADVANCEDXML; fi
# sed -i "s/<placement x=\"%col1_x_caption%\" y=\"%row3_1a_y%\"\/>/<placement x=\"0\" y=\"0\"\/>/g" $ADVANCEDXML
# sed -i "s/<placement x=\"%col1_x_caption%\" y=\"%row5_2_y%\"\/>/<placement x=\"%col1_x_caption%\" y=\"%row3_1a_y%\"\/>/g" $ADVANCEDXML
sed -i "s/<placement x=\"0\" y=\"%row5_3_y%\" w=\"%screen_w%\" h=\"%bl_h4%\"\/>/<placement x=\"0\" y=\"%row3_2a_y%\" w=\"%screen_w%\" h=\"%bl_h3%\"\/>/g" $ADVANCEDXML
# sed -i "s/Roboto/GoogleSans/g" $FONTXML
# sed -i "s/value=\"n\"/value=\"s\"/g" $FONTXML
sed -i "s/<condition var1=\"of_hide_app_hint\" op=\"!=\" var2=\"1\"\/>/<condition var1=\"of_hide_app_hint\" op=\"!=\" var2=\"0\"\/>/g" $ADVANCEDXML
sed -i "/name=\"{@more}\"/I,+4 d" $ADVANCEDXML; sed -i "/name=\"{@hide}\"/I,+5 d" $ADVANCEDXML
sed -i "/<condition var1=\"utils_show\" var2=\"1\"\/>/d" $ADVANCEDXML
# sed -i "s/ui_print \" >> Rebooting to Recovery in 5 seconds ...\"/ui_print \" - Check FOX_DISABLE_APP_MANAGER\"; \/sdcard\/FoxFiles\/runatboot.sh; rm -f \/sdcard\/FoxFiles\/runatboot.sh; ui_print \" >> Rebooting to Recovery in 5 seconds ...\" /g" $INSTALLER
}

Default_Settings() {
if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/maintainer.png ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/maintainer.png scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/images/Default/About; rm -f scripts/OrangeFox/device/xiaomi/$FDEVICE/maintainer.png; fi
if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/busybox ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/busybox scripts/OrangeFox/vendor/recovery/Files; rm -f scripts/OrangeFox/device/xiaomi/$FDEVICE/busybox; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/GoogleSans.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/GoogleSans.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue_Legacy.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/SubstratumRescue_Legacy.zip; fi
if [ -f scripts/OrangeFox/vendor/recovery/FoxFiles/OF_initd.zip ]; then rm -f scripts/OrangeFox/vendor/recovery/FoxFiles/OF_initd.zip; fi
if [ -d scripts/OrangeFox/vendor/recovery/FoxFiles/AromaFM ]; then rm -rf scripts/OrangeFox/vendor/recovery/FoxFiles/AromaFM; fi
if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/unrootmagisk.zip ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/unrootmagisk.zip scripts/OrangeFox/vendor/recovery/FoxFiles/unrootmagisk.zip; rm -f scripts/OrangeFox/device/xiaomi/$FDEVICE/unrootmagisk.zip; fi
#if [ -f scripts/OrangeFox/device/xiaomi/$FDEVICE/recovery/root/sbin/runatboot.sh ]; then cp -f scripts/OrangeFox/device/xiaomi/$FDEVICE/recovery/root/sbin/runatboot.sh scripts/OrangeFox/vendor/recovery/FoxFiles; fi
cd scripts/OrangeFox; if [ -f device/xiaomi/$FDEVICE/$OFKP ]; then tar -xf device/xiaomi/$FDEVICE/$OFKP -C device/xiaomi/$FDEVICE/prebuilt; rm -f device/xiaomi/$FDEVICE/$OFKP; fi
}

Default_Fox_Vars() {
# Other Settings
export PLATFORM_VERSION="16.1.0"
export PLATFORM_SECURITY_PATCH="2099-12-31"
export TW_DEFAULT_LANGUAGE="en"
#export FOX_R11=1; #DEPCRECATED!
#export FOX_ADVANCED_SECURITY=0; # This forces ADB and MTP to be disabled until after you enter the recovery (ie, until after all decryption/recovery passwords are successfully entered)
export OF_USE_TWRP_SAR_DETECT=0; # Blyad Prosto
export OF_SUPPORT_PRE_FLASH_SCRIPT=1; # Support running a script before flashing zips (other than ROMs). The script must be called /sbin/fox_pre_flash - and you need to copy it there yourself
#export OF_VANILLA_BUILD=1
export OF_CLASSIC_LEDS_FUNCTION=0; # Use the old R9.x Leds function
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1; # If this is set, this script will also automatically set OF_USE_MAGISKBOOT to 1
#export OF_USE_MAGISKBOOT=1; # If OF_USE_MAGISKBOOT_FOR_ALL_PATCHES is on, then you don't need to turn it on 
export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1 # if you disable this, then enable the next line
#export OF_NO_MIUI_PATCH_WARNING=1
#export OF_USE_NEW_MAGISKBOOT=1; # OBSOLETE!
export OF_CHECK_OVERWRITE_ATTEMPTS=1; # Check for attempts by a ROM's installer to overwrite OrangeFox with another recovery
export FOX_RESET_SETTINGS=1
export OF_FLASHLIGHT_ENABLE=1
export FOX_DISABLE_APP_MANAGER=0
#export OF_NO_TREBLE_COMPATIBILITY_CHECK=1; # Disable checking for compatibility.zip in ROMs
export OF_RUN_POST_FORMAT_PROCESS=1

# BACKUP
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=0
export OF_QUICK_BACKUP_LIST="/boot;/data;/system_root;/vendor;"

# Files
export FOX_USE_GREP_BINARY=0
export FOX_DELETE_AROMAFM=1
export FOX_DELETE_INITD_ADDON=1
export FOX_REPLACE_BUSYBOX_PS=1
#export FOX_REMOVE_AAPT=1; # Used for FOX_DISABLE_APP MANAGER if on enable
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
#export FOX_USE_NANO_EDITOR=1
#export FOX_USE_TAR_BINARY=1
#export FOX_USE_ZIP_BINARY=1; # OBSOLETE!
#export FOX_DELETE_MAGISK_ADDON=1
export FOX_USE_XZ_UTILS=1

# OTA for custom ROMs
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1; #This setting is incompatible with OF_DISABLE_MIUI_SPECIFIC_FEATURES/OF_TWRP_COMPATIBILITY_MODE/OF_VANILLA_BUILD
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

# Encryption
export OF_PATCH_AVB20=1; # Patch AVB 2.0 so that OrangeFox is not replaced by stock recovery
export OF_OTA_RES_DECRYPT=1; # Decrypt internal storage (instead bailing out with an error) during MIUI OTA restore
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
export FOX_VERSION=R11.1-$VOF$MMVOF
export FOX_BUILD_TYPE=Monthly

# MAINTAINER
export OF_MAINTAINER="Lord Of The Lost"
}

# build the project
Build() {
Patch_OF_Settings
Default_Settings
Default_Fox_Vars
# compile it
. build/envsetup.sh
add_lunch_combo omni_$FDEVICE-eng
add_lunch_combo omni_$FDEVICE-user
add_lunch_combo omni_$FDEVICE-userdebug
lunch omni_$FDEVICE-eng && mka recoveryimage
}

# --- main --- #
Build
#
