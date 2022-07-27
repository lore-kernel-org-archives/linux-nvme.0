Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE7BC04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6YdN6BuyNfKUhnJ4Ex4JoHzWc/k6rZ3Vga2E3H8xjE=; b=Qs0fY+Lmd1BNxyCgoskmH/jAd2
	ZKQVUHS/rnzeWzKkV/4HzeQUC6WQ2uxpdd1gdAYtnmhuEamRyhTuZyklcVlUQFlVli18/dZPG81tG
	rvObeFrkrLUKXtJbNtU7HXYIdiqhunU0YpSfrsiAa3d6nQsjpuQ7voX1az67dV2Scx2563vB/k401
	lqrbbWWvlFxUzXfrkVcXe9VuW57inxOVqSasRiwmCB1uaU61gFxNQJF/CJeefJgXG49aKOGfVKMpU
	slGCqZwm3BDSohhqnyex9FFdA2r/FpCLFpUNcrQrVJycR5HMFhloAJ4woc8VyyXxpTJXt3aCAfMlf
	T3awDMxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjpV-00FVOL-44; Wed, 27 Jul 2022 16:24:13 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjoG-00FUVZ-Ng
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 16:22:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162255euoutp0102e49c928ec3f9ed0600cab67d5119fe~FvDVwkA_I2521125211euoutp01m
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162255euoutp0102e49c928ec3f9ed0600cab67d5119fe~FvDVwkA_I2521125211euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658938975;
	bh=o6YdN6BuyNfKUhnJ4Ex4JoHzWc/k6rZ3Vga2E3H8xjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7jODNejbm/XQCl/4CN4CwNIe51C11Ol4A8teABxLKfXVyyx9veY5MpQuSG6J3mcD
	 g7A5KWpA+ytRsCjbdKzMDRw6zUdXdUdITBK6GXR54PpfAcmiKE8pkuSXu8zH1hhXPH
	 gYlHnzI+8ooJJGcttzO3RS//IPDX7ohwHu1uHHoc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220727162254eucas1p233f05f6d0ebf6420e5c5a1ede6933299~FvDUgkQdX2220522205eucas1p24;
	Wed, 27 Jul 2022 16:22:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 36.E8.09580.E5661E26; Wed, 27
	Jul 2022 17:22:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f~FvDUBWZKL2552225522eucas1p1j;
	Wed, 27 Jul 2022 16:22:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220727162253eusmtrp22d668828082dcd16db4e000e6aa34a22~FvDUAjAdg0811608116eusmtrp2x;
	Wed, 27 Jul 2022 16:22:53 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-e4-62e1665ea39d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.1E.09095.D5661E26; Wed, 27
	Jul 2022 17:22:53 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220727162253eusmtip153d4fe6af3d463321ed8ca423b743eac~FvDTsxnYN0064100641eusmtip1R;
	Wed, 27 Jul 2022 16:22:53 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
	snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
	pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, Luis Chamberlain
	<mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v8 07/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date: Wed, 27 Jul 2022 18:22:41 +0200
Message-Id: <20220727162245.209794-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7pxaQ+TDNp3sFisvtvPZjHtw09m
	i99nzzNb7H03m9Xi5oGdTBZ7Fk1isli5+iiTxZP1s5gt/nbdY7LYe0vb4vKuOWwW85c9ZbeY
	0PaV2eLGhKeMFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
	5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRXDYpqTmZZalF+nYJXBl9dy6wFkzl
	rrhw6ANTA2MXZxcjJ4eEgInEobV/WLsYuTiEBFYwSjQfnMQM4XxhlNg54TQLSJWQwGdGiTML
	YmE6Tr9dzgJRtJxR4uru2WwQznNGie1/NgLN4uBgE9CSaOxkB2kQESiWePiuFayBWeAAk8Tv
	Q/eZQRLCAsESZ7buYgSpZxFQlbjzUQ0kzCtgJfHx6SxmiGXyEjMvfQebwylgLbF5yjwmiBpB
	iZMzn4AdxwxU07x1NtjVEgLrOSW2XNnJDtHsIvF1wU6oQcISr45vgYrLSPzfOZ8Jwq6WeHrj
	N1RzC6NE/871bCAHSQBt6zuTA2IyC2hKrN+lD1HuKHF/4l5GiAo+iRtvBSFO4JOYtG06M0SY
	V6KjTQiiWkli588nUEslJC43zWGBsD0k9i2bzzKBUXEWkmdmIXlmFsLeBYzMqxjFU0uLc9NT
	i43zUsv1ihNzi0vz0vWS83M3MQKT4Ol/x7/uYFzx6qPeIUYmDsZDjBIczEoivAnR95OEeFMS
	K6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MBUoTlhY4DCNwdf9
	2ymJNzdjNjNz886pfzrrdfS0TarGt2e5PQryPGb6u2Px26LOQq1PW6O/SxqlsiptS3JZljgx
	/llBdZr/ooL0uuOf4oN2iMS1RKU23go+6l7CP1/du6Sq6f3db43SnGbCzJ13XpgcLra0bw/d
	1mnqOHXl4gWHxQ72CaYpRbz9tUpPirneStN1vWFi1aopKhXbvbUT2V/N+McmabosJ2+C353l
	r9uz9CvWX7u4ZGeZfpL2yytJ7s4h98+kyq90P85u3dd+8d/8rbnHGypeV6z/aNb9vj3Tcd1G
	7jssKr0mFr6btt9xDpq4eM5qs4P1Xa8OnMhRPqxw+NO6Sscvt4931xxPVGIpzkg01GIuKk4E
	AGlHgy3xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7qxaQ+TDA7tkbNYfbefzWLah5/M
	Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
	zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
	LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL67lxgLZjKXXHh0AemBsYuzi5GTg4JAROJ
	02+Xs3QxcnEICSxllFj58RQjREJC4vbCJihbWOLPtS42iKKnjBLX2l+ydjFycLAJaEk0drKD
	mCIClRJnv8iClDALnGOSWHnhNhNIr7BAoMS6hn42kBoWAVWJOx/VQMK8AlYSH5/OYoYYLy8x
	89J3dhCbU8BaYvOUeWCtQkA1zx58ZIOoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1i
	FEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNdtx35u3sE479VHvUOMTByMhxglOJiVRHgTou8n
	CfGmJFZWpRblxxeV5qQWH2I0BTp7IrOUaHI+MGHklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
	pCeWpGanphakFsH0MXFwSjUwbROfev/Onbu3ft9yjM3+2iC3zm56J/OMXXtMqhwaJHcKvLzo
	7d65b3Lzd5N735utvj+xccndmHbkFtfTP/vvHwtesVhwW7RRcYb6r2tsh27IClUw7kziczz5
	LcsghlMq0NGwK+RY+PU378IdfqyOMFG+maBiWnlBz1Xz+XfBW9k94cX/zxzeMDX5xiybm1NX
	bKqP4J3gqqWcezFIrS7wv+ODReXLnyrM7ZHqSTlwJ19kluxqf69iJ/mzlhtZ1jxLP1isWfM8
	XfLD7sAbcwR0jJpPn91W8njhVCXzx3umHjtUGZLwyElmb+nVzPCuiRJhnI+YxDzKfe3DOE6u
	1p+v/GfP7wq3mL5jRacrhKtNlViKMxINtZiLihMBuerqPWADAAA=
X-CMS-MailID: 20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f
References: <20220727162245.209794-1-p.raghav@samsung.com>
	<CGME20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_092257_120281_3668ED2E 
X-CRM114-Status: GOOD (  12.25  )
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

dm-zoned relies on the assumption that the zone size is a
power-of-2(po2) and the zone capacity is same as the zone size.

Ensure only po2 devices can be used as dm-zoned target until a native
non po2 support is added.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zoned-target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 95b132b52f33..16499b75c5ee 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = bdev_zone_sectors(bdev);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size is not power of 2";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones = bdev_nr_zones(bdev);
 		}
@@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 			return -EINVAL;
 		}
 		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
+		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
+			ti->error = "Zone size is not power of 2";
+			return -EINVAL;
+		}
 		zoned_dev->nr_zones = bdev_nr_zones(bdev);
 	}
 
-- 
2.25.1


