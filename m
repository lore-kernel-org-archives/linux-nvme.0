Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4889FCCF9F1
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsG0GX0bcwd19Yyih11kWhW2PWjbatdSFFG/y8BgT5E=; b=CgO9bconYsHzOw+IrWnbrF6Bdm
	GJEO5a13jvKYLDee4q2Sn8q5MQQOxzPIOThLRDb/wGomp0U9e1pxLQq6jFcvK7oo/Aqim5A83bLz8
	h48pZlJYw55vtWprhe9FumvoTM4W33b+JuUOpNqJxD9mkb73jjRjYgpBjh8W/y3SlwhZCaL0KE2Z8
	03jG0TITRaPwpkbXb5mKMdHdYbrHCjxA/ZfG9FnjMeUlKtBxKN7cIz8EAmOiK1Pe1ad9Zo/B2M2xZ
	lkQ5xTrLZILKxPwr/nx2ld0wHiIHLftvr/7R3qJCrTa9sK+5he5ipg3+HGQuURW9RhWkHs2V2BYKa
	ZTlsPGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXi-00000003wGM-0F5C;
	Thu, 30 Oct 2025 10:06:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXh-00000003wFL-0LHa
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 10:06:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 815BA604E4;
	Thu, 30 Oct 2025 10:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF1C4CEF1;
	Thu, 30 Oct 2025 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818764;
	bh=e0DStP5hUJf7YK1iKoYaQGpA0g5OWWSFDrWkvEoshXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZMNID5g+7eLLOAqaRxOgc8yU3iJFHExWC4KViArijg1ylTvtjBRFh8cb6lS/Xyr4
	 ROf9E2tkXQMzyNVzpFe7HHB1p4fn0Fci50sVddLoy8XsD2+H3P+ttBN7qzaTo2Xbtk
	 d1+Ixg4CvwODY5obH02tG1oFaE4S1Ne58HROF6qfgNO0fMhTGIYuFuUmenZzRY7Zqg
	 7JXUuD2pYhGowE3Mg6GVxgiWRs9+dWYgTf8vGSC1IyAImSWSrp/6vKDDhBIg6qGj2z
	 SgZlsc+wfAsYogFPa/0AHOmg0XSIxAmwhoVTlhxWfodqHsGvu/mUQCp2Eo04kXDwBk
	 vI4n9NvVzU5ig==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:49 +0100
Subject: [PATCH v2 5/5] nvmet-fc: use pr_* print macros instead of dev_*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-5-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

Many of the nvmet-fc log messages cannot print the device used, because
it's not there yet:

  (NULL device *): {0:0} Association deleted

Use the pr_* macros consistently throughout the module and match the
output of the nvme-fc module.

Using port:association ids are more useful when debugging what's going
on, because these match now with the log entries from nvme-fc.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7d84527d5a43..0d9784004c9b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -490,8 +490,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 			sizeof(*discon_rqst) + sizeof(*discon_acc) +
 			tgtport->ops->lsrqst_priv_sz), GFP_KERNEL);
 	if (!lsop) {
-		dev_info(tgtport->dev,
-			"{%d:%d} send Disconnect Association failed: ENOMEM\n",
+		pr_info("{%d:%d}: send Disconnect Association failed: ENOMEM\n",
 			tgtport->fc_target_port.port_num, assoc->a_id);
 		return;
 	}
@@ -513,8 +512,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	ret = nvmet_fc_send_ls_req_async(tgtport, lsop,
 				nvmet_fc_disconnect_assoc_done);
 	if (ret) {
-		dev_info(tgtport->dev,
-			"{%d:%d} XMT Disconnect Association failed: %d\n",
+		pr_info("{%d:%d}: XMT Disconnect Association failed: %d\n",
 			tgtport->fc_target_port.port_num, assoc->a_id, ret);
 		kfree(lsop);
 	}
@@ -1187,8 +1185,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	if (oldls)
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	ida_free(&tgtport->assoc_cnt, assoc->a_id);
-	dev_info(tgtport->dev,
-		"{%d:%d} Association freed\n",
+	pr_info("{%d:%d}: Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
 	kfree(assoc);
 }
@@ -1224,8 +1221,7 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 			flush_workqueue(assoc->queues[i]->work_q);
 	}
 
-	dev_info(tgtport->dev,
-		"{%d:%d} Association deleted\n",
+	pr_info("{%d:%d}: Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
 
 	nvmet_fc_tgtport_put(tgtport);
@@ -1716,9 +1712,9 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 	}
 
 	if (ret) {
-		dev_err(tgtport->dev,
-			"Create Association LS failed: %s\n",
-			validation_errors[ret]);
+		pr_err("{%d}: Create Association LS failed: %s\n",
+		       tgtport->fc_target_port.port_num,
+		       validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				sizeof(*acc), rqst->w0.ls_cmd,
 				FCNVME_RJT_RC_LOGIC,
@@ -1730,8 +1726,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 	atomic_set(&queue->connected, 1);
 	queue->sqhd = 0;	/* best place to init value */
 
-	dev_info(tgtport->dev,
-		"{%d:%d} Association created\n",
+	pr_info("{%d:%d}: Association created\n",
 		tgtport->fc_target_port.port_num, iod->assoc->a_id);
 
 	/* format a response */
@@ -1809,9 +1804,9 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 	}
 
 	if (ret) {
-		dev_err(tgtport->dev,
-			"Create Connection LS failed: %s\n",
-			validation_errors[ret]);
+		pr_err("{%d}: Create Connection LS failed: %s\n",
+		       tgtport->fc_target_port.port_num,
+		       validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				sizeof(*acc), rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
@@ -1871,9 +1866,9 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	}
 
 	if (ret || !assoc) {
-		dev_err(tgtport->dev,
-			"Disconnect LS failed: %s\n",
-			validation_errors[ret]);
+		pr_err("{%d}: Disconnect LS failed: %s\n",
+		       tgtport->fc_target_port.port_num,
+		       validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				sizeof(*acc), rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
@@ -1907,8 +1902,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
 	if (oldls) {
-		dev_info(tgtport->dev,
-			"{%d:%d} Multiple Disconnect Association LS's "
+		pr_info("{%d:%d}: Multiple Disconnect Association LS's "
 			"received\n",
 			tgtport->fc_target_port.port_num, assoc->a_id);
 		/* overwrite good response with bogus failure */
@@ -2051,8 +2045,8 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	struct fcnvme_ls_rqst_w0 *w0 = (struct fcnvme_ls_rqst_w0 *)lsreqbuf;
 
 	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests)) {
-		dev_info(tgtport->dev,
-			"RCV %s LS failed: payload too large (%d)\n",
+		pr_info("{%d}: RCV %s LS failed: payload too large (%d)\n",
+			tgtport->fc_target_port.port_num,
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "",
 			lsreqbuf_len);
@@ -2060,8 +2054,8 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	}
 
 	if (!nvmet_fc_tgtport_get(tgtport)) {
-		dev_info(tgtport->dev,
-			"RCV %s LS failed: target deleting\n",
+		pr_info("{%d}: RCV %s LS failed: target deleting\n",
+			tgtport->fc_target_port.port_num,
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
 		return -ESHUTDOWN;
@@ -2069,8 +2063,8 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 
 	iod = nvmet_fc_alloc_ls_iod(tgtport);
 	if (!iod) {
-		dev_info(tgtport->dev,
-			"RCV %s LS failed: context allocation failed\n",
+		pr_info("{%d}: RCV %s LS failed: context allocation failed\n",
+			tgtport->fc_target_port.port_num,
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
 		nvmet_fc_tgtport_put(tgtport);

-- 
2.51.1


