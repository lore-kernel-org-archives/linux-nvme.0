From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Thu, 21 Dec 2017 23:31:36 -0800
Subject: [PATCH 00/11] mpt3sas: Enable scsi MQ & lockless command submission
Message-ID: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>

From: Hannes Reinecke <hare@suse.de>

Hi all,

This patch set is initially posted by Hannes Reinecke to enable scsi
multiqueue for the mpt3sas driver.
While the HBA only has a single mailbox register for submitting commands,
it does have individual receive queues per MSI-X interrupt and as such
does benefit from converting it to full multiqueue support. 

Suganath Prabu S (11):
  mpt3sas: set default value for cb_idx
  mpt3sas: use list_splice_init()
  mpt3sas: separate out _base_recovery_check()
  mpt3sas: open-code _scsih_scsi_lookup_get()
  mpt3sas: Introduce mpt3sas_get_st_from_smid()
  mpt3sas: check command status before attempting abort
  mpt3sas: always use first reserved smid for ioctl      passthrough
  mpt3sas: simplify task management functions
  mpt3sas: simplify mpt3sas_scsi_issue_tm()
  mpt3sas: simplify _wait_for_commands_to_complete()
  mpt3sas: lockless command submission

 drivers/scsi/mpt3sas/modules.order       |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c      | 199 +++++++++++----------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  29 ++-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  31 ++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 292 +++++++------------------------
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c |  33 +---
 6 files changed, 192 insertions(+), 394 deletions(-)

Thanks,
Suganath Prabu S
-- 
2.5.5
