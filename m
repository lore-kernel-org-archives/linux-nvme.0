Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB16C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03BC224DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03BC224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T4GPCeMbPE5DPslnsL1m8C5dBpkAiJRshcbByLOvosw=; b=qWR1CHqtobtG2fGrYr6PFkpHp
	xLzGbFyQK5saoubx30aGHpQN8sXEwOUDoGOxkvJd7bM8UXPDXFdGeaejOumoYKR3cQakdCYhrLr2q
	BREphJYKnoqR67DRf8c3gSCydqvLIqppUpD5gdN1hq3akonocyHcIqmd3mxZIMnurPhvnbcwFvnTS
	O8Y+TK5XD0MVAiAaHSq6jqTXDjjNCSYopFKMxOq54FHsJELLMphRdOmHrnoI8oIhsxsH7KqkWjYae
	DzLGhob9s+LX0c26DLMyqRo3Mv/KsQunx3CQwcDtTu+82uBbGpvYi7N6M22akrAy2PjJ52fwf9uyk
	s2XA4OGHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpU-0004re-4i; Sun, 13 Dec 2020 19:14:48 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWpR-0004ql-AA
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:14:46 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJBjZD011021; Sun, 13 Dec 2020 11:14:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=ufUCzPPsduCTIqDf5n8Z2nwQqWQqcKeiJym0cT892fk=;
 b=X/XPHfK2cGYZT9tMdnaUAVzqreVOZwDxiyz07PmpcNuFi/dt0wVq/SJUtMS5vxIcU6La
 LC+C4l6Vi3wN4m+KYyKNbvgB0+t6JUDjJ4EGFChe6ZQrRMOG5mF4ByOfsbajsoBMLBAL
 suioGjPrbuRaz3z/5+bIo0ssHtRBhboaUHhsxQQAXTQbCcWVhd9I/qdm3pxxb2dzvCE0
 77sIAZ3lQrqVaX8uZykV1Lzz+MhAe1OhwA4IKODisH7ZOwJzj4sFRadMSuf4GoeoKv1m
 OU2366WfFa5CK2cHVj08STP6yUgamhEKAqT5UtJB/ZN6vQ5R4fEX3V6WIlnxaAy1UO/3 HQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 35cv3stjkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:37 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:36 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 511E63F7040;
 Sun, 13 Dec 2020 11:14:33 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 7/7] nvme-tcp-offload: Add IO level implementation
Date: Sun, 13 Dec 2020 21:14:01 +0200
Message-ID: <20201213191401.22734-8-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201213191401.22734-1-smalin@marvell.com>
References: <20201213191401.22734-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141445_519162_FAEB08AF 
X-CRM114-Status: GOOD (  23.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: smalin@marvell.com, aelior@marvell.com, agershberg@marvell.com,
 mkalderon@marvell.com, nassa@marvell.com, dbalandin@marvell.com,
 malin1024@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Dean Balandin <dbalandin@marvell.com>

In this patch, we present the IO level functionality.
The nvme-tcp-offload shall work on the IO-level, meaning the nvme-tcp-offload
ULP module shall pass the request to the nvme-tcp-offload vendor driver and
shall expect for the request compilation.
No additional handling is needed in between, this design will reduce the CPU
utilization as we will describe below.

The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
with the following IO-path ops:
 - init_req
 - map_sg - in order to map the request sg (similar to nvme_rdma_map_data).
 - send_req - in order to pass the request to the handling of the offload
   driver that shall pass it to the vendor specific device.
 - poll_queue

The vendor driver will manage the context from which the request will be
executed and the request aggregations.
Once the IO completed, the nvme-tcp-offload vendor driver shall call
command.done() that shall invoke the nvme-tcp-offload ULP layer for
completing the request.

Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 80 +++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 12f675bdd221..37046ed46aea 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -113,6 +113,7 @@ int nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
 /**
  * nvme_tcp_ofld_req_done() - NVMeTCP Offload request done callback
  * function. Pointed to by nvme_tcp_ofld_req->done.
+ * Handles both NVME_TCP_F_DATA_SUCCESS flag and NVMe CQE.
  * @req:	NVMeTCP offload request to complete.
  * @result:     The nvme_result.
  * @status:     The completion status.
@@ -125,7 +126,10 @@ nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
 		       union nvme_result *result,
 		       __le16 status)
 {
-	/* Placeholder - complete request with/without error */
+	struct request *rq = blk_mq_rq_from_pdu(req);
+
+	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), *result))
+		nvme_complete_rq(rq);
 }
 
 struct nvme_tcp_ofld_dev *
@@ -734,9 +738,10 @@ nvme_tcp_ofld_init_request(struct blk_mq_tag_set *set,
 {
 	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_tcp_ofld_ctrl *ctrl = set->driver_data;
+	int qid = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 
-	/* Placeholder - init request */
-
+	req->queue = &ctrl->queues[qid];
+	nvme_req(rq)->ctrl = &ctrl->nctrl;
 	req->done = nvme_tcp_ofld_req_done;
 	ctrl->dev->ops->init_req(req);
 
@@ -749,11 +754,30 @@ nvme_tcp_ofld_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(bd->rq);
 	struct nvme_tcp_ofld_queue *queue = hctx->driver_data;
-	struct nvme_tcp_ofld_ops *ops = queue->dev->ops;
+	struct nvme_tcp_ofld_ctrl *ctrl = queue->ctrl;
+	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_tcp_ofld_dev *dev = queue->dev;
+	struct nvme_tcp_ofld_ops *ops = dev->ops;
+	struct request *rq = bd->rq;
+	bool queue_ready;
+	int rc;
+
+	queue_ready = test_bit(NVME_TCP_OFLD_Q_LIVE, &queue->flags);
+	if (!nvmf_check_ready(&ctrl->nctrl, rq, queue_ready))
+		return nvmf_fail_nonready_command(&ctrl->nctrl, rq);
+
+	rc = nvme_setup_cmd(ns, rq, &req->nvme_cmd);
+	if (unlikely(rc))
+		return rc;
 
-	/* Call nvme_setup_cmd(...) */
+	blk_mq_start_request(rq);
+	rc = ops->map_sg(dev, req);
+	if (unlikely(rc))
+		return rc;
 
-	/* Call ops->map_sg(...) */
+	rc = ops->send_req(req);
+	if (unlikely(rc))
+		return rc;
 
 	return BLK_STS_OK;
 }
@@ -823,9 +847,47 @@ static int nvme_tcp_ofld_map_queues(struct blk_mq_tag_set *set)
 
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
+static enum blk_eh_timer_return
+nvme_tcp_ofld_timeout(struct request *rq, bool reserved)
+{
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_ofld_ctrl *ctrl = req->queue->ctrl;
+
+	/* Restart the timer if a controller reset is already scheduled. Any
+	 * timed out request would be handled before entering the connecting
+	 * state.
+	 */
+	if (ctrl->nctrl.state == NVME_CTRL_RESETTING)
+		return BLK_EH_RESET_TIMER;
+
+	dev_warn(ctrl->nctrl.device,
+		 "queue %d: timeout request %#x type %d\n",
+		 nvme_tcp_ofld_qid(req->queue), rq->tag,
+		 req->nvme_cmd.common.opcode);
+
+	if (ctrl->nctrl.state != NVME_CTRL_LIVE) {
+		/*
+		 * Teardown immediately if controller times out while starting
+		 * or we are already started error recovery. all outstanding
+		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 */
+		flush_work(&ctrl->err_work);
+		nvme_tcp_ofld_teardown_io_queues(&ctrl->nctrl, false);
+		nvme_tcp_ofld_teardown_admin_queue(&ctrl->nctrl, false);
+		return BLK_EH_DONE;
+	}
+
+	dev_warn(ctrl->nctrl.device, "starting error recovery\n");
+	nvme_tcp_ofld_error_recovery(&ctrl->nctrl);
+
+	return BLK_EH_RESET_TIMER;
 }
 
 static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
@@ -835,6 +897,7 @@ static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_hctx,
 	.map_queues	= nvme_tcp_ofld_map_queues,
+	.timeout	= nvme_tcp_ofld_timeout,
 	.poll		= nvme_tcp_ofld_poll,
 };
 
@@ -844,6 +907,7 @@ static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
 	.complete	= nvme_complete_rq,
 	.exit_request	= nvme_tcp_ofld_exit_request,
 	.init_hctx	= nvme_tcp_ofld_init_hctx,
+	.timeout	= nvme_tcp_ofld_timeout,
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
