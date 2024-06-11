Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386AAC27C5E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xY3slEHkiIq7NT2sGuMOxA8hJLcOIj4MfNseHu5TMns=; b=yh9yrfj/b9u8Rzk3+norsjggY9
	rO49RD3kP1+tsawKjSdTegtWc8clQ7YiQCcM0MkzNh/hYuzAptIXOL7UcruMiW8syq7ai/e9idXd5
	3nYVOY5xifvquKVFs+g3BV1y6a9O1tSAu4X0y2VqlcU1XUJ9EhMqNSLTC+aFG6PkitWQhQLuRQdVN
	nqj9oUxDOE674elgZ1E3pG6fQ3D4w/5Qhkroa58UE3lYjyqnAlmJgVBX7f4zpSSmoAOpTHFkzYS2x
	zbCO2bHEaB/pUfbAyk+DHAhG7QdaFXt4t/SJ7I3Fkr2vZBuIHK4LRNmGhqmkVV1d+eqepztl0R48E
	a0HQpcew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGv4h-00000007hlV-0P55;
	Tue, 11 Jun 2024 06:33:43 +0000
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtwA-00000007RkZ-1jS3;
	Tue, 11 Jun 2024 05:20:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com,
	nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 26/26] block: move the bounce flag into the feature field
Date: Tue, 11 Jun 2024 07:19:26 +0200
Message-ID: <20240611051929.513387-27-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 22:22:01 -0700
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

Move the bounce field into the flags field to reclaim a little bit of
space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c    | 1 -
 block/blk.h             | 2 +-
 drivers/scsi/scsi_lib.c | 2 +-
 include/linux/blkdev.h  | 6 ++++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 96e07f24bd9aa1..d0e9096f93ca8a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -479,7 +479,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_zeroes_sectors);
 	t->max_zone_append_sectors = min(queue_limits_max_zone_append_sectors(t),
 					 queue_limits_max_zone_append_sectors(b));
-	t->bounce = max(t->bounce, b->bounce);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
 					    b->seg_boundary_mask);
diff --git a/block/blk.h b/block/blk.h
index 79e8d5d4fe0caf..fa32f7fad5d7e6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -394,7 +394,7 @@ struct bio *__blk_queue_bounce(struct bio *bio, struct request_queue *q);
 static inline bool blk_queue_may_bounce(struct request_queue *q)
 {
 	return IS_ENABLED(CONFIG_BOUNCE) &&
-		q->limits.bounce == BLK_BOUNCE_HIGH &&
+		(q->limits.features & BLK_FEAT_BOUNCE_HIGH) &&
 		max_low_pfn >= max_pfn;
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 54f771ec8cfb5e..e2f7bfb2b9e450 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1986,7 +1986,7 @@ void scsi_init_limits(struct Scsi_Host *shost, struct queue_limits *lim)
 		shost->dma_alignment, dma_get_cache_alignment() - 1);
 
 	if (shost->no_highmem)
-		lim->bounce = BLK_BOUNCE_HIGH;
+		lim->features |= BLK_FEAT_BOUNCE_HIGH;
 
 	dma_set_seg_boundary(dev, shost->dma_boundary);
 	dma_set_max_seg_size(dev, shost->max_segment_size);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7ad25def6e50b..d1d9787e76ce73 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -325,6 +325,9 @@ enum {
 
 	/* skip this queue in blk_mq_(un)quiesce_tagset */
 	BLK_FEAT_SKIP_TAGSET_QUIESCE		= (1u << 13),
+
+	/* bounce all highmem pages */
+	BLK_FEAT_BOUNCE_HIGH			= (1u << 14),
 };
 
 /*
@@ -332,7 +335,7 @@ enum {
  */
 #define BLK_FEAT_INHERIT_MASK \
 	(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA | BLK_FEAT_ROTATIONAL | \
-	 BLK_FEAT_STABLE_WRITES | BLK_FEAT_ZONED)
+	 BLK_FEAT_STABLE_WRITES | BLK_FEAT_ZONED | BLK_FEAT_BOUNCE_HIGH)
 
 /* internal flags in queue_limits.flags */
 enum {
@@ -352,7 +355,6 @@ enum blk_bounce {
 struct queue_limits {
 	unsigned int		features;
 	unsigned int		flags;
-	enum blk_bounce		bounce;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
 
-- 
2.43.0


