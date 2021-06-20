BRAND="xiaomi"; FDEVICE="dipper"; VOF="$( date +"%d.%m" ).21-(19)"; OFKP="prebuilt/Image.tar.xz"
RECOVERY="scripts/OrangeFox/vendor/recovery"
FOXFILES="$RECOVERY/FoxFiles"
FOXDEVICE="scripts/OrangeFox/device"
FONTXML="scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/themes/font.xml"
ADVANCEDXML="scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/pages/advanced.xml"
INSTALLER="$RECOVERY/installer/META-INF/com/google/android/update-binary"
sudo chmod -R 777 $RECOVERY

Patch_OF_Settings() {
if [ -f $RECOVERY/ADVANCEDXML ]; then touch $RECOVERY/ADVANCEDXML; else sed -i "320,356 d" $ADVANCEDXML; touch $RECOVERY/ADVANCEDXML; fi
# sed -i "s/<placement x=\"%col1_x_caption%\" y=\"%row3_1a_y%\"\/>/<placement x=\"0\" y=\"0\"\/>/g" $ADVANCEDXML
sed -i "s/<placement x=\"%col1_x_caption%\" y=\"%row5_2_y%\"\/>/<placement x=\"%col1_x_caption%\" y=\"%row4_1a_y%\"\/>/g" $ADVANCEDXML
sed -i "s/<placement x=\"0\" y=\"%row5_3_y%\" w=\"%screen_w%\" h=\"%bl_h4%\"\/>/<placement x=\"0\" y=\"%row4_2a_y%\" w=\"%screen_w%\" h=\"%bl_h4%\"\/>/g" $ADVANCEDXML
# sed -i "s/Roboto/GoogleSans/g" $FONTXML
# sed -i "s/value=\"n\"/value=\"s\"/g" $FONTXML
sed -i "s/<condition var1=\"of_hide_app_hint\" op=\"!=\" var2=\"1\"\/>/<condition var1=\"of_hide_app_hint\" op=\"!=\" var2=\"0\"\/>/g" $ADVANCEDXML
sed -i "/name=\"{@more}\"/I,+4 d" $ADVANCEDXML; sed -i "/name=\"{@hide}\"/I,+5 d" $ADVANCEDXML
sed -i "/<condition var1=\"utils_show\" var2=\"1\"\/>/d" $ADVANCEDXML
# sed -i "s/ui_print \" >> Rebooting to Recovery in 5 seconds ...\"/ui_print \" - Check FOX_DISABLE_APP_MANAGER\"; \/sdcard\/FoxFiles\/runatboot.sh; rm -f \/sdcard\/FoxFiles\/runatboot.sh; ui_print \" >> Rebooting to Recovery in 5 seconds ...\" /g" $INSTALLER
}

Default_Settings() {
if [ -f $FOXDEVICE/$FDEVICE/maintainer.png ]; then cp -f $FOXDEVICE/$FDEVICE/maintainer.png scripts/OrangeFox/bootable/recovery/gui/theme/portrait_hdpi/images/Default/About; rm -f $FOXDEVICE/$FDEVICE/maintainer.png; fi
if [ -f $FOXDEVICE/$FDEVICE/busybox ]; then cp -f $FOXDEVICE/$FDEVICE/busybox $RECOVERY/Files; fi
for f in GoogleSans.zip SubstratumRescue.zip SubstratumRescue_Legacy.zip OF_initd.zip AromaFM; do if [ -f $FOXFILES/$f.zip ]; then rm -rf $FOXFILES/$f; fi; done
if [ -f $FOXDEVICE/$FDEVICE/unrootmagisk.zip ]; then cp -f $FOXDEVICE/$FDEVICE/unrootmagisk.zip $FOXFILES/unrootmagisk.zip; rm -f $FOXDEVICE/$FDEVICE/unrootmagisk.zip; fi
#if [ -f $FOXDEVICE/$FDEVICE/recovery/root/sbin/runatboot.sh ]; then cp -f $FOXDEVICE/$FDEVICE/recovery/root/sbin/runatboot.sh $FOXFILES; fi
cd scripts/OrangeFox; if [ -f device/$FDEVICE/$OFKP ]; then tar -xf device/$FDEVICE/$OFKP -C device/$FDEVICE/prebuilt; rm -f device/$FDEVICE/$OFKP; fi
}

Default_Fox_Vars() {
# Other Settings
export PLATFORM_VERSION="16.1.0"
export PLATFORM_SECURITY_PATCH="2099-12-31"
export TW_DEFAULT_LANGUAGE="en"
#export FOX_R11=1; #DEPCRECATED!
#export FOX_ADVANCED_SECURITY=0; # This forces ADB and MTP to be disabled until after you enter the recovery (ie, until after all decryption/recovery passwords are successfully entered)
export OF_USE_TWRP_SAR_DETECT=0; # Blyad Prosto
export OF_SUPPORT_PRE_FLASH_SCRIPT=0; # Support running a script before flashing zips (other than ROMs). The script must be called /sbin/fox_pre_flash - and you need to copy it there yourself
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
export FOX_DISABLE_APP_MANAGER=1
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
export FOX_REMOVE_AAPT=1; # Used for FOX_DISABLE_APP MANAGER if on enable
export FOX_USE_BASH_SHELL=0
export FOX_ASH_IS_BASH=0
export FOX_USE_NANO_EDITOR=0
export FOX_USE_TAR_BINARY=0
#export FOX_USE_ZIP_BINARY=1; # OBSOLETE!
#export FOX_DELETE_MAGISK_ADDON=1
export FOX_USE_XZ_UTILS=0

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
export FOX_VERSION=R11.1-$VOF
export FOX_BUILD_TYPE=Monthly

# CUMTAINER
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

Build