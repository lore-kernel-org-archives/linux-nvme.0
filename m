From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  3 Sep 2018 03:47:07 -0700
Subject: [PATCH v2] nvmet-rdma: fix possible bogus dereference under heavy load
Message-ID: <20180903104707.5776-1-sagi@grimberg.me>

Currently we always repost the recv buffer before we send a response
capsule back to the host. Since ordering is not guaranteed for send
and recv completions, it is posible that we will receive a new request
from the host before we got a send completion for the response capsule.

Today, we pre-allocate 2x rsps the length of the queue, but in reality,
under heavy load there is nothing that is really preventing the gap to
expand until we exhaust all our rsps.

To fix this, if we don't have any pre-allocated rsps left, we dynamically
allocate a rsp and make sure to free it when we are done. If under memory
pressure we fail to allocate a rsp, we silently drop the command and
wait for the host to retry.

Reported-by: Steve Wise <swise at opengridcomputing.com>
Tested-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- fixed list mutation outside locking in nvmet_rdma_get_rsp
- check allocation status in nvmet_rdma_get_rsp
- silent drop in case that fallback memory allocation failed

 drivers/nvme/target/rdma.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3533e918ea37..404ec6e72c1c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -66,6 +66,7 @@ struct nvmet_rdma_rsp {
 
 	struct nvmet_req	req;
 
+	bool			allocated;
 	u8			n_rdma;
 	u32			flags;
 	u32			invalidate_rkey;
@@ -174,11 +175,21 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->rsps_lock, flags);
-	rsp = list_first_entry(&queue->free_rsps,
+	rsp = list_first_entry_or_null(&queue->free_rsps,
 				struct nvmet_rdma_rsp, free_list);
-	list_del(&rsp->free_list);
+	if (likely(rsp)) {
+		list_del(&rsp->free_list);
+		rsp->allocated = false;
+	}
 	spin_unlock_irqrestore(&queue->rsps_lock, flags);
 
+	if (unlikely(!rsp)) {
+		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+		if (unlikely(!rsp))
+			return NULL;
+		rsp->allocated = true;
+	}
+
 	return rsp;
 }
 
@@ -187,6 +198,11 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
 {
 	unsigned long flags;
 
+	if (rsp->allocated) {
+		kfree(rsp);
+		return;
+	}
+
 	spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
 	list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
 	spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
@@ -776,6 +792,15 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	cmd->queue = queue;
 	rsp = nvmet_rdma_get_rsp(queue);
+	if (unlikely(!rsp)) {
+		/*
+		 * we get here only under memory pressure,
+		 * silently drop and have the host retry
+		 * as we can't even fail it.
+		 */
+		nvmet_rdma_post_recv(queue->dev, cmd);
+		return;
+	}
 	rsp->queue = queue;
 	rsp->cmd = cmd;
 	rsp->flags = 0;
-- 
2.17.1
