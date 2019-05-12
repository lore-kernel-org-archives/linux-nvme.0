From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 13 May 2019 00:54:10 +0900
Subject: [PATCH v3 0/7] nvme-pci: support device coredump
Message-ID: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>

This enables to collect snapshot of controller information via device
coredump mechanism.  The nvme device coredump is triggered when command
timeout occurs, and can also be triggered by writing sysfs attribute.

After finishing the nvme device coredump, the following files are created.

 - regs: NVMe controller registers (00h to 4Fh)
 - sq<qid>: Submission queue
 - cq<qid>: Completion queue
 - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
 - data: Empty

The device coredump mechanism currently allows drivers to create only a
single coredump file, so this also provides a new function that allows
drivers to create several device coredump files in one crashed device.

* v3
- Merge 'add telemetry log page definisions' patch and 'add facility to
  check log page attributes' patch
- Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli
- Add BUILD_BUG_ON for the size of struct nvme_telemetry_log_page_hdr
- Fix typo s/machanism/mechanism/ in commit log
- Fix max transfer size calculation for get log page
- Add function comments
- Extract 'enable to trigger device coredump by hand' patch
- Don't try to get telemetry log when admin queue is not available
- Avoid deadlock in .coredump callback

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
  nvme: add basic facility to get telemetry log page
  nvme-pci: add device coredump infrastructure
  nvme-pci: trigger device coredump on command timeout
  nvme-pci: enable to trigger device coredump by hand

 drivers/base/devcoredump.c  | 168 +++++++++------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/core.c    |   3 +
 drivers/nvme/host/nvme.h    |   1 +
 drivers/nvme/host/pci.c     | 494 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/devcoredump.h |  33 +++
 include/linux/nvme.h        |  17 ++
 7 files changed, 644 insertions(+), 73 deletions(-)

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
-- 
2.7.4
