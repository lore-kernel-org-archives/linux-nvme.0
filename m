From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 16:27:24 -0700
Subject: [PATCH 0/5] nvme: remove FC transport status values
Message-ID: <20170907232729.28763-1-jsmart2021@gmail.com>

The NVM express group recinded the reserved range for the transport.
Remove the FC-centric values that had been defined and convert the
FC transport and LLDD to use generic values.

*** BLURB HERE ***

James Smart (5):
  nvme: remove FC transport-specific error values
  nvme-fc: remove use of FC-specific error codes
  nvmet-fc: remove use of FC-specific error codes
  nvmet-fcloop: remove use of FC-specific error codes
  lpfc: remove use of FC-specific error codes

 drivers/nvme/host/fc.c        |  8 ++++----
 drivers/nvme/target/fc.c      |  9 +++------
 drivers/nvme/target/fcloop.c  |  2 +-
 drivers/scsi/lpfc/lpfc_nvme.c |  2 +-
 include/linux/nvme.h          | 13 -------------
 5 files changed, 9 insertions(+), 25 deletions(-)

-- 
2.13.1
