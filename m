Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E86EC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwTaopREgSnpAfTD+3OtpTVBIWNH/fMIOBz13duJlBU=; b=CDdJ9R2HkBvgSHYAAdtEaH4PCH
	D++7gVyexWORI+ea68+z/M64EY3m6tVVPuSBhHpZF2S+/r9grRJVOwM6kdM2mdqXTYXi+Y4oDAYue
	Qfm7YKRrX5jP2iAd/qpHQNvfsTg+PSBieone12kvXO5atdk1x5ZcMT1hyXJWFawFCs/xs/3o/q46K
	kb5TvN/fPWERsV/nqEq8AgD6Jaupqb0LgJwIndZhmfm1pwq8lnNnejW06oe79tPSX8AVOO6TK6Txi
	vqOUv6BGdbBq/s4ubIanIG6TyThg+KJq/9mpGfNLj99xZurbMw+xslKNeh0VInxFigRK1VMig5R7c
	6XjVCp8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQH-000000050Rb-2zHS;
	Wed, 26 Feb 2025 18:46:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQG-000000050Pw-2Dgd
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 139E061540;
	Wed, 26 Feb 2025 18:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D98CC4CEE8;
	Wed, 26 Feb 2025 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595579;
	bh=KgJVfB3Qy7a1wCHTTv+5L+khTJcVq387laAYSWSU2L8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TR2dhLX8wKrboAjqPtRK1DUYiBpB8ZrwYVzlPSrNx26XOY0oj19EQrHrsYryWIVwY
	 2a0l+G1nnbFZyyB4VGEX1EXGunv2ishDz5J/X4YRHKDI7WeeDvXkdo1GrvtNx2Tfrh
	 Ow5jjjkYY38i57h/IvbeCRBVBfMxjt7OEQPZLx1OlP07F2wLN7ONj/WjoMdkUT1WBV
	 dMDuozEzNtYELhoVscT8TKNYKt8svxizS/OiaklcUsdCUw3lpEFIE5X6bmDTPxPW6r
	 hXbva8FgySMXlrR/HGsW1v3yrSTlTyUy1t/IAGvCAxnWHfEtFfJcNrj8c9nidX1114
	 IzAZxv0hz2r9w==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:01 +0100
Subject: [PATCH 09/11] nvmet-fc: free pending reqs on tgtport unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-9-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

When nvmet_fc_unregister_targetport is called by the LLDD, it's not
possible to communicate with the host, thus all pending request will not
be process. Thus explicitly free them.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 391917b4ce0115dbc0ad99d1fb363b1af6ee0685..a5f7cb18ac9f49e41626e1c9a031c3cc830af9ba 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1610,6 +1610,37 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
 
+static void
+nvmet_fc_free_pending_reqs(struct nvmet_fc_tgtport *tgtport)
+{
+	struct nvmet_fc_ls_req_op *lsop;
+	struct nvmefc_ls_req *lsreq;
+
+	/*
+	 * After this point the connection is lost and thus any pending
+	 * request can't be processed by the normal completion path. This
+	 * is likely a request from nvmet_fc_send_ls_req_async.
+	 */
+	for (;;) {
+		lsop = list_first_entry_or_null(&tgtport->ls_req_list,
+						struct nvmet_fc_ls_req_op,
+						lsreq_list);
+		if (!lsop)
+			break;
+
+		list_del(&lsop->lsreq_list);
+
+		if (!lsop->req_queued)
+			continue;
+
+		lsreq = &lsop->ls_req;
+		fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
+				    (lsreq->rqstlen + lsreq->rsplen),
+				    DMA_BIDIRECTIONAL);
+		nvmet_fc_tgtport_put(tgtport);
+	}
+}
+
 /**
  * nvmet_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
@@ -1633,13 +1664,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 
 	flush_workqueue(nvmet_wq);
 
-	/*
-	 * should terminate LS's as well. However, LS's will be generated
-	 * at the tail end of association termination, so they likely don't
-	 * exist yet. And even if they did, it's worthwhile to just let
-	 * them finish and targetport ref counting will clean things up.
-	 */
-
+	nvmet_fc_free_pending_reqs(tgtport);
 	nvmet_fc_tgtport_put(tgtport);
 
 	return 0;

-- 
2.48.1


