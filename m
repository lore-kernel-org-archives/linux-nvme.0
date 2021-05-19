Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C014CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:17:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310786135B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310786135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zWKm3UfzUNvzYl74MRv4ubTKzu8US6+IZzwAVGK1mOQ=; b=nvulSnivj2rMgcsiQoAUVR+Dz
	XA+JIAn+IGlJeOrUgrsT/5oj/L2icHARnJqt8/CLA7ykvEvQaSR7CAna7DPpO5wPgdE7wxXbXqS5M
	7N8VL8U8OFsViNCDlVd317Wn6Zz2sXzHnDN7hkdjUgSZOuPaDQ0MrUnS77fGQ7lWA8QHpIv0IMt0l
	2yT1xqCewJFBUxp2+BHbGdiuJPIJpp+kfhKOHDdz6+VAvGorVf1wibv0mS9egCx43/SgDLFuk38WV
	LP3NapBkDZdXe9zj0dbzchPPIVu2GK5iMWckpUrvqeRgKvRLiDjiLkWp6rr2DJJ6M15cvX4fLJ2oq
	mbaTv8M0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljKCV-003jZw-0x; Wed, 19 May 2021 11:17:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKAX-003j5H-FK
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 11:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=I0IMNHO8n+ukjfNz6UpESnHur9QXmJqXtHERRzdKFHU=; b=vGMT+hpcyajDX2Er/CgLLFaWnD
 GT6fmYBcuqWqsgJCN1lzLeV3pfdfQnAeNNWWTKcJaAety24gDI2Yq8/bg59MvEhnJ08pYfw4h2W69
 0X3DColHknTZ/YCCavLVO0zkfByyBVU4RfSyJRShOzIz7PilocCbJ+JhQQT9qCfU6db91N6u0tmha
 isYuGC6/JBL8e2WGEAxyGaKhf01aqZmN1JGswl0pF7fWQSgWHSguBMEKESRTjXt863btSuMGKoC0R
 zT2sbQfikWeEq1SylJbXJPLC1hotveGbZ9N7YIpJfjycbnMiiJwaqLrAolwqq+pbGU2JVayTfFCDz
 aCcLM81g==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKAU-00FOOt-4D
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:15:16 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JBAiqZ007767; Wed, 19 May 2021 04:15:08 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 38mqcwhy4f-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:15:08 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:15:03 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:15:00 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v5 08/27] nvme-tcp-offload: Add Timeout and ASYNC Support
Date: Wed, 19 May 2021 14:13:21 +0300
Message-ID: <20210519111340.20613-9-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: _eySkGhtZ-uZdheKeyGgszC47FfTL0gG
X-Proofpoint-ORIG-GUID: _eySkGhtZ-uZdheKeyGgszC47FfTL0gG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_041514_305286_65AE74A0 
X-CRM114-Status: GOOD (  18.47  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp-offload.c | 85 ++++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |  2 +
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 276b8475ac85..01b4c43cdaa5 100644
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
@@ -733,7 +753,23 @@ void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
 
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
@@ -1039,6 +1075,51 @@ static int nvme_tcp_ofld_poll(struct blk_mq_hw_ctx *hctx)
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
@@ -1046,6 +1127,7 @@ static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 	.map_queues	= nvme_tcp_ofld_map_queues,
 	.poll		= nvme_tcp_ofld_poll,
 };
@@ -1056,6 +1138,7 @@ static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
 	.init_request	= nvme_tcp_ofld_init_request,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_admin_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index 2233d855aa10..f897b811c399 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -117,6 +117,8 @@ struct nvme_tcp_ofld_ctrl {
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
