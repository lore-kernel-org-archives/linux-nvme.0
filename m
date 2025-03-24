Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F73C36005
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLH9c4ZTSlFZUac2OHGbpxgTerlmUrNeL7+FWFieTwI=; b=tVyEjkMcuPS8PhIjLCg1s/+2X2
	l8Xze5TuodvY1npys7d6lnZH8y4cw2zznOPuDx8TwqjpYu6DFCAqfudJBP4eHgSTY4MWWC14zv7Bc
	5FINCcsY6fMlV6nrLQdLxNIDIQ7UnUAH1LXwIHeFx2NtMHh/AZxmNU5q6IEvdXf9+OdTmj5h9cDJq
	mUPhVa9gusI7qFZAEGR92NztHtkI3PY/UAeBpKh1VZ9LrVupBcmDT+UdJziVyAd2X6GuCmbqfWO9u
	WO5A7psCZOELrF+3MEilNwyrJ/v6NkTvASjuGlyTVi5VYiamiJLF8MUODyfm5ozDZrIx/a5Nq5KkM
	G8M/zFFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyu-00000002oNi-3FEO;
	Mon, 24 Mar 2025 10:24:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twexw-00000002oBr-2L5b
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLH9c4ZTSlFZUac2OHGbpxgTerlmUrNeL7+FWFieTwI=;
	b=TCfBhpdwcHJc9auOq57gWLY0IvwLg2T7t9kL6R45Ff2I572ca5lq/vvgtbjqq0uNTbQ0kk
	fbSSglH44YOCul6lq0sSHTk+BVh7SC1UVmdyzy6PcV7h65bxQa8JK8P3NZhj6883IBiRrz
	hcWJcvltK6DLs5qTbxdb0w/3FRg5Fuk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-e76gxOOoNVGLJ04D6jMh7A-1; Mon,
 24 Mar 2025 06:23:28 -0400
X-MC-Unique: e76gxOOoNVGLJ04D6jMh7A-1
X-Mimecast-MFC-AGG-ID: e76gxOOoNVGLJ04D6jMh7A_1742811807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87068180AF6D;
	Mon, 24 Mar 2025 10:23:27 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA5BD180A801;
	Mon, 24 Mar 2025 10:23:24 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 03/11] nvme-core: add a function to submit a cancel command
Date: Mon, 24 Mar 2025 11:23:02 +0100
Message-ID: <20250324102310.658007-4-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pd5B_fQrTNfFGiMRfj9AAQelk7r-YvaqsUtHB-cq5Pk_1742811807
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032332_661550_12F75C86 
X-CRM114-Status: GOOD (  14.45  )
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

Add a function to send a cancel command to abort the specified request.
When the cancel command completes, the host driver will print the
number of deferred and immediate aborts performed by the target.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5e6d7cd152a..d0dbc249b575 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3113,6 +3113,67 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
+static enum rq_end_io_ret nvme_cancel_endio(struct request *req, blk_status_t error)
+{
+	struct nvme_ctrl *ctrl = req->end_io_data;
+	u32 result;
+	u16 imm_abrts, def_abrts;
+
+	if (!error) {
+		result = le32_to_cpu(nvme_req(req)->result.u32);
+		def_abrts = upper_16_bits(result);
+		imm_abrts = lower_16_bits(result);
+
+		dev_warn(ctrl->device,
+			 "Cancel status: 0x0 imm abrts = %u def abrts = %u",
+			 imm_abrts, def_abrts);
+	} else {
+		dev_warn(ctrl->device, "Cancel status: 0x%x",
+			 nvme_req(req)->status);
+	}
+
+	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
+}
+
+int nvme_submit_cancel_req(struct nvme_ctrl *ctrl, struct request *rq,
+			   unsigned int sqid, int action)
+{
+	struct nvme_command c = { };
+	struct request *cancel_req;
+
+	if (sqid == 0)
+		return -EINVAL;
+
+	c.cancel.opcode = nvme_cmd_cancel;
+	c.cancel.sqid = cpu_to_le32(sqid);
+	c.cancel.nsid = NVME_NSID_ALL;
+	c.cancel.action = action;
+	if (action == NVME_CANCEL_ACTION_SINGLE_CMD)
+		c.cancel.cid = nvme_cid(rq);
+	else
+		c.cancel.cid = 0xFFFF;
+
+	cancel_req = blk_mq_alloc_request_hctx(rq->q, nvme_req_op(&c),
+					       BLK_MQ_REQ_NOWAIT |
+					       BLK_MQ_REQ_RESERVED,
+					       sqid - 1);
+	if (IS_ERR(cancel_req)) {
+		dev_warn(ctrl->device, "%s: Could not allocate the Cancel "
+					"command", __func__);
+		return PTR_ERR(cancel_req);
+	}
+
+	nvme_init_request(cancel_req, &c);
+	cancel_req->end_io = nvme_cancel_endio;
+	cancel_req->end_io_data = ctrl;
+
+	blk_execute_rq_nowait(cancel_req, false);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_submit_cancel_req);
+
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6dfc875ddfd1..6388f0a52638 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -908,6 +908,8 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
+int nvme_submit_cancel_req(struct nvme_ctrl *ctrl, struct request *rq,
+			       unsigned int sqid, int action);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
-- 
2.43.5


