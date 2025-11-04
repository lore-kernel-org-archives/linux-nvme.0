Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09580CCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsG52MnJTbvHyvnE/3hDu3rjBe96XdtlcoPfxBWLvrI=; b=rrTYkXSt/VD/mCK0geLMYtkIff
	DvNI4Ace4a9EMObK8TOwAwwXIapkj0uNkHSR9PbH8yru+bVcnoFT0nyY0Wl9GEzmHwIIQkC8IDi8S
	mwe7ZsNTsqM5eDvcyNxP33Ff8dTFaE7AA5rcqE8hIEhrKMyB89P3tr1c5RdUK40Kb6NALzFBKnp8p
	lQzv17Py462eoyA7xvqHRh/neCCRhewEz767hYJpuBvfzgVjpNFa026dnx98gB4vAmAIiAHIxghgP
	pxpY0vaT56pGG+6PHixpPcIfgWNo/oZMisPrYFtBFVZQgaoSLwbvtTgUA9jVXK5fw88uHKRmUYUPD
	25qnLGUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xr-0000000AuRa-1f9D;
	Tue, 04 Nov 2025 01:36:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xn-0000000AuMQ-1LtT
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:36:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 09EED4396A;
	Tue,  4 Nov 2025 01:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A58C116D0;
	Tue,  4 Nov 2025 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220158;
	bh=jkUl4ViBNC1pK98r3zSHyTQiSlOqISQSn9wsaobDJ84=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I2QF/tZ4+sqWQYEa/TO3+5KqFqsr/9ZvkLVyYkfsQcutBLQgMTZ2Nt5B+0g5u6J1O
	 p5xwVSkHF0Jmr7PwoRi8UWSE5XPsxKXmOhFT0JfEgsrlZa1LJb470qUEotevzPZOfw
	 NGrID2YKPfj1MdJOlvHD1zI0dcrXSSQNUKmLmVbMG5FhJJfshYvevXDZzBWb21dHZk
	 FksxN+cwB06Tz8FrZYooFkoNir5SPE31tVWlrLrEd1hiiwJHEQtIL2Su/PH+KL5PBr
	 P5xwV1rIivMPkNbIoMtQvf7Weead9xiBxB4EPoU0kAcbs4RqxV8OGv9X7kRbGzhV8M
	 r+YBMlhB//jpA==
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
Subject: [PATCH v3 08/15] block: refactor blkdev_report_zones() code
Date: Tue,  4 Nov 2025 10:31:40 +0900
Message-ID: <20251104013147.913802-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_173559_474742_5768EB2F 
X-CRM114-Status: GOOD (  13.64  )
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
---
 block/blk-zoned.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 37a52de866d6..0d1065c1e598 100644
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


