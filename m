Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C1AC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J3QqLW6uzCJydrFlgvYGM4oYu1xKxHEklRD1Od4noxs=; b=DiY7zjjHsMl4XfY640gLnPsjMQ
	GHg2xHJea5fh2t0Z0syiz1BnPxK2XL373UJegNzDvGUMbR1JV1i+OKBrrWtJ7B6cjP4HEUQlpbIzh
	8NDTYH0EVgd4mKRmI7ikdhLm7ClaXQfOJ3ycfo7lsAn1S60jiMmcNlCkpA+u7bfKrN8+b4RjlV2cm
	U+chX3xoRSw0AhplzYDThRCkRUabhr/6tAmlFZWmCD1FhiZ60oNFj6ca62qADb59AkTH3JewaXER0
	eAO/s438yqisqRPl+rphHLUTzNET3JQiZknI1ZB4q69E2hRsXWHNGSxyz++dtMbOaYyrf3Zk5KKS6
	nd8m/rPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEg-00DH2o-1O;
	Mon, 22 Jan 2024 17:37:26 +0000
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEf-00DGzD-0A;
	Mon, 22 Jan 2024 17:37:25 +0000
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
Subject: [PATCH 13/15] loop: cleanup loop_config_discard
Date: Mon, 22 Jan 2024 18:36:43 +0100
Message-Id: <20240122173645.1686078-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
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

Initialize the local variables for the discard max sectors and
granularity to zero as a sensible default, and then merge the
calls assigning them to the queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3f855cc79c29f5..7abeb586942677 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -755,7 +755,8 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
-	u32 granularity, max_discard_sectors;
+	u32 granularity = 0, max_discard_sectors = 0;
+	struct kstatfs sbuf;
 
 	/*
 	 * If the backing device is a block device, mirror its zeroing
@@ -775,29 +776,17 @@ static void loop_config_discard(struct loop_device *lo)
 	 * We use punch hole to reclaim the free space used by the
 	 * image a.k.a. discard.
 	 */
-	} else if (!file->f_op->fallocate) {
-		max_discard_sectors = 0;
-		granularity = 0;
-
-	} else {
-		struct kstatfs sbuf;
-
+	} else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &sbuf)) {
 		max_discard_sectors = UINT_MAX >> 9;
-		if (!vfs_statfs(&file->f_path, &sbuf))
-			granularity = sbuf.f_bsize;
-		else
-			max_discard_sectors = 0;
+		granularity = sbuf.f_bsize;
 	}
 
-	if (max_discard_sectors) {
+	blk_queue_max_discard_sectors(q, max_discard_sectors);
+	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+	if (max_discard_sectors)
 		q->limits.discard_granularity = granularity;
-		blk_queue_max_discard_sectors(q, max_discard_sectors);
-		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
-	} else {
+	else
 		q->limits.discard_granularity = 0;
-		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_max_write_zeroes_sectors(q, 0);
-	}
 }
 
 struct loop_worker {
-- 
2.39.2


