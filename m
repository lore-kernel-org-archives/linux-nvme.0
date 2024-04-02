Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CA0C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKcBjUrAnF64gBaXsron+kcawKs7Hm5sgBtdLOoLVtI=; b=NjO4G0Rv/DgZ/l1H+1CYzs4Cbj
	NcuseJnSmAMYjLp8wgWX67EvhxcaYjNnd+nj41U0dNqXF1tgDuEW/jk80JKRJ6xoQ+nJjhtqcht09
	TFkfBvjC0H+K3I53/JlyH32WMcYqWvGHmYcVOW1/hWXD/h0tCxweotrE37ZW2PKsI5LR8KjvL5nJV
	tqIUlGSHq/qroTp0dh18UfQsL9F4lpsOJ3hah0kIMLHLtqs3FRkcPbSDyW4wuO/gUpUQYWSap8V8S
	9rmDzIbzo/G1Nc2PmjotXG4ls34LFuBCagroFxcIySDDcPxjGqyu8twpUeY2Lxok9+zlb7w0A4AEn
	KbQDj+rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQN-0000000B6Q9-0dlG;
	Tue, 02 Apr 2024 12:39:35 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQ6-0000000B6At-2aoC
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CD9E5CE1B5D;
	Tue,  2 Apr 2024 12:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED005C433C7;
	Tue,  2 Apr 2024 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061556;
	bh=jjiUilvd0iKnYt0AP2dJMfoR1ndfXit0U3Y/hv0duX0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g6F4jUlRWYHL+30frClE3iOp/DTSyRPKUjoaBos8cU/TVj5WpZVjeo0s7ZiGZ/gnK
	 JPjbUH2R0CH9LKVXWsp0vAuwP2yC7fKX4P21/bYKOp1uRr+42coVTo9Jm+MYVLY2f8
	 ugwmxr7Qru9iez1ARNe0j+eeEbNTaPh+jJyx/7XhUSy7MKuJQLLsl42IpBMcyRWZpv
	 tY4ZSI58eIogOFibd+6LVrtgPQCbCJQAQfH5MD0j05HmiMUSjT3Kcj65ETkpTCr9w8
	 IcvRe5TTxVTBwd4DNd1bq5FUTZslN92PH0PHCvShbkvwXtpMuKrNorVypxLLboZl66
	 P+i72jRvmMFGA==
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
Subject: [PATCH v4 04/28] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
Date: Tue,  2 Apr 2024 21:38:43 +0900
Message-ID: <20240402123907.512027-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053918_909448_AF23869D 
X-CRM114-Status: GOOD (  10.96  )
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


