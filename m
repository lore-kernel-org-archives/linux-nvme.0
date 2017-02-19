From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 19 Feb 2017 19:59:06 +0200
Subject: [PATCH 2/2] nvmet-rdma: use nvme cm status helper
In-Reply-To: <1487527146-5358-1-git-send-email-maxg@mellanox.com>
References: <1487527146-5358-1-git-send-email-maxg@mellanox.com>
Message-ID: <1487527146-5358-2-git-send-email-maxg@mellanox.com>

Also remove redundant debug prints.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/rdma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6099022..5d189c0 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1041,6 +1041,9 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 {
 	struct nvme_rdma_cm_rej rej;
 
+	pr_debug("rejecting connect request: status %d (%s)\n",
+		 status, nvme_rdma_cm_msg(status));
+
 	rej.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
 	rej.sts = cpu_to_le16(status);
 
@@ -1135,7 +1138,6 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 out_free_queue:
 	kfree(queue);
 out_reject:
-	pr_debug("rejecting connect request with status code %d\n", ret);
 	nvmet_rdma_cm_reject(cm_id, ret);
 	return NULL;
 }
@@ -1188,7 +1190,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 
 	ndev = nvmet_rdma_find_get_device(cm_id);
 	if (!ndev) {
-		pr_err("no client data!\n");
 		nvmet_rdma_cm_reject(cm_id, NVME_RDMA_CM_NO_RSC);
 		return -ECONNREFUSED;
 	}
-- 
1.7.1
