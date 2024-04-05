Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249C5CD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 04:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hnyg2IPkrDSGBH+HtzOiBIeTqEjIMpKRnevBYApvf9k=; b=M64nvOAK5CoDu+75i12B9bjpYP
	GGmSM4fXuH9jtRCL/6yuJsmtOpCk14/ScUcJnwMk6KiOKkoAvq2wMyCkfBwOwKcQL5V+SoBGWOU5K
	XpjCW+L9vw5Zigux9brTTDbPDkRILDNaSnj3XWGX5A0gy6TnzUePpAb0tXF0MOTQetRf5IH9nuO85
	5SZrcm0y7Hhj0O2SSDLqM4Ic+RlZPToI8Jy7MxiGlWcheN6129fYZh5fzuBnnLaFej8vlIBOknAjN
	Dzs4b2rW3Dn6c+hXaArPv0fHRl9D8qLA9LkH/k35hIDC0kRFW6AjJpPJN3goHJHDl5H398tpKTvfn
	GmrHR78A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPC-00000005BCr-2YDL;
	Fri, 05 Apr 2024 04:42:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbP8-00000005B7q-08do
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3F869CE35E4;
	Fri,  5 Apr 2024 04:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5233FC433C7;
	Fri,  5 Apr 2024 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292135;
	bh=7qLFKHmMqXCPhSR7cz1IzscSua25WxaMhOqOUOURAX0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fjGtxkbYkTG4F8M3FVBPb6ax8unAeIXDLJhm6OZCOnpLzNa4TNgpKooN3HJaLCG7A
	 ojb9TXtlT+8mFzaLKjbpf2Q+UqDc8vNbh8UqkCOfAypcI1wu3J9x44Qu/54DJZDPrV
	 h61pCc1Cgc0VxPfHKEaNjxugSUOeKjlQYgyLLFIjGB1+YLEhr6cbEyBOrkal/kphOl
	 1wUAfVX23sfFf07VbcdUn9ega97+RwNmKQcxbeFFrK+at4/JBTlaOIUXVwiR6IfMHG
	 M2k0tzsHVfsUG6PlnwSUJHsTmpm9CrRv1byKISklexbasa/dlcwMDfmOFAxTOkkLRr
	 Ssej2jp4eObPg==
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
Subject: [PATCH v6 04/28] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
Date: Fri,  5 Apr 2024 13:41:43 +0900
Message-ID: <20240405044207.1123462-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214218_344671_41B9DB5C 
X-CRM114-Status: GOOD (  10.46  )
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


