Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0F2C54E55
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCouwC0fhxTIxJn2BmBN/79OSqvHAzI8vVcSvmEQk0s=; b=xDWKQfUqJMQHBo5rTjM3FSx+R/
	eqxqrzmgIV7PwVEh0ytiXqkuwa1/mXOOBCjiaTV5xlq+HogYsmzRKbTJkR04Ofk2mUDhHWUCpKy83
	4D8FxoltKX8pDANslHxrm4DKkd7fFIQmQUSZyqARGQS1UDvpeE8ASEiivqxPScMoa42HpWV54prRb
	K27xncpi+PXuQ05XjDt0h26D2SF9JqirjvPXXiRF3i7gke/A/Ptn7FPvWG9GBKNT2P9z1BiMphmjq
	7XktGLjioEoz/rrvG0UVL4gXBzActdVVTQjU/QrM7Ngj6A9vYDbje9uc0Edn3lXj6h6co1d7LVZqV
	uOUO8yeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPl-0000000AREU-0fF7;
	Wed, 28 Feb 2024 18:12:21 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPf-0000000ARCC-3Qv7;
	Wed, 28 Feb 2024 18:12:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 02/21] block: add a queue_limits_stack_bdev helper
Date: Wed, 28 Feb 2024 10:11:56 -0800
Message-Id: <20240228181215.873854-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
References: <20240228181215.873854-1-hch@lst.de>
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

Add a small wrapper around blk_stack_limits that allows passing a bdev
for the bottom device and prints an error in case of misaligned
device. The name fits into the new queue limits API and the intent is
to eventually replace disk_stack_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 25 +++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1989a177be201b..865fe4ebbf9b83 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -891,6 +891,31 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 }
 EXPORT_SYMBOL(blk_stack_limits);
 
+/**
+ * queue_limits_stack_bdev - adjust queue_limits for stacked devices
+ * @t:	the stacking driver limits (top device)
+ * @bdev:  the underlying block device (bottom)
+ * @offset:  offset to beginning of data within component device
+ * @pfx: prefix to use for warnings logged
+ *
+ * Description:
+ *    This function is used by stacking drivers like MD and DM to ensure
+ *    that all component devices have compatible block sizes and
+ *    alignments.  The stacking driver must provide a queue_limits
+ *    struct (top) and then iteratively call the stacking function for
+ *    all component (bottom) devices.  The stacking function will
+ *    attempt to combine the values and ensure proper alignment.
+ */
+void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
+		sector_t offset, const char *pfx)
+{
+	if (blk_stack_limits(t, &bdev_get_queue(bdev)->limits,
+			get_start_sect(bdev) + offset))
+		pr_notice("%s: Warning: Device %pg is misaligned\n",
+			pfx, bdev);
+}
+EXPORT_SYMBOL_GPL(queue_limits_stack_bdev);
+
 /**
  * disk_stack_limits - adjust queue limits for stacked drivers
  * @disk:  MD/DM gendisk (top)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dd510ad7ce4b45..285e82723d641f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -924,6 +924,8 @@ extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
+void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
+		sector_t offset, const char *pfx);
 extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 			      sector_t offset);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
-- 
2.39.2


