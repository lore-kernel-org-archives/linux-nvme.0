From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed,  8 May 2019 01:58:27 +0900
Subject: [PATCH v2 0/7] nvme-pci: support device coredump
Message-ID: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>

This enables to capture snapshot of controller information via device
coredump machanism, and it helps diagnose and debug issues.

The nvme device coredump is triggered when command timeout occurs, and
creates the following coredump files.

 - regs: NVMe controller registers (00h to 4Fh)
 - sq<qid>: Submission queue
 - cq<qid>: Completion queue
 - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
 - data: Empty

(I don't have the NVMe device that supports telemetry log page for now, so
capturing telemetry log is untested.)

The device coredump mechanism currently allows drivers to create only a
single coredump file, so this also provides a new function that allows
drivers to create several device coredump files in one crashed device.

* v2
- Add Reviewed-by tag.
- Add patch to fix typo in comment
- Remove unneeded braces.
- Allocate device_entry followed by an array of devcd_file elements.
- Add telemetry log page definisions
- Add facility to check log page attributes
- Exclude the doorbell registers from register dump.
- Save controller registers in a binary format instead of a text format.
- Create an empty 'data' file in the device coredump.
- Save telemetry controller-initiated log if available
- Make coredump procedure into two phases (before resetting controller and
  after resetting as soon as admin queue is available).

Akinobu Mita (7):
  devcoredump: use memory_read_from_buffer
  devcoredump: fix typo in comment
  devcoredump: allow to create several coredump files in one device
  nvme.h: add telemetry log page definisions
  nvme: add facility to check log page attributes
  nvme-pci: add device coredump support
  nvme-pci: trigger device coredump on command timeout

 drivers/base/devcoredump.c  | 168 ++++++++++------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/core.c    |   2 +
 drivers/nvme/host/nvme.h    |   1 +
 drivers/nvme/host/pci.c     | 460 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/devcoredump.h |  33 ++++
 include/linux/nvme.h        |  25 +++
 7 files changed, 617 insertions(+), 73 deletions(-)

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
-- 
2.7.4
