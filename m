Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFDEC10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3AE24679
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R0N8lfbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3AE24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kJXqq9Qk/P3nfN17v8uhf/9xWGLAiOqF8mfnovFmHuI=; b=R0N8lfblWGoFE37bri7aH3IgI/
	FiTL3hpIy1dzFINZ5e+cfBhf7AJdjivNY42AlOx6teotdGbAHi3dsZuVEBHZsr5JX4EtHiX6OZjSh
	Dg1pedqAO/vnE6C9fsLItXWuhEnQhejKOoVTFvl5O1wBumbfbomdETU5IrKpJUPBAotLNSKnD4f9l
	l4I+N+V49HEtZ+BCnN/rNoqlaWiLuCbfXBc6SIIGGFR9u8LFZCWCpcHlTooRIhAgKXqM9ANq8k0WV
	gD2/T6gvX3O2MpwTXzzIQ5ElgR2qLmOkTq0rir7hJNv4jsnIDKKyFGcgstxmSgzOT9COrXV4soheT
	AGDLX7WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jACfF-0001Qg-2L; Fri, 06 Mar 2020 13:05:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jACeq-0008EU-M1
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 13:04:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 32A84B239;
 Fri,  6 Mar 2020 13:04:49 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] nvmet/fc: Sanitize tgtport reference counting for LS
 requests
Date: Fri,  6 Mar 2020 14:04:38 +0100
Message-Id: <20200306130440.16864-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200306130440.16864-1-hare@suse.de>
References: <20200306130440.16864-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_050452_868445_3E8C02E9 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <keith.busch@wdc.com>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We need to validate the targetport upon first access, otherwise
there's a risk of accessing an invalid targetport.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 0a0f03b2faf3..aff959300ef3 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -358,6 +358,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
+		nvmet_fc_tgtport_put(tgtport);
 		return;
 	}
 
@@ -386,9 +387,6 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	if (!tgtport->ops->ls_req)
 		return -EOPNOTSUPP;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return -ESHUTDOWN;
-
 	lsreq->done = done;
 	lsop->req_queued = false;
 	INIT_LIST_HEAD(&lsop->lsreq_list);
@@ -396,10 +394,9 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
 				  DMA_BIDIRECTIONAL);
-	if (fc_dma_mapping_error(tgtport->dev, lsreq->rqstdma)) {
-		ret = -EFAULT;
-		goto out_puttgtport;
-	}
+	if (fc_dma_mapping_error(tgtport->dev, lsreq->rqstdma))
+		return -EFAULT;
+
 	lsreq->rspdma = lsreq->rqstdma + lsreq->rqstlen;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
@@ -426,9 +423,6 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
-out_puttgtport:
-	nvmet_fc_tgtport_put(tgtport);
-
 	return ret;
 }
 
@@ -482,14 +476,19 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	struct nvmefc_ls_req *lsreq;
 	int ret;
 
+	if (!nvmet_fc_tgtport_get(tgtport))
+		return;
+
 	/*
 	 * If ls_req is NULL or no hosthandle, it's an older lldd and no
 	 * message is normal. Otherwise, send unless the hostport has
 	 * already been invalidated by the lldd.
 	 */
 	if (!tgtport->ops->ls_req || !assoc->hostport ||
-	    assoc->hostport->invalid)
+	    assoc->hostport->invalid) {
+		nvmet_fc_tgtport_put(tgtport);
 		return;
+	}
 
 	lsop = kzalloc((sizeof(*lsop) +
 			sizeof(*discon_rqst) + sizeof(*discon_acc) +
@@ -498,6 +497,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 		dev_info(tgtport->dev,
 			"{%d:%d} send Disconnect Association failed: ENOMEM\n",
 			tgtport->fc_target_port.port_num, assoc->a_id);
+		nvmet_fc_tgtport_put(tgtport);
 		return;
 	}
 
@@ -522,6 +522,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 			"{%d:%d} XMT Disconnect Association failed: %d\n",
 			tgtport->fc_target_port.port_num, assoc->a_id, ret);
 		kfree(lsop);
+		nvmet_fc_tgtport_put(tgtport);
 	}
 }
 
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
