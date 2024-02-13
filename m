Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E40CC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gmEEgchAPPO8mcnoSMt3cYSx4rpjOlnGmkpMNUkCUI=; b=4ffXZ2W9r7TkV8IHEaCi/G9oYr
	VWdpca0EczaWeOmzHmTDOwxNQD483N4brGx11zE8gnkaMCuJy43VOo+MXr20dgZwcFkJY8e4lY3zc
	nNRE/h2hvJDqU6jMKqnPP6dziYZgwvNhkZO+ORxmL874MuAfZDR89vaHr73fBo9jxQAtuGqAP0aeY
	80tK/YwtBhu7KuyhiLBOMfaorcffrLW6a8+pr/NPrWj8ftxv1eplmwqX+fTzlhZ0kETD158HHRsJW
	U9GS+Z9+YGFlwrWNzZHMeJI+jMfCh7XwyIANOj9453CL3DbhbKDF1Swr/m5LeYm6SIas9cXissImD
	LoZ9Djnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnJf-00000008GED-0Pj8;
	Tue, 13 Feb 2024 07:34:55 +0000
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnJc-00000008GAm-1TaA;
	Tue, 13 Feb 2024 07:34:53 +0000
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
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/15] block: decouple blk_set_stacking_limits from blk_set_default_limits
Date: Tue, 13 Feb 2024 08:34:13 +0100
Message-Id: <20240213073425.1621680-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-settings.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f16d3fec6658e5..24042f6b33d54e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -65,13 +65,18 @@ void blk_set_default_limits(struct queue_limits *lim)
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
+	lim->logical_block_size = SECTOR_SIZE;
+	lim->physical_block_size = SECTOR_SIZE;
+	lim->io_min = SECTOR_SIZE;
+	lim->discard_granularity = SECTOR_SIZE;
+	lim->dma_alignment = SECTOR_SIZE - 1;
+	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 
 	/* Inherit limits from component devices */
 	lim->max_segments = USHRT_MAX;
-- 
2.39.2


