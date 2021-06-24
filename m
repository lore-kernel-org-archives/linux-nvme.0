Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B56C49EA5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143D2613B3
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143D2613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GT7zlbTAYeVfWNgzoW0eFugHieh8oMpw4dCb653p2DY=; b=nZz5jTRg80vACP
	scHvMjLbZzp495MteizczIVrsQqE/Nn3QQpQt6DVzV0Fj2oylqE1bestLVPGmPumzaNUQPbB5t1kz
	+d2wS/gIYNMuBmqvClqgt6VC5RBolYrUpcvFc8p1meo+PvajejjQJRZSuO3afMP80Yh/Mygdc7i3L
	cI8wooh7yFMbV0WNggpbz9PtQn4/5NKuvVjjnYWmvqt4ci/VHW03wZYj3M3awan3nAdAJqp936ppV
	7EraXL0Wz4Q4Xhul6E+FJcOSS7Ju0mkfA8BqAh0Kq5fLjkD1MhEcwFy9kWCX6qQDsEy9oi2B5qfp0
	/nN7l7rkdpl/MLnmkCAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwTAX-00FeW0-3O; Thu, 24 Jun 2021 17:29:37 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwT6N-00FdAv-He
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 17:25:21 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OHAcOe027034; Thu, 24 Jun 2021 10:25:07 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 39cg2nbdeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 24 Jun 2021 10:25:06 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 24 Jun 2021 10:25:03 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 24 Jun 2021 10:25:00 -0700
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <aelior@marvell.com>,
 <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>,
 "Dean Balandin" <dbalandin@marvell.com>
Subject: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
Date: Thu, 24 Jun 2021 20:23:58 +0300
Message-ID: <20210624172410.14225-9-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210624172410.14225-1-smalin@marvell.com>
References: <20210624172410.14225-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: dY6kTCNgXGO7NL0VQT8uj4MWv2ykJ8j5
X-Proofpoint-GUID: dY6kTCNgXGO7NL0VQT8uj4MWv2ykJ8j5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-24_12:2021-06-24,
 2021-06-24 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_102519_997055_2593C638 
X-CRM114-Status: GOOD (  24.03  )
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
driver and shall expect for the request completion.
No additional handling is needed in between, this design will reduce the
CPU utilization as we will describe below.

The nvme-tcp-offload driver shall register to nvme-tcp-offload ULP
with the following IO-path ops:
 - send_req - in order to pass the request to the handling of the offload
   driver that shall pass it to the offload specific device
 - poll_queue

The offload device driver will manage the context from which the request
will be executed and the request aggregations.
Once the IO completed, the nvme-tcp-offload driver shall call
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
 drivers/nvme/host/tcp-offload.c | 180 ++++++++++++++++++++++++++++++--
 drivers/nvme/host/tcp-offload.h |   2 +
 2 files changed, 175 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 26253b107db2..7ba56136f9b1 100644
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
+ * API function that allows the offload device specific driver to report
+ * request completions to the common offload layer.
+ */
+void nvme_tcp_ofld_async_req_done(struct nvme_tcp_ofld_req *req,
+				  union nvme_result *result, __le16 status)
+{
+	struct nvme_tcp_ofld_queue *queue = req->queue;
+	struct nvme_tcp_ofld_ctrl *ctrl = queue->ctrl;
+
+	nvme_complete_async_event(&ctrl->nctrl, status, result);
 }
 
 static struct nvme_tcp_ofld_dev *
@@ -717,6 +740,56 @@ static void nvme_tcp_ofld_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
+static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
+{
+	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+
+	sg->addr = 0;
+	sg->length = 0;
+	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
+			NVME_SGL_FMT_TRANSPORT_A;
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
+static void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
+{
+	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+
+	sg->addr = 0;
+	sg->length = cpu_to_le32(data_len);
+	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
+			NVME_SGL_FMT_TRANSPORT_A;
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
@@ -855,9 +928,13 @@ nvme_tcp_ofld_init_request(struct blk_mq_tag_set *set,
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
@@ -873,9 +950,46 @@ static blk_status_t
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
@@ -948,9 +1062,58 @@ static int nvme_tcp_ofld_map_queues(struct blk_mq_tag_set *set)
 
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
+static enum blk_eh_timer_return nvme_tcp_ofld_timeout(struct request *rq,
+						      bool reserved)
+{
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_ofld_ctrl *ctrl = req->queue->ctrl;
+
+	dev_warn(ctrl->nctrl.device,
+		 "queue %d: timeout request %#x type %d\n",
+		 nvme_tcp_ofld_qid(req->queue), rq->tag,
+		 req->nvme_cmd.common.opcode);
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
@@ -959,6 +1122,7 @@ static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 	.map_queues	= nvme_tcp_ofld_map_queues,
 	.poll		= nvme_tcp_ofld_poll,
 };
@@ -969,6 +1133,7 @@ static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_admin_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
@@ -979,6 +1144,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
 	.free_ctrl		= nvme_tcp_ofld_free_ctrl,
+	.submit_async_event     = nvme_tcp_ofld_submit_async_event,
 	.delete_ctrl		= nvme_tcp_ofld_delete_ctrl,
 	.get_address		= nvmf_get_address,
 };
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index b3502c01394e..a4c28ddaf3ab 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -115,6 +115,8 @@ struct nvme_tcp_ofld_ctrl {
 	/* Connectivity params */
 	struct nvme_tcp_ofld_ctrl_con_params conn_params;
 
+	struct nvme_tcp_ofld_req async_req;
+
 	/* Offload device driver context */
 	void *private_data;
 };
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
