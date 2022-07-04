Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC7ECCA479
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgcBAlW8kpoNWrI2qSfc2h94aoc6Kt3RliANNqAJEac=; b=HcbOe3w8sxAr+q2GdwiyHwuumW
	hKVCl73jJJrAsyz6qrCIs9C7TecsziN2WG7CeUB8B2N3gxO5ivz+76zdogkWsjkY1MYC4mPLAxuJ8
	7oB53xOpZdW2HoSIXGQ2qJfOIj6IXIKPRYP9oYvfjOZiDRC4+hOMgE/xRbouKM7DRYld/Digq7g3l
	X+6bAwJ1WSVPwKpSkrHmuyj9UkLf0yxCwK51DBnDSumxV4JIsHF1mOdqH1pOL2Gkc6NzhjgmxxDX+
	cWhpkrWLyUWuqrRnIUtWITndbj6LO5uqGWbxrj8EM/8XkAkIQlgRiQ6DyeSKoeWuNljXljSTiGp8a
	4jQompTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LSb-008sg3-8i; Mon, 04 Jul 2022 12:45:53 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LS5-008sIX-3z; Mon, 04 Jul 2022 12:45:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 07/17] block: simplify blk_check_zone_append
Date: Mon,  4 Jul 2022 14:44:50 +0200
Message-Id: <20220704124500.155247-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704124500.155247-1-hch@lst.de>
References: <20220704124500.155247-1-hch@lst.de>
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

Use the bdev based helpers instead of open coding them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc16e9bae2dc4..b530ce7b370c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -565,7 +565,6 @@ static int blk_partition_remap(struct bio *bio)
 static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 						 struct bio *bio)
 {
-	sector_t pos = bio->bi_iter.bi_sector;
 	int nr_sectors = bio_sectors(bio);
 
 	/* Only applicable to zoned block devices */
@@ -573,8 +572,8 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (pos & (blk_queue_zone_sectors(q) - 1) ||
-	    !blk_queue_zone_is_seq(q, pos))
+	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
 	/*
-- 
2.30.2


