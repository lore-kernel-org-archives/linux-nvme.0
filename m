From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 17 Jun 2019 09:12:19 -0700
Subject: [PATCH v3 0/3] NVMe 1.4 Identify Namespace Support
Message-ID: <20190617161222.253849-1-bvanassche@acm.org>

Hi Christoph,

This patch series adds support for several of the new parameters introduced
in the NVMe 1.4 Identify Namespace command. Please consider these patches
for kernel version 5.3.

Thanks,

Bart.

Changes compared to v2:
- In the initiator, use AWUPF instead NAWUPF if NAWUPF == 0.

Changes compared to v1:
- Added a patch for the NVMe target code that exports these parameters.
- Limited the physical block size to the value of AWUPF/NAWUPF as appropriate.

Bart Van Assche (3):
  nvme: Introduce NVMe 1.4 Identify Namespace fields in struct
    nvme_id_ns
  nvmet: Export NVMe namespace attributes
  nvme: Set physical block size and optimal I/O size according to NVMe
    1.4

 drivers/nvme/host/core.c          | 30 +++++++++++++++++++--
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/target/admin-cmd.c   |  5 ++++
 drivers/nvme/target/io-cmd-bdev.c | 45 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 37 +++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  2 ++
 include/linux/nvme.h              | 12 ++++++---
 7 files changed, 127 insertions(+), 5 deletions(-)

-- 
2.22.0.rc3
