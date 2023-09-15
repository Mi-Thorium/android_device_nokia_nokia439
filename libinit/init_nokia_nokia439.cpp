/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_variant.h>

#include "vendor_init.h"

#include <android-base/file.h>

static const variant_info_t deadpool_info = {
    .brand = "Nokia",
    .device = "Deadpool",
    .marketname = "",
    .model = "Nokia 3.2",
    .build_fingerprint = "Nokia/Deadpool_00WW/DPL_sprout:9/PKQ1.190202.001/00WW_1_41B:user/release-keys",
    .dpi = 320,
};

static const variant_info_t panther_info = {
    .brand = "Nokia",
    .device = "Panther",
    .marketname = "",
    .model = "Nokia 4.2",
    .build_fingerprint = "Nokia/Panther_00WW/PAN_sprout:11/RKQ1.200928.002/00WW_3_150:user/release-keys",
    .dpi = 300,
};

static void determine_device()
{
    std::string mach_codename;
    android::base::ReadFileToString("/sys/nokia-sdm439-mach/codename", &mach_codename, true);
    mach_codename.pop_back();
    if (mach_codename == "deadpool")
        set_variant_props(deadpool_info);
    else if (mach_codename == "panther")
        set_variant_props(panther_info);
}

void vendor_load_properties() {
    determine_device();
    set_dalvik_heap();
}
