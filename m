Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECCEC19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=; b=XHfxHy8pk7xXa2IFE0xIraN1ix
	60Pk6uuBWh28D3r8EaMU049fXtnQ8nr+dN9itO52gJZcIUBCM4twe+1DQCxJCSvzZISX6aEuUzqDN
	aREBw7s4GNQKOW1TptHWXIU3cwm3VYo1ge2uu7hXWCt2BVlaJ4qOOe/K96nOCGwSmtkUxSXc5Xt8V
	L77XSxnYjnHOyfcTnsdSPKXVnNivYTLqVsp5CajJh3Z9YMc+EyZEsol4witwUQt6CuEmc/AD8PfT6
	Nmik0ZJi2qDAUx8tFpB0Z1OdZgWiC2+7szhtwIAlEt6kkTdR/5p3g/e/uVoRAY3BplxKwx9v+4kHJ
	D92okY4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAzf-004TdQ-59; Wed, 03 Aug 2022 09:48:47 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAz4-004T6x-AS
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 09:48:13 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094806euoutp0126321efe6fc5817d2a21a7f0ca61b135~HzLnNJqA83128231282euoutp018
	for <linux-nvme@lists.infradead.org>; Wed,  3 Aug 2022 09:48:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094806euoutp0126321efe6fc5817d2a21a7f0ca61b135~HzLnNJqA83128231282euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659520086;
	bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRXn0UmwY8hgWPVxsZu8A4quC3F9VbzMhhgCbJH3bi8sYQrS/a38E4joFjL2Sj98e
	 0eBSTpIQdpisjkixXy2QI+conYm5vRrmGFtEuMKDttQ3oflV0zmuy6UX0dC5TCSpia
	 WM7ITptkhlLkJzvwvmVL/VkVV6w6wbwaoV80V/kc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220803094804eucas1p23f4f95acc37debaf32ebca7b7461228e~HzLlsvk8B2078320783eucas1p2-;
	Wed,  3 Aug 2022 09:48:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 47.F2.09580.4544AE26; Wed,  3
	Aug 2022 10:48:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220803094803eucas1p2ee8d16f3b6e08203ac9b4e0df6f53d9d~HzLlKJBYJ2274622746eucas1p2y;
	Wed,  3 Aug 2022 09:48:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220803094803eusmtrp29abd99fd25b82a7151d193ea5f023056~HzLlJU8T40985609856eusmtrp2q;
	Wed,  3 Aug 2022 09:48:03 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-08-62ea44546ac3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.DB.09095.3544AE26; Wed,  3
	Aug 2022 10:48:03 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220803094803eusmtip28563b2ce9e5f1b5ca2b66ba8b64b2160~HzLkybMHr1682216822eusmtip2o;
	Wed,  3 Aug 2022 09:48:03 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
	hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	bvanassche@acm.org, Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>
Subject: [PATCH v9 01/13] block: make bdev_nr_zones and disk_zone_no generic
 for npo2 zone size
Date: Wed,  3 Aug 2022 11:47:49 +0200
Message-Id: <20220803094801.177490-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djP87ohLq+SDC4sFrWYfljRYv2pY8wW
	q+/2s1lM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8
	aw6bxfxlT9ktJrR9Zba4MeEpo8XnpS3sFmtuPmWxOHFL2kHY4/IVb4+ds+6ye1w+W+qxaVUn
	m8fmJfUeu282sHnsbL3P6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPFJdNSmpOZllqkb5d
	AlfG36ntTAVXRSqeTXjF1sA4S7CLkZNDQsBE4vb5NcxdjFwcQgIrGCW2H3jFBuF8YZS4tLKP
	CcL5zChx7cMe1i5GDrCW7mO6EPHljBL7b/+Dan/JKPFt2kI2kCI2AS2Jxk52kLiIQDOjxN2/
	PawgDrPAGyaJZct/s4MsFxZIlNjV/ZwNxGYRUJVouPGCCcTmFbCSmHn4OwvEgfISMy99B6vn
	FLCWmPIPZBtIjaDEyZlPwGqYgWqat84Gu0JC4DCnxIYbS1ghml0kLm89ywRhC0u8Or6FHcKW
	kfi/cz5UvFri6Y3fUM0tjBL9O9ezQfxpLdF3JgfEZBbQlFi/Sx+i3FHiRtt7dogKPokbbwUh
	TuCTmLRtOjNEmFeio00IolpJYufPJ1BLJSQuN82B+spDYsLRzewTGBVnIXlmFpJnZiHsXcDI
	vIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwNZ7+d/zrDsYVrz7qHWJk4mA8xCjBwawk
	wnvH5XmSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBiYR
	3Qj3p2uVHpZXxX42tGU49Lnnd35V4NTGy0pxuWeTDlnUFR+tiE77xvHVvSy65M62qwu3PK9j
	1P0sFaBU9WLu5BK+27fDzxxK33TxsP5ZYYNVyu7rFbcGK3tM80h+UrJKcnbG5mzWZVWXV1++
	YLU6J3Nu9Lcw9z8b4qRZtlX91H+9ZJ6Z1lTV+0lTChQ0XV94P721UHauStyFdQJdfu6n9rg1
	Gxo2Xre6Z6u7YuIzhrsr2LX0Q7zy8vdxbnV+HxvHNnmCSNxhLakkl3PPl/KanmBeGs0ru6jU
	qeje/8edp3udLqvPb39SmXbefDqDb/OBJdvPCXM4ca5gFnv9MamqMeqsXvI8A8u3slMepSqx
	FGckGmoxFxUnAgDeHdQF/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7rBLq+SDPb80bOYfljRYv2pY8wW
	q+/2s1lM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8
	aw6bxfxlT9ktJrR9Zba4MeEpo8XnpS3sFmtuPmWxOHFL2kHY4/IVb4+ds+6ye1w+W+qxaVUn
	m8fmJfUeu282sHnsbL3P6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPlJ5NUX5pSapCRn5x
	ia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G36ntTAVXRSqeTXjF1sA4
	S7CLkYNDQsBEovuYbhcjF4eQwFJGiaULdzF1MXICxSUkbi9sYoSwhSX+XOtiA7GFBJ4zSjSd
	5gbpZRPQkmjsZAfpFRHoZpS4fOYcK4jDLPCHSeLv0dMsIA3CAvESR0+3soLYLAKqEg03XoAt
	4BWwkph5+DsLxAJ5iZmXvrOD2JwC1hJT/v1jhlhmJbHu7yxWiHpBiZMzn4DVMwPVN2+dzTyB
	UWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmN427Gfm3cwznv1Ue8QIxMH
	4yFGCQ5mJRHeOy7Pk4R4UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5H5hE8kriDc0MTA1NzCwN
	TC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamPxrN894KbnldNZ3Ltf+tq3Wf4If6rB+
	2flbIsxEsPpoUI/KNOMV0q171MMDT3iLbn3Ivia8wHvrqlV+M1xWLjtku/z0+VPBC5W4fPwm
	1STvd1j+su5mReUF73X7l66tst3rm7dI/+1z1Q6W2T6bfm1ruc1skbV2S/PsRVsczr29ovpY
	f4d+udXLTzs2fa/a2SJodV5HJmNjXLl6hOFiM+kKh0U5j18wb39rXNUSfnmywPaiCU+vc0+8
	vfG8p9RM4cK5s5edEMg5sGbf2UO6O5R9lV5Y/NK9ucLen7cw4pIkM+/UQ+V7b/pl/JDfrxex
	JY59yR41JT6WM49iDwfrSvfo/ZKfnL3yeNM5ybX8E1KUWIozEg21mIuKEwGNwBmyagMAAA==
X-CMS-MailID: 20220803094803eucas1p2ee8d16f3b6e08203ac9b4e0df6f53d9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094803eucas1p2ee8d16f3b6e08203ac9b4e0df6f53d9d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094803eucas1p2ee8d16f3b6e08203ac9b4e0df6f53d9d
References: <20220803094801.177490-1-p.raghav@samsung.com>
	<CGME20220803094803eucas1p2ee8d16f3b6e08203ac9b4e0df6f53d9d@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_024810_715071_5C973E63 
X-CRM114-Status: GOOD (  15.66  )
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

Adapt bdev_nr_zones and disk_zone_no functions so that they can
also work for non-power-of-2 zone sizes.

As the existing deployments assume that a device zone size is a power of
2 number of sectors, power-of-2 optimized calculation is used for those
devices.

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
index 84b13fdd34a7..ab82d1ff0cce 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -674,9 +674,15 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
 
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


