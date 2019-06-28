From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 28 Jun 2019 09:53:28 -0700
Subject: [PATCH v5 0/3] NVMe 1.4 Identify Namespace Support
Message-ID: <20190628165331.163919-1-bvanassche@acm.org>

Hi Christoph,

This patch series adds support for several of the new parameters introduced
in the NVMe 1.4 Identify Namespace command. Please consider these patches
for kernel version 5.3.

Thanks,

Bart.

Changes compared to v4:
- Left out the empty file I/O backend function nvmet_file_set_limits().
- Left out the reference to NVMe 1.4 in a nvmet_bdev_set_limits() comment.
- Moved the nvmet_file_set_limits() function into the nvmet.h header file.
- In the initiator code, only use the NAWUPF / AWUPF value if NABO == 0.
- Fixed an endianness issue in the initiator code.

Changes compared to v3:
- In the file backend code, do not set any of the namespace atomic properties.

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

Bart Van Assche (3):
  nvme: Introduce NVMe 1.4 Identify Namespace fields in struct
    nvme_id_ns
  nvmet: Export NVMe namespace attributes
  nvme: Set physical block size and optimal I/O size according to NVMe
    1.4

 drivers/nvme/host/core.c          | 34 +++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/io-cmd-bdev.c | 39 +++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  8 +++++++
 include/linux/nvme.h              | 12 +++++++---
 6 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog
