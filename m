Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F6C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 17:56:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7268C65202
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 17:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7268C65202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wuVK/2siPlQwyuIwpJ2PcqlWc18czLjrytP7TxjyqZk=; b=Uht9KdG63PzKguHeDYfreSVM/F
	KSUWSpw04f/FayDQVjA3nn90JtV3614225QcJ18AXjWZd+4/XnbRC4m5b/29LbcP20cLhgmFu5yoA
	2ehlwhSAyMOUUvTXo2AZZhUrMm4gaDCtyNrJbPRf/GzkmG3TU4Fdbh1RwIgj13e7pOwT009lv+6CN
	AWoPl5KTqblY4v33sRjki00052YRVqHvWda+3H64WMnv0hwZViGLJFpATKFBycTBbGcN1jZwpaE74
	vR7ww4nA5E9BqPyorQrQKq1kkZIVdOWI/adJyEWXnrhVFYDZ1nhExX3c60JpSIw/QNpS/ZHV6+qXD
	YvffI9tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGmm7-0004cM-7H; Mon, 01 Mar 2021 17:56:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGmm4-0004be-Uy
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 17:56:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 97D26ADDD;
 Mon,  1 Mar 2021 17:56:03 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-tcp: Check if request has started before processing it
Date: Mon,  1 Mar 2021 18:56:01 +0100
Message-Id: <20210301175601.116405-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_125605_211924_E66991E2 
X-CRM114-Status: GOOD (  21.04  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk_mq_tag_to_rq() always returns a request if the tag id is in a
valid range [0...max_tags). If the target replies with a tag for which
we don't have a request but it's not started, the host will likely
corrupt data or simply crash.

Add an additional check if the a request has been started if not
reset the connection.

This addition check will not protected against an invalid tag which
maps to a request which has been started. There is nothing we can do
about this. Though it will at a least protect from crashing the host,
which generally thought to be the right thing to do.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

The patch is against nmve-5.12.

I noted that nvme_tcp_process_nvme_cqe() returns EINVAL
where as the rest uses ENOENT. Looks a bit odd to me.

I've tested this with blktests.

v2:
  - moved the check into a helper to avoid code duplication
  - use nvme_reset_ctrl if request has not been started
  - added nvme_tcp_recv_ddgst() callsite

 drivers/nvme/host/tcp.c | 56 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..af6f725b842b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -479,19 +479,38 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
-static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-		struct nvme_completion *cqe)
+static bool nvme_tcp_tag_to_rq(struct nvme_tcp_queue *queue,
+			__u16 command_id, struct request **req)
 {
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag 0x%x not found\n",
-			nvme_tcp_queue_id(queue), cqe->command_id);
+			nvme_tcp_queue_id(queue), command_id);
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-		return -EINVAL;
+		return false;
 	}
+	if (!blk_mq_request_started(rq)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d received invalid tag\n",
+			nvme_tcp_queue_id(queue));
+		nvme_reset_ctrl(&queue->ctrl->ctrl);
+		return false;
+	}
+
+	*req = rq;
+	return true;
+}
+
+static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
+		struct nvme_completion *cqe)
+{
+	struct request *rq;
+
+	if (!nvme_tcp_tag_to_rq(queue, cqe->command_id, &rq))
+		return -EINVAL;
 
 	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
 		nvme_complete_rq(rq);
@@ -505,13 +524,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 {
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+	if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
 		return -ENOENT;
-	}
 
 	if (!blk_rq_payload_bytes(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -609,13 +623,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct request *rq;
 	int ret;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+	if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
 		return -ENOENT;
-	}
 	req = blk_mq_rq_to_pdu(rq);
 
 	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
@@ -695,13 +704,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct nvme_tcp_request *req;
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+	if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
 		return -ENOENT;
-	}
 	req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
@@ -794,8 +798,10 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-						pdu->command_id);
+		struct request *rq;
+
+		if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
+			return -EINVAL;
 
 		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 		queue->nr_cqe++;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
