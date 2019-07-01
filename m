From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon,  1 Jul 2019 23:12:30 +0900
Subject: [PATCH v5 0/4] nvme: add thermal zone devices
Message-ID: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>

The NVMe controller reports up to nine temperature values in the SMART /
Health log page (the composite temperature and temperature sensor 1 through
temperature sensor 8).
The temperature threshold feature (Feature Identifier 04h) configures the
asynchronous event request command to complete when the temperature is
crossed its corresponding temperature threshold.

This provides these temperatures and thresholds via thermal zone devices.

The main purpose of this is to turn on a fan when overheated without
polling the device for the smart log that could prevent the lower power
state transitions.

In addition to the standard thermal zone device, this adds support for
registering the DT thermal zone device.

* v5
- remove 'Export get and set features' patch as it has been merged in -next
- split the DT thermal zone support into separate patch
- round up temperature when writing trip point
- add DT binding documentation
- don't register both standard and DT thermal zone
- use thermal_zone_device_update() instead of thermal_notify_framework()

* v4
- add thermal.c to hold thermal zone related code
- add 'use_thermal_zone' module parameter
- add CONFIG_THERMAL_WRITABLE_TRIPS dependency
- add comment about the return value of nvme_thermal_zones_register()
- support DT thermal zone device.
- use bitmap to iterate over implemented sensors

* v3
- Change the type name of thermal zone devices from 'nvme_temp<sensor>' to
  'nvme<instance>_temp<sensor>'
- Pass a NULL to the status argument of nvme_set_feature()
- Change the name of symbolic link from 'nvme_temp<sensor>' to 'temp<sensor>'
- Don't make it fatal error if the device provides a response
- Don't register thermal zone for composite temperature if smart log reports
  zero value
- Move the thermal zones registration and unregistration into the core module.

* v2
- s/correspoinding/corresponding/ typo in commit log
- Borrowed nvme_get_features() from Keith's patch
- Temperature threshold notification is splitted into another patch
- Change the data type of 'sensor' to unsigned
- Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
- Add WARN_ON_ONCE for paranoid checks
- Fix off-by-one error in nvme_get_temp
- Validate 'sensor' where the value is actually used
- Define and utilize two enums related to the temperature threshold feature
- Remove hysteresis value for this trip point and don't utilize the under
  temperature threshold
- Print error message for thermal_zone_device_register() failure
- Add function comments for nvme_thermal_zones_{,un}register
- Suppress non-fatal errors from nvme_thermal_zones_register()
- Add comment about implemented temperature sensors 
- Instead of creating a new 'thermal_work', append async smart event's
  action to the existing async_event_work
- Add comment for tzdev member in nvme_ctrl
- Call nvme_thermal_zones_unregister() earlier than the last reference
  release

Akinobu Mita (4):
  nvme: add thermal zone devices
  dt-bindings: thermal: nvme: Add binding documentation
  nvme: support DT thermal zone device
  nvme: notify thermal framework when temperature threshold events occur

 Documentation/devicetree/bindings/thermal/nvme.txt |  56 ++++
 drivers/nvme/host/Kconfig                          |   1 +
 drivers/nvme/host/Makefile                         |   1 +
 drivers/nvme/host/core.c                           |  19 ++
 drivers/nvme/host/nvme.h                           |  40 +++
 drivers/nvme/host/thermal.c                        | 343 +++++++++++++++++++++
 include/linux/nvme.h                               |  12 +
 7 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvme.txt
 create mode 100644 drivers/nvme/host/thermal.c

Cc: Rob Herring <robh at kernel.org>
Cc: Zhang Rui <rui.zhang at intel.com>
Cc: Eduardo Valentin <edubezval at gmail.com>
Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
-- 
2.7.4
