From: mlin@kernel.org (Ming Lin)
Date: Mon, 25 Apr 2016 14:33:20 -0700
Subject: [PATCH v2] nvme: add helper nvme_cleanup_cmd()
Message-ID: <1461620000-18707-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

This hides command cleanup into nvme.h and fabrics drivers will
also use it.

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/nvme.h | 6 ++++++
 drivers/nvme/host/pci.c  | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

v2:
  - make this a static inline in nvme.h

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e8fae8..8c363ab 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -181,6 +181,12 @@ static inline unsigned nvme_map_len(struct request *rq)
 		return blk_rq_bytes(rq);
 }
 
+static inline void nvme_cleanup_cmd(struct request *req)
+{
+	if (req->cmd_flags & REQ_DISCARD)
+		kfree(req->completion_data);
+}
+
 static inline int nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
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
