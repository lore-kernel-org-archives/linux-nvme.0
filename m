From: jsmart2021@gmail.com (James Smart)
Date: Wed, 10 May 2017 12:06:58 -0700
Subject: [PATCH 00/15] lpfc updates for 11.2.0.14
Message-ID: <20170510190713.30171-1-jsmart2021@gmail.com>

This patch set provides a number of bug fixes, code cleanups, and error
handling, mostly in the nvme area of lpfc.

There is one new feature in the series to add MDS diagnostics support

The patches were cut against the Martin's 4.12/scsi-fixes tree.
There are no outside dependencies. The patches should merge via
Martin's tree. 


James Smart (15):
  lpfc: Fix used-RPI accounting problem.
  lpfc: Fix system crash when port is reset.
  lpfc: Adding additional stats counters for nvme.
  lpfc: Fix nvmet RQ resource needs for large block writes.
  lpfc: Fix NVMEI driver not decrementing counter causing bad rport
    state.
  lpfc: Fix NMI watchdog assertions when running nvmet IOPS tests
  lpfc: Separate NVMET data buffer pool fir ELS/CT.
  lpfc: Separate NVMET RQ buffer posting from IO resources
    SGL/iocbq/context
  lpfc: Added recovery logic for running out of NVMET IO context
    resources
  lpfc: Fix NVME I+T not registering NVME as a supported FC4 type
  lpfc: Fix debugfs root inode "lpfc" not getting deleted on driver
    unload.
  lpfc: Cleanup entry_repost settings on SLI4 queues
  lpfc: Fix NVMEI's handling of NVMET's PRLI response attributes
  lpfc: Add MDS Diagnostic support.
  lpfc: update version to 11.2.0.14

 drivers/scsi/lpfc/lpfc.h           |  23 ++-
 drivers/scsi/lpfc/lpfc_attr.c      |  45 ++--
 drivers/scsi/lpfc/lpfc_crtn.h      |  11 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   1 +
 drivers/scsi/lpfc/lpfc_debugfs.c   |  69 ++++---
 drivers/scsi/lpfc/lpfc_disc.h      |   1 +
 drivers/scsi/lpfc/lpfc_els.c       |  19 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c   |   9 +-
 drivers/scsi/lpfc/lpfc_hw4.h       |  16 +-
 drivers/scsi/lpfc/lpfc_init.c      | 137 ++++--------
 drivers/scsi/lpfc/lpfc_mem.c       | 100 +++------
 drivers/scsi/lpfc/lpfc_nportdisc.c |   6 +
 drivers/scsi/lpfc/lpfc_nvmet.c     | 412 ++++++++++++++++++++++++++++++-------
 drivers/scsi/lpfc/lpfc_nvmet.h     |  14 +-
 drivers/scsi/lpfc/lpfc_sli.c       | 357 +++++++++++++++++++++++++-------
 drivers/scsi/lpfc/lpfc_sli4.h      |  18 +-
 drivers/scsi/lpfc/lpfc_version.h   |   2 +-
 17 files changed, 829 insertions(+), 411 deletions(-)

-- 
2.11.0
