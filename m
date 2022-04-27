Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1278EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z59AramoBMIFuOXUYYH05DZBLjfbCNMGUst3i9j3Z7Q=; b=pGBVagt2Lrjtt60oTC1yrc83SQ
	KyXCh2F9eRRs9NcJs6FNLG/VhzunmlO9S9Xekb9fzG8s8lkCDAEsCU313XPDTSqHgos2MrRhfV6iN
	RyTQS6OOd+MRR8vQK8C3QjKE4TNaea2FB1Qd25gzFbeRQA76YSVhiTvUyCaha07Sqzn0/KRQZQtSc
	W6TWvEN2Hhqy6ebo/iN+vq5dgCtqvSVir60aSieHcgG/iaIbD5Hved7BEVjAs7Vs/oLBGHK7dUFVr
	W/EdMpVZMuWRl3/g34SP7PoCfWOYmoEFpKMKJpin3lxdOp6g7DQsbPAejNba3TrvPm8Tnyj/PGvy1
	5YKKIK7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njkKD-002Ejj-HU; Wed, 27 Apr 2022 16:15:33 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njk8L-0029et-7U
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 16:03:24 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220427160310euoutp01f50b8bbbecb06c571c802fd1c05acdbe~pzFHHiKxi0745007450euoutp01j
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:03:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220427160310euoutp01f50b8bbbecb06c571c802fd1c05acdbe~pzFHHiKxi0745007450euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651075390;
 bh=Z59AramoBMIFuOXUYYH05DZBLjfbCNMGUst3i9j3Z7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W7RCwmZtNSpvqE8y4evit2Zuyld27ntnSWb6JvmMVBxMaxqsV2CNMLB1BGalJnTQP
 YU0C/GItlU594cRcvi1Dbxne/WVtaDdWMEvWlL9JbbHa5tK/3iAwedjLyWAn8J47KM
 uIoIWOO+pVS0kGYKL9LDlUfRYQeyBV2VT2nUvGbg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220427160308eucas1p29e66b3685c84483f3fdd5a90299d93e1~pzFFvrXVn2333623336eucas1p2p;
 Wed, 27 Apr 2022 16:03:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 8C.0A.10260.C3969626; Wed, 27
 Apr 2022 17:03:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220427160307eucas1p229f9ebae38fcca9974909799e5e63ccf~pzFFKDoBX2335623356eucas1p2h;
 Wed, 27 Apr 2022 16:03:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220427160307eusmtrp194cac78e29ca037961137d3a49caf9ec~pzFFDipZN2142221422eusmtrp1D;
 Wed, 27 Apr 2022 16:03:07 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-96-6269693c7e10
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.A7.09404.B3969626; Wed, 27
 Apr 2022 17:03:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220427160307eusmtip1fe2208eed35a4c2cc164aecccf9c648a~pzFEt7JbD1109611096eusmtip1x;
 Wed, 27 Apr 2022 16:03:07 +0000 (GMT)
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
Subject: [PATCH 11/16] btrfs: zoned: relax the alignment constraint for
 zoned devices
Date: Wed, 27 Apr 2022 18:02:50 +0200
Message-Id: <20220427160255.300418-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTZxzNd+/t7S2z7lpd+CLdiFWmuPAQMPvG2MIWs924p7pMMNmwwOWR
 8XAt4BAX64oOOnlVUB5uQh2TAqGUh1lBSIMCMoa6YkeBDOKEqSCt8kjpEFjLrZn/nXN+5/zO
 70s+ChfpyM1UYkoaK0uRJklID+JKj+OmX1hiYnTgco8Y6X7rwVHdXwUkOvfYgaP+kgEMqQtK
 +Whp4BaOOqwVPHR78SSGho0GDGnrujE0oSvH0RnjYwItq8acWvZdHD29uwupu/4EaNJcjqGO
 kdeQ6V4NH5k076OrHX0EGmy7QKKLv0zyUeHpBRxZCicBKupt5qG56mw+api2EejGiFf4y8zg
 nQ+YlRv1JFOktPKZW2N6ghkcSGeaanNJpkpRgjPNP59g2ivnMKZ9WEEyeUoryRhOjfMYW6eZ
 ZPJbagGjazETTGGznvep6JBHWCyblJjBygLePuyRYCrOx44o1n2z0mTnK8CiQAUEFKRDoL7K
 gauAByWiawA8t7xKcmQeQIW2wk3mALxe14E9i1y71OqOXAawbLERcOQhgPfGTM4JRZH0Tngy
 l+/SN9EWAIsaGzEXwekpHN5uGVpbtZE+CPWLVuDCBO0D8+by1rCQfhPa74zyuTpvWGay811L
 BU69cDaCs2yAfWUThAvjTouytWLtIkhrPeC4qRhw2T2wumUC5/BGONXb4t4phv1nzxAczoKT
 liV3OBvAAoOOdJVBZ1n+70kuiNO+UNcWwNnfgdctBh7nWA8tMxu4E9ZD9ZXzOCcLYc5pEeeW
 QINjwl0K4eB3FwjOwkDD0t5CsKX8ubeUP/eW8v9rKwFeCzzZdHlyPCsPTmGP+sulyfL0lHj/
 mNTkJuD80/0rvQu/gpqpJ/5dAKNAF4AULtkknG9PiBYJY6WZx1hZapQsPYmVdwEvipB4CmMS
 G6UiOl6axn7FskdY2bMpRgk2KzCv+jJhZEZw67qg6QXpt5KPM7UfhVrT7seZc5JrreNBr74e
 fvT+zIcvafy2WEvtQ/b34vzSA//VBBmK2zQp+n1ZMDNb3aAmJjSVA7v3BeERxqhHxu/HRsOE
 OT7nfecv7pU0PEwVp379hWm1x3dZXLzDR6na+lnuZcGxEDgjLXG88GPp8LveMUPH/zn1R3DA
 tC33wbYn9It/q2pWFw490n651bPEM8RBNYyHrUZHHoyIN1bVd0YFbCsw6iWx1uN9/vu1scod
 b72SaQsIDzzw9CfJgZVr3bPb94d2x3lGPnjDODLsvWeWarQczhAPh3p1niB++Byxtu2726tH
 L+mzrn5iKr1plhDyBOmunbhMLv0P+DRJV0IEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xu7rWmZlJBlem61isP3WM2WL13X42
 i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
 /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
 MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
 8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
 xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
 +nYJehmXpvQxFTTwVPzb9J29gfEHZxcjJ4eEgInE4cVbmbsYuTiEBJYySvQ/WcAKkZCQuL2w
 iRHCFpb4c62LDcQWEnjOKDHhtGQXIwcHm4CWRGMnO0iviMATRon7Px+zgDjMAg0sErcm7mIC
 aRAWCJWY1NLMDmKzCKhK9H7uBRvKK2At8f3KbXaIBfISMy99ZwcZygkUn/ApAmKXlUT3olus
 EOWCEidnPmEBsZmBypu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
 GIEJZduxn1t2MK589VHvECMTB+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosPMZoCnT2R
 WUo0OR+Y0vJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjmrbjk
 9E73Oa/J+if9fbyVPcrR819umO4l9WfiedHM9K3yc/6Gbyg62Tsx7MYf/zfPimqaavWu+PZK
 MFqoGGlO1k35krMgp0nx9Pnrk9v+V+5Oj9WaYmo1f90kBvnlXxa+kvf/lb3Zf/fVXQn9s8vy
 mlri9jQ9lBUtLUw71Ht/Pu/8Sx8y+xa/z3qlkhm3PE9bSebp4+RTjpGcG7Rv817UnFhZHV72
 4sg0++ZHk1j8eddUrNkx64SjxfM/27/d+Mxw52zurrkCx825z/sceibeyelzr+vJC48DMxy0
 3zutXD6Fa2E1z7w1r6a1PD37+/TBpn/VXgebj/CvDIt2udqfe01MzXFXetXfVRx1z3r8lViK
 MxINtZiLihMBMHgdG7EDAAA=
X-CMS-MailID: 20220427160307eucas1p229f9ebae38fcca9974909799e5e63ccf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160307eucas1p229f9ebae38fcca9974909799e5e63ccf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160307eucas1p229f9ebae38fcca9974909799e5e63ccf
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160307eucas1p229f9ebae38fcca9974909799e5e63ccf@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_090317_617142_C21B0C33 
X-CRM114-Status: GOOD (  12.78  )
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

Checks were in place to return error when a non power-of-2 zoned devices
is detected. Remove those checks as non power-of-2 zoned devices are
now supported.

Relax the zone size constraint to align with the BTRFS_STRIPE_LEN(64k)
so that block groups are aligned to the BTRFS_STRIPE_LEN.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8f3f542e174c..3ed085762f14 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -395,8 +395,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
-	/* Check if it's power of 2 (see is_power_of_2) */
-	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
+	ASSERT(zone_sectors != 0 && IS_ALIGNED(zone_sectors, BTRFS_STRIPE_LEN));
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
 
 	/* We reject devices with a zone size larger than 8GB */
@@ -835,9 +834,11 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 
 	ASSERT(rw == READ || rw == WRITE);
 
-	if (!is_power_of_2(bdev_zone_sectors(bdev)))
-		return -EINVAL;
 	nr_sectors = bdev_nr_sectors(bdev);
+
+	if (!IS_ALIGNED(nr_sectors, BTRFS_STRIPE_LEN))
+		return -EINVAL;
+
 	nr_zones = bdev_zone_no(bdev, nr_sectors);
 
 	sb_zone = sb_zone_number(bdev, mirror);
-- 
2.25.1


