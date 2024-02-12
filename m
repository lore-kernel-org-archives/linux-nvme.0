Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FD4C4829E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6HSM27GbKcz02IsFZ1aYD7BVqR49cLm+9QPOfHJCYE=; b=h1YQFwFyu+fW2PZqLAwQJmljQp
	hGSSPCotVxrU8gCMI8qo8d/rJWYeKsawv2lGVBJBWnJ0lwjiVpsgukrKhZ7qtLo1nhv1QaZi7CM/c
	yjx68/RpsyjgxXCqBiTMvpRWHdjceis229GI6ZkgTaVkH3JciZuXhCGHsUvvSjA0rQz0hMndeJtse
	zTkCBOVxICQLO2JFjDdnpkktxbhPsvIJeRttyh/LO3Hl1fKpu6FRNjXaPRsB5TLZR1g2l+inXXuSm
	WQMZDN69c3F89xrq5F1fA58wipYe1iOQgH8elD1TTVxy915T+dukct94IEZCeknaHBy2svE/+FBF7
	hsqsw/Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5F-00000004Pc5-4Byl;
	Mon, 12 Feb 2024 06:46:30 +0000
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5C-00000004Pa7-1s0g;
	Mon, 12 Feb 2024 06:46:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 03/15] block: decouple blk_set_stacking_limits from blk_set_default_limits
Date: Mon, 12 Feb 2024 07:45:57 +0100
Message-Id: <20240212064609.1327143-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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

blk_set_stacking_limits uses very little from blk_set_default_limits.
Open code these initializations in preparation for rewriting
blk_set_default_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f16d3fec6658e5..1cae2db41490d2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -65,13 +65,16 @@ void blk_set_default_limits(struct queue_limits *lim)
  * blk_set_stacking_limits - set default limits for stacking devices
  * @lim:  the queue_limits structure to reset
  *
- * Description:
- *   Returns a queue_limit struct to its default state. Should be used
- *   by stacking drivers like DM that have no internal limits.
+ * Prepare queue limits for applying limits from underlying devices using
+ * blk_stack_limits().
  */
 void blk_set_stacking_limits(struct queue_limits *lim)
 {
-	blk_set_default_limits(lim);
+	memset(lim, 0, sizeof(*lim));
+	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
+	lim->discard_granularity = 512;
+	lim->dma_alignment = 511;
+	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 
 	/* Inherit limits from component devices */
 	lim->max_segments = USHRT_MAX;
-- 
2.39.2


