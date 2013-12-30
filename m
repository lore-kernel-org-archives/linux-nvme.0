From: santoshsy@gmail.com (Santosh Y)
Date: Mon, 30 Dec 2013 15:57:15 +0530
Subject: [PATCH RFC 0/5] NVMe: Hotplug support
Message-ID: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>

This patchset provides hotplug support for NVMe.
For NVMe hotplug feature to work, PCIe slot must be hotplug capable.

Santosh Y (5):
  NVMe: Code cleanup and minor checkpatch correction
  NVMe: Basic NVMe device hotplug support
  NVMe: Asynchronous device scan support
  NVMe: Stale node cleanup based on reference count
  NVMe: Hotplug support during hibernate/sleep states

 drivers/block/Kconfig     |   8 ++
 drivers/block/nvme-core.c | 334 +++++++++++++++++++++++++++++++++++++++++++---
 include/linux/nvme.h      |  15 +++
 3 files changed, 339 insertions(+), 18 deletions(-)

-- 
1.8.3.2
