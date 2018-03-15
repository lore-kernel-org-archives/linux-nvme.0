From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 14 Mar 2018 20:34:51 -0700
Subject: [PATCH v2 00/13] qla2xxx: Fixes for FC-NVMe
Message-ID: <20180315033504.12628-1-himanshu.madhani@cavium.com>

Hi Martin,

This patch series addresses issue with FC-NVMe abort handling in the
driver. Code has been cleaned up and devloss timeout support has been
added in qla2xxx.

Please apply this series to 4.17/scsi-queue at your earliest convenience.

Hi Christoph, Sagi, Johannes, James,

Please review this series. I would however like this to be merged via
Martin's SCSI tree.

Changes from v1-> v2
- Added reviewed-by tags for Hannes.
- Fixes build warning reported by kbuild robot

Thanks,
Himanshu 


Darren Trapp (10):
  qla2xxx: Set IIDMA and fcport state before qla_nvme_register_remote()
  qla2xxx: Add changes for devloss timeout in driver
  qla2xxx: Restore ZIO threshold setting
  qla2xxx: Add FC-NVMe abort processing
  qla2xxx: Fix n2n_ae flag to prevent dev_loss on PDB change
  qla2xxx: Return busy if rport going away
  qla2xxx: Remove nvme_done_list
  qla2xxx: Fix retry for PRLI RJT with reason of BUSY
  qla2xxx: Fix FC-NVMe IO abort during driver reset
  qla2xxx: Cleanup code to improve FC-NVMe error handling

Himanshu Madhani (2):
  qla2xxx: Remove unneeded message and minor cleanup for FC-NVMe
  qla2xxx: Update driver version to 10.00.00.06-k

Quinn Tran (1):
  qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan

 drivers/scsi/qla2xxx/qla_dbg.c     |   2 +-
 drivers/scsi/qla2xxx/qla_def.h     |  12 +-
 drivers/scsi/qla2xxx/qla_gbl.h     |   4 +-
 drivers/scsi/qla2xxx/qla_gs.c      | 274 ++++++++++++++++++++++++++++---------
 drivers/scsi/qla2xxx/qla_init.c    |  35 +++--
 drivers/scsi/qla2xxx/qla_isr.c     |  78 ++++-------
 drivers/scsi/qla2xxx/qla_mbx.c     |  10 +-
 drivers/scsi/qla2xxx/qla_mid.c     |   6 -
 drivers/scsi/qla2xxx/qla_nvme.c    | 245 +++++++++++++++------------------
 drivers/scsi/qla2xxx/qla_nvme.h    |   9 +-
 drivers/scsi/qla2xxx/qla_os.c      |  11 +-
 drivers/scsi/qla2xxx/qla_target.c  |  13 +-
 drivers/scsi/qla2xxx/qla_target.h  |   2 +-
 drivers/scsi/qla2xxx/qla_version.h |   2 +-
 14 files changed, 416 insertions(+), 287 deletions(-)

-- 
2.12.0
