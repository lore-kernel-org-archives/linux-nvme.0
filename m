From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 31 Aug 2018 18:14:47 -0700
Subject: [PATCH] nvmet-rdma: fix possible bogus dereference under heavy load
Message-ID: <20180901011447.32287-1-sagi@grimberg.me>

Currently we always repost the recv buffer before we send a response
capsule back to the host. Since ordering is not guaranteed for send
and recv completions, it is posible that we will receive a new request
from the host before we got a send completion for the response capsule.

Today, we pre-allocate 2x rsps the length of the queue, but in reality, under
heavy load there is nothing that is really preventing the gap to expand
until we exhaust all our rsps.

To fix this, if we don't have any pre-allocated rsps left, we dynamically
allocate a rsp and make sure to free it when we are done.

Reported-by: Steve Wise <swise at opengridcomputing.com>
Tested-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e7f43d1e1779..1515b8a76ea5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -66,6 +66,7 @@ struct nvmet_rdma_rsp {
 
 	struct nvmet_req	req;
 
+	bool			allocated;
 	u8			n_rdma;
 	u32			flags;
 	u32			invalidate_rkey;
@@ -174,10 +175,16 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->rsps_lock, flags);
-	rsp = list_first_entry(&queue->free_rsps,
+	rsp = list_first_entry_or_null(&queue->free_rsps,
 				struct nvmet_rdma_rsp, free_list);
-	list_del(&rsp->free_list);
 	spin_unlock_irqrestore(&queue->rsps_lock, flags);
+	if (rsp) {
+		list_del(&rsp->free_list);
+		rsp->allocated = false;
+	} else {
+		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+		rsp->allocated = true;
+	}
 
 	return rsp;
 }
@@ -187,6 +194,11 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
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
-- 
2.17.1
