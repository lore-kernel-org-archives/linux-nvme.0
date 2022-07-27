Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A090AC19F2B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9bdbdbUw6KTK2r5hitLcl/AEOPoWY1dExIREEyMjHGo=; b=EsRBHvOxH75N68gla9VC+E85ad
	kHKQlSoCa9qv8GDGtOInMdo8K7Mvls+LtNn/Fel7DICohI5R55Z+TimdDppePySitij+Z03O4BXWq
	q7QYqP1eKpSKGCSX2g8ZoU7C/WYwhjwWbZEernjDUJYTdHCxFWwtZFdJl99odoMtgyEKajIJnutN/
	5Q63qK+Z7Wru1zz7dkqS9yQikVLnGu2JNDnz66q+FcoYRKC9lNs5/WdI2N7rN+CMZnD8Xma10Eo5o
	+oG4y2oQSmSt6XduS/GIAMHmkUR053tTfJvELV5oniLSdUHkcyJgmf5XtgltHhdDt4q6BGwYEDvsB
	tHoi868A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjoF-00FUUL-5t; Wed, 27 Jul 2022 16:22:55 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjoB-00FURW-KE
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 16:22:53 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162250euoutp018350f38d13deedb839373e2de976e902~FvDQsZ_5E2521125211euoutp01c
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 16:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162250euoutp018350f38d13deedb839373e2de976e902~FvDQsZ_5E2521125211euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658938970;
	bh=9bdbdbUw6KTK2r5hitLcl/AEOPoWY1dExIREEyMjHGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pN1vw6nDRuYgCIUnwWmU+afmN2lz9zLzoHRNwUhC9wwa3lkjI/uhi80ro+uKo7GtP
	 mjuTCW9HayJHv+dQsoJROxB2AKtKMYq/3o7xGnmjka/Emj9jawUJXBaCKPgVvPZ2br
	 F9zEPiWnCv3Ije/VvcSK1I+lu2WS775a5jcJoc4I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220727162248eucas1p2754b09a52a4cc967eb7028ff301c7878~FvDPAZvNB0838408384eucas1p2_;
	Wed, 27 Jul 2022 16:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.E8.09580.85661E26; Wed, 27
	Jul 2022 17:22:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85~FvDOOXpfQ2171521715eucas1p2h;
	Wed, 27 Jul 2022 16:22:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220727162247eusmtrp1e5b1271244a6333800cd425899ce71ee~FvDOH-yMw0298902989eusmtrp1G;
	Wed, 27 Jul 2022 16:22:47 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-d9-62e166583e6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.8D.09038.75661E26; Wed, 27
	Jul 2022 17:22:47 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220727162246eusmtip1a0c727e66078316c43a69fc09227168e~FvDN32e690064100641eusmtip1P;
	Wed, 27 Jul 2022 16:22:46 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
	snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
	pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, Pankaj Raghav
	<p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, Adam
	Manzanares <a.manzanares@samsung.com>
Subject: [PATCH v8 01/11] block: make bdev_nr_zones and disk_zone_no generic
 for npo2 zsze
Date: Wed, 27 Jul 2022 18:22:35 +0200
Message-Id: <20220727162245.209794-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7oRaQ+TDKavZrOYfljRYvXdfjaL
	aR9+Mlv8Pnue2WLvu9msFjcP7GSy2LNoEpPFytVHmSyerJ/FbPG36x6Txd5b2haXd81hs5i/
	7Cm7xYS2r8wWNyY8ZbT4vLSF3WLNzacsFiduSTsIeVy+4u2xc9Zddo/LZ0s9Nq3qZPPYvKTe
	Y/fNBjaPna33WT3e77vK5tG3ZRWjx+bT1R6fN8l5tB/oZgrgieKySUnNySxLLdK3S+DKaDjw
	nrFgt0jFhcf32RsYOwW7GDk5JARMJP7N7GUCsYUEVjBKLPjK2sXIBWR/YZS49PIcO4TzmVHi
	5+c5jDAd72Z3QFUtZ5Q4vHkKK0T7c0aJq5uBxnJwsAloSTR2soOERQSKJR6+a2UBqWcWeMck
	8WXhdbCEsECMxK97m8CGsgioShy9v5YNxOYVsJJoaP3LDLFMXmLmpe9g9ZwC1hKbp8xjgqgR
	lDg58wkLiM0MVNO8dTYzyAIJgc2cEguOX2SCaHaR6Dl2gB3CFpZ4dXwLlC0jcXpyDwuEXS3x
	9MZvqOYWRon+nevZQD6QANrWdyYHxGQW0JRYv0sfotxRYtf0P+wQFXwSN94KQpzAJzFp23Rm
	iDCvREebEES1ksTOn0+glkpIXG6aA7XUQ2JO50+WCYyKs5A8MwvJM7MQ9i5gZF7FKJ5aWpyb
	nlpsnJdarlecmFtcmpeul5yfu4kRmAxP/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuFNiL6fJMSb
	klhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoFpw5/MgKpDnfoM
	DJcvnbXcfn2n45ldfl84ix81vmkMTUjYKnQssSSDt7D9aMPhnws3d04rMvoX6PRbmWleRmje
	n+JH52z+ChlKJOtZzPJy/L3a8fPkRevML35+4vmwzPuIzKmnbatthXzmTpybUvvisML5qMIT
	SntmlXQfvxAlmWKQsvD/R37tOJXFjPFzxMs82dW9N9oJJ2l5xv0/vdil97KU5/H4FzsUa7/5
	PZuXmqMp+XNSEOMSvrMWPl1x/He+Py097RcRN6Hk1jRZj/PpjzufHNzuJ+kc1HjMzHPT/P/X
	InYHmN1n79BZ8fJBytoZe618j/eYJKQvkv/dndnOxPzqxcKX58Q2GXqcOeKkxFKckWioxVxU
	nAgAkGZkTfUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rhaQ+TDFY38FhMP6xosfpuP5vF
	tA8/mS1+nz3PbLH33WxWi5sHdjJZ7Fk0icli5eqjTBZP1s9itvjbdY/JYu8tbYvLu+awWcxf
	9pTdYkLbV2aLGxOeMlp8XtrCbrHm5lMWixO3pB2EPC5f8fbYOesuu8fls6Uem1Z1snlsXlLv
	sftmA5vHztb7rB7v911l8+jbsorRY/Ppao/Pm+Q82g90MwXwROnZFOWXlqQqZOQXl9gqRRta
	GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlNBx4z1iwW6TiwuP77A2MnYJdjJwc
	EgImEu9md7B2MXJxCAksZZQ48fMaC0RCQuL2wiZGCFtY4s+1LjaIoqeMEvNOv2XuYuTgYBPQ
	kmjsZAcxRQQqJc5+kQUpZxb4wySxdwGYLSwQJTHn6gMmEJtFQFXi6P21bCA2r4CVREPrX2aI
	8fISMy99ZwexOQWsJTZPmQdWLwRU8+zBR6h6QYmTM5+wQMyXl2jeOpt5AqPALCSpWUhSCxiZ
	VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG7bZjP7fsYFz56qPeIUYmDsZDjBIczEoivAnR
	95OEeFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+YOPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoS
	hQTSE0tSs1NTC1KLYPqYODilGpimx7zbf4bR4JLesn0axrX7nh7J+dC0afd8OWbG7C77c3HC
	669NU9l9Qlxm399FG39FvavcekrEvPSeyOZVOY+4fn7jdH+zyci6NHXOsW1N1pcXf1J6Jvpi
	35S+S1mRT4VPRbZ+tN+1xHWKm+oSs8C3lV2vzs2bvO3fyV86DcKSH9wSA4+H2p8Rqtv9Omg2
	q/yKYuP8es1nCjmBLcXGf4yjLm8WKfP1UDikp2/+81TCvZYf7XsTNtmuvCmSOk+3y+Zqq/3J
	y1982SaXN9wP0VT9ZFM5Q8P5o6NTUONVvXUW7xZo1b654+2VNCWfiSX9UO9GkY0Lp1cbm208
	1ePXv0hl2a0nO2RvyFxhr8ztXdWjxFKckWioxVxUnAgAwdXUPmQDAAA=
X-CMS-MailID: 20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85
References: <20220727162245.209794-1-p.raghav@samsung.com>
	<CGME20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_092252_110586_3407A5CE 
X-CRM114-Status: GOOD (  15.92  )
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

Adapt bdev_nr_zones and disk_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 13 +++++++++----
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a264621d4905..dce9c95b4bcd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,17 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * bdev_nr_zones - Get number of zones
  * @bdev:	Target device
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int bdev_nr_zones(struct block_device *bdev)
 {
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	sector_t capacity = bdev_nr_sectors(bdev);
 
 	if (!bdev_is_zoned(bdev))
 		return 0;
-	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
-		ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(bdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dccdf1551c62..85b832908f28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -673,9 +673,15 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
 
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return sector >> ilog2(disk->queue->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-- 
2.25.1


