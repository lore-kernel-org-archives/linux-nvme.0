Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F069AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P5OuqG/wHWU5PWWhi0Nrc+hpQAT9EtuSrQkfrxN106o=; b=HYJlGTKrHeLcXhZDZGbFf2t1/w
	oZG27zw0BwzSBZeH/NKvauEv2rtrvy8JUmmncYpabFHfK5lUbz0NyZCTTZEAHdSwVU4TZQMP8/rT2
	9IPn/XY92Ik15NJu16HBSKPE6pDHhp5zQNw5PhdYPJn5YEzbVIST53NINfOO0j/hrwjI9WRIQKmwG
	ynpUVqv0YbrXDCQPFw57AzHOGPZ73U/wNqJ4aGFnQ54TZ2La7a0FucCEGCpYPzvN9P5bTfRfel7Zr
	D3IRnxaBa8RyA/nkZrbC519+oauTcdXEuyTc9PFea0aftfROR/c4atuxMR1SASm5VbXuHlkmfOpsy
	mSLI6SmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LSU-008sao-4v; Mon, 04 Jul 2022 12:45:46 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LS2-008sGf-C7; Mon, 04 Jul 2022 12:45:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 06/17] nvmet: use blkdev_zone_mgmt_all
Date: Mon,  4 Jul 2022 14:44:49 +0200
Message-Id: <20220704124500.155247-7-hch@lst.de>
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

Use blkdev_zone_mgmt_all instead of a copy and pasted version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/zns.c | 104 ++------------------------------------
 1 file changed, 3 insertions(+), 101 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7a72b..c6f0a775efdee 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -337,110 +337,12 @@ static u16 blkdev_zone_mgmt_errno_to_nvme_status(int ret)
 	}
 }
 
-struct nvmet_zone_mgmt_send_all_data {
-	unsigned long *zbitmap;
-	struct nvmet_req *req;
-};
-
-static int zmgmt_send_scan_cb(struct blk_zone *z, unsigned i, void *d)
-{
-	struct nvmet_zone_mgmt_send_all_data *data = d;
-
-	switch (zsa_req_op(data->req->cmd->zms.zsa)) {
-	case REQ_OP_ZONE_OPEN:
-		switch (z->cond) {
-		case BLK_ZONE_COND_CLOSED:
-			break;
-		default:
-			return 0;
-		}
-		break;
-	case REQ_OP_ZONE_CLOSE:
-		switch (z->cond) {
-		case BLK_ZONE_COND_IMP_OPEN:
-		case BLK_ZONE_COND_EXP_OPEN:
-			break;
-		default:
-			return 0;
-		}
-		break;
-	case REQ_OP_ZONE_FINISH:
-		switch (z->cond) {
-		case BLK_ZONE_COND_IMP_OPEN:
-		case BLK_ZONE_COND_EXP_OPEN:
-		case BLK_ZONE_COND_CLOSED:
-			break;
-		default:
-			return 0;
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	set_bit(i, data->zbitmap);
-
-	return 0;
-}
-
-static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
-{
-	struct block_device *bdev = req->ns->bdev;
-	unsigned int nr_zones = blkdev_nr_zones(bdev->bd_disk);
-	struct request_queue *q = bdev_get_queue(bdev);
-	struct bio *bio = NULL;
-	sector_t sector = 0;
-	int ret;
-	struct nvmet_zone_mgmt_send_all_data d = {
-		.req = req,
-	};
-
-	d.zbitmap = kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(*(d.zbitmap)),
-				 GFP_NOIO, q->node);
-	if (!d.zbitmap) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	/* Scan and build bitmap of the eligible zones */
-	ret = blkdev_report_zones(bdev, 0, nr_zones, zmgmt_send_scan_cb, &d);
-	if (ret != nr_zones) {
-		if (ret > 0)
-			ret = -EIO;
-		goto out;
-	} else {
-		/* We scanned all the zones */
-		ret = 0;
-	}
-
-	while (sector < get_capacity(bdev->bd_disk)) {
-		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
-			bio = blk_next_bio(bio, bdev, 0,
-				zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC,
-				GFP_KERNEL);
-			bio->bi_iter.bi_sector = sector;
-			/* This may take a while, so be nice to others */
-			cond_resched();
-		}
-		sector += blk_queue_zone_sectors(q);
-	}
-
-	if (bio) {
-		ret = submit_bio_wait(bio);
-		bio_put(bio);
-	}
-
-out:
-	kfree(d.zbitmap);
-
-	return blkdev_zone_mgmt_errno_to_nvme_status(ret);
-}
-
 static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
 {
+	unsigned int op = zsa_req_op(req->cmd->zms.zsa);
 	int ret;
 
-	switch (zsa_req_op(req->cmd->zms.zsa)) {
+	switch (op) {
 	case REQ_OP_ZONE_RESET:
 		ret = blkdev_zone_mgmt(req->ns->bdev, REQ_OP_ZONE_RESET, 0,
 				       get_capacity(req->ns->bdev->bd_disk),
@@ -451,7 +353,7 @@ static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:
-		return nvmet_bdev_zone_mgmt_emulate_all(req);
+		return blkdev_zone_mgmt_all(req->ns->bdev, op, GFP_KERNEL);
 	default:
 		/* this is needed to quiet compiler warning */
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
-- 
2.30.2


