From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:44 +0100
Subject: [PATCH 10/13] nvme-mpath: remove I/O polling support
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-11-hch@lst.de>

The ->poll_fn has been stale for a while, as a lot of places check for mq
ops.  But there is no real point in it anyway, as we don't even use
the multipath code for subsystems without multiple ports, which is usually
what we do high performance I/O to.  If it really becomes an issue we
should rework the nvme code to also skip the multipath code for any
private namespace, even if that could mean some trouble when rescanning.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/multipath.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ffebdd0ae34b..ec310b1b9267 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,21 +220,6 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	return ret;
 }
 
-static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc, bool spin)
-{
-	struct nvme_ns_head *head = q->queuedata;
-	struct nvme_ns *ns;
-	int found = 0;
-	int srcu_idx;
-
-	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = srcu_dereference(head->current_path[numa_node_id()], &head->srcu);
-	if (likely(ns && nvme_path_is_optimized(ns)))
-		found = ns->queue->poll_fn(q, qc, spin);
-	srcu_read_unlock(&head->srcu, srcu_idx);
-	return found;
-}
-
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
@@ -281,7 +266,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		goto out;
 	q->queuedata = head;
 	blk_queue_make_request(q, nvme_ns_head_make_request);
-	q->poll_fn = nvme_ns_head_poll;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
-- 
2.19.1
