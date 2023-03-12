#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

# the recovery log
LOGF=/tmp/recovery.log;
SUPER=0;

# write to the log
logit() {
  echo -n "- OrangeFox-DEBUG: " >> $LOGF;
  echo "$@" >> $LOGF;
}

# is this a dynamic-partition build ?
is_dynamic() {
  local super=$(getprop "orangefox.super.partition");
  if [ "$super" != "true" ]; then
     super=$(getprop "ro.boot.dynamic_partitions");
  fi

  if [ "$super" = "true" ]; then
     echo "1";
  else
     echo "0";
  fi
}

# PE uses keymaster4
check_for_keymaster4() {
local D=/FFiles/temp/system_prop;
local S=/dev/block/bootdevice/by-name/system;
local F=/FFiles/temp/system-build.prop;
local found=0;

	# dynamic partitions
	if [ "$SUPER" = "1" ]; then
		echo "1";
		resetprop "rom_uses_keymaster4" "true";
		return;
	fi

    	cd /FFiles/temp/;
    	#logit "Creating directory: $D";
    	mkdir -p $D;

    	#logit "Mounting directory: $D";
    	mount -r $S $D;

	if [ "$?" = "0" ]; then
		logit "Mounted the system partition successfully";
	else
	     	logit "I cannot mount the system partition. Quitting.";
		echo "0";
		resetprop "rom_uses_keymaster4" "false";
		return;
	fi

	#logit "Copying $D/system/build.prop to $F";
    	cp $D/system/build.prop $F;
	[ "$?" = "0" ] && logit "Copied the system build.prop successfully" || logit "I cannot copy the system build.prop";

    	umount $D;
    	rmdir $D;

    	[ ! -f $F ] && {
    		logit "$F does not exist. Quitting.";
    		echo "0";
    		resetprop "rom_uses_keymaster4" "false";
    		return;
    	}

    	#logit "About to check for PE/KM4 ROMs";
    	found=0;
    	if [ -n "$(grep org.pixelexperience.device $F)" ]; then
    		found=1;
    	elif [ -n "$(grep org.pixelexperience.version $F)" ]; then
    		found=1;
    	elif [ -n "$(grep org.pixelexperience.build $F)" ]; then
    		found=1;
    	fi

    	if [ "$found" != "0" ]; then
    		#logit "Okay, clearly this uses keymaster4. Let's try to set some props to work around the issues.";
    		resetprop "rom_uses_keymaster4" "true";
    		echo "1";
    	else
    		#logit "Okay, clearly this doesn't use keymaster4 ...";
    		resetprop "rom_uses_keymaster4" "false";
    		echo "0";
    	fi

    	#logit "Finished checking: KM4 ROM=$found";
    	rm $F;
}

process_variants() {
	local force_km_version=$(getprop ro.fox.force_keymaster_version);
    	if [ -n "$force_km_version" ]; then
    	   if [ "$force_km_version" = "4" ]; then
    		logit "This release only supports keymaster4.0 (enforcing KM_version=$force_km_version); removing the keymaster3 stuff...";
		rm -f /system/bin/android.hardware.keymaster@3.0-service-qti;
	   else
    		logit "This release doesn't support keymaster4.0 (enforcing KM_version=$force_km_version); removing the keymaster4 stuff...";
		rm -f /system/bin/android.hardware.keymaster@4.0-service-qti;
	   fi
	   return;
	fi

	local KMV=$(getprop ro.fox.keymaster_version);
	local D=$(check_for_keymaster4);
	local K=$(getprop rom_uses_keymaster4);

    	#logit "The output of 'check_for_keymaster4'=$D";
    	#logit "The output of 'getprop rom_uses_keymaster4'=$K";
    	#logit "The output of 'getprop ro.fox.keymaster_version'=$KMV";
    	if [ "$D" = "1" -o "$K" = "true" -o "x$force_km_version" = "x4" ]; then
    		logit "This ROM uses keymaster4.0; removing the keymaster3 stuff...";
		rm -f /system/bin/android.hardware.keymaster@3.0-service-qti;	

		if [ "$KMV" != "4" ]; then
			logit "The ROM's keymaster does not match OrangeFox's keymaster version (v$KMV). OrangeFox will probably not boot.";
		fi
    	else
    		logit "This ROM doesn't use keymaster4.0; removing the keymaster4 stuff...";
		rm -f /system/bin/android.hardware.keymaster@4.0-service-qti;

		if [ "$KMV" != "3" ]; then
			logit "The ROM 's keymaster does not match OrangeFox's keymaster version (v$KMV). OrangeFox will probably not boot.";
		fi
    	fi
}

# ---
logit "Starting the script: $0";
SUPER=$(is_dynamic);
process_variants;
exit 0;
# ---
