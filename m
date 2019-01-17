From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 17 Jan 2019 11:14:43 -0500
Subject: [PATCH 0/2] Fix use-after-free errors in lpfc driver when using NVMe
Message-ID: <20190117161445.25671-1-emilne@redhat.com>

These two patches fix use-after-free errors in the shutdown path of the lpfc
driver with both the Initiator and Target mode usage of FC ports.

The problem is very apparent with slub_debug enabled, as the memory poisoning
prevents the wait_for_completion_timeout() from returning after the object
has been freed.

Ewan D. Milne (2):
  lpfc: nvme: avoid hang / use-after-free when destroying localport
  lpfc: nvmet: avoid hang / use-after-free when destroying targetport

 drivers/scsi/lpfc/lpfc_nvme.c  | 16 +++++++++-------
 drivers/scsi/lpfc/lpfc_nvme.h  |  2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c |  8 +++++---
 drivers/scsi/lpfc/lpfc_nvmet.h |  2 +-
 4 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.1.0
