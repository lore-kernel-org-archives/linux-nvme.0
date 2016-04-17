From: mlin@kernel.org (Ming Lin)
Date: Sat, 16 Apr 2016 22:35:46 -0700
Subject: [PATCH] nvme: add helper nvme_cleanup_cmd()
Message-ID: <1460871346-10811-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

This hides command cleanup into core.c and fabrics drivers will
also use it.

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/pci.c  | 3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4eb5759..7dd9905 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -243,6 +243,13 @@ int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
+void nvme_cleanup_cmd(struct request *req)
+{
+	if (req->cmd_flags & REQ_DISCARD)
+		kfree(req->completion_data);
+}
+EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e8fae8..4f9ddbf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -220,6 +220,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 void nvme_requeue_req(struct request *req);
 int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
+void nvme_cleanup_cmd(struct request *req);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff3c8d7..0569cbf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -363,8 +363,7 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	__le64 **list = iod_list(req);
 	dma_addr_t prp_dma = iod->first_dma;
 
-	if (req->cmd_flags & REQ_DISCARD)
-		kfree(req->completion_data);
+	nvme_cleanup_cmd(req);
 
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
-- 
1.9.1
