From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 5 Nov 2014 23:39:09 +0300
Subject: [patch -next] NVMe: blk_mq_alloc_request() returns error pointers
Message-ID: <20141105203909.GB26314@mwanda>

We recently converted this to blk_mq but the error checks have to be
updated to check for IS_ERR() instead of NULL.

Fixes: a4aea5623d4a ('NVMe: Convert to blk-mq')
Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 39050a3..f7a8717 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -826,8 +826,8 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	struct request *req;
 
 	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_KERNEL, false);
-	if (!req)
-		return -ENOMEM;
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	cmd_info = blk_mq_rq_to_pdu(req);
 	nvme_set_info(cmd_info, req, async_req_completion);
@@ -848,8 +848,8 @@ static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
 	struct nvme_cmd_info *cmd_rq;
 
 	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_KERNEL, false);
-	if (!req)
-		return -ENOMEM;
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	req->timeout = timeout;
 	cmd_rq = blk_mq_rq_to_pdu(req);
@@ -1026,7 +1026,7 @@ static void nvme_abort_req(struct request *req)
 
 	abort_req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC,
 									false);
-	if (!abort_req)
+	if (IS_ERR(abort_req))
 		return;
 
 	abort_cmd = blk_mq_rq_to_pdu(abort_req);
@@ -1884,7 +1884,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	if (!ns)
 		return NULL;
 	ns->queue = blk_mq_init_queue(&dev->tagset);
-	if (!ns->queue)
+	if (IS_ERR(ns->queue))
 		goto out_free_ns;
 	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
