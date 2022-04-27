Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD06DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T09TdKd+PKEo6/XUyeNORY3qJAIzmSkSW/V2uBW8/x8=; b=3tgDutl1eA25YRRxj6sU4EWqpY
	oNFivYLqOpBHj7pkwn8nZ322W1Csd+hlvOcGf69H1YcEGmurV7GXimCqOfFd1O6pXnMou4rdhceSd
	cQs69H0ZNvvfJ8q9IhmdZcYx0rTBQbowaaSIBJw3nwED0OGvFr/WN/vxNJyrnNL9ii6bLKawzYY3X
	5ys5KDM787w+M6BHQvJSY1jBWIle36UV9BCYsz+rvs3qsgNlZY1sZQihQYelo2imtIEn0bIKhqx1S
	Nvhj/EvNBLY6OK0HKlhcgCLNPBj+mpn9jb5/Z9NAfrVkriYmPsQI0aw8qio76D/G4tZ5lUwgEyyBb
	qnLVAKHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njkJ7-002ELz-3C; Wed, 27 Apr 2022 16:14:25 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njk8K-0029eK-K5
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 16:03:23 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220427160315euoutp02caa6760fa5da2bce7d0e732af39323fb~pzFL1FubP1479314793euoutp024
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:03:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220427160315euoutp02caa6760fa5da2bce7d0e732af39323fb~pzFL1FubP1479314793euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651075395;
 bh=T09TdKd+PKEo6/XUyeNORY3qJAIzmSkSW/V2uBW8/x8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XvvkE/3L93M0ztjxYphRVPfQl3magsan30V9vvdhTP7mRxFlNLj1mjzC6AlyeLw9D
 egBm9E1bwBN3Fpab3MnE8f1gc9fX+pdSSLpj/wkCXRe98K+GYu5s6ONn8p1sbDP6PN
 t4b79Il3zRxkovf/IvCAhnueJaHPdSjBfydterzw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220427160313eucas1p28f302518de9cf124f9194cc8d376fd43~pzFKbY0Jn2334023340eucas1p2s;
 Wed, 27 Apr 2022 16:03:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id C1.E7.10009.14969626; Wed, 27
 Apr 2022 17:03:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676~pzFJ-Gzll2489024890eucas1p1n;
 Wed, 27 Apr 2022 16:03:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220427160313eusmtrp2cea78a3137da11659e89a20f8b5be479~pzFJ_NFx82598325983eusmtrp2p;
 Wed, 27 Apr 2022 16:03:13 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-93-62696941346b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.81.09522.04969626; Wed, 27
 Apr 2022 17:03:12 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220427160312eusmtip1ae2f42acfa009ab15e75927ef0532d22~pzFJnZ99a1317113171eusmtip1M;
 Wed, 27 Apr 2022 16:03:12 +0000 (GMT)
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
Subject: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are allowed
Date: Wed, 27 Apr 2022 18:02:55 +0200
Message-Id: <20220427160255.300418-17-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHc+69vb3tVrgUI2e1Y1pn5tDx2Ng8CQtItmRXpwvGLTJxj4J3
 hQ0KawEH/kF5jGHdpJDgRoEIhJcULJROKRUFlllQCYS3JOJwsEU6XrZqUWFruZj53+f3O5/f
 +Z5fcihc3ExKqARlKqtSyhNlpJC4eG1l4I3IhITY4Mc1UmS8fg1HhtuFJDq7tIKjGyX9GCou
 /IWPnvQP4KhzoYyHBl3ZGLrVZcHQecPvGJox6nH0Y9cSgVa1U+5e3jSOnk6HoOKeMYBmR/UY
 6pzchYb+bOCjoeoP0OXOPgINd5ST6FzdLB/p8h/gaEI3C1CRrY2HHLV5fHTBvkig3skte19m
 hkc+ZNZ6m0imKHeBzwxMtRLMcH8aY2o8RTJVmhKcaavJYqyVDoyx3tKQzE+5CyRj+f4Oj1m8
 MkoyZ8yNgDGaRwlG19bKixIfFb57nE1MSGdVQeFfCuPryoxEyrzgu0sFDzENyKO0QEBBOhTa
 SisJLRBSYroBQPu4nccVTgDbR+oxrnAA+EPjIHg2Ml1TtzFSD+BvRZb1AzF9D8A5p1ILKIqk
 A2D2Kb7H2URPAFjU0rJ+E07P4XDQPI55BnzpKPhHdf46E/QO6Bpq4nlYRIfB5SUXyaW9AkuH
 HvE9lwrcfd39aE7xgX2lM4SHcbeS+2sZzum1Qthu9+H4fdhgG+Nz7AvnbOYNlsJ/Lecwjk/C
 2YknuOdtkM4DsNBiJD1Z0J115maiB3H6dWjsCOL0SPjXdQfGGV5wYt6He4EXLL74M861RbAg
 X8zZMmhZmdkIhXA4p5zgFAZe1r2jA9v0z62if24V/f+xlQBvBH5smjpJwapDlOyJQLU8SZ2m
 VATGJSeZgPtH31iz3W8HFXPLgT0Ao0APgBQu2yRyWuNjxaLj8oxMVpX8hSotkVX3gC0UIfMT
 xSW0yMW0Qp7KfsOyKazq2SlGCSQa7Jh3Lf1S5NhK+af1wuj0Kv+srpgLV2JPRGdcOhauurcv
 Y+shA89bMGhojWiLPuJUEgFd+49Id2pHMr3uvnZwsysn5p895x9L3+KFer25q2nRdNuQ0lKd
 vtk389Cib+DuCeeL3acP7ow5/HXEV93DyhrF4ZAK6tHRSWnHAe+n+7P7pmxT1u4X/Bci4+6o
 k3M+X9B+RFRJVicfzMsVMyaXJHxv8dVtwj6rYfuy78c7RpAWCwt+uEfhqDLFBDVkn/b7NnZR
 39wqk7+3dTUr6TNBlKRkjfcq1bzvb7s2dcnsH3Gy0REWerVA8HbsJ7kH7vJ2a3pzyWDnzbLt
 FVnN5vHx/HmTVCcj1PHykABcpZb/B7EFCq9ABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xu7oOmZlJBn+mW1usP3WM2WL13X42
 i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
 /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
 MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
 8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
 xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
 +nYJehnLZq9nKXjLWbG94xtTA2MLRxcjJ4eEgInEwyXLWLoYuTiEBJYySmxYMJEdIiEhcXth
 EyOELSzx51oXG4gtJPCcUeLhKrUuRg4ONgEticZOdpBeEYEnjBL3fz4GG8Qs0MAicWviLiaQ
 BmEBP4mn+2+DDWIRUJX4cWkNK4jNK2At8fHDDzaIBfISMy99ZwcZygkUn/ApAmKXlUT3oltQ
 5YISJ2c+YQGxmYHKm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnFpXnpesn5uZsY
 gQll27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8xmgKdPZFZ
 SjQ5H5jS8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamOoNztk7
 676Vqz9ou6rw0tv1akJitqWbtj5JydrfKbNS7pTm13VZmWtnX80QzUgviwhx+f3njLLFRY4H
 jus3m76TDZhgq6r+UPdQkuSxF7I3Zcwf3M17EnTt2zJPO9mQLFPZw3oZlwr7ZVi6uDnXvMs2
 Wxa0IffyTJUuqaayzraXsiaq269fZ/inmPLOu8n/eTr7t097n/vxftx9T0v1LJf242WN58+m
 SjQ7Nd7scpjsoOQ7WZ9dwfHHeqO3cY1nzVYZ5T+dK6I3ycX+YP08SYNW7d7iz4xzeOabMp/t
 jprluMSX1+T2XuHk96+iPz+a3B5yquyNt/+Xusthrvxz76zynMgj9TUtJHbX1z1NSizFGYmG
 WsxFxYkA506w3bEDAAA=
X-CMS-MailID: 20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_090317_027548_10DFA2EB 
X-CRM114-Status: GOOD (  12.77  )
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

From: Luis Chamberlain <mcgrof@kernel.org>

Today dm-zoned relies on the assumption that you have a zone size
with a power of 2. Even though the block layer today enforces this
requirement, these devices do exist and so provide a stop-gap measure
to ensure these devices cannot be used by mistake

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zone.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 57daa86c19cf..221e0aa0f1a7 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	struct request_queue *q = md->queue;
 	unsigned int noio_flag;
 	int ret;
+	struct block_device *bdev = md->disk->part0;
+	sector_t zone_sectors;
+	char bname[BDEVNAME_SIZE];
+
+	zone_sectors = bdev_zone_sectors(bdev);
+
+	if (!is_power_of_2(zone_sectors)) {
+		DMWARN("%s: %s only power of two zone size supported\n",
+		       dm_device_name(md),
+		       bdevname(bdev, bname));
+		return 1;
+	}
 
 	/*
 	 * Check if something changed. If yes, cleanup the current resources
-- 
2.25.1


