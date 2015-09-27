From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:54 +0200
Subject: [PATCH 06/10] nvme: switch delete SQ/CQ to blk_execute_rq_nowait
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-7-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 42 ++++++++----------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c1745eb..a2973bd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -91,8 +91,6 @@ static int nvme_process_cq(struct nvme_queue *nvmeq);
 struct async_cmd_info {
 	struct kthread_work work;
 	struct kthread_worker *worker;
-	struct request *req;
-	u32 result;
 	int status;
 	void *ctx;
 };
@@ -319,16 +317,6 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 	++nvmeq->dev->abort_limit;
 }
 
-static void async_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion *cqe)
-{
-	struct async_cmd_info *cmdinfo = ctx;
-	cmdinfo->result = le32_to_cpup(&cqe->result);
-	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
-	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
-	blk_mq_free_request(cmdinfo->req);
-}
-
 static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue *nvmeq,
 				  unsigned int tag)
 {
@@ -1109,28 +1097,13 @@ static int nvme_submit_aen(struct nvme_dev *dev)
 			true, aen_endio, NULL);
 }
 
-static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
-			struct nvme_command *cmd,
-			struct async_cmd_info *cmdinfo, unsigned timeout)
+static void async_cmd_info_endio(struct request *req, int error)
 {
-	struct nvme_queue *nvmeq = dev->queues[0];
-	struct request *req;
-	struct nvme_cmd_info *cmd_rq;
+	struct async_cmd_info *cmdinfo = req->end_io_data;
 
-	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_KERNEL, false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->timeout = timeout;
-	cmd_rq = blk_mq_rq_to_pdu(req);
-	cmdinfo->req = req;
-	nvme_set_info(cmd_rq, cmdinfo, async_completion);
-	cmdinfo->status = -EINTR;
-
-	cmd->common.command_id = req->tag;
-
-	nvme_submit_cmd(nvmeq, cmd);
-	return 0;
+	cmdinfo->status = req->errors;
+	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
+	blk_mq_free_request(req);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -2686,8 +2659,9 @@ static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
 	c.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
 	init_kthread_work(&nvmeq->cmdinfo.work, fn);
-	return nvme_submit_admin_async_cmd(nvmeq->dev, &c, &nvmeq->cmdinfo,
-								ADMIN_TIMEOUT);
+	return nvme_submit_async_cmd(nvmeq->dev->admin_q, &c, ADMIN_TIMEOUT,
+				     GFP_KERNEL, false,
+				     &nvmeq->cmdinfo, async_cmd_info_endio);
 }
 
 static void nvme_del_cq_work_handler(struct kthread_work *work)
-- 
1.9.1
