Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A7C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=roge0E6G3NOd458B785vm4qIl5Vln8m/KdPSSnmFNPI=; b=Y0btj9RgSw6QtIGzRDaK05KQ9T
	EoGGAvaBnL2KTH5qS8ZWx6RzxsD3qj1hYOmQ3u35qz2YTedJobh9d1Tym+POFzbG5Aeje0cMo8fgG
	qmH7Lq6wtwGncNJiQ+BJ6Le4v0tGvQ+3RvKj5nkt1uv5c2gSMV419OZGuQK625f8GBBxfXPliRtHR
	IulYbT4CUdgf5b0km8jvd2Dg2y5w5nUK9CZBUdCG2TromATG0tU3OSZOGRL1ZdX05Ec8LDs1dZsii
	IIU1A9bZu41RymRbdBcciBqKnX49+RtfkMM2XIpqUrCoeeHgBeC2uKaSUmHARUMc9Va49RKnmFyX1
	U4Y72NbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8z-0000000FnQA-22ic;
	Thu, 13 Jun 2024 08:49:17 +0000
Received: from 2a02-8389-2341-5b80-034b-6bc2-b258-c831.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:34b:6bc2:b258:c831] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8s-0000000FnIs-1eys;
	Thu, 13 Jun 2024 08:49:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/12] block: bypass the STABLE_WRITES flag for protection information
Date: Thu, 13 Jun 2024 10:48:20 +0200
Message-ID: <20240613084839.1044015-11-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
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

Currently registering a checksum-enabled (aka PI) integrity profile sets
the QUEUE_FLAG_STABLE_WRITE flag, and unregistering it clears the flag.
This can incorrectly clear the flag when the driver requires stable
writes even without PI, e.g. in case of iSCSI or NVMe/TCP with data
digest enabled.

Fix this by looking at the csum_type directly in bdev_stable_writes and
not setting the queue flag.  Also remove the blk_queue_stable_writes
helper as the only user in nvme wants to only look at the actual
QUEUE_FLAG_STABLE_WRITE flag as it inherits the integrity configuration
by other means.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-integrity.c         |  6 ------
 drivers/nvme/host/multipath.c |  3 ++-
 include/linux/blkdev.h        | 12 ++++++++----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 1d2d371cd632d3..bec0d1df387ce9 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -379,9 +379,6 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tag_size = template->tag_size;
 	bi->pi_offset = template->pi_offset;
 
-	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
-		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
-
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	if (disk->queue->crypto_profile) {
 		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
@@ -404,9 +401,6 @@ void blk_integrity_unregister(struct gendisk *disk)
 
 	if (!bi->tuple_size)
 		return;
-
-	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
-		blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d8b6b4648eaff9..12c59db02539e5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -875,7 +875,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 		nvme_mpath_set_live(ns);
 	}
 
-	if (blk_queue_stable_writes(ns->queue) && ns->head->disk)
+	if (test_bit(QUEUE_FLAG_STABLE_WRITES, &ns->queue->queue_flags) &&
+	    ns->head->disk)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
 				   ns->head->disk->queue);
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bdd33388e1ced8..f9089750919c6b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,8 +571,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_noxmerges(q)	\
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
 #define blk_queue_nonrot(q)	test_bit(QUEUE_FLAG_NONROT, &(q)->queue_flags)
-#define blk_queue_stable_writes(q) \
-	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
@@ -1300,8 +1298,14 @@ static inline bool bdev_synchronous(struct block_device *bdev)
 
 static inline bool bdev_stable_writes(struct block_device *bdev)
 {
-	return test_bit(QUEUE_FLAG_STABLE_WRITES,
-			&bdev_get_queue(bdev)->queue_flags);
+	struct request_queue *q = bdev_get_queue(bdev);
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	/* BLK_INTEGRITY_CSUM_NONE is not available in blkdev.h */
+	if (q->integrity.csum_type != 0)
+		return true;
+#endif
+	return test_bit(QUEUE_FLAG_STABLE_WRITES, &q->queue_flags);
 }
 
 static inline bool bdev_write_cache(struct block_device *bdev)
-- 
2.43.0


