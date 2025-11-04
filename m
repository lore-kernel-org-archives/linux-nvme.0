Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19A2CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hw9IOsK+S/8eYHgNNn62sQw7cP29uX+x9NRY8Rsk0sU=; b=e1+nPp0qRtDsXT5hyIaGcxMWPx
	U4jW/pPgEsMYVc043tTBajy2Qicsul/hgvCDM1V2ZDC2ByMMVpI/cI/ZqHQ6NZMTd6eolwA9RBAhe
	LGLEKSORKdbAH0QoQCaazBy69zpIe/hLaKbVhtBbpFq0J7tsKwIQo8sI56KLiAUWQnMieKUnK/fmD
	+NdGDg0/N1eDRfa4z9Jqv3AzoPlWJXVZY88Y30KPqlevIkeCtPyR7mBkLIT3IHuXkyxhDSAK5RNSQ
	S6E9TsNQM4II1O7ICak0Gmw/uptMRBRsq6oTIH+dKUifITrx0naVluiTxLNa5aiWZkUVi1zAsx0Ef
	mQJ+kSRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYL-0000000CbQ5-0Ri4;
	Tue, 04 Nov 2025 21:26:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYI-0000000CbMM-3M90
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 21:26:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 379D960207;
	Tue,  4 Nov 2025 21:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D1BC2BC87;
	Tue,  4 Nov 2025 21:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291613;
	bh=4q4p+IFe5Iy7QQe7jIRJcL0InLZzcorfJ3Z8S4gSK0M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ObOrRvoqXHYVp3vmEVXkBvslTW+QQRffkWq2pT8X22vy1qUtTFW9g4HggqgYHVi8T
	 De/0fAQhxBvOTlLij820n/gbaEI/FqLeoq6aDQSHGnUsOU7QJmjz4zfJmbwOcgUpNT
	 /tdfyqDvI3a19hpXN4xH14haULuxld9rjmPHNqakfrl0f5og1kVjz397IE/qFFpCou
	 vkwBfrH8RmNgUq68qLRXOyKEb/CmjqUoAjI01ka2n1QGUrjLL/q2w4J9xZ8Ig+q0Xq
	 lIgegcDSywX36VFBAilb86stAz+VckkDvcYSqKF35U28wivCcLAI6EQhpgn81Trb+f
	 P3YYLsrbFrQRw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v4 08/15] block: refactor blkdev_report_zones() code
Date: Wed,  5 Nov 2025 06:22:42 +0900
Message-ID: <20251104212249.1075412-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
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

In preparation for implementing cached report zone, split the main part
of the code of blkdev_report_zones() into the helper function
blkdev_do_report_zones(), with this new helper taking as argument a
struct blk_report_zones_args pointer instead of a report callback
function and its private argument.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-zoned.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c5fa303093a9..9ce7570c91e1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -205,6 +205,21 @@ struct blk_report_zones_args {
 	void		*data;
 };
 
+static int blkdev_do_report_zones(struct block_device *bdev, sector_t sector,
+				  unsigned int nr_zones,
+				  struct blk_report_zones_args *args)
+{
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
+		return -EOPNOTSUPP;
+
+	if (!nr_zones || sector >= get_capacity(disk))
+		return 0;
+
+	return disk->fops->report_zones(disk, sector, nr_zones, args);
+}
+
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
@@ -227,19 +242,12 @@ struct blk_report_zones_args {
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
-	struct gendisk *disk = bdev->bd_disk;
 	struct blk_report_zones_args args = {
 		.cb = cb,
 		.data = data,
 	};
 
-	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
-		return -EOPNOTSUPP;
-
-	if (!nr_zones || sector >= get_capacity(disk))
-		return 0;
-
-	return disk->fops->report_zones(disk, sector, nr_zones, &args);
+	return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
-- 
2.51.0


