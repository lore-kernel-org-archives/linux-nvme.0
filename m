Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F524CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9RdA45sthYgBk3leOfJv4nQr02nreypFi/e5EQeFtc=; b=MyU9HnbsOSQqN0uI1BQDYqW8hq
	RHZuY/E0dYFvDfepQw4ka/y5vB5cXKKOY2NVZj4Rj+AhH39ht+x1fzv/0V6w/mNYSgjjVOfeHiPs5
	xAYCT8y+fNbh5sVEvfv0IaNLTlDYeMMfOVl5yL0oUjFc7S/XXe3nY9Je9RD6CZ2vZ3q7U9hr9m1t3
	kO2jMfe79apf8NpFfG/SOea6gTeUJNUDSBrigv+ldSU8NjALDkNQw+mPHu3ItDysbyHNaHtDwjoYQ
	wY0k/olDnXOvgvdCxNmHikm5LByGNCQapMhcZ7Q0AEAkgUWIXWP6mNTYF4OGGFF6JWXlfMkMy/qn8
	bl7gj+9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte15-0000000DvLR-3X4y;
	Mon, 08 Apr 2024 01:41:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte0w-0000000DvFY-437y
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:41:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 710AE60DCF;
	Mon,  8 Apr 2024 01:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA307C433F1;
	Mon,  8 Apr 2024 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540498;
	bh=cUwQkF213nGEUnN+95fFuqIB+TNqvUJ+tiTrGtsuV4Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cC0W2cVJKzH3Bt1t+2mVAEKbDWzlSMJU4F0g7pF4+ziNh2NBKjqGN1E35Y3txdyFw
	 yacBa/bMTaCJ9wqVPacuxojMgHbWRWkuR2Xl/bFr4urQ5QTs7YQDpmvgcC1bqJFPTC
	 K5faWFRAO7eST6hUGiNxVhYyb6lPa3OekJb7ZVwQVhsKKxZ55uFCjVU0jXTZrbV9Em
	 NNyO6k/9w7w16c4dcy0BqKDu8ht/gTDfhQeD8hczDIqIuRihRmdPLCvWhvLu0imqM5
	 RK8Z9BtHPU/sJ2AArRTVnvgx+R0CfQN3p/ZrNPLLUqVXsoXIoF0FXSRt2ai86qab5p
	 PSK3zRKpSwMKw==
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
Subject: [PATCH v7 04/28] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
Date: Mon,  8 Apr 2024 10:41:04 +0900
Message-ID: <20240408014128.205141-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184139_309098_CB5EA748 
X-CRM114-Status: GOOD (  10.56  )
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
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/blkdev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 172c91879999..0380b7e6f818 100644
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


