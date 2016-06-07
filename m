From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Tue,  7 Jun 2016 06:36:56 +0000
Subject: [RFC 8/8] nvme/loop: Add support for bio integrity handling
In-Reply-To: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
References: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
Message-ID: <1465281416-28355-9-git-send-email-nab@linux-iscsi.org>

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch adds support for nvme/loop block integrity,
based upon the reported ID_NS.ms + ID_NS.dps feature
bits in nvmet_execute_identify_ns().

Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Martin Petersen <martin.petersen at oracle.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Hannes Reinecke <hare at suse.de>
Cc: Mike Christie <michaelc at cs.wisc.edu>
Signed-off-by: Nicholas Bellinger <nab at linux-iscsi.org>
---
 drivers/nvme/target/loop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 08b4fbb..b4b4da9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -42,6 +42,7 @@ struct nvme_loop_iod {
 	struct nvme_loop_queue	*queue;
 	struct work_struct	work;
 	struct sg_table		sg_table;
+	struct scatterlist	meta_sg;
 	struct scatterlist	first_sgl[];
 };
 
@@ -193,6 +194,24 @@ static int nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		BUG_ON(iod->req.sg_cnt > req->nr_phys_segments);
 	}
 
+	if (blk_integrity_rq(req)) {
+		int count;
+
+		if (blk_rq_count_integrity_sg(hctx->queue, req->bio) != 1)
+			BUG_ON(1);
+
+		sg_init_table(&iod->meta_sg, 1);
+		count = blk_rq_map_integrity_sg(hctx->queue, req->bio,
+						&iod->meta_sg);
+
+		iod->req.prot_sg = &iod->meta_sg;
+		iod->req.prot_sg_cnt = 1;
+#if 0
+		printk("nvme/loop: Set prot_sg %p and prot_sg_cnt: %d\n",
+			iod->req.prot_sg, iod->req.prot_sg_cnt);
+#endif
+	}
+
 	iod->cmd.common.command_id = req->tag;
 	blk_mq_start_request(req);
 
-- 
1.9.1
