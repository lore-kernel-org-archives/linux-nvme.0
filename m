From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 16 May 2019 00:17:15 +0900
Subject: [PATCH 0/2] nvme: add thermal zone devices
Message-ID: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>

The NVMe controller reports up to nine temperature values in the SMART /
Health log page (the composite temperature and temperature sensor 1 through
temperature sensor 8).
The temperature threshold feature (Feature Identifier 04h) configures the
asynchronous event request command to complete when the temperature is
crossed its correspoinding temperature threshold.

This provide these temperatures and thresholds via thermal zone devices.

Akinobu Mita (2):
  nvme: add thermal zone infrastructure
  nvme-pci: support thermal zone

 drivers/nvme/host/core.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  24 ++++
 drivers/nvme/host/pci.c  |   5 +
 include/linux/nvme.h     |   4 +
 4 files changed, 397 insertions(+), 4 deletions(-)

Cc: Zhang Rui <rui.zhang at intel.com>
Cc: Eduardo Valentin <edubezval at gmail.com>
Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
-- 
2.7.4
