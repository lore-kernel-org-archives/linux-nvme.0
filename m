Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7E4C43460
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:24:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9466142A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 19:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9466142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SBJoDc+xnuMiqLPdKBrwfG2JUM9NH92rbVmckCNhLyM=; b=leIGJI2sTSUloZLa541ex8bRh
	Tp870A4ewm0mZteSQc/QDSqQhreRXdzel4dJvpFzDaCA50ykd11IfLSxBNSuplJSA1tukSeZY7NnB
	hTkHgkxD28VEvZ4aZtHXg7L+DiJx8eB/t2W2ec0ZL5cDabaL3zKPg8ywNj5IiGd3gThfJxAHz196X
	WfWk1bEiVdpD9wSkjheGjBCY2x3YbK9yLKvSu6O0+SCAEpSvJ73NAkBjoo7BOvkQSu/N37+qwQvNc
	Mnc6ikWl7e4pWKO9g65cf0L1jGM+Plz431enYGo632XnO45TgBXNrxzpXazqcZTSWKyIkHw8h+nfG
	S0ms0ZQag==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcCH7-006Hny-Ap; Thu, 29 Apr 2021 19:24:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3m-006FTv-JD
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 19:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SrEO9QQrlNJq2XQVzvqa9fqFFahLA7WAaziNAtCBLcw=; b=bXenydRWgY7izYCgW2lQboTwr4
 NnXXAUx9re9KpVbGspsx83QXqo+68pOvUOL4cDLUBiO5DxXiJDobRE3WdaZUisTIpn3ppOHsEQHBW
 yG036YJHjS79/GHwI9LRr46auXeNjC/BMT+91svnCeq8usvVeusabW5eJIpVqFb6uyGiu/mGyYpQu
 PAqOwMWOP3tFn5stVtM9Ne5FeK1Bd5Xa6Fp26BFovH31PkU8ovF0WLBO2zJs128cv1S2AxGpx8WHF
 tMcnyItX72/lyASMcP7zlUBmcQSgVuUb+3tQACuRLAG27ztwKeT/A9DJ526vI77ol8RIcjcgPc5kX
 oXoxasiw==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcC3j-000sf0-MO
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 19:10:49 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13TJ5Arb027348; Thu, 29 Apr 2021 12:10:42 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 387rpnamra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 29 Apr 2021 12:10:42 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 29 Apr 2021 12:10:40 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 29 Apr 2021 12:10:37 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: =?UTF-8?q?David=20S=20=2E=20Miller=20davem=20=40=20davemloft=20=2E=20net=20=C2=A0--cc=3DJakub=20Kicinski?=
 <kuba@kernel.org>,
 <smalin@marvell.com>, <aelior@marvell.com>, <mkalderon@marvell.com>,
 <okulkarni@marvell.com>, <pkushwaha@marvell.com>, <malin1024@gmail.com>
Subject: [RFC PATCH v4 15/27] nvme-tcp-offload: Add Timeout and ASYNC Support
Date: Thu, 29 Apr 2021 22:09:14 +0300
Message-ID: <20210429190926.5086-16-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210429190926.5086-1-smalin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: W_l6JchRh86gvdnJcEL1TL0kwBt6Wphe
X-Proofpoint-ORIG-GUID: W_l6JchRh86gvdnJcEL1TL0kwBt6Wphe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-29_10:2021-04-28,
 2021-04-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_121047_870129_881F6B0F 
X-CRM114-Status: GOOD (  17.07  )
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

In this patch, we present the nvme-tcp-offload timeout support
nvme_tcp_ofld_timeout() and ASYNC support
nvme_tcp_ofld_submit_async_event().

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 85 ++++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |  2 +
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 0cdf5a432208..1d62f921f109 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -133,6 +133,26 @@ void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
 		nvme_complete_rq(rq);
 }
 
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
+}
+
 struct nvme_tcp_ofld_dev *
 nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
 {
@@ -719,7 +739,23 @@ void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
 
 static void nvme_tcp_ofld_submit_async_event(struct nvme_ctrl *arg)
 {
-	/* Placeholder - submit_async_event */
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
+	ctrl->async_req.last = true;
+	ctrl->async_req.done = nvme_tcp_ofld_async_req_done;
+
+	ops->send_req(&ctrl->async_req);
 }
 
 static void
@@ -1024,6 +1060,51 @@ static int nvme_tcp_ofld_poll(struct blk_mq_hw_ctx *hctx)
 	return ops->poll_queue(queue);
 }
 
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
+}
+
 static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.queue_rq	= nvme_tcp_ofld_queue_rq,
 	.commit_rqs     = nvme_tcp_ofld_commit_rqs,
@@ -1031,6 +1112,7 @@ static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 	.map_queues	= nvme_tcp_ofld_map_queues,
 	.poll		= nvme_tcp_ofld_poll,
 };
@@ -1041,6 +1123,7 @@ static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_admin_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index d82645fcf9da..275a7e2d9d8a 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -110,6 +110,8 @@ struct nvme_tcp_ofld_ctrl {
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
