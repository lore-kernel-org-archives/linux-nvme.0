From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu,  2 May 2019 17:59:17 +0900
Subject: [PATCH 0/4] nvme-pci: support device coredump
Message-ID: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>

This enables to capture snapshot of controller information via device
coredump machanism, and it helps diagnose and debug issues.

The nvme device coredump is triggered before resetting the controller
caused by I/O timeout, and creates the following coredump files.

- regs: NVMe controller registers, including each I/O queue doorbell
        registers, in nvme-show-regs style text format.

- sq<qid>: I/O submission queue

- cq<qid>: I/O completion queue

The device coredump mechanism currently allows drivers to create only a
single coredump file, so this also provides a new function that allows
drivers to create several device coredump files in one crashed device.

Akinobu Mita (4):
  devcoredump: use memory_read_from_buffer
  devcoredump: allow to create several coredump files in one device
  nvme-pci: add device coredump support
  nvme-pci: trigger device coredump before resetting controller

 drivers/base/devcoredump.c  | 173 +++++++++++++++++++-----------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/pci.c     | 252 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/devcoredump.h |  33 ++++++
 4 files changed, 387 insertions(+), 72 deletions(-)

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
-- 
2.7.4
