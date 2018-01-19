From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Fri, 19 Jan 2018 12:29:23 -0800
Subject: [PATCH 0/5] qla2xxx: Fixes for FC-NVMe erorr path. 
Message-ID: <20180119202928.13239-1-himanshu.madhani@cavium.com>

Hi Christoph,

This series has mostly cleanup and support for devloss timeout in qla2xxx
driver for FC-NVMe protocol. 

Please consider this series for inclusion in 4.16

Thanks,
Himanshu

Darren Trapp (3):
  qla2xxx: Set IIDMA and fcport state before qla_nvme_register_remote()
  qla2xxx: Add changes for devloss timeout in driver
  qla2xxx: Restore ZIO threshold setting

Himanshu Madhani (2):
  qla2xxx: Remove unneeded message and minor cleanup for FC-NVMe
  qla2xxx: Update driver version to 10.00.00.06-k

 drivers/scsi/qla2xxx/qla_def.h     |   1 +
 drivers/scsi/qla2xxx/qla_init.c    |  13 ++-
 drivers/scsi/qla2xxx/qla_isr.c     |   5 +-
 drivers/scsi/qla2xxx/qla_nvme.c    | 158 +++++++++++++++----------------------
 drivers/scsi/qla2xxx/qla_nvme.h    |   6 +-
 drivers/scsi/qla2xxx/qla_target.c  |  13 +--
 drivers/scsi/qla2xxx/qla_target.h  |   2 +-
 drivers/scsi/qla2xxx/qla_version.h |   2 +-
 8 files changed, 94 insertions(+), 106 deletions(-)

-- 
2.12.0
