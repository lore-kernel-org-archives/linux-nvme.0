From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:28:27 +0100
Subject: [PATCH 09/16] nvme: switch delete SQ/CQ to blk_execute_rq_nowait
In-Reply-To: <1448090914-13121-1-git-send-email-hch@lst.de>
References: <1448090914-13121-1-git-send-email-hch@lst.de>
Message-ID: <1448090914-13121-10-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 49 +++++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6ce398..6602d29 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -85,8 +85,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_iod *iod);
 struct async_cmd_info {
 	struct kthread_work work;
 	struct kthread_worker *worker;
-	struct request *req;
-	u32 result;
 	int status;
 	void *ctx;
 };
@@ -390,16 +388,6 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
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
@@ -983,28 +971,13 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
-			struct nvme_command *cmd,
-			struct async_cmd_info *cmdinfo, unsigned timeout)
+static void async_cmd_info_endio(struct request *req, int error)
 {
-	struct nvme_queue *nvmeq = dev->queues[0];
-	struct request *req;
-	struct nvme_cmd_info *cmd_rq;
-
-	req = blk_mq_alloc_request(dev->ctrl.admin_q, WRITE, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	struct async_cmd_info *cmdinfo = req->end_io_data;
 
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
@@ -2008,6 +1981,7 @@ static void nvme_del_queue_end(struct nvme_queue *nvmeq)
 static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
 						kthread_work_func_t fn)
 {
+	struct request *req;
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
@@ -2015,8 +1989,15 @@ static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
 	c.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
 	init_kthread_work(&nvmeq->cmdinfo.work, fn);
-	return nvme_submit_admin_async_cmd(nvmeq->dev, &c, &nvmeq->cmdinfo,
-								ADMIN_TIMEOUT);
+
+	req = nvme_alloc_request(nvmeq->dev->ctrl.admin_q, &c, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->timeout = ADMIN_TIMEOUT;
+	req->end_io_data = &nvmeq->cmdinfo;
+	blk_execute_rq_nowait(req->q, NULL, req, 0, async_cmd_info_endio);
+	return 0;
 }
 
 static void nvme_del_cq_work_handler(struct kthread_work *work)
-- 
1.9.1
