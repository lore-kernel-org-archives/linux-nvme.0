Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88CEC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fB5oDuaGkkcETTJw89yvusi2uN29/80pENYiXN8LNH8=; b=E2ZDsrSuHb5JbkOf3e/82IwXlZ
	0hvIgsfTgFjnQuQYOliU3ot2Kgdk5GpELWsEQv2Ud1Vs515bAlPz88b7AZsoRYPaE4HkKSscu+n2T
	JDftiI+cLOibf+IbOEI2HlSNH2n/fxOAIizmLZCKnakA2vanusCQ1PNM7/iRoiFELzFsAm+gA7fqV
	Qveg8qAN2g7lsEBbWJnhJpCmwRm6pAVDp6mxeL7oe9nFjbqMVyuVYPSReKcec8i8v84NlOZcztfSF
	10e/DgFIC3bqeaDWbI4r/AsxVkOPcil0lktpG03SRiVdzB106mytwOxtaGcmJH8ozlpLXiTiWcjY7
	cMyuWGEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Q9Q-00DnAs-ON; Wed, 15 Jun 2022 10:21:28 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Q7i-00DmDj-Mf
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 10:19:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101941euoutp02a85da81183e5587d6740445caaff1631~4xANHJFwh2930429304euoutp02D
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 10:19:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615101941euoutp02a85da81183e5587d6740445caaff1631~4xANHJFwh2930429304euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655288381;
	bh=fB5oDuaGkkcETTJw89yvusi2uN29/80pENYiXN8LNH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q51rVz4lL7ZuSYH9mXRLyvapyJvbr/9nRcRaakStOmD4Mzxv5gjso8EOe+/gx9/Z6
	 04vmLa4aKTmtU7C524y3CD7yQCxgK9rcNAS8GWuHOIWl6/m8f4wMpM0bayZJpdblnS
	 PPzU9H31ZWnpCNfY1RTfnvsEFAkgBleEKLYgYnyQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220615101939eucas1p2eb2c5ef6e00ebaa4a2acbb8d2deb2eea~4xALZ4g0g1912519125eucas1p2g;
	Wed, 15 Jun 2022 10:19:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5C.69.09580.A32B9A26; Wed, 15
	Jun 2022 11:19:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220615101938eucas1p26ab159a1ffd0fa5a16d7f202ba7206e7~4xAKNP28S2111721117eucas1p2V;
	Wed, 15 Jun 2022 10:19:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220615101938eusmtrp246a65538e1923130b814cf2be9b59611~4xAKMLDK-0361403614eusmtrp2H;
	Wed, 15 Jun 2022 10:19:38 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-19-62a9b23a0857
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.45.09095.A32B9A26; Wed, 15
	Jun 2022 11:19:38 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220615101937eusmtip1e4794119142cb0d2fedd8d7073fa370c~4xAJR_qbe1151011510eusmtip1D;
	Wed, 15 Jun 2022 10:19:37 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
	axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
	jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
	dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
	dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, Pankaj Raghav
	<p.raghav@samsung.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date: Wed, 15 Jun 2022 12:19:11 +0200
Message-Id: <20220615101920.329421-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djPc7rWm1YmGWxcw2qx+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
	aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
	6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
	AvijuGxSUnMyy1KL9O0SuDI2X1zFWrCXv+LD2t1sDYyTeLsYOTkkBEwk1u/tZO5i5OIQEljB
	KPG0s5EVwvnCKHGl5z8ThPOZUeLayoksMC03X56DqlrOKDF5YQ9U/0tGiVO/moAyHBxsAloS
	jZ3sIA0iAuESR/fcA5vELHCQWeL9/pmsIAlhgQiJgx+fsoHYLAKqEq+OtYA18ApYSSzb/B5q
	m7zEzEvfweKcAtYSO2b3sELUCEqcnPkErIYZqKZ562xmiPpznBJvV6tB2C4SD65uZ4SwhSVe
	Hd/CDmHLSPzfOZ8Jwq6WeHrjN9gDEgItjBL9O9ezgTwgAbSs70wOiMksoCmxfpc+RLmjxKTj
	IKeBVPBJ3HgrCHEBn8SkbdOZIcK8Eh1tQhDVShI7fz6BWiohcblpDlSnh8Tkh7kTGBVnIXll
	FpJXZiGsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwcZ7+d/zrDsYVrz7qHWJk
	4mA8xCjBwawkwmsWvDJJiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQi
	mCwTB6dUA5N/t3HgaoG5k679EHGMKOWfLW1etU94ugPn0bgz/2efXNX5Ve8bU4rX6+q9Yrfq
	G4PvCnUp9r9+xmHjU3Oy4WDQg2iDnTxVE/a+uxd0mGE+x/Vnpdc/sz/feK/8o7ymYs4nNelL
	P0PfWS2P8X5vdlXpvdBUS8Giv18ERd4qrM220egw1+xe07qp9Qzz5jexy6c/Lo3KZ7BYXvEr
	bbqQxxNVmYN3Ze5dTPU/EWuXeWxL1MlbZXKOOllTXkx4ded2fssPad7W6q1b9jhYOT6euu+e
	1ctjJSbs/7c85L+Q9b30UeHjKYeOFp1kq026nKd2jGWuZ0x2iWTlO7WN4Que7/jR1d0uF+tU
	tS/t962PGRpKLMUZiYZazEXFiQADHUwPCwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7pWm1YmGfw4x2Wx+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
	aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
	6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
	Avij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI2
	X1zFWrCXv+LD2t1sDYyTeLsYOTkkBEwkbr48x9rFyMUhJLCUUWL26vvsEAkJidsLmxghbGGJ
	P9e62CCKnjNK/Dl2C6iIg4NNQEuisROsXkQgWqLz5nuwGmaBy8wS+268AEsIC4RJXPn9lAXE
	ZhFQlXh1rAUszitgJbFs83sWiAXyEjMvfQeLcwpYS+yY3cMKMl8IqGbXu3iIckGJkzOfgJUz
	A5U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo3zbsZ+bdzDO
	e/VR7xAjEwfjIUYJDmYlEV6z4JVJQrwpiZVVqUX58UWlOanFhxhNgc6eyCwlmpwPTDN5JfGG
	ZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MAY/2C/UfWLa0aekdkzMP
	PTpKTsv/ncZfMHXJacuEIx3vPu7IUio98pxX/2PYnZBP02O/ikU1F5ml8RQY3HAX+/n5nZ5h
	2DS2qeUBPw8vybNgSnwzzW7nrp1rLp3oaVO33CTtb5W//x2LDoO9ceIntu0lkim2bJ6btXfn
	KzLomQR2iLRZnG2at+C6n//8rzb5y6ZUWH4yXXFHNszZe0M2d3XyyzT5eZPCuSZPXX5j85JL
	T4Vi7n3Z/0f+cuolMU1tg2+bKtcsY1oabTjp30rh7DPaSdPUOO8+ehl78fTxjYe9JKJs9nZK
	F2/iPLAx73JEJFuuXOUm540N+RryT1a8+HDexPS8vofY5r2e59XLlViKMxINtZiLihMB1fs6
	AXsDAAA=
X-CMS-MailID: 20220615101938eucas1p26ab159a1ffd0fa5a16d7f202ba7206e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101938eucas1p26ab159a1ffd0fa5a16d7f202ba7206e7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101938eucas1p26ab159a1ffd0fa5a16d7f202ba7206e7
References: <20220615101920.329421-1-p.raghav@samsung.com>
	<CGME20220615101938eucas1p26ab159a1ffd0fa5a16d7f202ba7206e7@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_031943_118482_CA558FD6 
X-CRM114-Status: GOOD (  15.01  )
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

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7..5516dd6cc 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -242,7 +242,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3c106dba1..e09d73473 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1387,6 +1387,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1


