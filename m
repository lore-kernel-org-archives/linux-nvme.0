From: jsmart2021@gmail.com (James Smart)
Date: Mon, 22 May 2017 15:28:41 -0700
Subject: [PATCH v3 0/3] outstanding nvme_fc/nvmet_fc fixes
Message-ID: <20170522222844.22494-1-jsmart2021@gmail.com>

This is the remaining outstanding patches, reworked for the
prior review comments.

cut against nvme-4.12

-- james

James Smart (3):
  nvme_fc: replace ioabort msleep loop with completion
  nvmet_fc: Reduce work_q count
  nvme_fcloop: fix port deletes and callbacks

 drivers/nvme/host/fc.c       |  14 +--
 drivers/nvme/target/fc.c     | 206 ++++++++++++++++++++++++++++++++-----------
 drivers/nvme/target/fcloop.c |  86 ++++++++----------
 3 files changed, 199 insertions(+), 107 deletions(-)

-- 
2.11.0
