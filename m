Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD292C369D1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyYG1DZJse234Xdwr8KhFeSDcV1jPCTUIoCjXmmS6cQ=; b=3dS1DMWWUMohdRwAK1BakQuwt6
	poZursmeanCkc/TxARV94an6QTwHBXIEnYYgEyxV4ouSUj46BtvrSpKUbDDD3AbNrKCzCItLw4QTN
	Kb+s7q5bjPFHrAVDLEGyHtS9agkDkJvHWh/7uBgRC1f/RSo4dm32bjb1ai3hTv+swiLRGGW2sk9TN
	cgUXGa2yIDdlR4r5gYlUsoG9lQyEzmfZ0sBUO9FifDQM93Rr6XbyvnOd+mmeaXW51A8oN8Wiwxin5
	gD0lzNBYn5391XmlRN5aPj5Wyh7qGjj9iQezDI+x1s97RjClTaT0/ZUbRFu9zXFDbPUgxJJ36VWJX
	PlVFk9ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXU-0000000AhxM-45Z9;
	Wed, 23 Apr 2025 13:53:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3W-0000000Aaor-1Vze
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D801435EB;
	Wed, 23 Apr 2025 13:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845B3C4CEE2;
	Wed, 23 Apr 2025 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414545;
	bh=NnHI6Paao3NgdBRHQkL+L4jcP1yEUV4TLY9mPyueH3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=klMyHZSmxKc/xXNzVRz+rJJICulW7EiqNI41446qVIicVCSEvSEEVij6NHH/AzivB
	 tYRIZvGs73gIkQNs4sjwkNTWGgibURhleKa3nxtJXKe/5JAE8v1k/8l2zir4htDBgC
	 FtPXHZaXzDO5jNOQqqbVFFF1JZjvNpB2NPSBzjYlYn6JeZ4Y3706naY+11XpQ2r4Ad
	 EQdz8t70XS7+ctfHeaDDp2RTpx3jvUYQXyNT9jrZcfaLasCrgVqi7oWsW75FxjWGBc
	 iqWo+HUwD4Fd6ZYVUADppz4q+BaZ4UWiAwPwz0u+F3wqv8NTYXzbTdUTDEHXFbUP6a
	 J1+S0/I8MgdAg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:55 +0200
Subject: [PATCH v5 12/14] nvmet-fc: free pending reqs on tgtport unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-12-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062226_430091_0D3ABB2A 
X-CRM114-Status: GOOD (  15.01  )
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


