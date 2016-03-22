From: mlin@kernel.org (Ming Lin)
Date: Tue, 22 Mar 2016 00:24:43 -0700
Subject: [PATCH v2 1/4] nvme: add helper nvme_map_len()
In-Reply-To: <1458631486-14120-1-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
Message-ID: <1458631486-14120-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

The helper returns the number of bytes that need to be mapped
using PRPs/SGL entries.

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/nvme.h |  8 ++++++++
 drivers/nvme/host/pci.c  | 13 +++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75982b9..331d437 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -181,6 +181,14 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return (sector >> (ns->lba_shift - 9));
 }
 
+static inline unsigned nvme_map_len(struct request *rq)
+{
+	if (rq->cmd_flags & REQ_DISCARD)
+		return sizeof(struct nvme_dsm_range);
+	else
+		return blk_rq_bytes(rq);
+}
+
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4301584..2db6f89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -348,16 +348,11 @@ static __le64 **iod_list(struct request *req)
 	return (__le64 **)(iod->sg + req->nr_phys_segments);
 }
 
-static int nvme_init_iod(struct request *rq, struct nvme_dev *dev)
+static int nvme_init_iod(struct request *rq, unsigned size,
+		struct nvme_dev *dev)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(rq);
 	int nseg = rq->nr_phys_segments;
-	unsigned size;
-
-	if (rq->cmd_flags & REQ_DISCARD)
-		size = sizeof(struct nvme_dsm_range);
-	else
-		size = blk_rq_bytes(rq);
 
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
 		iod->sg = kmalloc(nvme_iod_alloc_size(dev, size, nseg), GFP_ATOMIC);
@@ -651,6 +646,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
 	struct nvme_command cmnd;
+	unsigned map_len;
 	int ret = BLK_MQ_RQ_QUEUE_OK;
 
 	/*
@@ -666,7 +662,8 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	}
 
-	ret = nvme_init_iod(req, dev);
+	map_len = nvme_map_len(req);
+	ret = nvme_init_iod(req, map_len, dev);
 	if (ret)
 		return ret;
 
-- 
1.9.1
