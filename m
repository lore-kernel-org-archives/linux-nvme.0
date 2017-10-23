From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 23 Oct 2017 12:59:27 +0300
Subject: [PATCH 1/1] nvme-rdma: align nvme_rdma_device structure
Message-ID: <1508752767-22939-1-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff..01b9505 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -50,8 +50,8 @@
 	(NVME_AQ_DEPTH - NVME_RDMA_NR_AEN_COMMANDS)
 
 struct nvme_rdma_device {
-	struct ib_device       *dev;
-	struct ib_pd	       *pd;
+	struct ib_device	*dev;
+	struct ib_pd		*pd;
 	struct kref		ref;
 	struct list_head	entry;
 };
-- 
1.7.1
