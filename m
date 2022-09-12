Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37673C6FA83
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=; b=lSHw5YIJus8dT3YTew+J0IWphW
	S9bTZH5+BeJliODVy4G/Qt81P0wpDhIqgZOT+4Bp8T1G/J+6nmPwM7fxMVd5GjjwK56TNnckpqwfD
	kh3pv3S23wICICxn8Jhv89SrIJ74XGuw8wm2/F/9IQaIt7zIaVNWLQLRURI8HN7YLTjT/DKmU/ztl
	qEr7BbVyg99ywYmL7xiNRuTXu3pH76uHC9yjIwJQbSHfpWZBroDHOuYkSomqa2JyOEKlu9StFmE2v
	cHEoq9XeYu4Vgoqwl7+28dTWrOjimzjBHTBNmxB7wYHaGMmmT7Ft1pnLXWv+8vWgZL4gp3tKyycD9
	6BKVhMYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXeic-007kLT-UN; Mon, 12 Sep 2022 08:23:08 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXeiJ-007k7h-Js
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 08:22:46 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082214euoutp01cad6a64a63b620baab063a1c830015ed~UD0EKF0GX1404314043euoutp01T
	for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 08:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220912082214euoutp01cad6a64a63b620baab063a1c830015ed~UD0EKF0GX1404314043euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662970934;
	bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRqX/k2uvt0NXazwL9MRQaxiFj1YX2mW5l7vnKM/jZ1A+mYDZn2Bh7kxWKUjvugDK
	 Ry4e+kR6Yabb95tfx0RLPRJ/Ifq6woKBvZFO/R+hxqy7F8sWKduQqSjbkWsCj21lTP
	 7Srjof5lKaJl7/hiEMAUOmEHIG+51GdelaeUIPko=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220912082207eucas1p29c7db135677f5003724aae601b8c346b~UDz9pzoBc0134101341eucas1p2i;
	Mon, 12 Sep 2022 08:22:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.98.29727.F2CEE136; Mon, 12
	Sep 2022 09:22:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220912082206eucas1p25336d07279850f7009be6b5d1fccf558~UDz9G3b792084220842eucas1p2y;
	Mon, 12 Sep 2022 08:22:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220912082206eusmtrp1650c92c0efd28a6fd06dff561d98c82c~UDz9F6VZF1301813018eusmtrp1S;
	Mon, 12 Sep 2022 08:22:06 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-de-631eec2fb1fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 64.2F.07473.E2CEE136; Mon, 12
	Sep 2022 09:22:06 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220912082206eusmtip101d2c775cf01540cc46c480381f1d24c~UDz8utiBG1320313203eusmtip1f;
	Mon, 12 Sep 2022 08:22:06 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
	axboe@kernel.dk, snitzer@kernel.org
Cc: linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
	linux-nvme@lists.infradead.org, pankydev8@gmail.com,
	matias.bjorling@wdc.com, linux-block@vger.kernel.org, bvanassche@acm.org,
	gost.dev@samsung.com, dm-devel@redhat.com, hare@suse.de, jaegeuk@kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: [PATCH v13 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Date: Mon, 12 Sep 2022 10:21:52 +0200
Message-Id: <20220912082204.51189-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djP87r6b+SSDX58FbGYfljRYv2pY8wW
	q+/2s1lM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8
	aw6bxfxlT9ktJrR9Zba4MeEpo8XnpS3sFmtuPmWxOHFL2kHY4/IVb4+ds+6ye1w+W+qxaVUn
	m8fmJfUeu282sHnsbL3P6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPFJdNSmpOZllqkb5d
	AlfG36ntTAVXRSqeTXjF1sA4S7CLkZNDQsBE4nDjSsYuRi4OIYEVjBJztq5jhXC+MErcXrWK
	DcL5zCix7MZq9i5GDrCWm40pEPHljBKf1kxngXBeMkpMvvuYBaSITUBLorGTHWSFiEC6xPfp
	75hAapgFupglDny/wAaSEBZIkrj98R8TiM0ioCqxZdskMJtXwFKi7/c0Voj75CVmXvoONohT
	wEri9apWRogaQYmTM5+wgNjMQDXNW2czgyyQENjPKdE8awpUs4vE1hkfmCFsYYlXx7ewQ9gy
	Eqcn97BA2NUST2/8hmpuYZTo37meDeJNa4m+MzkgJrOApsT6XfoQ5Y4Sly88YYKo4JO48VYQ
	4gQ+iUnbpjNDhHklOtqEIKqVJHb+fAK1VELictMcqKUeEj2PH7JMYFScheSZWUiemYWwdwEj
	8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAxHj63/FPOxjnvvqod4iRiYPxEKMEB7OS
	CC+LoXSyEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqay
	kOgtk6+/u7KyVkj6/KOCVdZ/oktrysOk05bf0Fyq210l36P98/zEq9OS7Wa+UC4UP8tUdkZy
	y/f+t5dEJtyoeuz0Z87kE88fG++Z+EeZWbFuk/cxP5OUS7XRhY+tmKetL1KyYJx+Vt6j7M9x
	o58HepV6H3xuYjELSec6/Hfx3qwmq0VMS4601zyfdveKcmL0+lBrr+/fDs2rWx8qs9/g2cSw
	uXE59of+J09fsWOWvP2yk8VPDK7Jt+X9uVFk+/ppDG9NnhLXDZfQXw/Z9ZzUzj2Kdfm5ag53
	0nNNcYYgWcclT9fwPzKRjnX+c93606f0xNufz5YwpobGCJk6rJW77x5YsJ9z013jhl/eCo5K
	LMUZiYZazEXFiQCvAdvc+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7p6b+SSDQ7N1rOYfljRYv2pY8wW
	q+/2s1lM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8
	aw6bxfxlT9ktJrR9Zba4MeEpo8XnpS3sFmtuPmWxOHFL2kHY4/IVb4+ds+6ye1w+W+qxaVUn
	m8fmJfUeu282sHnsbL3P6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPlJ5NUX5pSapCRn5x
	ia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G36ntTAVXRSqeTXjF1sA4
	S7CLkYNDQsBE4mZjShcjJ4eQwFJGiTMXckFsCQEJidsLmxghbGGJP9e62LoYuYBqnjNKPLx2
	gBWkl01AS6Kxkx2kRkQgV+Lzyh9gNcwCs5glvkw6xASSEBZIkGie2cYGYrMIqEps2TYJLM4r
	YCnR93saK8QCeYmZl76DDeIUsJJ4vaqVEeIgS4mz326wQ9QLSpyc+YQFxGYGqm/eOpt5AqPA
	LCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG8LZjPzfvYJz36qPeIUYmDsZD
	jBIczEoivCyG0slCvCmJlVWpRfnxRaU5qcWHGE2B7p7ILCWanA9MIXkl8YZmBqaGJmaWBqaW
	ZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUyMwefPHo5+5nDQQYhxwpFFVzInPmv7s55h
	pcYShqDkTZJie7e9+Lpb2f2pYmH6+rnPztgrG8oqpc8WXXjkltXuLZtOvz+bfKHr2U83s6k1
	TsffRRyMjG66yi9Wse7I18OJ0i5ya9kkT6h+sEhs3Hz04PrJ2p9P6iVq35v3bEFt2a/gQ8f5
	ZJM3XlFTVN4/32bDj0lPzdf8K7xzmeE/a7BK+Zb5OlfUzxzrjNsmFyd2p2Zzhv51rUO+zme3
	igcXf2fvs923kbV6DYvgoWbf1HXXw4/Vrb0Qsf750b9F+YuTMzb+j27Xf3nh1MT9R9YvWRwi
	OeGFYOUt52dbb+xJXMns+dhWVv/pt8N6aZUhkZmeR5VYijMSDbWYi4oTAWwtWAxpAwAA
X-CMS-MailID: 20220912082206eucas1p25336d07279850f7009be6b5d1fccf558
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082206eucas1p25336d07279850f7009be6b5d1fccf558
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082206eucas1p25336d07279850f7009be6b5d1fccf558
References: <20220912082204.51189-1-p.raghav@samsung.com>
	<CGME20220912082206eucas1p25336d07279850f7009be6b5d1fccf558@eucas1p2.samsung.com>
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


