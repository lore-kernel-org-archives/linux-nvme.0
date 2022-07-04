Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA846C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wNQtyfRXZcvIkmsMqQTlsOMSKBr77f7qSQM5+q+ESrM=; b=rH4yMLxF3SOUkLwKPIQg2XG+eT
	oFmryIjaCyp/YoYFeucLeUVaA+iZ1OX0Mn1X6tvfIBE/HyaLyoq5x5ZSAxmf4GLQWssZQnRXkREp2
	E1l241/a/8tzYjhjPNPZ4d3UCHE/m43BSjds/dIUTgGBcQpFPpUob0Zen6Jp93JE0NWnzpNjVF6Jn
	9Sza1UyOt4RXSXX5iRpIbJ8bym5NPG3HBo07v3Jtn5+RV4szGQu72URP6Pho5gQYMKJkSQ9zovVO6
	aIY3x24rWCMAkddCORHbI6AOhJZMf2qaAWEEYWZ/adDG1LlKGyp+3T/twzBnvy7dXUwrvPD6i5oMW
	bPwTbn0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LRy-008sFA-2D; Mon, 04 Jul 2022 12:45:14 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LRr-008sAh-HI; Mon, 04 Jul 2022 12:45:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 02/17] block: call blk_queue_free_zone_bitmaps from disk_release
Date: Mon,  4 Jul 2022 14:44:45 +0200
Message-Id: <20220704124500.155247-3-hch@lst.de>
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

The zone bitmaps are only used for non-passthrough I/O, so free them as
soon as the disk is released.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 2 --
 block/genhd.c     | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 58cb9cb9f48cd..7590810cf13fc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -776,8 +776,6 @@ static void blk_release_queue(struct kobject *kobj)
 	blk_free_queue_stats(q->stats);
 	kfree(q->poll_stat);
 
-	blk_queue_free_zone_bitmaps(q);
-
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
diff --git a/block/genhd.c b/block/genhd.c
index b1fb7e058b9cc..d0bdeb93e922c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1165,6 +1165,7 @@ static void disk_release(struct device *dev)
 
 	disk_release_events(disk);
 	kfree(disk->random);
+	blk_queue_free_zone_bitmaps(disk->queue);
 	xa_destroy(&disk->part_tbl);
 
 	disk->queue->disk = NULL;
-- 
2.30.2


