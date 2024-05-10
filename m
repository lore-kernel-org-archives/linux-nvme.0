Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F4C41513
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5V/B68v+jT0RTFxWZ6tM0SjoVWPiuW1I4+b3h48n8c=; b=KYua4nHg7Los84lUVjbhZo8keY
	2wUdqJXRF+inTGPprTvpXEDsuIfyeu+4Bn8kGgUwxZ4AcpyXXHaXkEyBsORVr2St6Gr50BkuJ1CRn
	rLZ7Fkf0eQnh6zZywvZ+Td+Kn4DUrWCRaLLedXj24/iAXjbVRG6eMb7MeofkUDGsjmQ7sJ59ahOMB
	2FbBaoBoErKVzJcc3Wzi2hml1eTfTu2Pcib8T4MIVDGfqt0kR3Tnc5nKE6lgjOiAgl/V9oxQ5FJXu
	Q52QI/+e/zwYHJI+IxmY/e2EIrNsyLtw/mnf7OaWfR4e741gD9XIeRuoQMnsas0UJJcNtcwugMxJK
	34O8zBEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8u-00000005s3f-2sX4;
	Fri, 10 May 2024 16:30:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8p-00000005s0q-2ibe
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715358636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5V/B68v+jT0RTFxWZ6tM0SjoVWPiuW1I4+b3h48n8c=;
	b=Zj6vEzAqvcfVXK7CkVRJoofUDVyzwnUpP8KZBHOVptrJBcKUSDoaQuhCkyo/QSlRGpVPmE
	0j9HXzCh1ZtgS38Vzi6gysUF2gogVosQ9HxiIua2L/PuQa+yNIx8T75hd28hm/nByQRkvj
	91VGUCWkMjWUBMAzuohxBEFtHbmQxpQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-_n3t8QVbMhyjeOMKDuTjHg-1; Fri,
 10 May 2024 12:30:33 -0400
X-MC-Unique: _n3t8QVbMhyjeOMKDuTjHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1667929AC036;
	Fri, 10 May 2024 16:30:33 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.42.28.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3E09207CDF0;
	Fri, 10 May 2024 16:30:30 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/5] nvme-core: add a function to submit a cancel command
Date: Fri, 10 May 2024 18:30:23 +0200
Message-Id: <20240510163026.786898-3-mlombard@redhat.com>
In-Reply-To: <20240510163026.786898-1-mlombard@redhat.com>
References: <20240510163026.786898-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_093039_797462_6B70D77E 
X-CRM114-Status: GOOD (  13.80  )
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
To execute the task, the "single command" cancel action is used.

When the cancel command completes, the host driver will print the
number of deferred and immediate aborts performed by the target.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b48967c98114..3d8c31d5f8ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2965,6 +2965,60 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
+static enum rq_end_io_ret nvme_cancel_endio(struct request *req, blk_status_t error)
+{
+	struct nvme_ctrl *ctrl = req->end_io_data;
+	u32 result;
+	u16 imm_abrts, def_abrts;
+	u16 status = nvme_req(req)->status;
+
+	result = le32_to_cpu(nvme_req(req)->result.u32);
+
+	def_abrts = upper_16_bits(result);
+	imm_abrts = lower_16_bits(result);
+
+	dev_warn(ctrl->device,
+		 "Cancel status: 0x%x imm abrts = %u def abrts = %u",
+		 status, imm_abrts, def_abrts);
+
+	blk_mq_free_request(req);
+	return RQ_END_IO_NONE;
+}
+
+int nvme_submit_cancel_req(struct nvme_ctrl *ctrl, struct request *rq,
+			   unsigned int sqid)
+{
+	struct nvme_command c = { };
+	struct request *cancel_req;
+
+	if (sqid == 0)
+		return -EINVAL;
+
+	c.cancel.opcode = nvme_cmd_cancel;
+	c.cancel.cid = nvme_cid(rq);
+	c.cancel.sqid = cpu_to_le32(sqid);
+	c.cancel.nsid = NVME_NSID_ALL;
+	c.cancel.action = NVME_CANCEL_ACTION_SINGLE_CMD;
+
+	cancel_req = blk_mq_alloc_request_hctx(rq->q, nvme_req_op(&c),
+					       BLK_MQ_REQ_NOWAIT |
+					       BLK_MQ_REQ_RESERVED,
+					       sqid - 1);
+	if (IS_ERR(cancel_req)) {
+		dev_warn(ctrl->device, "Cancel command failed!\n");
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
index b564c5f1450c..c4cea8b948a8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -895,6 +895,8 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
+int nvme_submit_cancel_req(struct nvme_ctrl *ctrl, struct request *rq,
+			       unsigned int sqid);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
-- 
2.39.3


