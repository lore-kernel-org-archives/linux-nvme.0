From: keith.busch@intel.com (Keith Busch)
Date: Thu,  2 Aug 2012 14:05:59 -0600
Subject: [PATCH] NVMe: Free cmdid of nvme_submit_bio error
Message-ID: <1343937959-7836-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 3278fbd..15670ca 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -545,6 +545,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	u16 control;
 	u32 dsmgmt;
 	int psegs = bio_phys_segments(ns->queue, bio);
+	nvme_completion_fn fn;
 
 	if ((bio->bi_rw & REQ_FLUSH) && psegs) {
 		result = nvme_submit_flush_data(nvmeq, ns);
@@ -588,7 +589,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 
 	result = nvme_map_bio(nvmeq->q_dmadev, iod, bio, dma_dir, psegs);
 	if (result < 0)
-		goto free_iod;
+		goto free_cmdid;
 	length = result;
 
 	cmnd->rw.command_id = cmdid;
@@ -608,6 +609,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 
 	return 0;
 
+ free_cmdid:
+	free_cmdid(nvmeq, cmdid, &fn);
  free_iod:
 	nvme_free_iod(nvmeq->dev, iod);
  nomem:
-- 
1.7.0.4
