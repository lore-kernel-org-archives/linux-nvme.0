From: mlin@kernel.org (Ming Lin)
Date: Wed, 13 Jul 2016 14:26:34 -0700
Subject: [PATCH 0/2] nvme-rdma: device removal crash fixes
Message-ID: <1468445196-6915-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Here are 2 fixes for the device removal crash.

Steve,

Could you review and add tag if you feel OK?
Thanks again for your great debug.

Ming Lin (2):
  nvme-rdma: grab reference for device removal event
  nvme-rdma: move admin queue cleanup to nvme_rdma_free_ctrl

 drivers/nvme/host/rdma.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
1.9.1
