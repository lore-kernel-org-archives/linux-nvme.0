Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320ECC19F2B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGWThfwHOEp7mmQTUw5C+8KJuKfjScM9cKVMnYcvmQ0=; b=w1z9Rq1Ed/flGsBMMuHAv1cKI9
	ErCbkdnw7sClDV/7b4D8Z/18zEqrtPYqC1rQ5r7R44TVrRale/8DaVbQwwIvrz/31LEGdf9Uabwfy
	7PimnyX/XoosFkdIiNSrcusVJY39XZie/cI2v+MuBIQr4fX66gyiHsf2sZmoETFE9UriwLUx1UBc8
	cD3ueA4SWD3MVw9FIFF/ptHVqK+Tz6cT+GK1/V8/yVBDMNqzl5bSv2TQwHtK533+1E9/N/m9XA1T6
	dyyQWuMoX+syAPvW5zCTHmI8pZNeVYaMtp0Jqu3HgXUV8c9kWTYHlHayzEHqB4gv7BEFhQ5GFPK0v
	ARZ7FFdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjqC-00FVr6-F5; Wed, 27 Jul 2022 16:24:56 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjoJ-00FUXo-DY
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 16:23:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162257euoutp024aa2d17ecedfde0109ead219988e3068~FvDYGZiqa1245112451euoutp02p
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 16:22:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220727162257euoutp024aa2d17ecedfde0109ead219988e3068~FvDYGZiqa1245112451euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658938978;
	bh=bGWThfwHOEp7mmQTUw5C+8KJuKfjScM9cKVMnYcvmQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaE8EM7F1p2E3k7Z8pZ51CGfkGHdMmZhhqLQ59ZtNAhEyx10zRjOuzg1WlurCP7PY
	 +QpBqFHdn3LdkvfD4og8GFZvrI4ApF5/r4EolKyxEN5800IpoHFUhvaQEEWxIzy9jC
	 KrLMfpNXSviF267AC/KwzWvVkHEPR9cqHyycFbsA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220727162256eucas1p26353ef138695507e6f8643aeaede4e78~FvDWuiFFY2169421694eucas1p2t;
	Wed, 27 Jul 2022 16:22:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.C3.09664.06661E26; Wed, 27
	Jul 2022 17:22:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8~FvDWEgher2238722387eucas1p2k;
	Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220727162255eusmtrp1e5f37af38464571ccadbe3d2a13e71c3~FvDWDv6y10298902989eusmtrp1Q;
	Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-f3-62e16660d0c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.8D.09038.F5661E26; Wed, 27
	Jul 2022 17:22:55 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220727162255eusmtip25fb2b24fbcb9d0862c628cfdc10559a5~FvDVtuT4W2868528685eusmtip2J;
	Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
	snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
	pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH v8 09/11] dm-table: allow non po2 zoned devices
Date: Wed, 27 Jul 2022 18:22:43 +0200
Message-Id: <20220727162245.209794-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7oJaQ+TDA5/F7VYfbefzWLah5/M
	Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8XnpS3sFmtuPmWxOHFL2kHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
	6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPFJdNSmpOZllqkb5dAlfGh8u8Be95KjqfT2Vp
	YJzP1cXIySEhYCJxYWcraxcjF4eQwApGiZ4zR9ggnC+MEh/fz2OEcD4zSjxpXMEI0zLh3Xom
	iMRyRonnj6+wQzjPGSU+b7gB1M/BwSagJdHYyQ7SICJQLPHwXSsLSA2zwCwmidPHHjODJIQF
	7CVaJu9hBbFZBFQlFizeDRbnFbCW2LtuEzvENnmJmZe+g9mcQPHNU+YxQdQISpyc+YQFxGYG
	qmneOpsZZIGEwGJOicWbp0Kd6iJxaGonK4QtLPHq+BaooTISpyf3sEDY1RJPb/yGam5hlOjf
	uR7sAwmgbX1nckBMZgFNifW79CHKHSWuHt/FAlHBJ3HjrSDECXwSk7ZNZ4YI80p0tAlBVCtJ
	7Pz5BGqphMTlpjlQSz0kvt6dyDiBUXEWkmdmIXlmFsLeBYzMqxjFU0uLc9NTiw3zUsv1ihNz
	i0vz0vWS83M3MQKT3+l/xz/tYJz76qPeIUYmDsZDjBIczEoivAnR95OEeFMSK6tSi/Lji0pz
	UosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MPks2n0tsC7irciUrgt7ZoeaN+3K
	eOAn1PEj8+fzo3zxMwWm6NcKau55pcGt/O0Gt2nt3sqv1p/ZmLIPRx2wkX3LeW6WtdhGgXN/
	i7nvOvzRmlW5+MTfmtmmIk1ye7kU3iXMe7BMPObkjJwVsxf07p/B8XRyzYKZzHkXpJ2ZLM6e
	8dviwB4wM+TvhttfS6yCxH3D2lY0H5u8cbVR3HXxQ97fCxqimK1+7GF+JLL66oVFSdt+3wtw
	Od/g6LOW8/Fm76qjIYWvi74YZijP8pWYs1OprT0g43XI2/JvLY9CZ2lHadh398n46wWmnJiw
	1Nb+ecvzfx6zEgKl5/sqBB12ubcwspIh3cGN++ych5/dXyuxFGckGmoxFxUnAgCDdvwC7QMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7rxaQ+TDGZd0LBYfbefzWLah5/M
	Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8XnpS3sFmtuPmWxOHFL2kHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
	6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
	nqGxeayVkamSvp1NSmpOZllqkb5dgl7Gh8u8Be95KjqfT2VpYJzP1cXIySEhYCIx4d16pi5G
	Lg4hgaWMElc3/maHSEhI3F7YxAhhC0v8udbFBlH0lFHi8vUFQAkODjYBLYnGTnYQU0SgUuLs
	F1mQcmaBZUwSG07IgNjCAvYSLZP3sILYLAKqEgsW72YGsXkFrCX2rtsEtUpeYual72A2J1B8
	85R5TCC2kICVxLMHH9kg6gUlTs58wgIxX16ieets5gmMArOQpGYhSS1gZFrFKJJaWpybnlts
	pFecmFtcmpeul5yfu4kRGKPbjv3csoNx5auPeocYmTgYDzFKcDArifAmRN9PEuJNSaysSi3K
	jy8qzUktPsRoCnT3RGYp0eR8YJLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1I
	LYLpY+LglGpgcmV1lD9VWXhgVtkRNovX3F/lCg+Emn24dtmwvUo4e4fE+58LxbskVqnZzVaQ
	OWpcd8RR/KJUfOvPXR784hFHJLy2L1Ltc+vv9/r+WPr0jWhRGcON/B/efS5Y9XXxobcNOdqr
	GZl+rvJYaXvXlz+Fo9jj66WfVXxJZa+vXik5/3hLZ97RS+dOTWjQXfbB6tmpTa/mSpYns7qZ
	tGRsF9hy+N5xxTdv/LVeTj2Z2in778nz/YX529MWyxa4TF2xV5Nr9YXg7VO2Jp356icS0h9+
	P7FJTrA0d5n1rGc777PFOfjlPz8QM0vrlkqUxW/eV2x3BXlF10+fumC5cO3XmcVar+v+Lbyr
	ypa84+7Jw5JqUkosxRmJhlrMRcWJAGBR6RRaAwAA
X-CMS-MailID: 20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8
References: <20220727162245.209794-1-p.raghav@samsung.com>
	<CGME20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_092259_766501_812E45FA 
X-CRM114-Status: GOOD (  13.25  )
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

As the block layer now supports non po2 zoned devices, allow dm to
support non po2 zoned device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b58252..534fddfc2b42 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_aligned(bdev, start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_aligned(bdev, len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
@@ -1642,8 +1642,8 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	/* Check zone size validity */
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1


