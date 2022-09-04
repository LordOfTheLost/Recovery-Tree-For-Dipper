#
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_PACKAGES += \
	qcom_decrypt \
	qcom_decrypt_fbe

TARGET_RECOVERY_DEVICE_MODULES := \
	libcap \
	libpcrecpp \
	libxml2 \
	android.hidl.base@1.0 \
	android.hardware.boot@1.0 \
	ashmemd \
	ashmemd_aidl_interface-cpp \
	libashmemd_client \
	vendor.display.config@1.0 \
	vendor.display.config@2.0 \
	libdisplayconfig.qti

TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES := \
	$(TARGET_OUT_EXECUTABLES)/ashmemd

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES := \
	$(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so

PRODUCT_COPY_FILES += \
	$(OUT_DIR)/target/product/dipper/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

# TARGET_HW_DISK_ENCRYPTION := true
# ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
# $(warning FDE doesn't work with the 11.0 manifest. You will not be able to decrypt MIUI ROMs)
# TARGET_CRYPTFS_HW_PATH := vendor/qcom/opensource/cryptfs_hw

# TARGET_RECOVERY_DEVICE_MODULES += \
	# libhardware_legacy \
	# android.system.suspend@1.0

# RECOVERY_LIBRARY_SOURCE_FILES += \
	# $(TARGET_OUT_SHARED_LIBRARIES)/libhardware_legacy.so \
	# $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend@1.0.so

# PRODUCT_COPY_FILES += \
	# $(OUT_DIR)/target/product/dipper/obj/SHARED_LIBRARIES/libcryptfs_hw_intermediates/libcryptfs_hw.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libcryptfs_hw.so
# endif
