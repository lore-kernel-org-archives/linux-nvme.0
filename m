From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:43:16 -0700
Subject: [PATCH 0/5] nvmet_fc: bug fixes and lldd api mods
Message-ID: <20170324034321.8719-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

This patch set contains modifications to the lldd api on the target
side to specify isr vs threaded calling contexts, address the manner in
which the transport releases io contexts back to the lldd, and addresses
the abort interface.

Any modifications to the lpfc driver are isolated to nvme-specific files.
Therefore any mods should be able to go in through the blk tree and avoid
the scsi tree.


James Smart (5):
  nvmet_fc: add target feature flags for upcall isr contexts
  nvmet_fc: add req_release to lldd api
  nvme_fcloop: split job struct from transport for req_release
  nvmet_fc: Rework target side abort handling
  nvmet_fc: add missing reference in add_port

 drivers/nvme/target/fc.c       | 251 +++++++++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c   | 197 ++++++++++++++++++++++++++------
 drivers/scsi/lpfc/lpfc_nvmet.c | 126 ++++++++++++++++-----
 drivers/scsi/lpfc/lpfc_nvmet.h |   7 +-
 include/linux/nvme-fc-driver.h |  97 +++++++++++-----
 5 files changed, 523 insertions(+), 155 deletions(-)

-- 
2.9.3
