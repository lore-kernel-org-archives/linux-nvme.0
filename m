Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A82CD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgFKlWH0JH97rYMkmWDusW0V/4XcAw9867fTEsRa1Nk=; b=Cab8sCc7agkjx1BypfNoWzccuR
	rFBNxZ58JP49WKWAxtfUCK2eu1M38LCsr6rUkJU4FTnHd7+dm+e47I0P1F2C7H74tXFswm+C3r49B
	OmmKaS2nqEquGE5ls/FIyqMiJxyHP6x5zEP0I7Yrjb6P+HUMuT+w+L/77/Bh59hng3xojnnD77GrO
	4I7qp/3SIuXPTEMKgUAzF7FJJY1XdL4jlQPQ6VeXecl7FJqAVUva5xMZhdJFh75Uj6JzsB34VQLx6
	8EohdB6gNsnIqqfe85HtHYwm3F1yr7ZS5rYbbB9zyfKd8WX4PXI97VbVaFFXUngyAIDGU7Kc/fQbi
	+v9SE0RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSP-00000005LO6-26xU;
	Fri, 05 Apr 2024 05:49:45 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPD-00000005BAz-2unS
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 34B60CE35DD;
	Fri,  5 Apr 2024 04:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE391C433A6;
	Fri,  5 Apr 2024 04:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292142;
	bh=HF0VH9PAOhF80lTTrQzXr/sS4SOkHCGb5yRMqIqdJyw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=adYTqFFVVWp/zdChc9+yzissyl9hcRtdmm5HeXz9etZv9GmcpnTTdWFB+B5KHh+cg
	 AW+Fu6VaJjrIw4NMaVftDvo1YwbVGbB1RN94Kkkb1oK/wAdJWg/VVYJepFVXNtkiX5
	 qIWLs4d87SyxHFDljU4ntOtwMGe24D0cpc61TPgXon+ad9fvJkfVBBSCu+RvD/n4UU
	 6A9V3D/AWmsIGA09oK/eFlb7DX+bscosCZ2H2uOMDPPCy/H/OOoHRPaZnwvJkisxIx
	 D3V9HzAOcfdHwDhs5m7qG7RXSYV97YA+smsBtH8Am0C1QJtlgLRd6I2aRukP9zJTiO
	 /SCZLj9Kdj93w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 09/28] block: Allow zero value of max_zone_append_sectors queue limit
Date: Fri,  5 Apr 2024 13:41:48 +0900
Message-ID: <20240405044207.1123462-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214224_203957_88B1C084 
X-CRM114-Status: GOOD (  25.90  )
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

In preparation for adding a generic zone append emulation using zone
write plugging, allow device drivers supporting zoned block device to
set a the max_zone_append_sectors queue limit of a device to 0 to
indicate the lack of native support for zone append operations and that
the block layer should emulate these operations using regular write
operations.

blk_queue_max_zone_append_sectors() is modified to allow passing 0 as
the max_zone_append_sectors argument. The function
queue_max_zone_append_sectors() is also modified to ensure that the
minimum of the max_hw_sectors and chunk_sectors limit is used whenever
the max_zone_append_sectors limit is 0. This minimum is consistent with
the value set for the max_zone_append_sectors limit by the function
blk_validate_zoned_limits() when limits for a queue are validated.

The helper functions queue_emulates_zone_append() and
bdev_emulates_zone_append() are added to test if a queue (or block
device) emulates zone append operations.

In order for blk_revalidate_disk_zones() to accept zoned block devices
relying on zone append emulation, the direct check to the
max_zone_append_sectors queue limit of the disk is replaced by a check
using the value returned by queue_max_zone_append_sectors(). Similarly,
queue_zone_append_max_show() is modified to use the same accessor so
that the sysfs attribute advertizes the non-zero limit that will be
used, regardless if it is for native or emulated commands.

For stacking drivers, a top device should not need to care if the
underlying devices have native or emulated zone append operations.
blk_stack_limits() is thus modified to set the top device
max_zone_append_sectors limit using the new accessor
queue_limits_max_zone_append_sectors(). queue_max_zone_append_sectors()
is modified to use this function as well. Stacking drivers that require
zone append emulation, e.g. dm-crypt, can still request this feature by
calling blk_queue_max_zone_append_sectors() with a 0 limit.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 block/blk-core.c       |  2 +-
 block/blk-settings.c   | 30 +++++++++++++++++++-----------
 block/blk-sysfs.c      |  2 +-
 block/blk-zoned.c      |  2 +-
 include/linux/blkdev.h | 23 ++++++++++++++++++++---
 5 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..3bf28149e104 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -602,7 +602,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_IOERR;
 
 	/* Make sure the BIO is small enough and will not get split */
-	if (nr_sectors > q->limits.max_zone_append_sectors)
+	if (nr_sectors > queue_max_zone_append_sectors(q))
 		return BLK_STS_IOERR;
 
 	bio->bi_opf |= REQ_NOMERGE;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index cdbaef159c4b..c0197e1e7485 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -412,24 +412,32 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
  * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
  * @q:  the request queue for the device
  * @max_zone_append_sectors: maximum number of sectors to write per command
+ *
+ * Sets the maximum number of sectors allowed for zone append commands. If
+ * Specifying 0 for @max_zone_append_sectors indicates that the queue does
+ * not natively support zone append operations and that the block layer must
+ * emulate these operations using regular writes.
  **/
 void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors)
 {
-	unsigned int max_sectors;
+	unsigned int max_sectors = 0;
 
 	if (WARN_ON(!blk_queue_is_zoned(q)))
 		return;
 
-	max_sectors = min(q->limits.max_hw_sectors, max_zone_append_sectors);
-	max_sectors = min(q->limits.chunk_sectors, max_sectors);
+	if (max_zone_append_sectors) {
+		max_sectors = min(q->limits.max_hw_sectors,
+				  max_zone_append_sectors);
+		max_sectors = min(q->limits.chunk_sectors, max_sectors);
 
-	/*
-	 * Signal eventual driver bugs resulting in the max_zone_append sectors limit
-	 * being 0 due to a 0 argument, the chunk_sectors limit (zone size) not set,
-	 * or the max_hw_sectors limit not set.
-	 */
-	WARN_ON(!max_sectors);
+		/*
+		 * Signal eventual driver bugs resulting in the max_zone_append
+		 * sectors limit being 0 due to the chunk_sectors limit (zone
+		 * size) not set or the max_hw_sectors limit not set.
+		 */
+		WARN_ON_ONCE(!max_sectors);
+	}
 
 	q->limits.max_zone_append_sectors = max_sectors;
 }
@@ -756,8 +764,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
-	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
-					b->max_zone_append_sectors);
+	t->max_zone_append_sectors = min(queue_limits_max_zone_append_sectors(t),
+					 queue_limits_max_zone_append_sectors(b));
 	t->bounce = max(t->bounce, b->bounce);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8c8f69d8ba48..e3ed5a921aff 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -224,7 +224,7 @@ static ssize_t queue_zone_write_granularity_show(struct request_queue *q,
 
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
-	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
+	unsigned long long max_sectors = queue_max_zone_append_sectors(q);
 
 	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4b21a1ec00d4..fcc1284b7c19 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1692,7 +1692,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 		return -ENODEV;
 	}
 
-	if (!q->limits.max_zone_append_sectors) {
+	if (!queue_max_zone_append_sectors(q)) {
 		pr_warn("%s: Invalid 0 maximum zone append limit\n",
 			disk->disk_name);
 		return -ENODEV;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 348b57ca0425..46613bf6a402 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1173,12 +1173,29 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
-static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)
+static inline unsigned int queue_limits_max_zone_append_sectors(struct queue_limits *l)
 {
+	unsigned int max_sectors = min(l->chunk_sectors, l->max_hw_sectors);
 
-	const struct queue_limits *l = &q->limits;
+	return min_not_zero(l->max_zone_append_sectors, max_sectors);
+}
+
+static inline unsigned int queue_max_zone_append_sectors(struct request_queue *q)
+{
+	if (!blk_queue_is_zoned(q))
+		return 0;
 
-	return min(l->max_zone_append_sectors, l->max_sectors);
+	return queue_limits_max_zone_append_sectors(&q->limits);
+}
+
+static inline bool queue_emulates_zone_append(struct request_queue *q)
+{
+	return blk_queue_is_zoned(q) && !q->limits.max_zone_append_sectors;
+}
+
+static inline bool bdev_emulates_zone_append(struct block_device *bdev)
+{
+	return queue_emulates_zone_append(bdev_get_queue(bdev));
 }
 
 static inline unsigned int
-- 
2.44.0


