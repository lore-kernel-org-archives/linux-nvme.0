Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D861DCCA473
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBz/LhwBZw9yI8kZ+GIiGhL/9U8OwJhoN7e643gX1Pk=; b=qw2SrYJy9uq18fQa9DfzodfWyW
	K+BbEQB1KKZ2VPn1xp0IWcvi9n+1xphfRminNzLFtks16Uv+7izA40a4TjRJ1EQCcUDLDdSQl46CM
	szO7YRqxr7viTyEL0LSNLg6a74cU1knlbKZdPNaWI9j0VsoFhkWGBDw2mYyThRCGE4VGNMpewBLOE
	RJGSAaBXCyTFij0kiCNVGW0rhgxmoZZD2MncTI9pmFnH3gZNqBhJ7EH03QgFRN/EzBL+yS0KHy0Ln
	1ppyKY2ZRFH0AVFloFhMWCgfyTcCtzENNQk7xMA4dh/GDHRg981fcocg/ua09lMCYc3MsUlYvreVL
	KAWHoJrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z6X-006wLr-10; Wed, 06 Jul 2022 07:05:45 +0000
Received: from [2001:4bb8:189:3c4a:f22c:c36a:4e84:c723] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z5H-006vEM-3p; Wed, 06 Jul 2022 07:04:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 13/16] nvmet:: use bdev based helpers in nvmet_bdev_zone_mgmt_emulate_all
Date: Wed,  6 Jul 2022 09:03:47 +0200
Message-Id: <20220706070350.1703384-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
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
 drivers/nvme/target/zns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c4c99b832daf2..9d8717126ab31 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -413,7 +413,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 		ret = 0;
 	}
 
-	while (sector < get_capacity(bdev->bd_disk)) {
+	while (sector < bdev_nr_sectors(bdev)) {
 		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
 			bio = blk_next_bio(bio, bdev, 0,
 				zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC,
@@ -422,7 +422,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 			/* This may take a while, so be nice to others */
 			cond_resched();
 		}
-		sector += blk_queue_zone_sectors(q);
+		sector += bdev_zone_sectors(bdev);
 	}
 
 	if (bio) {
-- 
2.30.2


