From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:50:04 +0200
Subject: [PATCH 6/7] nvmet/fc: properly endian swap sq_head
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-7-hch@lst.de>

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 4392b514725b..62eba29c85fb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1700,7 +1700,7 @@ nvmet_fc_prep_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
 	    xfr_length != fod->total_length ||
 	    (le16_to_cpu(cqe->status) & 0xFFFE) || cqewd[0] || cqewd[1] ||
 	    (sqe->flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND)) ||
-	    queue_90percent_full(fod->queue, cqe->sq_head))
+	    queue_90percent_full(fod->queue, le16_to_cpu(cqe->sq_head)))
 		send_ersp = true;
 
 	/* re-set the fields */
-- 
2.11.0
