From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 26 Sep 2018 09:25:30 -0700
Subject: [PATCH v2 0/5] qla2xxx: Add FC-NVMe Target support
Message-ID: <20180926162535.24314-1-himanshu.madhani@cavium.com>

Hi Martin, 

This series adds support for FC-NVMe Target.

Patch #1 addes new qla_nvmet files for FC-NVMe Target support.
Patch #2 adds Kconfig and Makefile changes to prepare code compile.
Patch #3, #4 has bulk of changes to handle FC-NVMe Target LS4 processing 
         via Purex pass through path.
Patch #4 adds SysFS hook to enable NVMe Target for the port.

Note: All the patches in this series must be applied before they can be compilable.

Please apply them to 4.20/scsi-queue

Changes from v1 -> v2
o Addressed all comments from Bart.
o Consolidated Patch 1 and Patch 2 into single patch.
o Fixed smatch warning reported by kbuild autommation.
o NVMe Target mode is exclusive at the moment. Qlogic driver does not support both
  FCP Target and NVMe Target at the same time. This will be fixed in later updates.
 
Thanks,
Himanshu

Anil Gurumurthy (4):
  qla2xxx_nvmet: Add files for FC-NVMe Target support
  qla2xxx_nvmet: Add FC-NVMe Target Link Service request handling
  qla2xxx_nvmet: Add FC-NVMe Target handling
  qla2xxx_nvmet: Add SysFS node for FC-NVMe Target

Himanshu Madhani (1):
  qla2xxx: Update driver version to 11.00.00.00-k

 drivers/scsi/qla2xxx/Makefile      |   3 +-
 drivers/scsi/qla2xxx/qla_attr.c    |  33 ++
 drivers/scsi/qla2xxx/qla_dbg.c     |   1 +
 drivers/scsi/qla2xxx/qla_dbg.h     |   2 +
 drivers/scsi/qla2xxx/qla_def.h     |  35 +-
 drivers/scsi/qla2xxx/qla_fw.h      | 263 ++++++++++
 drivers/scsi/qla2xxx/qla_gbl.h     |  17 +-
 drivers/scsi/qla2xxx/qla_gs.c      |  16 +-
 drivers/scsi/qla2xxx/qla_init.c    |  49 +-
 drivers/scsi/qla2xxx/qla_iocb.c    |  42 +-
 drivers/scsi/qla2xxx/qla_isr.c     | 112 ++++-
 drivers/scsi/qla2xxx/qla_mbx.c     | 101 +++-
 drivers/scsi/qla2xxx/qla_nvme.h    |  33 --
 drivers/scsi/qla2xxx/qla_nvmet.c   | 798 ++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_nvmet.h   | 129 +++++
 drivers/scsi/qla2xxx/qla_os.c      |  77 ++-
 drivers/scsi/qla2xxx/qla_target.c  | 977 ++++++++++++++++++++++++++++++++++++-
 drivers/scsi/qla2xxx/qla_target.h  |  90 ++++
 drivers/scsi/qla2xxx/qla_version.h |   4 +-
 19 files changed, 2708 insertions(+), 74 deletions(-)
 create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.c
 create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.h

-- 
2.12.0
