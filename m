From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue, 11 Apr 2017 11:32:27 -0700
Subject: [PATCH v2 0/5] nvmet_fc: bug fixes and lldd api mods
Message-ID: <20170411183232.8955-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

This patch set contains modifications to the lldd api on the target
side to specify isr vs threaded calling contexts, address the manner in
which the transport releases io contexts back to the lldd, and addresses
the abort interface.

Any modifications to the lpfc driver are isolated to nvme-specific files.
Therefore any mods should be able to go in through the blk tree and avoid
the scsi tree.

No changes were made from the prior posting. The patches were recut
on the latest block for-4.12/block branch


James Smart (5):
  nvmet_fc: add target feature flags for upcall isr  contexts
  nvmet_fc: add req_release to lldd api
  nvme_fcloop: split job struct from transport for req_release
  nvmet_fc: Rework target side abort handling
  nvmet_fc: add missing reference in add_port

 drivers/nvme/target/fc.c       | 251 +++++++++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c   | 197 ++++++++++++++++++++++++++------
 drivers/scsi/lpfc/lpfc_nvmet.c | 126 ++++++++++++++++-----
 drivers/scsi/lpfc/lpfc_nvmet.h |   7 +-
 include/linux/nvme-fc-driver.h |  98 +++++++++++-----
 5 files changed, 523 insertions(+), 156 deletions(-)

-- 
2.9.3
