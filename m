Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F66C19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lcXxddPODppydfVfNWVe2xGRFgwQKIkYPo+taXvQpg=; b=HXFfcq9PoqBtEJWj5e87OJiS8/
	Z5bl8CcB458yhLyq+zbwQONDEYCP6cnnj9Qv9o0XEREqYBLrA8La0JxW2qaqVZPbnmA+qBEVvqKnp
	O/ehtYfNKS63La1IB56UdLtEvwCnyXJ9Hlv51gz7o0TLmY5y2oPM7GIfayWa+8sF+tfOBSII8t2/7
	2gkeDSdRG9XD/38EXGt0ZxBPUQayB78bR8LxPs3kN8uwMZgdp4jrXhN1FLV00w5LF42b09mm5pN7A
	iFxvA9RP7iRQVe1P8PDidfUF3ot/8toLdVDM1OP8RELaaxdqODtBeGnJxhfwjFOBMyBiCLJELzNOy
	iSMmjiNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAzm-004Tjo-Jc; Wed, 03 Aug 2022 09:48:54 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAz4-004T7w-AM
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 09:48:13 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094808euoutp01f1780413e47aa42385a5de85869a1ad3~HzLpGK3Af3128231282euoutp01-
	for <linux-nvme@lists.infradead.org>; Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094808euoutp01f1780413e47aa42385a5de85869a1ad3~HzLpGK3Af3128231282euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659520088;
	bh=/lcXxddPODppydfVfNWVe2xGRFgwQKIkYPo+taXvQpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCAkVi0nKVBlWu9lc4hm61KIPTnstlqZLGqkoDDQvC29MNnm29VDawG1r8dTNuYkx
	 uR+r0vUkBN2PZrNx+LIz6mWX/rrpXZr1HlnwXrm6s6Qo4b6BKfpmNJfxwE+/zjaOs0
	 V9EbckTxdRC48Cw7wh6k4ebGGWusolpum4n8KftU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220803094806eucas1p28e4acaa00f0bcede2828c6f7798de3ea~HzLnfy-8w3120331203eucas1p2s;
	Wed,  3 Aug 2022 09:48:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.FF.09664.6544AE26; Wed,  3
	Aug 2022 10:48:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83~HzLnD0WR_0754607546eucas1p16;
	Wed,  3 Aug 2022 09:48:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220803094805eusmtrp25e56a76f66728139fcf1a55fd7baa169~HzLnC2gES0985609856eusmtrp2u;
	Wed,  3 Aug 2022 09:48:05 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-7f-62ea44563ea2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.9B.09038.5544AE26; Wed,  3
	Aug 2022 10:48:05 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220803094805eusmtip19192ed3b0cdfd5c11a6f449fcf12697b~HzLmtXW9L2551225512eusmtip1e;
	Wed,  3 Aug 2022 09:48:05 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
	hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	bvanassche@acm.org, Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
	<mcgrof@kernel.org>
Subject: [PATCH v9 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date: Wed,  3 Aug 2022 11:47:51 +0200
Message-Id: <20220803094801.177490-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7phLq+SDE7MErVYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
	vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAldG/
	7yt7wS71ioOnPjI2MPYqdDFyckgImEg09v9l72Lk4hASWMEoMXniOSjnC6PEv+5mJgjnM6PE
	zNuzGWFaVnSvYwWxhQSWM0qs+1QOUfSSUeLP0QssXYwcHGwCWhKNnWCTRASaGSXu/u1hBXGY
	BQ4wSdzccosJpFtYIFri96LnYJNYBFQlZn37BdbMK2Al8fBIFsQyeYmZl76zg9icAtYSU/79
	YwaxeQUEJU7OfMICYjMD1TRvnc0MMl9CYDenxN99vcwQzS4S3283QtnCEq+Ob2GHsGUk/u+c
	zwRhV0s8vfEbqrmFUaJ/53o2kCMkgLb1nckBMZkFNCXW79KHKHeUOHjiAytEBZ/EjbeCECfw
	SUzaNp0ZIswr0dEmBFGtJLHz5xOopRISl5vmsEDYHhL7d/1hmcCoOAvJM7OQPDMLYe8CRuZV
	jOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgQnx9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe
	Oy7Pk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwlSbc
	fXjX6ZZQ3bUktrLczbFCwreePzaNllv4cureksicdeaP7z+a6tZ3KCc9bKN0T8JsprTnPT9O
	lj5r6/qpY6B0b94c6SXTNn7rtvOcWnGTaVUhl5mD7rv5J4MXVf/x1luanzl1NsN5pavrrOU+
	+SjrzQ/3mq3ztV7j6yrrrNzDO+0Kipx3Zq7gXWB3fHFyz1qDEqfZUv6/2P4r/J674Cl7vJG1
	69z09gfT9uwIzvyy+Xe4QILW1d+Nh1JC7q9/o/bHbp3efvX3eyttgkQ/fLPcsu+AzwHuc6wG
	h4q2vpLh4F07z0v/Vuf09c4PK8399edtuT9TpU/hEof327XZHt9szq78n+t49d1cJu2ZTkos
	xRmJhlrMRcWJAAutTGH3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7qhLq+SDPb8NLZYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
	vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
	aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9G/7yt7wS71ioOnPjI2MPYqdDFy
	ckgImEis6F7HCmILCSxllGg+XwgRl5C4vbCJEcIWlvhzrYuti5ELqOY5o0R/80WgBg4ONgEt
	icZOdpC4iEA3o8TlM+dYQRxmgXNMEnOePmAD6RYWiJSYfLyJGcRmEVCVmPXtFwtIM6+AlcTD
	I1kQC+QlZl76zg5icwpYS0z5948Z4iAriXV/Z4EdxysgKHFy5hMWEJsZqL5562zmCYwCs5Ck
	ZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYu9uO/dyyg3Hlq496hxiZOBgPMUpw
	MCuJ8N5xeZ4kxJuSWFmVWpQfX1Sak1p8iNEU6OyJzFKiyfnA5JFXEm9oZmBqaGJmaWBqaWas
	JM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cDkcG06p8ZbJ7nSSP0Z4S/XKAjzljiH8Xx2K7ZQ
	Wq05a9LeO6dOrJJV3yMp770h8dPX7H8KfO0buCcyVdvnHLggqnQ++pPggsS1e6taec/eWbTn
	8QyzzmIV15cJM8rMjoYd1bJozdFY+G1z4rdrgQxC07ZMvajx+9nh905tjRd15+pa6iumKqi8
	mMR9+N78qUtUBE5IqPpnzOStmTx76T/39JU6gne/J2t6sX5MXm3+zvf5I11D5Y3f5zbZrZXd
	uMhbZMqfSV8yqwoMeSZkHerXdtgsut3+n5f+4T82959ELAmavFLpF9dpvf+RHnvPTKt5xfuc
	1fiBU9QjWav6Fx9Vmnm8/TvP1Aqfrf3IpmGpxFKckWioxVxUnAgAqxFEeGYDAAA=
X-CMS-MailID: 20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83
References: <20220803094801.177490-1-p.raghav@samsung.com>
	<CGME20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_024810_695143_08A7ED0A 
X-CRM114-Status: GOOD (  21.24  )
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

Checking if a given sector is aligned to a zone is a common
operation that is performed for zoned devices. Add
bdev_is_zone_start helper to check for this instead of opencoding it
everywhere.

Convert the calculations on zone size to be generic instead of relying on
power-of-2(po2) based arithmetic in the block layer using the helpers
wherever possible.

The only hot path affected by this change for zoned devices with po2
zone size is in blk_check_zone_append() but bdev_is_zone_start() helper is
used to optimize the calculation for po2 zone sizes.

Finally, allow zoned devices with non po2 zone sizes provided that their
zone capacity and zone size are equal. The main motivation to allow zoned
devices with non po2 zone size is to remove the unmapped LBA between
zone capcity and zone size for devices that cannot have a po2 zone
capacity.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      | 24 ++++++++++++++++++------
 include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104c5590..1cb519220ffb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -563,7 +563,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
 	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dce9c95b4bcd..665b822d13f9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!bdev_is_zone_start(bdev, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
@@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zero zone size", disk->disk_name);
+			return -ENODEV;
+		}
+
+		/*
+		 * Non power-of-2 zone size support was added to remove the
+		 * gap between zone capacity and zone size. Though it is technically
+		 * possible to have gaps in a non power-of-2 device, Linux requires
+		 * the zone size to be equal to zone capacity for non power-of-2
+		 * zoned devices.
+		 */
+		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
+			pr_err("%s: Invalid zone capacity: %lld with non power-of-2 zone size: %lld",
+			       disk->disk_name, zone->capacity, zone->len);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22f97427b60b..5aa15172299d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -709,6 +709,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return div64_u64(sector, zone_sectors);
 }
 
+static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
+						   sector_t sec)
+{
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	u64 remainder = 0;
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	if (is_power_of_2(zone_sectors))
+		return sec & (zone_sectors - 1);
+
+	div64_u64_rem(sec, zone_sectors, &remainder);
+	return remainder;
+}
+
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
+{
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return bdev_offset_from_zone_start(bdev, sec) == 0;
+}
+
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 {
 	if (!blk_queue_is_zoned(disk->queue))
@@ -753,6 +777,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
 }
+
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
-- 
2.25.1


