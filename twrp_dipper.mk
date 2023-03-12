#
# Copyright (C) 2022 The OrangeFox Recovery Project
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

PRODUCT_RELEASE_NAME := dipper

# Inherit from our custom product configuration
$(call inherit-product, device/$(PRODUCT_RELEASE_NAME)/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := twrp_dipper
PRODUCT_DEVICE := dipper
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI 8
PRODUCT_MANUFACTURER := Xiaomi

TARGET_VENDOR_PRODUCT_NAME := dipper
TARGET_VENDOR_DEVICE_NAME := dipper
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=dipper \
    BUILD_PRODUCT=dipper \
    PRODUCT_NAME=dipper