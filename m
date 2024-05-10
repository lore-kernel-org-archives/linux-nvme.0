Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE50DC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaN7IUDVw2oYvWxpzPTXi5OQMgmBdUmZiXMpCgxLfIw=; b=YLlCDV/afHuK4NpBnYRLycic0R
	gAiqlwQw3E0dfqSMV3qatC6diKXLWcAzNRkKguaE2saVjLQr1y7KPWEeZ2EPgFZQcIKh6QoKVB/rq
	Lk6YZswr688MwOGm+KwdzZquEYkppJa6MaQrLQ8IvISoHimbzSvlDVEjtybZQ5t8bKGRBY8v9hTWc
	Gd6X18GOQnKOyaQY+QO8rnIvVvYIizDqZOcndgxSDlb80UDE90IgiLQRqE9/gkKVn94VDa2S+J15L
	O3I7pBtV9sRbzPHLSrPz/TntxYMcjv3HHOKZY0ZY3LpDpTjHmi2mRRbFoKkkhfbNdpxqHAxZWDnK5
	9IzcT6sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8w-00000005s51-17PQ;
	Fri, 10 May 2024 16:30:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8r-00000005s2G-1izg
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715358640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaN7IUDVw2oYvWxpzPTXi5OQMgmBdUmZiXMpCgxLfIw=;
	b=XMhtjOVlxdX5uHWTCZ89hyJlQ9lrYN2cxV8YRDNHjJxW+sY7dAV0F9x/3t1PfmLjWdQnnr
	Z2GHLAXBt8XNht4P6yLbMvwkYbdBLGZEZIhCi5KhJU7KkY7eTxiUxFk+UFRBAzpB+LqPRz
	hM98hPXNbXLs+netHzALfEGKV2tLRw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-pa64xKU4NFC4hnI1DsqEDA-1; Fri, 10 May 2024 12:30:37 -0400
X-MC-Unique: pa64xKU4NFC4hnI1DsqEDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9479101A525;
	Fri, 10 May 2024 16:30:36 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.42.28.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B20BC200A380;
	Fri, 10 May 2024 16:30:34 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/5] nvme-rdma: use the cancel command to perform an abort if target supports it
Date: Fri, 10 May 2024 18:30:25 +0200
Message-Id: <20240510163026.786898-5-mlombard@redhat.com>
In-Reply-To: <20240510163026.786898-1-mlombard@redhat.com>
References: <20240510163026.786898-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_093041_547865_6EF019FC 
X-CRM114-Status: GOOD (  14.53  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If available, use Cancel command to abort the command that timed
out instead of resetting the controller.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/rdma.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 366f0bb4ebfc..a45b45965b9e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -74,6 +74,7 @@ struct nvme_rdma_request {
 	struct nvme_rdma_sgl	data_sgl;
 	struct nvme_rdma_sgl	*metadata_sgl;
 	bool			use_sig_mr;
+	bool			aborted;
 };
 
 enum nvme_rdma_queue_flags {
@@ -1956,16 +1957,19 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
-	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	struct nvme_rdma_ctrl *rdma_ctrl = queue->ctrl;
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
+	int error;
+	u32 effects;
 
-	dev_warn(ctrl->ctrl.device,
+	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -1983,11 +1987,26 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
+	if (!req->aborted) {
+		effects = le32_to_cpu(ctrl->effects->iocs[nvme_cmd_cancel]);
+
+		if (!(effects & NVME_CMD_EFFECTS_CSUPP))
+			goto err_recovery;
+
+		error = nvme_submit_cancel_req(ctrl, rq, qid);
+		if (error)
+			goto err_recovery;
+
+		req->aborted = true;
+		return BLK_EH_RESET_TIMER;
+	}
+
 	/*
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_rdma_error_recovery(ctrl);
+err_recovery:
+	nvme_rdma_error_recovery(rdma_ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2011,6 +2030,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	dev = queue->device->dev;
+	req->aborted = false;
 
 	req->sqe.dma = ib_dma_map_single(dev, req->sqe.data,
 					 sizeof(struct nvme_command),
-- 
2.39.3


