From: vishal.l.verma@intel.com (Vishal Verma)
Date: Mon,  4 Mar 2013 18:40:55 -0700
Subject: [PATCH v3 0/3] NVMe: Add support for SG_IO
Message-ID: <1362447658-25695-1-git-send-email-vishal.l.verma@intel.com>

These patches allow the nvme driver to handle the SG_IO ioctl.
Applications may send any supported SCSI Command through the
SG_IO framework. The supported command list as well as the
translation reference is available on www.nvmexpress.org

Vishal Verma (3):
  NVMe: Rename nvme.c to nvme-core.c
  NVMe: Move dev, ns, iod structs to nvme.c
  NVMe: Add nvme-scsi.c

 drivers/block/Makefile    |    1 +
 drivers/block/nvme-core.c | 1760 +++++++++++++++++++++++++++
 drivers/block/nvme-scsi.c | 2941 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/block/nvme.c      | 1808 ----------------------------
 include/linux/nvme.h      |  107 ++
 5 files changed, 4809 insertions(+), 1808 deletions(-)
 create mode 100644 drivers/block/nvme-core.c
 create mode 100644 drivers/block/nvme-scsi.c
 delete mode 100644 drivers/block/nvme.c
