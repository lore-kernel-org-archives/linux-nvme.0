From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Mar 2015 13:42:52 -0600
Subject: [PATCH] NVMe: Fix blk-mq hot cpu notification
Message-ID: <1427485372-2784-1-git-send-email-keith.busch@intel.com>

The driver may issue commands to a device that may never return, so its
request_queue could always have active requests while the controller is
running. Waiting for the queue to freeze could block forever, which is
what blk-mq's hot cpu notification handler was doing when nvme drives
were in use.

This has the nvme driver make the asynchronous event command's tag
reserved and does not keep the request active. We can't have more than
one since the request is released back to the request_queue before the
command is completed. Having only one avoids potential tag collisions,
and reserving the tag for this purpose prevents other admin tasks from
reusing the tag.

I also couldn't think of a scenario where issuing AEN requests single
depth is worse than issuing them in batches, so I don't think we lose
anything with this change.

As an added bonus, doing it this way removes "Cancelling I/O" warnings
observed when unbinding the nvme driver from a device.

Reported-by: Yigal Korman <yigal at plexistor.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e8baffa..0d72ff2 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -302,8 +302,6 @@ static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
-	struct request *req = ctx;
-
 	u32 result = le32_to_cpup(&cqe->result);
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
@@ -312,8 +310,6 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 	if (status == NVME_SC_SUCCESS)
 		dev_warn(nvmeq->q_dmadev,
 			"async event result %08x\n", result);
-
-	blk_mq_free_hctx_request(nvmeq->hctx, req);
 }
 
 static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
@@ -1025,18 +1021,19 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	struct nvme_cmd_info *cmd_info;
 	struct request *req;
 
-	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC, false);
+	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC, true);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	req->cmd_flags |= REQ_NO_TIMEOUT;
 	cmd_info = blk_mq_rq_to_pdu(req);
-	nvme_set_info(cmd_info, req, async_req_completion);
+	nvme_set_info(cmd_info, NULL, async_req_completion);
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = req->tag;
 
+	blk_mq_free_hctx_request(nvmeq->hctx, req);
 	return __nvme_submit_cmd(nvmeq, &c);
 }
 
@@ -1581,6 +1578,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
 		dev->admin_tagset.nr_hw_queues = 1;
 		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
+		dev->admin_tagset.reserved_tags = 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(&dev->pci_dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
@@ -2307,7 +2305,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
-	dev->event_limit = min(ctrl->aerl + 1, 8);
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
@@ -2836,6 +2833,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	if (result)
 		goto free_tags;
 
+	dev->event_limit = 1;
 	return result;
  free_tags:
 	nvme_dev_remove_admin(dev);
-- 
1.7.10.4
