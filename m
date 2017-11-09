From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 8 Nov 2017 19:17:50 -0800
Subject: [PATCH v2 0/4] qla2xxx: Add FC-NVMe Target support
Message-ID: <20171109031754.10270-1-himanshu.madhani@cavium.com>

Hi Christoph/Sagi, 

I've corrected the mailing list and maintainers for this series. 

This series adds support for FC-NVMe Target.

Patch #1 addes new qla_nvmet files for FC-NVMe Target support.
Patch #2 adds Kconfig and Makefile changes to prepare code compile.
Patch #3 and #4 has bulk of changes to handle FC-NVMe Target LS4
processing via Purex pass through path.

Note: All the patches in this series must be applied before they can be compilable.

These patches were cut against 4.15/scsi-queue.

Changes from v1 -> v2

o Fixed 0-day kernel warning and build regression.

Thanks,
Himanshu 

Anil Gurumurthy (4):
  qla2xxx_nvmet: Add files for FC-NVMe Target support
  qla2xxx_nvmet: Added Makefile and Kconfig changes
  qla2xxx_nvmet: Add FC-NVMe Target LS request handling
  qla2xxx_nvmet: Add FC-NVMe Target handling

 drivers/scsi/qla2xxx/Kconfig      |   1 +
 drivers/scsi/qla2xxx/Makefile     |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.c    |   1 +
 drivers/scsi/qla2xxx/qla_dbg.h    |   2 +
 drivers/scsi/qla2xxx/qla_def.h    |  35 +-
 drivers/scsi/qla2xxx/qla_fw.h     | 263 +++++++++++
 drivers/scsi/qla2xxx/qla_gbl.h    |  17 +-
 drivers/scsi/qla2xxx/qla_gs.c     |  15 +-
 drivers/scsi/qla2xxx/qla_init.c   |  49 +-
 drivers/scsi/qla2xxx/qla_iocb.c   |  42 +-
 drivers/scsi/qla2xxx/qla_isr.c    |  70 +++
 drivers/scsi/qla2xxx/qla_mbx.c    | 100 +++-
 drivers/scsi/qla2xxx/qla_nvme.h   |  33 --
 drivers/scsi/qla2xxx/qla_nvmet.c  | 783 ++++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_nvmet.h  | 130 ++++++
 drivers/scsi/qla2xxx/qla_os.c     |  75 ++-
 drivers/scsi/qla2xxx/qla_target.c | 932 +++++++++++++++++++++++++++++++++++++-
 drivers/scsi/qla2xxx/qla_target.h |  93 +++-
 18 files changed, 2585 insertions(+), 59 deletions(-)
 create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.c
 create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.h

-- 
2.12.0
