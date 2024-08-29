Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C426C761AE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 06:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NkxCFYIpq6+J+U6p74Z+6H1GYyCA1t3uiS15G3UaGNc=; b=QuDdboYlGCT0pZck5A5pva3Ze0
	75tQdJq38WCySrWg0dCbfn0PJk5GsB+N01xdj+nyEz6hnhiwuN/CCDFki9sYG4HKqCQtQ29Q4/DSf
	oujvvZdZcUEioZmnA4+hjP3xACWAEHHOxaCqxbSbIuIYyA2Xkyy4/U1F3afvzyfOjBJEZY5VRavTw
	cqdlpGFD0iuMpgeqZQfaFRQSa8Bz1i1R++oZJDx/+gAPzqyNL4NqaVbsJrT/6RSZF01FA6MkcU3Vz
	asISZk+0MlqLIaLJ5FwypKiSCamcbzMqGtq/s9Ly7ZRvymg7/USIU9SRz2xJx9qH2++1w6mVvLVV5
	HHZwbQlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYgY-00000000mnt-0kzQ;
	Thu, 29 Aug 2024 06:31:10 +0000
Received: from [2001:4bb8:2c1:ef51:b1e3:1751:33fd:c3bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYaH-00000000keV-377H;
	Thu, 29 Aug 2024 06:24:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: set BLK_FEAT_ZONED for ZNS multipath disks
Date: Thu, 29 Aug 2024 09:24:37 +0300
Message-ID: <20240829062437.2045604-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The new stricter limits validation doesn't like a max_append_sectors value
to be set without BLK_FEAT_ZONED.  Set it before allocation the disk to
fix this instead of just inheriting it later.

Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 25761fb7d88ff0..ac6991ded82a47 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -617,7 +617,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
-	if (head->ids.csi != NVME_CSI_ZNS)
+	if (head->ids.csi == NVME_CSI_ZNS)
+		lim.features |= BLK_FEAT_ZONED;
+	else
 		lim.max_zone_append_sectors = 0;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
-- 
2.43.0


