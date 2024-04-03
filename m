Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D2BCD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKcBjUrAnF64gBaXsron+kcawKs7Hm5sgBtdLOoLVtI=; b=z3L/17GxPiaVzjSUwVJKo5xQeV
	ApZv/R72uStbWMkERoiDDMUeDqTbHLotmi1Ywb4vkcIx7eiW95rUy0nrMApZyGcrVsAc0IjBMYpCN
	04iFQcrOfRG5R/hfjwJ59zDAu+1ttA+oS/g/f6PbzKIjt6CkNUrUTsrScOEyDw/J4Wmu4snfRFYYJ
	TSdZGwWJOvgg8BNd1/rHnGIgLVFQt0B22IR+m7ZZGXBXZ4Bsh8gHCNNh0/QC389AGpCmZuXzaeum0
	Bay6TY4ZRQcCk9qrXbH4ZlI/TnenEkNx6FiFttWNM+47vKlan0+DJDen2YtaWRu77eStk/+YkFAsA
	9lAFhU9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwD2-0000000EyhY-3xA2;
	Wed, 03 Apr 2024 08:43:04 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwCw-0000000Eyay-0gus
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8A247CE2111;
	Wed,  3 Apr 2024 08:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E668BC43399;
	Wed,  3 Apr 2024 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133776;
	bh=jjiUilvd0iKnYt0AP2dJMfoR1ndfXit0U3Y/hv0duX0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fob5/M3R5ElofVQ1/9H11uJ3AONmZ7efp85jIVm06uuzoDT0CmpNJM4jgYiDBng91
	 Zu3IhU97e8Oxm46GdOuo4rh5WZj4nK1sDGLM0aoQ3hnSQKE6rdCSLLHJW8HK8uU7cK
	 LS5MsAYyu9ZeZIRihDyyHLD03nxg9Edwjr/Wy+178maMEtEOXEt10VpL0qDV8WS5eU
	 K6dlpeT8Sj4QbOzgtimuJxiyjZPEJREy952ZDyKeLWDUSwNVW7nkBREyMommPlNNG9
	 cHx9T+1UrRBM/gCsGClZG+iG4lbieamWUa7Kms4KLWbl7qh6hFtYHxQnZBverfnYv+
	 R1eRkk84kEPAA==
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
Subject: [PATCH v5 04/28] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
Date: Wed,  3 Apr 2024 17:42:23 +0900
Message-ID: <20240403084247.856481-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_014258_456163_A9804976 
X-CRM114-Status: GOOD (  10.76  )
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

Implement the inline helper functions bio_straddles_zones() and
bio_offset_from_zone_start() to respectively test if a BIO crosses a
zone boundary (the start sector and last sector belong to different
zones) and to obtain the offset of a BIO from the start sector of its
target zone.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..ec7bd7091467 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -853,6 +853,13 @@ static inline unsigned int bio_zone_no(struct bio *bio)
 	return disk_zone_no(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector);
 }
 
+static inline bool bio_straddles_zones(struct bio *bio)
+{
+	return bio_sectors(bio) &&
+		bio_zone_no(bio) !=
+		disk_zone_no(bio->bi_bdev->bd_disk, bio_end_sector(bio) - 1);
+}
+
 static inline unsigned int bio_zone_is_seq(struct bio *bio)
 {
 	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector);
@@ -1328,6 +1335,12 @@ static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
 	return sector & (bdev_zone_sectors(bdev) - 1);
 }
 
+static inline sector_t bio_offset_from_zone_start(struct bio *bio)
+{
+	return bdev_offset_from_zone_start(bio->bi_bdev,
+					   bio->bi_iter.bi_sector);
+}
+
 static inline bool bdev_is_zone_start(struct block_device *bdev,
 				      sector_t sector)
 {
-- 
2.44.0


