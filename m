Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812BDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYBJahfwkfMLeoVA8quXPBFpQwI12nXD7pTG2SEW+HY=; b=a07CqH+XALkgpGaRQdRh9sJ6wE
	8XigetqpiWpDhjMwNhfbDXx/yTwd8WqINhn6cdVeEKMnBjabhYUAHfNUHSdii/u8PBKqYgevjRyb9
	m0zVWpO05WBwR5s3NdgD70T2y8KCUcAKScYbK5IVsjx0H6miYctQ08+8ALWzbAQ7gZ9Dh4sEV1Hxe
	TbhIies4Jb/MBN1eq1qAD6TjlNBFAlhgceWV5YcfkJWG/YloXHD4jyhombd322I8PHkIBwZZS3/b1
	25IYTgfCvJXfFjEV25YMMAtfNDDWsZ0ajSczBdKGV1598Ylg3zs9vOEapPL3jh419T9kXORYKNeRr
	u2xNPGOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LUh-008txX-TU; Mon, 04 Jul 2022 12:48:03 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LSO-008sVA-3A; Mon, 04 Jul 2022 12:45:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 14/17] block: use bdev based helpers in blkdev_zone_mgmt / blkdev_zone_mgmt_all
Date: Mon,  4 Jul 2022 14:44:57 +0200
Message-Id: <20220704124500.155247-15-hch@lst.de>
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

Use the bdev based helpers instead of the queue based ones to clean up
the code a bit and prepare for storing all zone related fields in
struct gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 836b96ebfdc04..ee8752f083a94 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -190,8 +190,8 @@ int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
 			 gfp_t gfp_mask)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-	sector_t capacity = get_capacity(bdev->bd_disk);
-	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	sector_t capacity = bdev_nr_sectors(bdev);
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
 	unsigned long *need_reset;
 	struct bio *bio = NULL;
 	sector_t sector = 0;
@@ -262,8 +262,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		     gfp_t gfp_mask)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-	sector_t zone_sectors = blk_queue_zone_sectors(q);
-	sector_t capacity = get_capacity(bdev->bd_disk);
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	sector_t capacity = bdev_nr_sectors(bdev);
 	sector_t end_sector = sector + nr_sectors;
 	struct bio *bio = NULL;
 	int ret = 0;
-- 
2.30.2


