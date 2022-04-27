Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB74C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJVMrlQpvMBXokOVGO8QBkDOO+u9KZOAxDi7xzIPKXQ=; b=XfWFCfnjlTCqHcV+fc6gxSGT4R
	D0AWfjvpHHeOsHHQ+HEhiQz2JkIcmXyEIe2i1y4kM7bIBVg2+3R5wFEV9uTbtrbn9VwCEx9U2dG8+
	+jqd3RWhgw7rsET1t17pHVyaudSaPW1IKtn/XvNBk30lSe3nE0nMeeiMUoJFaSXIboW/wNbawZmx5
	ExKzrwTiCMzPqySwfg6ez8p51jK0btr/i3j2b+TRpipPOeGBOYa9oBbcGNhgQQizPa4O3B8uZ6o6X
	nBKPd0k5LP8QmRU1ZsLvuMgTa4EiMOAoThqSrPeE4xrATIbT3DdG3yI5mBojfwd6250vaP9iQHLgL
	L8mbP1Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njkBc-002BQN-IZ; Wed, 27 Apr 2022 16:06:40 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njk8D-0029Ss-Tg
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 16:03:13 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220427160300euoutp02d12348ee78149dfbff8aefa8696c0924~pzE_MiVtA1060610606euoutp02d
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:03:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220427160300euoutp02d12348ee78149dfbff8aefa8696c0924~pzE_MiVtA1060610606euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651075380;
 bh=RJVMrlQpvMBXokOVGO8QBkDOO+u9KZOAxDi7xzIPKXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hm/DOeyCcaKdDk9xu6hdF6129Z33BVsqljAvLdYQOq4TXbF86UxKVp4//UAYM1JWb
 ZMLN0ZHtnzpC3du0x1jTRHI9nhHOp8VFEjt2LCcBy6Sl7f4scRPldoQnFGcsaXOY+J
 6eYqmxgN6KDAf93zrKzPXCr/9iFVZ2HYmQ1+OJM8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220427160258eucas1p252cb6872c7cc20eea327c199f8e2aec9~pzE8vLb-p1589415894eucas1p2E;
 Wed, 27 Apr 2022 16:02:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.0A.10260.23969626; Wed, 27
 Apr 2022 17:02:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220427160258eucas1p19548a7094f67b4c9f340add776f60082~pzE8W8LWT0330603306eucas1p1Q;
 Wed, 27 Apr 2022 16:02:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220427160258eusmtrp2f76aadf93653911fc7f556ba6f0a2efb~pzE8ULUY32598325983eusmtrp2d;
 Wed, 27 Apr 2022 16:02:58 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-81-6269693261bd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.71.09522.23969626; Wed, 27
 Apr 2022 17:02:58 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220427160258eusmtip2b1f69ceee95e1cec081198bf82161f87~pzE79CnAQ2569125691eusmtip2E;
 Wed, 27 Apr 2022 16:02:58 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: jaegeuk@kernel.org, axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
 mcgrof@kernel.org, naohiro.aota@wdc.com, sagi@grimberg.me,
 damien.lemoal@opensource.wdc.com, dsterba@suse.com,
 johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 02/16] block: add blk_queue_zone_aligned and
 bdev_zone_aligned helper
Date: Wed, 27 Apr 2022 18:02:41 +0200
Message-Id: <20220427160255.300418-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xTVxTHd999fX1tUvYoBO8E3Og0UwZYQLcbWHQGM1/CFlmyxGW6YYEn
 MMuPtLJN3GYdSJQILThwVBg/FShCEUoBkUWbDWTalBYYKBNHhDHAAQoyQCejPMz873vu+Xy/
 55zk0lBaR62n4xOPcKpEhVJGiUlzx6LNPyg+PkpemBeIjb92QFxzV0vh/JlFiG/mWQmcq/1B
 iJ9YbRC3T50X4O6FEwS+fa2VwNU1vxB4xKiH+My1GRL/mzm08pY+DPHT4UCca/kN4NE+PYHb
 77yJHferhNhRtgdfbe8icc+VQgoXXxwVYl3GY4gHdKMA53Q2CvDshXQhrpucJvGNO57verM9
 veHssxuXKDYnbUrI2oYuk2yPNYVtMJym2FJNHmQbK46zbSWzBNt2W0OxWWlTFNt68p6Anf6p
 j2KzTQbAGk19JKtrvCyIkH4ifieGU8Z/wam27jgojrNVmsnkEulXjuVpoAFnXs4EIhox29DC
 /VlhJhDTUqYKIGvjFMkXcwAtGnsJvpgFaOnBkuC5ZUwzTPGNSoAKhhogX4wD1DzWvuKnaYrx
 RSdOr+a6MwMA5dTXr0ZBZgKiblM/4YxyY/ah/KzhVU0ym1D2vB06tYQJQWbbAuTHvYoKHP8I
 naEiJhTpHn3MI66oq2CEdGq4gqQ1nV9dAjEXxOj3divl5BGzG/U0rW3thiY6TUJee6Hl1mKC
 18fQ6MCTNW86QNpW45o3FGXfUjolZLYg45WtPL4LWSc7BDzhggb+duU3cEG55nOQf5agUxlS
 npah1sWRtaEI9XxXSPIIi67/eEAHfPQvnKJ/4RT9/2NLADSAdVyKOiGWUwcncl8GqBUJ6pTE
 2IDopIQGsPKlbz7rfNwCqiYeBlgAQQMLQDSUuUvm2uKipJIYxdFUTpUUqUpRcmoL8KRJ2TpJ
 dHy9QsrEKo5whzkumVM97xK0aL2G+IyNsMqaP4DBzfaw7Ut7w0wexR+dnJ4fl2/LChz8eURe
 62JSbio6uCM8ZLvo3uTSK+WG5b4yw6dZ55SftxRJIoNr1WnabOOg0VF8V17+eoyorFr4QFDu
 My8fPJ6Bandz3wxoizaUpu08hKI3w1t/hpedTRa3aI5Vjft5b6F2hVY2PUq42v92R1dzaZh/
 6vh+j/f8K3LPfj/ZrzCM2fNP5aW+ocX2uo1uMzvldJRrUdvXF72qZYzF093i5/mtPelwr+Sh
 d9D+A5ubNnzon/N0cDDiJb89Xr5EV+ShipC/zCxF+dRcN+97a1IbQTPdfziCkpIvddZPH907
 95pRutGj+n1WRqrjFIG+UKVW/AcO+wgYQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7pGmZlJBot2CFisP3WM2WL13X42
 i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
 /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
 MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
 8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
 xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
 +nYJehnnl29jKVggVHHp/3vGBsYe/i5GTg4JAROJ5w0P2boYuTiEBJYySjxqn8MEkZCQuL2w
 iRHCFpb4c60Lqug5o8Sx2SuBHA4ONgEticZOdpC4iMATRon7Px+zgDjMAg0sErcm7gKbJCwQ
 KjHnQifYJBYBVYm+bxeZQWxeASuJbed/MENskJeYeek7O8hQTgFriQmfIkDCQkAl3YtusUKU
 C0qcnPmEBcRmBipv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIE
 ppRtx35u3sE479VHvUOMTByMhxglOJiVRHi/7M5IEuJNSaysSi3Kjy8qzUktPsRoCnT2RGYp
 0eR8YFLLK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgOlYt+uyP
 4MbKiz+3vmr4/3fGp3QrZr5382afuudfWSes+vTWB1udzvjH7B7xZldmL8nd8vXH6t3bpkzk
 jOJZy6q6b85K4R3Z6y3MYgzN7s3U8P36YoXTl9ftK/V3bEqZHNiVfDThzzHJKKmZ1Sbek9Yu
 XRu3wH9d0IfkyN40szSRDvdpXO6XWZOSDB1WxutY72yt6W2cckMh53nK7lwL14RZ07NFvIK8
 vgfXXWRak3djU/u3XzHd92x3Ft6/eFryj13xUm3hPcv+b35cr8MdvWf/C5u5IRu47kS3Bt04
 s6bPutrs8zTerU/r74v0/5qlbj3ppecVi6aYLXWfRTyVtPcf4vPZVsmwQ2DTJCcRVyWW4oxE
 Qy3mouJEAGOYaxeyAwAA
X-CMS-MailID: 20220427160258eucas1p19548a7094f67b4c9f340add776f60082
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160258eucas1p19548a7094f67b4c9f340add776f60082
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160258eucas1p19548a7094f67b4c9f340add776f60082
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160258eucas1p19548a7094f67b4c9f340add776f60082@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_090310_281270_52B531A6 
X-CRM114-Status: GOOD (  13.74  )
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

Checking if a given sector is aligned to a zone is a very common
operation that is performed for zoned devices. Add
blk_queue_zone_aligned helper to check for this instead of opencoding it
everywhere.

The helper is made to be generic so that it can also check for alignment
for non non-power-of-2 zone size devices.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is done for devices with
power-of-2 zone size

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c4e4c7071b7b..f8f2d2998afb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -676,6 +676,22 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 	return div64_u64(sector, zone_sectors);
 }
 
+static inline bool blk_queue_zone_aligned(struct request_queue *q, sector_t sec)
+{
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	u64 remainder = 0;
+
+	if (!blk_queue_is_zoned(q))
+		return false;
+
+	if (is_power_of_2(zone_sectors))
+		return IS_ALIGNED(sec, zone_sectors);
+
+	div64_u64_rem(sec, zone_sectors, &remainder);
+	/* if there is a remainder, then the sector is not aligned */
+	return remainder == 0;
+}
+
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
 					 sector_t sector)
 {
@@ -722,6 +738,12 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 {
 	return 0;
 }
+
+static inline bool blk_queue_zone_aligned(struct request_queue *q, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int queue_max_open_zones(const struct request_queue *q)
 {
 	return 0;
@@ -1361,6 +1383,15 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline bool bdev_zone_aligned(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return blk_queue_zone_aligned(q, sec);
+	return false;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1


