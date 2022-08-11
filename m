Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FECC25B0C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IETSHhg+Pz8bc6feXW/VCb8IyBS9MrfSYvdPWvuUfIQ=; b=Xquz9ypSlg+sOayj5I5HKZT6j8
	+1gb8oKS8hIWedZyvM2y0Twj/U9plAVC43bgqJ3GaA8k9vA3a2k3ohBYBGfp/jRW/LBxJ6pm3gm0G
	z8RZjp7MENOHwLqvE58Lt/gGvjpIaqz4m6T+sL7gPXsTxg9f2fOqCb2UxkziH58w7Ia834kH4CAds
	VxDLJh+jBr1scNZrUek9QxrfLBGgD53W+w3aaIbneZBhyOQWFBnved9ofqxMdmjLycRz1BuFdHVt6
	cR6R7hn+oeWWb1bxVLAm67DVXhIOJZqQ09NUo6o/+HmqJYdE/DASuoKP08vCTVcnPcPv5R5stkDgu
	YD1Adzqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM9Dq-00DITN-Sc; Thu, 11 Aug 2022 14:31:42 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM9D3-00DHjj-ME
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 14:30:57 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143049euoutp0262295bad3146f6bb475dfd0e38aedba6~KUMvk-vxe1585015850euoutp02M
	for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 14:30:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220811143049euoutp0262295bad3146f6bb475dfd0e38aedba6~KUMvk-vxe1585015850euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660228249;
	bh=IETSHhg+Pz8bc6feXW/VCb8IyBS9MrfSYvdPWvuUfIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUJjmSETtKrfnHjivgZ2RCbNIwYaxlgocTXAgW3jGYdvlF9gFqD56GoEEsuzPvOL6
	 HVWYG34/qOyGtfUiu/pb01V3dBVGj2kM7dm6XtA0AEhuJM3J8GL/CI/fq1SPHK3DRk
	 3FK1aU+6aJAXV8+Tapp7iF+V4xZwxB3sffsmhFhs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220811143047eucas1p2b9a2611311d138dadaa78f294cb95c04~KUMuDO0vk2328423284eucas1p2K;
	Thu, 11 Aug 2022 14:30:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.8C.09580.79215F26; Thu, 11
	Aug 2022 15:30:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c~KUMtbE4vD1005510055eucas1p26;
	Thu, 11 Aug 2022 14:30:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220811143046eusmtrp138eff0a7326f9b32d9d9e7bd5354f752~KUMtaNGU02320623206eusmtrp1O;
	Thu, 11 Aug 2022 14:30:46 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-a4-62f512979374
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.00.09038.69215F26; Thu, 11
	Aug 2022 15:30:46 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220811143046eusmtip24bbf8f26edcb02bde2c4177a98ae4647~KUMs-Uyjg1162311623eusmtip2J;
	Thu, 11 Aug 2022 14:30:46 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
	damien.lemoal@opensource.wdc.com
Cc: linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
	bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
	gost.dev@samsung.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
	pankydev8@gmail.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v10 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Date: Thu, 11 Aug 2022 16:30:32 +0200
Message-Id: <20220811143043.126029-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87rThb4mGSztkbJYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
	zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDIajjSwFdwW
	rdj08h17A2OfUBcjJ4eEgInE6j3vmUBsIYEVjBLTTwlB2F8YJZ7PVO5i5AKyPzNKHO1ezgjT
	8LRjKSNEYjmjxImfB5khOl4wSizZHdHFyMHBJqAl0djJDhIWEUiXWL9gOQuIzSywjUliywNh
	EFsYKL7n9js2EJtFQFXixuXFrCA2r4CVxJb9rcwQu+QlZl76DjaHU8BaYsKii0wQNYISJ2c+
	gZopL9G8dTYzyD0SAus5JS6un8YOcoOEgIvEvy3qEHOEJV4d38IOYctInJ7cwwJhV0s8vfEb
	qreFUaJ/53o2iF5rib4zOSAms4CmxPpd+hBRR4nvcwUgTD6JG28FIQ7gk5i0bTozRJhXoqMN
	GrBKEjt/PoHaKSFxuWkO1E4PicWN35gmMCrOQvLKLCSvzEJYu4CReRWjeGppcW56arFxXmq5
	XnFibnFpXrpecn7uJkZg8jv97/jXHYwrXn3UO8TIxMF4iFGCg1lJhLds0eckId6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUxT2yXbnv4Jd97EHtDKw3G3
	+fOM2kPmfOtKeK+dv9PvLlzsxsf6IvdLfkg/b36Fz/KmdW88FkqpBbckHUm+d0XpWp/IwkeH
	XFb/XJ1e/Evopeqenwd5mL+u1Dy9+vmzh//kZ0Rd2jBnSaav/dKtCasKwjWnxt5s3Sm5N8OL
	K/mxTzHfJGbW0N92f5RO+DwWTOZJWr9F895h+9wdduXS2z7X7Hha0PBF4tXh54J16Wuy/33/
	qhaw92TrwjtvBM5Vs9tOsL08f6625tt/OQpFEaYXpYUOP9u9ik9KLdvrtd37NZNdDs86yTWf
	Yx6r/eGrIay83gz3H5+cV7/XiJ/vcGjs0/yzWcYHJvIpVpwWMnFVYinOSDTUYi4qTgQAkBJD
	qu0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7rThL4mGSx5bmKx/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
	/rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
	m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
	WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0HGlgK7gtWrHp5Tv2BsY+oS5GTg4JAROJ
	px1LGUFsIYGljBIPjkRBxCUkbi9sYoSwhSX+XOti62LkAqp5xigx8+Ys1i5GDg42AS2Jxk52
	EFNEIFfi4JFAkBJmgSNMEs1vd7GA9AoLpErM/LeaCcRmEVCVuHF5MSuIzStgJbFlfyszxHx5
	iZmXvrOD2JwC1hITFl1kgrjHSmJCxzF2iHpBiZMzn4DNZAaqb946m3kCo8AsJKlZSFILGJlW
	MYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbrtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8ZYs+
	JwnxpiRWVqUW5ccXleakFh9iNAW6eyKzlGhyPjBh5JXEG5oZmBqamFkamFqaGSuJ83oWdCQK
	CaQnlqRmp6YWpBbB9DFxcEo1MJVeP6X3SWl/edOdO3IGOessTsxvXi55KTTxAefrrXcWzleR
	4zPnzF9iWHvjixzTvGO+Ftcuva87O0XITC5gPiPHgb7FViWN50Ps2aLnfpURTJx9scB7SvPR
	tmBD05JVmU/9/9Wm8FyZs1MqsUbbuTWLh2NVp3YPG6Mdd9ru0BrTY92huzIzva8pv/0mqsJa
	47bd7e5G27OGZWxncxeennNSWauzc1bzjJmPoiP+fZvNvXnLjoyrrv8Kb8sX1qdMytwpv2RG
	NffkbdM8As/v9frb6NlSc4XLneOuF+f2qC05vxfmvNhyQG3GlYlC7y4/yS25IuSh1PTwy5zQ
	wt+WH+sEuhMclY9fCimx4gtnUGIpzkg01GIuKk4EAGMLFrxgAwAA
X-CMS-MailID: 20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c
References: <20220811143043.126029-1-p.raghav@samsung.com>
	<CGME20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_073054_138064_34621820 
X-CRM114-Status: GOOD (  13.92  )
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

Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
superfluous NULL check for request queue while we are at it.

This commit has no functional change, and it is a prep patch for allowing
zoned devices with non-power-of-2 zone sizes in the block layer.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 43 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab82d1ff0cce..84e7881262e3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
 	return q->mq_ops;
 }
 
+static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
+{
+	return bdev->bd_queue;	/* this is never NULL */
+}
+
 #ifdef CONFIG_PM
 static inline enum rpm_status queue_rpm_status(struct request_queue *q)
 {
@@ -666,6 +671,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
+static inline bool bdev_is_zoned(struct block_device *bdev)
+{
+	return blk_queue_is_zoned(bdev_get_queue(bdev));
+}
+
+static inline sector_t bdev_zone_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!blk_queue_is_zoned(q))
+		return 0;
+	return q->limits.chunk_sectors;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
@@ -892,11 +911,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
 int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 			unsigned int flags);
 
-static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-{
-	return bdev->bd_queue;	/* this is never NULL */
-}
-
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
@@ -1296,25 +1310,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
-static inline bool bdev_is_zoned(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
-}
-
-static inline sector_t bdev_zone_sectors(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!blk_queue_is_zoned(q))
-		return 0;
-	return q->limits.chunk_sectors;
-}
-
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1


