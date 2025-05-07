Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AFAC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyYG1DZJse234Xdwr8KhFeSDcV1jPCTUIoCjXmmS6cQ=; b=0n5SWXEqSEd2oXPiEP0WU4A2LY
	Uih5Mp2XVvPu+m8T3W8l+QC04Ir6YFkrItYTO/YVY3Uct+LXtg/OzCBU1cV+svtdzBJakGhU1daQx
	mE+yI3AaIp5JHlaYNqxd2ruAW1JnXXhGWFA7z1SviKjNUUD2l5BhZU1suI+aIAuZkIR7u5HWLjE3q
	F79I8QAbzGETWzyBXZWnAkmTQlBQ4x3qV6udlP7XuTrZV7pBEvjadgmSoJGOX33L8rcpADNOSRfJS
	3Yi8hdUqKvjdBvlRE58I5pbr3V5OXkhd9BfxKsvXYZEvUnrVsmFKozjBMmM8fwMxvGN8pGIfqH0hi
	tZgfIBfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoJ-0000000FNFJ-1gFD;
	Wed, 07 May 2025 12:23:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdoH-0000000FNDY-3Abw
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 31228629E5;
	Wed,  7 May 2025 12:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75013C4CEEB;
	Wed,  7 May 2025 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620616;
	bh=NnHI6Paao3NgdBRHQkL+L4jcP1yEUV4TLY9mPyueH3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n6DOZW2cHnbY+TUFxGLcw/pa/l/tODURCwyoVFPR+n2ppRlrdgHxMDgVnwC1R4/JJ
	 6OSnM2824oCm9k9ved5kYh918AevGGRVtBDq92zR2pfls45cnUjPSQx1e/s4bBo66V
	 N6tiVQShxVit4PqDDK9pSPBG2JCZvjnwawjsr7l6nmLuK58rC80i0TFMorl98p6BJl
	 fIcbv2SzMUanpX1yWFUQnhKHatibfr1mllGjUDAwfKzmZiPLB0ySn8+3ih+OImHuOJ
	 xiSKIymvYyFTyGsaBecB0Fxn35JOSadGuP4Fg5TFoOr1XHl5Q7Vg5M3arDI9KGx8+g
	 zejm27lZfXwjQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:08 +0200
Subject: [PATCH v6 12/14] nvmet-fc: free pending reqs on tgtport unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-12-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7b50130f10f6578e6e49fe8ea661de34dfbb3683..75ddb7425605dd6623db38a133b63e201592354c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1580,6 +1580,39 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
 
+static void
+nvmet_fc_free_pending_reqs(struct nvmet_fc_tgtport *tgtport)
+{
+	struct nvmet_fc_ls_req_op *lsop;
+	struct nvmefc_ls_req *lsreq;
+	struct nvmet_fc_ls_iod *iod;
+	int i;
+
+	iod = tgtport->iod;
+	for (i = 0; i < NVMET_LS_CTX_COUNT; iod++, i++)
+		cancel_work(&iod->work);
+
+	/*
+	 * After this point the connection is lost and thus any pending
+	 * request can't be processed by the normal completion path. This
+	 * is likely a request from nvmet_fc_send_ls_req_async.
+	 */
+	while ((lsop = list_first_entry_or_null(&tgtport->ls_req_list,
+				struct nvmet_fc_ls_req_op, lsreq_list))) {
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
+		kfree(lsop);
+	}
+}
+
 /**
  * nvmet_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
@@ -1608,13 +1641,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 
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
2.49.0


