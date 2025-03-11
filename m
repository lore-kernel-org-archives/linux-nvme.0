Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AE9C28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOMNfEnPYgYwKbi9LL8PIx98L2dBVsqiWCLV+iHIoMU=; b=4Io6EwOrZe6ter/SvBA/nSSa1n
	fmghwn2zY+QPMb37Q/77lqRvMYD/LVf5yo/SsiN42T/kbnTNMhtSDr4Dc294e6io1lv2LevcGiRdr
	BnaT8aUGqrRzWN7QY9fiQuh5ZZT7+lh4KGyrvoHg6EiuJ+TIKf/tlOiTJ6257TGn5DsvkLAbFIv3r
	A4yaRRQb6Vn99MjKJpvV1+Vq24QMy+YqMQOMHZ7hdPkA2ts6zuD/UFGj464LzAmSjFLZvxMvlav/B
	BsskQseolTRl0FJwXhJkOWrbB7Gj8TYkNlWEVzi1BjLLSZVHo5APsLu5lkURHWdkdRuBBfnU/kQsi
	Qw4Lp+bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaq-00000005GRQ-2zzv;
	Tue, 11 Mar 2025 10:12:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwan-00000005GNF-3wHT
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9DAD45C569E;
	Tue, 11 Mar 2025 10:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10C0C4CEEE;
	Tue, 11 Mar 2025 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687929;
	bh=vL5pMsi2oen3+xGkZg2MC9buTgMFVXZ352mKlFaYiM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VsGfpi1FGqamoKl9avuKGZcoYK4o36a+BDQS6N3QhUSbKbMDazVnSdDsJEWxHEnDN
	 C1wd2hieRh154W2XnBy/f/DR3HqsUCfbQysJKhQmnsJ5cKsJKc7IRr7V1jl1mZDpQJ
	 cw2I/swiOVoi/k2M+HCB4D7wnQXEtvEh7RPdUQVNT0HZif1acR1dcmrL8jFHJKjKur
	 NbLDFgSftxvQ2H1MN/sbRoPdrwnN9UQro0mG36S9ziQMBa7NvQhW04If4KOIlUthB4
	 QiFQRtIMBNu9jZrZ2q0K+zGiWl/tQVvbdm80J0rHKpGkoJErxPWzB+byhIVGxMHrgc
	 J8vEE2dnraKkw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:37 +0100
Subject: [PATCH v2 11/15] nvmet-fc: free pending reqs on tgtport unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-11-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031210_033151_8C9FFDA9 
X-CRM114-Status: GOOD (  14.46  )
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
 drivers/nvme/target/fc.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 810aff9901da725086f8bd76f3320fb31696468f..c579810f0225eedaadf84eb24e1d890629327623 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1616,6 +1616,37 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
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
@@ -1639,13 +1670,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 
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


