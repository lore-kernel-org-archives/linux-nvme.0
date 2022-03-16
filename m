Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CC3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=I3ij/P3MWbgeX+gTUKQuUT9ppw8meTDF4qy04Yjpofs=; b=iA0d13iqUj48UdTUB7mk8Mgwm2
	Vbr8rZP0mYqWyFEz0IFj5/pPXHFj6A+zwh5J235iceLWsTKHr3NEYSbElKxQKiT10PqlODvQ28EUU
	KXWCy4x60teBK3Wnt94y5LINTlN2wHSJgS0fe0BcOCSpyIoVjIH5nyCajbHAGXOAZsLTLI5HepN3I
	1k1pZ2ro7TS2Xnd3A8jjf/ioUb5cq1oLkwug6fSjvQFBYorTj/2aDt5y3CmesRFMKufbrbEUF4YRg
	kCoYj61Gjd41lp0XHE3F7cWbUGbojw04cnEJtl4t35/e/EZgowyo2G1jSG7CCrWu45U1fu0/tFOcC
	2UfT2gYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUQ3K-00CKNu-T6; Wed, 16 Mar 2022 09:34:46 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUQ3G-00CKM8-Ua
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 09:34:45 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220316093440euoutp020b8293db6fa802cffe5032c697fee33c~c0r7FebwQ2491324913euoutp02N
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 09:34:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220316093440euoutp020b8293db6fa802cffe5032c697fee33c~c0r7FebwQ2491324913euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647423280;
 bh=I3ij/P3MWbgeX+gTUKQuUT9ppw8meTDF4qy04Yjpofs=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gfAsRHOeg/+/5yi3nFomHYS3BPstaLXT3iUqCyj79wKoDplP+LTl+jhB8ewQ2pjae
 BK1c6t1TWwOGS6dYIBYq5CV4RSc7bAzOaqLA+tFiPrCDx0XSlpncgyKxwMm32pi4Xi
 QtVStQQQj4QgGX/Zs+eCGquZ3ikXwaZZ6bNPNFms=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220316093439eucas1p1b7665094d50d394010804df4a6dcd7da~c0r6mMJut2229322293eucas1p1q;
 Wed, 16 Mar 2022 09:34:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id AF.64.10009.F2FA1326; Wed, 16
 Mar 2022 09:34:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180~c0r58ZTN50323003230eucas1p2o;
 Wed, 16 Mar 2022 09:34:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220316093439eusmtrp1b409c8adcd8df53c7ce223035a6aba7c~c0r57iaD_0805108051eusmtrp1I;
 Wed, 16 Mar 2022 09:34:39 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-ef-6231af2fcb24
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.17.09404.F2FA1326; Wed, 16
 Mar 2022 09:34:39 +0000 (GMT)
Received: from localhost (unknown [106.210.248.212]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220316093438eusmtip13c452bc3a72f718eb8be51ec467131f6~c0r5k99920276802768eusmtip1o;
 Wed, 16 Mar 2022 09:34:38 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens
 Axboe <axboe@kernel.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org, Pankaj
 Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Date: Wed, 16 Mar 2022 10:34:23 +0100
Message-Id: <20220316093423.17906-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87r66w2TDH49NLOYfljRYvXdfjaL
 32fPM1usXH2UyeLxnc/sFn+77jFZHP3/ls3i/NvDTBaTDl1jtJi/7Cm7xY0JTxktPi9tYbdY
 c/Mpi8W61+9ZHPg8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPna33WT36tqxi9Gg/
 0M0UwBnFZZOSmpNZllqkb5fAldHVfYO5YJFUxevVCxgbGJeJdTFyckgImEg8WPWJsYuRi0NI
 YAWjxIa/K6GcL4wSm87cZ4dwPjNKnDm0kg2m5ffROcwQieWMEi8fbGGFcF4ySrxetw2on4OD
 TUBLorETrFtE4BejxL/Wa2wgDrPAISaJXZcfsIOMEhaIl2j98wbMZhFQlbizaBUTSDOvgKXE
 nuZsiG3yEjMvfQcr4RUQlDg58wkLiM0MFG/eOhvsCgmBLxwSE5b+ZIdocJGY96OBBcIWlnh1
 fAtUXEbi9OQeFoiGfkaJqS1/mCCcGYwSPYc3g22WELCW6DuTA2IyC2hKrN+lD9HrKPHwxGU2
 iAo+iRtvBSFu4JOYtG06M0SYV6KjTQiiWkli588nUFslJC43zYG6xkPi9PNGcCAKCcRKLO+6
 xjaBUWEWks9mIflsFsINCxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmtdP/jn/a
 wTj31Ue9Q4xMHIyHGCU4mJVEeM+80E8S4k1JrKxKLcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9
 sSQ1OzW1ILUIJsvEwSnVwDQva6NXm3r1/93mXA+faiZ9tXd+fn9lwvRHNyZLXlh1lm2q5ETL
 j4ezxf0M9vYdb21dp8Fod97rftXWG7dN57/SqmcSazvIoetWsr+de9ej+OSlxf8ex5UcimA3
 /Pj5q0n2HzGOIv1rd33/9G2TixNM4hKLvLCiwNHv52rTTudri5jlZi3cea86LPR1Gcf2SSW/
 /JJfz9PpD23v28avnnuW32E394zwGVIrH98++uX21tomW2b+lVpyNpbV0z+qzogSVfh5tPd2
 /rYTir8nTjALEjN2mOUnZKX2v2z6mmOevLOnz/vpttSr+evy0s4GM/94d5UV8ZW+ggbrdx95
 1usoJ+2Y7Owmb29xzqGtWImlOCPRUIu5qDgRAJdwGB7aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7r66w2TDNac47KYfljRYvXdfjaL
 32fPM1usXH2UyeLxnc/sFn+77jFZHP3/ls3i/NvDTBaTDl1jtJi/7Cm7xY0JTxktPi9tYbdY
 c/Mpi8W61+9ZHPg8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPna33WT36tqxi9Gg/
 0M0UwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
 l9HVfYO5YJFUxevVCxgbGJeJdTFyckgImEj8PjqHuYuRi0NIYCmjxMEzO5kgEhIStxc2MULY
 whJ/rnWxQRQ9Z5SY97GHvYuRg4NNQEuisZMdJC4i8I9R4m3LAxYQh1ngBJPEhFuHwLqFBWIl
 5r/ZwApiswioStxZtIoJpJlXwFJiT3M2xAJ5iZmXvrOD2LwCghInZz5hAbGZgeLNW2czT2Dk
 m4UkNQtJagEj0ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAeNp27OeWHYwrX33UO8TIxMF4
 iFGCg1lJhPfMC/0kId6UxMqq1KL8+KLSnNTiQ4ymQOdNZJYSTc4HRnReSbyhmYGpoYmZpYGp
 pZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTJpV/ieq5mX1aB6ZluDMnLpO9tWmNw+dp
 IfLOFnnLtc/KvCrkcX3dHb7bo6crasnF1jkvVQ4dO16U/3aheNT9U7NNHj69dFhwLdu3RV7x
 DGtyUnh7DvS7MMvNLFjpEOv97nSh1ilJa7WNXkbcfeuMcz5qzX4yJelq4oa3TyT6Ve6wfN8b
 fCzy7ua+RS8YdqSGzN8+dbsAb1Vp9qMSUflrRU8fpXcKpN7crnVtQ2/Gq1DpLkHLFYV72Vka
 z0s7CLO8WDGvXH7eTvay0Lzst4UfVrwr3PFuz8UX75Z/eHvi5l79hwzq62ofnPl9XPlr7cJy
 rbQUznv3Av7WBlQE1igIKJcZzorx/nNbYvaLg9PFlFiKMxINtZiLihMBbqYFFjADAAA=
X-CMS-MailID: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_023443_356790_F5A8D143 
X-CRM114-Status: GOOD (  20.34  )
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

This commit 2f4c9ba23b88 ("nvme: export zoned namespaces without Zone
Append support read-only") exported zoned namespaces without append support
to be marked as ro. It does it by setting NVME_NS_FORCE_RO to the
ns->flags in nvme_update_zone_info and later nvme_update_disk_info will
check for this flag and set the disk as ro.

But later this commit 73d90386b559 ("nvme: cleanup zone information
initialization") rearranged nvme_update_disk_info to be called before
nvme_update_zone_info thereby not marking the disk as ro. The call order
cannot be just reverted because nvme_update_zone_info sets certain queue
parameters such as zone_write_granularity that depend on the prior call
to nvme_update_disk_info.

Add a helper nvme_set_disk_ro that can be called in nvme_update_zone_info
to set the permission for ZNS drives correctly.

Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v1:
- Add a new helper to set permission directly from nvme_update_zone_info
  instead of calling nvme_update_disk_info again (Damien)

Note:
Christoph made a point that there is a race window where the disk will
be marked as writable during revalidate zones.
I already responded to the comment in the email thread as it will not be
the case as we mark the disk as ro before we start revalidating the
disk.
https://lore.kernel.org/all/1bbc81a0-19f0-433b-28c2-b22d28176e37@grimberg.me/T/#m0e19022babda81339188ee334551a5fb867abf4c

 drivers/nvme/host/core.c | 3 +--
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/zns.c  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51c08f206cbf..cde33f2a3a5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1855,8 +1855,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 
-	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
-		test_bit(NVME_NS_FORCE_RO, &ns->flags));
+	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7ccdb119ede..b6800bdd6ea9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -607,6 +607,11 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }
 
+static inline void nvme_set_disk_mode_ro(struct nvme_ns *ns)
+{
+	set_disk_ro(ns->disk, test_bit(NVME_NS_FORCE_RO, &ns->flags));
+}
+
 /*
  * Fill in the status and result information from the CQE, and then figure out
  * if blk-mq will need to use IPI magic to complete the request, and if yes do
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..4ab685fa02b4 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -113,6 +113,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
+	nvme_set_disk_mode_ro(ns);
 free_data:
 	kfree(id);
 	return status;
-- 
2.25.1


