Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eQZ6kViMFen5Vvv5WDxkU+VSeYRgwNz1guBAQ1Xbgw=; b=liwyEdcU7+R6Sy7jeS2J9JkB/R
	M4H8GhGcWTgmdv6NSCgulwhBjE2PhyL93olN4cR0zaiT4Ji9FXYhFy0IicC0b9Y29JZ8V1yjqyknM
	OjY3L58NZyYZlG8GsGgn1uFqRxoRgnEO+8RCtnvmsU/jpKGe4BmTYL8huNKRVTb/Ew9u317XfNaOU
	XRpPUD3fkMC56j6MsOAjKYBiVjgLlWxWTo4T+qXBR5TTHiSzyXQyXO+Tnn2D+jyrf6QbLQbyJRoxR
	apSfWAGNppm5U/52d25OfFrbC78YLUp1LlxltLH9jKw4La1sdc6UMlBpfBVnjIAR+ZPbcHExrf5hP
	1CHrYCbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nttH0-00Bfvb-Ly; Wed, 25 May 2022 15:50:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nttGw-00Bfqx-M5
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 15:50:08 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220525155001euoutp02d36ac98e1deac3c58bece34a621d78f2~yY9oxlwip0327103271euoutp02I
	for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 15:50:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220525155001euoutp02d36ac98e1deac3c58bece34a621d78f2~yY9oxlwip0327103271euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1653493802;
	bh=2eQZ6kViMFen5Vvv5WDxkU+VSeYRgwNz1guBAQ1Xbgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4r22eAsBHe0iH2u5aBM3JQS6HB6jwgo0YmhQutxHjmR0UiiixutGSD3ld4doRe9R
	 PhqWlf3u88fSy7EPZ9iDrGHa+lyQ6/wNv2nidmXvUB/rqbKJslfjzCsxyinTbObUbm
	 YpzULJXwsfpNVjOI3Us03oUecMShlROSIAcH65es=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220525155000eucas1p216752d9914ca37a7d223bef39c8fb758~yY9nXTACK0700607006eucas1p2H;
	Wed, 25 May 2022 15:50:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.FF.10260.8205E826; Wed, 25
	May 2022 16:50:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220525155000eucas1p200ac7e1c844980e728c9e88f51c4590e~yY9m7pDL80700607006eucas1p2G;
	Wed, 25 May 2022 15:50:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220525154959eusmtrp232e421c63a06da32f789c1209bc5a763~yY9m62BF90177001770eusmtrp2W;
	Wed, 25 May 2022 15:49:59 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-d0-628e502837bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.8E.09404.7205E826; Wed, 25
	May 2022 16:49:59 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220525154959eusmtip1b8cca573c1722645da3df92c140f2a0b~yY9mnZb3k1782817828eusmtip1W;
	Wed, 25 May 2022 15:49:59 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk, damien.lemoal@opensource.wdc.com, snitzer@redhat.com,
	Johannes.Thumshirn@wdc.com, hch@lst.de, hare@suse.de
Cc: dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, jaegeuk@kernel.org, gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 1/8] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date: Wed, 25 May 2022 17:49:50 +0200
Message-Id: <20220525154957.393656-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525154957.393656-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87oaAX1JBhemSlisvtvPZvH77Hlm
	i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
	L3vKbnFjwlNGi89LW9gt2jZ+ZXQQ8Ph3Yg2bx+WzpR6bVnWyeWxeUu+x+2YDm8fO1vusHu/3
	XWXz6NuyitFj/ZarLB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2PaibnsBZNEKl5N
	3sXYwPhQoIuRg0NCwETizJ6MLkYuDiGBFYwSi57sZuxi5ARyvjBK/G1ThUh8ZpRoeTWdFSQB
	0jC59QkzRGI5o0TDil42COcFo0TX7AlMIGPZBLQkGjvZQeIiAo2MElNfnmAEcZgFZjNJzPs2
	GWyHsECiRG/PHTYQm0VAVeLZm7usIM28AlYS+w5LQmyTl5h56Ts7iM0pYC0xf/9nZhCbV0BQ
	4uTMJywgNjNQTfPW2WAXSQis55Q4er+DDaLZRWLpiddQtrDEq+Nb2CFsGYn/O+czQdjVEk9v
	/IZqbmGU6N+5ng0SMNYSfWdyQExmAU2J9bv0IcodJR4//soOUcEnceOtIMQJfBKTtk1nhgjz
	SnS0CUFUK0ns/PkEaqmExOWmOSwQJR4SW29bTGBUnIXkl1lIfpmFsHYBI/MqRvHU0uLc9NRi
	47zUcr3ixNzi0rx0veT83E2MwOR3+t/xrzsYV7z6qHeIkYmD8RCjBAezkgjvhae9SUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqYkm9OKTvtfMh83uqA
	XfP8nF47HhCbJC3U4RZw5MviGLmptnZc7uKBJ9N/5Z41/ykSvmFhi9nT+OjDSRLZLDsEFt1/
	ke/cv3n/08L7ces6JrAdXRp4y6EjTPaTaMNCUw9lj6xLD45sE/5b8nJKlOSF8hNPpilf98s3
	cTgcMyOkPVgkNIt76y+hrIfrHjOdOrVWNb9NmvHnipMBszytPNRNFjfN8zqjINfn9yRcw5tv
	2mGlgCn/1q/iTOtfLr5D+5LCzfu9ggyBpXP4ZJktv6arNk2wkFdYVyOjeG3yiSXHQvpNjdcU
	71nEs/FEokSYwhJOBmalt89Ye5465e868cqZ5/cy9sQL8zqUb364ZjhLiaU4I9FQi7moOBEA
	QhWHGu0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7rqAX1JBse+WVisvtvPZvH77Hlm
	i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
	L3vKbnFjwlNGi89LW9gt2jZ+ZXQQ8Ph3Yg2bx+WzpR6bVnWyeWxeUu+x+2YDm8fO1vusHu/3
	XWXz6NuyitFj/ZarLB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
	xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PaibnsBZNEKl5N3sXYwPhQoIuRk0NCwERicusT
	ZhBbSGApo0TDLy2IuITE7YVNjBC2sMSfa11sXYxcQDXPGCUOzdvF1MXIwcEmoCXR2MkOEhcR
	6GSUmLOvFcxhFljOJPH80yJmkCJhgXiJ9df0QAaxCKhKPHtzlxUkzCtgJbHvsCTEfHmJmZe+
	s4PYnALWEvP3f4a6x0ri652vrCA2r4CgxMmZT1hAbGag+uats5knMArMQpKahSS1gJFpFaNI
	amlxbnpusZFecWJucWleul5yfu4mRmCkbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe+Fpb5IQ
	b0piZVVqUX58UWlOavEhRlOgsycyS4km5wNTRV5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6
	YklqdmpqQWoRTB8TB6dUA1PkhHXz4zKaVu72PXKjsvWD+uuOJKXKq0Z8VmEee9zfvpbiTdKT
	MpIqvyG85oSV4lW163f2z+ee4FHz7dRsnRbeG18DnZZJSm5R4mZ3K5acdUT7qvjyz+ZL4k5f
	Zf2qVMb24bXB7Yum2ryBzec3MD1Y2pN2s+8a44XVl0ymhfLqLJzmudjxdMo51szLq0/3t8xa
	YRTp/Nlgiv65ivc37x1wqZ0rxLyotTIlUDo1yC03XsNRUN9s0orMU3Lzfyq0tVX1r2thvLR6
	WvnUR6XP7jd5fmZ9fWw+5x+b+GsebV8PvChsPrxJ/Xf8Jke76u93K+0/Z4c/n9kePvN/8Zc7
	N/mzTN9EPQy69f/kx0cGYRuUWIozEg21mIuKEwGfZguQXQMAAA==
X-CMS-MailID: 20220525155000eucas1p200ac7e1c844980e728c9e88f51c4590e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525155000eucas1p200ac7e1c844980e728c9e88f51c4590e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155000eucas1p200ac7e1c844980e728c9e88f51c4590e
References: <20220525154957.393656-1-p.raghav@samsung.com>
	<CGME20220525155000eucas1p200ac7e1c844980e728c9e88f51c4590e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_085007_185769_E5184A84 
X-CRM114-Status: GOOD (  15.68  )
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

Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 12 +++++++++---
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8838..8b0615287cd3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,16 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * blkdev_nr_zones - Get number of zones
  * @disk:	Target gendisk
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60d016138997..c4e4c7071b7b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+
 	if (!blk_queue_is_zoned(q))
 		return 0;
-	return sector >> ilog2(q->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
-- 
2.25.1


