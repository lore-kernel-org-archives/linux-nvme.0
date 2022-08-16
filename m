Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE95C28B2B
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGdXrZOo82rW1rnRJeQcvmwRabixUhHDV5CM9X+9nHY=; b=GYoTF+mWKAd92wkF43W+vf5rNQ
	+xoFu/+tHqjKg2uugXAYydfpBHW299rZMpiCCKL8HEgxCMquGMQjv3LJTZV/YviG5ZRKnRjObKj+a
	s4LAp+7uur8iYp4sUzmg3Iqm8uOWo0uY9DJU18jcVzwZVankAns456O3yyXMZI28PToXI/Awm/IhG
	ZAzbhdEPu/RSXBqf9L08A2CGHig431CuwpgrbfqBLCjrqtn8s0PoVhS884w/FbSXj2cl3uQGbOJLd
	Sc7YV4kEABOOdULftR/g/UCJH46ZmZYxsznsEzQHxHRbBAp1SmHpLgcKIErPWsvOL3yPvxcQSmzKH
	GtzfpWVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNwQQ-002k2n-Cb; Tue, 16 Aug 2022 13:16:06 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNwQ5-002jjB-E9
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 13:15:47 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131544euoutp02ac31c005643068a43fa1c656f0a7d272~L1ZnOBMHY2958029580euoutp02F
	for <linux-nvme@lists.infradead.org>; Tue, 16 Aug 2022 13:15:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220816131544euoutp02ac31c005643068a43fa1c656f0a7d272~L1ZnOBMHY2958029580euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660655744;
	bh=tGdXrZOo82rW1rnRJeQcvmwRabixUhHDV5CM9X+9nHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OX6D6dlYQbFMtbD2VhiTAiNsHUHXNSsSybLVZN/G8Ypg9oh/VdhQHbTcHpRPl+CMw
	 G3lOhGkLMybeXNuUKX+8JYS6a/tiozMx2AhRCl/4Cd02JMm3HlpANKnhulOkN6kpyS
	 nwX2cGbNm31MkUETavuA7tFCFOymOkknEOyIwXsg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220816131542eucas1p25ea333b0145dc2db4bea93399819c075~L1ZliQojs0372203722eucas1p20;
	Tue, 16 Aug 2022 13:15:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id ED.65.09580.E789BF26; Tue, 16
	Aug 2022 14:15:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220816131541eucas1p1a025fa0b664cb89a5c3f513863f69032~L1ZlEiMOm0141101411eucas1p1a;
	Tue, 16 Aug 2022 13:15:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220816131541eusmtrp112f9ecb9c4ed041e0ee37c232919a072~L1ZlDriu-0149801498eusmtrp1C;
	Tue, 16 Aug 2022 13:15:41 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-df-62fb987e6c6b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.A0.09095.D789BF26; Tue, 16
	Aug 2022 14:15:41 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220816131541eusmtip183589bb30aa83ccac3b2bcf6852af3fe~L1ZkxXq_W2694326943eusmtip1A;
	Tue, 16 Aug 2022 13:15:41 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: damien.lemoal@opensource.wdc.com, axboe@kernel.dk, snitzer@kernel.org,
	hch@lst.de, agk@redhat.com
Cc: pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
	hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, Pankaj Raghav
	<p.raghav@samsung.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v11 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date: Tue, 16 Aug 2022 15:15:27 +0200
Message-Id: <20220816131536.189406-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87p1M34nGfQfE7RYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
	vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlTF7
	0y2WglP8Fc9atrE2MC7h7WLk5JAQMJH4t6OFrYuRi0NIYAWjxKxbT1ghnC+MEnM/NkA5n4Gc
	zWfYYVpu7pnFDpFYzihx78lEJgjnBaPEsTvzgVo4ONgEtCQaO8EaRATSJaa0vGQBqWEW6GeW
	OH7qEitIQlggUuLArPdgNouAqkTz2cWMIDavgJXE+VnbWCG2yUvMvPQdbBCngLXEv4ZVLBA1
	ghInZz4Bs5mBapq3zmYGWSAhsJ1T4u/Vl1CnukhsWLySEcIWlnh1fAtUXEbi9OQeFgi7WuLp
	jd9QzS2MEv0717OBfCABtK3vTA6IySygKbF+lz5EuaPEm48HmCAq+CRuvBWEOIFPYtK26cwQ
	YV6JjjYhiGoliZ0/n0AtlZC43DQHaqmHxKb7DxgnMCrOQvLMLCTPzELYu4CReRWjeGppcW56
	arFxXmq5XnFibnFpXrpecn7uJkZgSjz97/jXHYwrXn3UO8TIxMF4iFGCg1lJhFfwxY8kId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUyhAVWWf/o2HLLQ
	2bJol9500e4vEy39Js8RclMT4uPY9L7/PuNyzyNu3q+/Prj189rJxfyXWddduHBLg3WV8aO4
	9aekdTMjLqxa8H7Ots2JXy8IsJ3MVrHZcb4tSGXDwefRU28I/Uq1T2GpV7Usj5fc172h1kT3
	tefcwFuuoYYJmt9CDle8Y1383POPack+57kaei/v39dUlIxtnHP8R8jJb5+kDJtKJO4suL2R
	IX7alZ3GlrYa68Vnrn/96hz/k4ucMRPD9XRc2ldm+J9UZ1kdlfr9s+OlTyt/TVC54s9yV+ev
	w69/lvPcZOPPMcx+9fHH2bcypo8VnonUKZxnm3HXwFRrUiHrtcfzvqxMmjgtTImlOCPRUIu5
	qDgRACjim374AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7q1M34nGexabGix/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
	/rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
	eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
	0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P2plssBaf4K561bGNtYFzC28XI
	ySEhYCJxc88s9i5GLg4hgaWMEs1bjzFCJCQkbi9sgrKFJf5c62IDsYUEnjFKvDkm38XIwcEm
	oCXR2MkOEhYRyJVYtKyDFWQOs8B8Zon5b5eygNQIC4RL9G+rBqlhEVCVaD67GGwkr4CVxPlZ
	21ghxstLzLz0HWwOp4C1xL+GVSwQq6wk2o5dZoaoF5Q4OfMJWJwZqL5562zmCYwCs5CkZiFJ
	LWBkWsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYuduO/dy8g3Heq496hxiZOBgPMUpwMCuJ
	8Aq++JEkxJuSWFmVWpQfX1Sak1p8iNEU6O6JzFKiyfnA1JFXEm9oZmBqaGJmaWBqaWasJM7r
	WdCRKCSQnliSmp2aWpBaBNPHxMEp1cBU/rJnlXu8j7k438w9aRnWG9sqWvacPr22h/vK6r2W
	c9adLDq+hL+yhU+ShT3Oe/2CpG41u8kbVpse+8x3fIX65uC/TY9/uMbUL2jt3F956R3Pksva
	vmIyS9hObpsx1V6KI2CbPWPVbI0C4ctrVNrOMny0i75Vwvtm4bXulzzqK5re8HnlClvKmmyv
	m3K9MurjY60KTUn9rRoHsne31j54mbpkXZFP0t2L839t5zwdGdOxlE9CYAd7jNHutXdN3Zjt
	lLoYK6pcGvUtMx1PMx8wmfQ5eF9Iu5xNnHLqpD11zAwZvHOXfzJnLNj46JnG/Ykl2/b8uqr3
	4TGzXFbR8VVqRWm/XwYrWgpO/XhcUVOJpTgj0VCLuag4EQBKYnwZZQMAAA==
X-CMS-MailID: 20220816131541eucas1p1a025fa0b664cb89a5c3f513863f69032
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131541eucas1p1a025fa0b664cb89a5c3f513863f69032
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131541eucas1p1a025fa0b664cb89a5c3f513863f69032
References: <20220816131536.189406-1-p.raghav@samsung.com>
	<CGME20220816131541eucas1p1a025fa0b664cb89a5c3f513863f69032@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_061545_787031_8FB61290 
X-CRM114-Status: GOOD (  14.05  )
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

A generic bdev_zone_no() helper is added to calculate zone number for a
given sector in a block device. This helper internally uses disk_zone_no()
to find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for zoned devices with non po2 zone size.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 3 +--
 include/linux/blkdev.h    | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..662f1a92f39b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d0d66a0db224..b2636dcca105 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1340,6 +1340,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	return disk_zone_no(bdev->bd_disk, sec);
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1


