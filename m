Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33698CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knhle5Eb20Ixuz2GSkbqMsgzl7N8C/zOPh2TzAAUI7Q=; b=CSEceKzwLUuLnm+lNFMz7VwSd5
	2LmBWamS1TksK010Mks5coPUTavaBzevqfh+F9k9abseSAKXA2e2jRiRnmS/6IF6o+hHuJbSlP8Y6
	pT6H6Ny8u15d7Og45p/Mo1Z3c2uUUElsQyk8LyAgki6I74ZLdnwqtI+do4UzvgeztlFfsR5Ft2qn4
	ozCCNYpXdvP2tTO91K3SrKQlNFw5Wo7xsB2W5Au5zz4wPSKecH/skrTYpf10/YeFas1pZiVdTenUa
	Y3XsAcU/89qwQ+m7p0byVIbl2Cy0ey5LFSESLuD/HP0R3QoCSsqgQNztDpr3nrVvrYv2444lZx1bd
	kPyi9PLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlax-0000000GAhN-2ZnF;
	Tue, 28 Oct 2025 15:26:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlat-0000000GAe3-2i2B
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:26:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0CF548F32;
	Tue, 28 Oct 2025 15:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77991C4CEF7;
	Tue, 28 Oct 2025 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665202;
	bh=og4RpLkQbHwN8FOYj4/Ae2jn1OJFGZDc8igUI8xWOMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VMe6PPFDylySqOED17+YvMfnapMzSDc1WEfDcbD/ml3q+KmNrwBDXmvCq7BatsDXy
	 okJyPIfexJrWSbCBiu4AN0dZ4RGPKPwBcerg91Dbns7qi6cC/0YEWAzWo9q8Eq9krZ
	 /65wbFPshhoFg0r4/HcdHbrG5Nl0VHxFp47alG2fKpmtGVcLButFfi+Qd1K3PL6RIo
	 mjbGE+RoiqkLniwCPUqy7Fw7SGijxVFo2wH7n6KUq9TqSysVukOTh/aUwXwEQ6ErvN
	 TeOGgkjxmwRwDBOP2t5UDuTVVVfiNwy4SRlAcY3asqh4veB/u8QHZvDFaKzjYOS128
	 Xweo7JtwJbXBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:24 +0100
Subject: [PATCH 5/5] nvmet-fc: use pr_* print macros instead of dev_*
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_082644_488878_8D68F9B6 
X-CRM114-Status: GOOD (  12.70  )
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
2.51.0


