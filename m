From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:02:59 -0700
Subject: [PATCH 00/10] outstanding nvme_fc/nvmet_fc fixes
Message-ID: <20170513190309.25417-1-jsmart2021@gmail.com>

This set contains outstanding fixes for the nvmf fc transport.
All but the last patch has been previously posted.

patches cut against nvme-4.12

James Smart (10):
  nvme_fc: get rid of local reconnect_delay
  nvme_fc: Support ctrl_loss_tmo
  nvme_fc: replace ioabort msleep loop with completion
  nvme_fc: revise comment on teardown
  nvme_fc: set logging level on resets/deletes
  nvmet_fc: Reduce work_q count
  nvmet_fc: Add queue create and delete callbacks in LLDD api
  nvme_fc: remove extra controller reference taken on reconnect
  nvme_fcloop: fix port deletes and callbacks
  nvme_fc: correct nvme status set on abort

 drivers/nvme/host/fc.c         | 160 +++++++++++++----------------
 drivers/nvme/target/fc.c       | 224 +++++++++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c   |  66 ++++++------
 include/linux/nvme-fc-driver.h |  18 ++++
 4 files changed, 292 insertions(+), 176 deletions(-)

-- 
2.11.0
