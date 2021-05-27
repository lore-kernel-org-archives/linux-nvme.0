Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD550C47089
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:05:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FB561184
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FB561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HzjaK9NU2rn5IAnwS1AwT+y7Ma9w4pOCtjPXlmjprcU=; b=d5qGXcQcjXc4fg
	o1+rAQW4x5PeJAPPKr71g45iUAQhwjI+8PN8wtatM70/XnCFTZMh9SkQ3rlviGuOKpiqp+WoX+wvl
	gc5Sif+jQhK6tpcSC/R6l3nzaYr08kV+ci1Z5f8nvy2CZ/4yIT8aMA36YOU8v+eSA0ldpOeQhGMAW
	i6G/ee0wkOlbtSXBy8zUNvFKZUFMjGtg7jCzQJ9XP/7xEtBI4D9lcyHyRUPIsW6kkDcG110WCZ9UM
	zGx6ezduPCaW0qEMA/r5h2l6oIqvOYOsSQhB49/pqZAhUG1XfNgf4CwTMlQCvLjAoiw5F5mL3wvva
	pJY/97AKV1i83zhM3Yhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmPzr-00ARyL-My; Fri, 28 May 2021 00:05:03 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPvv-00APu4-Kv
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:01:01 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14RNpIdd024450; Thu, 27 May 2021 17:00:51 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38sxpmcyyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:00:51 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:00:48 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:00:44 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>, "Dean
 Balandin" <dbalandin@marvell.com>
Subject: [RFC PATCH v6 08/27] nvme-tcp-offload: Add IO level implementation
Date: Fri, 28 May 2021 02:58:43 +0300
Message-ID: <20210527235902.2185-9-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210527235902.2185-1-smalin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: _FxeCmoOU3OGeVU7g7Qs5JpwqGmF9KgI
X-Proofpoint-GUID: _FxeCmoOU3OGeVU7g7Qs5JpwqGmF9KgI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_170059_844169_450D429A 
X-CRM114-Status: GOOD (  23.92  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Dean Balandin <dbalandin@marvell.com>

In this patch, we present the IO level functionality.
The nvme-tcp-offload shall work on the IO-level, meaning the
nvme-tcp-offload ULP module shall pass the request to the nvme-tcp-offload
vendor driver and shall expect for the request completion.
No additional handling is needed in between, this design will reduce the
CPU utilization as we will describe below.

The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
with the following IO-path ops:
 - send_req - in order to pass the request to the handling of the offload
   driver that shall pass it to the vendor specific device
 - poll_queue

The vendor driver will manage the context from which the request will be
executed and the request aggregations.
Once the IO completed, the nvme-tcp-offload vendor driver shall call
command.done() that shall invoke the nvme-tcp-offload ULP layer for
completing the request.

This patch also add support for the nvme-tcp-offload timeout and
nvme-tcp-offload ASYNC flow.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/tcp-offload.c | 176 ++++++++++++++++++++++++++++++--
 drivers/nvme/host/tcp-offload.h |   2 +
 2 files changed, 171 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index eff10e31f17f..114972a68e52 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -125,7 +125,30 @@ void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
 			    union nvme_result *result,
 			    __le16 status)
 {
-	/* Placeholder - complete request with/without error */
+	struct request *rq = blk_mq_rq_from_pdu(req);
+
+	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), *result))
+		nvme_complete_rq(rq);
+}
+
+/**
+ * nvme_tcp_ofld_async_req_done() - NVMeTCP Offload request done callback
+ * function for async request. Pointed to by nvme_tcp_ofld_req->done.
+ * Handles both NVME_TCP_F_DATA_SUCCESS flag and NVMe CQ.
+ * @req:	NVMeTCP offload request to complete.
+ * @result:     The nvme_result.
+ * @status:     The completion status.
+ *
+ * API function that allows the vendor specific offload driver to report request
+ * completions to the common offload layer.
+ */
+void nvme_tcp_ofld_async_req_done(struct nvme_tcp_ofld_req *req,
+				  union nvme_result *result, __le16 status)
+{
+	struct nvme_tcp_ofld_queue *queue = req->queue;
+	struct nvme_tcp_ofld_ctrl *ctrl = queue->ctrl;
+
+	nvme_complete_async_event(&ctrl->nctrl, status, result);
 }
 
 struct nvme_tcp_ofld_dev *
@@ -699,6 +722,54 @@ static void nvme_tcp_ofld_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
+static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
+{
+	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+
+	sg->addr = 0;
+	sg->length = 0;
+	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) | NVME_SGL_FMT_TRANSPORT_A;
+}
+
+inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
+					struct nvme_command *c, u32 data_len)
+{
+	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+
+	sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);
+	sg->length = cpu_to_le32(data_len);
+	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
+}
+
+void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
+{
+	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+
+	sg->addr = 0;
+	sg->length = cpu_to_le32(data_len);
+	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) | NVME_SGL_FMT_TRANSPORT_A;
+}
+
+static void nvme_tcp_ofld_submit_async_event(struct nvme_ctrl *arg)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(arg);
+	struct nvme_tcp_ofld_queue *queue = &ctrl->queues[0];
+	struct nvme_tcp_ofld_dev *dev = queue->dev;
+	struct nvme_tcp_ofld_ops *ops = dev->ops;
+
+	ctrl->async_req.nvme_cmd.common.opcode = nvme_admin_async_event;
+	ctrl->async_req.nvme_cmd.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
+	ctrl->async_req.nvme_cmd.common.flags |= NVME_CMD_SGL_METABUF;
+
+	nvme_tcp_ofld_set_sg_null(&ctrl->async_req.nvme_cmd);
+
+	ctrl->async_req.async = true;
+	ctrl->async_req.queue = queue;
+	ctrl->async_req.done = nvme_tcp_ofld_async_req_done;
+
+	ops->send_req(&ctrl->async_req);
+}
+
 static void
 nvme_tcp_ofld_teardown_admin_queue(struct nvme_ctrl *nctrl, bool remove)
 {
@@ -837,9 +908,13 @@ nvme_tcp_ofld_init_request(struct blk_mq_tag_set *set,
 			   unsigned int numa_node)
 {
 	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_ofld_ctrl *ctrl = set->driver_data;
+	int qid;
 
-	/* Placeholder - init request */
-
+	qid = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
+	req->queue = &ctrl->queues[qid];
+	nvme_req(rq)->ctrl = &ctrl->nctrl;
+	nvme_req(rq)->cmd = &req->nvme_cmd;
 	req->done = nvme_tcp_ofld_req_done;
 
 	return 0;
@@ -855,9 +930,46 @@ static blk_status_t
 nvme_tcp_ofld_queue_rq(struct blk_mq_hw_ctx *hctx,
 		       const struct blk_mq_queue_data *bd)
 {
-	/* Call nvme_setup_cmd(...) */
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(bd->rq);
+	struct nvme_tcp_ofld_queue *queue = hctx->driver_data;
+	struct nvme_tcp_ofld_ctrl *ctrl = queue->ctrl;
+	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_tcp_ofld_dev *dev = queue->dev;
+	struct nvme_tcp_ofld_ops *ops = dev->ops;
+	struct nvme_command *nvme_cmd;
+	struct request *rq = bd->rq;
+	bool queue_ready;
+	u32 data_len;
+	int rc;
+
+	queue_ready = test_bit(NVME_TCP_OFLD_Q_LIVE, &queue->flags);
+
+	req->async = false;
+
+	if (!nvme_check_ready(&ctrl->nctrl, rq, queue_ready))
+		return nvme_fail_nonready_command(&ctrl->nctrl, rq);
+
+	rc = nvme_setup_cmd(ns, rq);
+	if (unlikely(rc))
+		return rc;
 
-	/* Call ops->send_req(...) */
+	blk_mq_start_request(rq);
+
+	nvme_cmd = &req->nvme_cmd;
+	nvme_cmd->common.flags |= NVME_CMD_SGL_METABUF;
+
+	data_len = blk_rq_nr_phys_segments(rq) ? blk_rq_payload_bytes(rq) : 0;
+	if (!data_len)
+		nvme_tcp_ofld_set_sg_null(&req->nvme_cmd);
+	else if ((rq_data_dir(rq) == WRITE) &&
+		 data_len <= nvme_tcp_ofld_inline_data_size(queue))
+		nvme_tcp_ofld_set_sg_inline(queue, nvme_cmd, data_len);
+	else
+		nvme_tcp_ofld_map_data(nvme_cmd, data_len);
+
+	rc = ops->send_req(req);
+	if (unlikely(rc))
+		return rc;
 
 	return BLK_STS_OK;
 }
@@ -930,9 +1042,56 @@ static int nvme_tcp_ofld_map_queues(struct blk_mq_tag_set *set)
 
 static int nvme_tcp_ofld_poll(struct blk_mq_hw_ctx *hctx)
 {
-	/* Placeholder - Implement polling mechanism */
+	struct nvme_tcp_ofld_queue *queue = hctx->driver_data;
+	struct nvme_tcp_ofld_dev *dev = queue->dev;
+	struct nvme_tcp_ofld_ops *ops = dev->ops;
 
-	return 0;
+	return ops->poll_queue(queue);
+}
+
+static void nvme_tcp_ofld_complete_timed_out(struct request *rq)
+{
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *nctrl = &req->queue->ctrl->nctrl;
+
+	nvme_tcp_ofld_stop_queue(nctrl, nvme_tcp_ofld_qid(req->queue));
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
+		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		blk_mq_complete_request(rq);
+	}
+}
+
+static enum blk_eh_timer_return nvme_tcp_ofld_timeout(struct request *rq, bool reserved)
+{
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_ofld_ctrl *ctrl = req->queue->ctrl;
+
+	dev_warn(ctrl->nctrl.device,
+		 "queue %d: timeout request %#x type %d\n",
+		 nvme_tcp_ofld_qid(req->queue), rq->tag, req->nvme_cmd.common.opcode);
+
+	if (ctrl->nctrl.state != NVME_CTRL_LIVE) {
+		/*
+		 * If we are resetting, connecting or deleting we should
+		 * complete immediately because we may block controller
+		 * teardown or setup sequence
+		 * - ctrl disable/shutdown fabrics requests
+		 * - connect requests
+		 * - initialization admin requests
+		 * - I/O requests that entered after unquiescing and
+		 *   the controller stopped responding
+		 *
+		 * All other requests should be cancelled by the error
+		 * recovery work, so it's fine that we fail it here.
+		 */
+		nvme_tcp_ofld_complete_timed_out(rq);
+
+		return BLK_EH_DONE;
+	}
+
+	nvme_tcp_ofld_error_recovery(&ctrl->nctrl);
+
+	return BLK_EH_RESET_TIMER;
 }
 
 static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
@@ -941,6 +1100,7 @@ static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 	.map_queues	= nvme_tcp_ofld_map_queues,
 	.poll		= nvme_tcp_ofld_poll,
 };
@@ -951,6 +1111,7 @@ static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_admin_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
@@ -961,6 +1122,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
 	.free_ctrl		= nvme_tcp_ofld_free_ctrl,
+	.submit_async_event     = nvme_tcp_ofld_submit_async_event,
 	.delete_ctrl		= nvme_tcp_ofld_delete_ctrl,
 	.get_address		= nvmf_get_address,
 };
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index fcc377680d9f..356e5c1ab771 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -114,6 +114,8 @@ struct nvme_tcp_ofld_ctrl {
 	/* Connectivity params */
 	struct nvme_tcp_ofld_ctrl_con_params conn_params;
 
+	struct nvme_tcp_ofld_req async_req;
+
 	/* Vendor specific driver context */
 	void *private_data;
 };
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
