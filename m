Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60352CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1kLpZ7PVAZX+JAxRKykLFL7vUBesUc5xqN78zoEpWM=; b=j4ib1j6DCdqiXPQHulswzTIkfg
	GMT7yEFeVU7RzehkBG6BPC9oY2r41BTFx1XOh4KoQ/l0jmNTi5MotVGEQcewLGVXr3umtaryQi1Mr
	s7fS9ur8Rqx2EYxRmkLbq559wNW0Z5rbMug//kogpykg3xKeF8JbxVmZJfW9bsTITbo/Jhka4dqVs
	cOV717tfZ7mRIdDoR879p6f4yW1nHiaNPWQLsZyeSikGWUYFEjzI/quB/u+6ZiQMzsU/t1lV3vGf9
	mBQgfBz4/7bPX2V0ag64XSFmj3oEOe1oesS6ZDpS7h/c1HiP2MtsK0Ev/KVTPFZo16j1bUc1IVaGl
	5xRZBEGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuia-00000009uFa-1pbp;
	Mon, 03 Nov 2025 13:35:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiX-00000009uBR-2CH4
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 238D3437F5;
	Mon,  3 Nov 2025 13:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6B4C4CEE7;
	Mon,  3 Nov 2025 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176929;
	bh=n64XgPi0fdjsnGjaoD1g0R4/axIwKJz+qT5JsKed4pE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FUa638yvGARpy4pul/g3fDhaBDBuxhpcVuBhWLBPX+rYDdXwcRyGP20TqHWIFgHcZ
	 hDPopBAHh+Q4cmrKvgjBEO84cVASHNRzHEVB0M6uH21fXTHKqN4WqWn2VG5KAITYzt
	 aChVrAKCP4TYLddjqftJwEBJLnVzAfEuw8e/Pl16T0VioejAmj/HrqqrKaAgDCBMaa
	 X6ao7n5PQ0VFIl0SfGsFJ4wsHrxwO/Qw/+Vo3Q6MWQBPTTRBgRUHKBXgy1+2bhPEgK
	 H1ea8UYpwDIwJ+O/5TYZ/hy+UOi1m51B+8n+FUFsWprgdmILnQACw5NdJ5ybALxqDJ
	 lM7XYpB//Qe7A==
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
Subject: [PATCH v2 08/15] block: refactor blkdev_report_zones() code
Date: Mon,  3 Nov 2025 22:31:16 +0900
Message-ID: <20251103133123.645038-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053529_580271_88E0E83D 
X-CRM114-Status: GOOD (  12.67  )
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
---
 block/blk-zoned.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e43ae56b19c3..6b4639f11896 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -204,6 +204,21 @@ struct blk_report_zones_args {
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
@@ -226,19 +241,12 @@ struct blk_report_zones_args {
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


