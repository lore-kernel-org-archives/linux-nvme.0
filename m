Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908BC54ED1
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZ20q90cuzIDMnvbv2G/OC471GJ5nYMbY/KN84m1fJ0=; b=Pn/R6Ifs/O2VEKy8zj26Yl+jKS
	yIRRaJnH/n0kgENVtNiIbSr8Dz8gBqgUyXLKdws68BaHxO0H0oiOXCSU2BgcHS95qNcO5eoCQ8TO0
	7LvA+weSgZYOvBnHK1aFxeRWA8VaCVFFvh9/OLqWMVVOfP70UUDt9ZzkvSbmOm98cPuuwIXGfL6A9
	ffr9J3tjc+HHSWFOhk+AettE+vZsfwbSQoLC7Djd8veK+RmE+A6VW6revLIS7EC/PBe0KxKhaDN0p
	0BVDBVEziMbvsr80a6cdL4tCxrt/W6cHNEUkILaIDtnsO4//31ExuHBqKX9JeC1zulMXWccodX81i
	7nYpwfTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHry4-0000000Gvff-3jls;
	Wed, 21 May 2025 22:31:20 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHry1-0000000Gvdt-4A3E
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 22:31:19 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQXcd002432
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=mZ20q90cuzIDMnvbv2G/OC471GJ5nYMbY/KN84m1fJ0=; b=jQma/pFI+CHK
	RlkX/qCoVaXaXreYvTS5/uZh8PFINU8y8Eiybdn1zp5qC5e4pmZQ6EzwuxifCVn2
	vFXd8AihzpysBsC+K+BSysEB0F4TJ0Xnhp8GOcEQivUkn6QqLFNZHeMNY+UZh5bV
	4X4DYK2QowvE/qe9reJJJGf9uk/xcmPQA/jesER7SlRuk+tRjIhtDKa9T5JpD577
	3O68yz6jVIMN/BuFYMZQbl7YI+bPmL1mGiDZsgLDRkS4IT9px6nEOZt/hdZLCJLG
	MNG9B3c0SwltG30PSB1SRrAgPvz+BUiweMv3oq97/RoL2mcn+7DbM3OB5MplISy/
	PTfbzVc+dQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfgkp1x-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:17 -0700 (PDT)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:14 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C91D91BE54AC9; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/5] block: add support for vectored copies
Date: Wed, 21 May 2025 15:31:06 -0700
Message-ID: <20250521223107.709131-5-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
References: <20250521223107.709131-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LAqh_FTo6gnyTmiQ7Jkn8SaFTC4PDCy_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfXw1hH/9lXiOuq +pkxMfR4Zu+nis+wLdZTjRv6OlTjOAtwqk8lQRJS91GlPv8m1qYRLkmAgkVBaoO5qDDeEAmLx8T hHAiUkRxIcrIkr/EZZarjiI758hFR5M+Ql70LfuCePQOGB/YV72KhxEX0wQWu2ppz6XcXND0IWQ
 lP9KBuXgTJagSqLXYef3Ce1MNG+c3VYUJmnE3yx/XxvLxKeIQTFqmtqsNw5VteTOVRf7RDCvnib EcKv/Plp9/5jqk0nPeVSY34oeFH3QXMjyilMt6u1DCuGpDi7OHLwLk/SOfaoF8bXgQfiJUPwXTn zTQvSQuBDd2sJev7e8WqCNTRkDot8SnFFNoO9en967objCQ8/57x3a8IxlY5rYgylr3nBu9d7W8
 mayx8DwP1LhaFn2A0571JNlxCXba0SQl6hruMI08FzIHZcCc5y1O1Z8AkIWwOtKirh6wgz4P
X-Authority-Analysis: v=2.4 cv=I9BlRMgg c=1 sm=1 tr=0 ts=682e5435 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QX-hf833l84o4JQLY-wA:9
X-Proofpoint-ORIG-GUID: LAqh_FTo6gnyTmiQ7Jkn8SaFTC4PDCy_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_153118_038822_4190754F 
X-CRM114-Status: GOOD (  23.47  )
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

From: Keith Busch <kbusch@kernel.org>

Copy offload can be used to defrad or garbage collect data spread across
the disk. Most storage protocols provide a way to specifiy multiple
sources in a single copy commnd, so introduce kernel and user space
interfaces to accomplish that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c         | 50 ++++++++++++++++++++++++----------
 block/ioctl.c           | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  2 ++
 include/uapi/linux/fs.h | 14 ++++++++++
 4 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index a538acbaa2cd7..7513b876a5399 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -424,26 +424,46 @@ static int __blkdev_copy(struct block_device *bdev,=
 sector_t dst_sector,
 }
=20
 static int blkdev_copy_offload(struct block_device *bdev, sector_t dst_s=
ector,
-		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
+		struct bio_vec *bv, int nr_vecs, gfp_t gfp)
 {
+	unsigned size =3D 0;
 	struct bio *bio;
-	int ret;
-
-	struct bio_vec bv =3D {
-		.bv_sector =3D src_sector,
-		.bv_sectors =3D nr_sects,
-	};
+	int ret, i;
=20
-	bio =3D bio_alloc(bdev, 1, REQ_OP_COPY, gfp);
-	bio_add_copy_src(bio, &bv);
+	bio =3D bio_alloc(bdev, nr_vecs, REQ_OP_COPY, gfp);
+	for (i =3D 0; i < nr_vecs; i++) {
+		size +=3D bv[i].bv_sectors << SECTOR_SHIFT;
+		bio_add_copy_src(bio, &bv[i]);
+	}
 	bio->bi_iter.bi_sector =3D dst_sector;
-	bio->bi_iter.bi_size =3D nr_sects << SECTOR_SHIFT;
+	bio->bi_iter.bi_size =3D size;
=20
 	ret =3D submit_bio_wait(bio);
 	bio_put(bio);
 	return ret;
+}
+
+/**
+ * blkdev_copy_range - copy range of sectors to a destination
+ * @dst_sector:	start sector of the destination to copy to
+ * @bv:		vector of source sectors
+ * @nr_vecs:	number of source sector vectors
+ * @gfp:	allocation flags to use
+ */
+int blkdev_copy_range(struct block_device *bdev, sector_t dst_sector,
+		struct bio_vec *bv, int nr_vecs, gfp_t gfp)
+{
+	int ret, i;
=20
+	if (bdev_copy_sectors(bdev))
+		return blkdev_copy_offload(bdev, dst_sector, bv, nr_vecs, gfp);
+
+	for (i =3D 0, ret =3D 0; i < nr_vecs && !ret; i++)
+		ret =3D __blkdev_copy(bdev, dst_sector, bv[i].bv_sector,
+				bv[i].bv_sectors, gfp);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(blkdev_copy_range);
=20
 /**
  * blkdev_copy - copy source sectors to a destination on the same block =
device
@@ -455,9 +475,11 @@ static int blkdev_copy_offload(struct block_device *=
bdev, sector_t dst_sector,
 int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
 		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
 {
-	if (bdev_copy_sectors(bdev))
-		return blkdev_copy_offload(bdev, dst_sector, src_sector,
-					nr_sects, gfp);
-	return __blkdev_copy(bdev, dst_sector, src_sector, nr_sects, gfp);
+	struct bio_vec bv =3D {
+		.bv_sector =3D src_sector,
+		.bv_sectors =3D nr_sects,
+	};
+
+	return blkdev_copy_range(bdev, dst_sector, &bv, 1, gfp);
 }
 EXPORT_SYMBOL_GPL(blkdev_copy);
diff --git a/block/ioctl.c b/block/ioctl.c
index 6f03c65867348..4b5095be19e1a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -241,6 +241,63 @@ static int blk_ioctl_copy(struct block_device *bdev,=
 blk_mode_t mode,
 	return blkdev_copy(bdev, dst, src, nr, GFP_KERNEL);
 }
=20
+static int blk_ioctl_copy_vec(struct block_device *bdev, blk_mode_t mode=
,
+		void __user *argp)
+{
+	sector_t align =3D bdev_logical_block_size(bdev) >> SECTOR_SHIFT;
+	struct bio_vec *bv, fast_bv[UIO_FASTIOV];
+	struct copy_range cr;
+	int i, nr, ret;
+	__u64 dst;
+
+	if (!(mode & BLK_OPEN_WRITE))
+		return -EBADF;
+	if (copy_from_user(&cr, argp, sizeof(cr)))
+		return -EFAULT;
+	if (!(IS_ALIGNED(cr.dst_sector, align)))
+		return -EINVAL;
+
+	nr =3D cr.nr_ranges;
+	if (nr <=3D UIO_FASTIOV) {
+		bv =3D fast_bv;
+	} else {
+		bv =3D kmalloc_array(nr, sizeof(*bv), GFP_KERNEL);
+		if (!bv)
+			return -ENOMEM;
+	}
+
+	dst =3D cr.dst_sector;
+	for (i =3D 0; i < nr; i++) {
+		struct copy_source csrc;
+		__u64 nr_sects, src;
+
+		if (copy_from_user(&csrc,
+				(void __user *)(cr.sources + i * sizeof(csrc)),
+				sizeof(csrc))) {
+			ret =3D -EFAULT;
+			goto out;
+		}
+
+		nr_sects =3D csrc.nr_sectors;
+		src =3D csrc.src_sector;
+		if (!(IS_ALIGNED(src | nr_sects, align)) ||
+		    (src < dst && src + nr_sects > dst) ||
+		    (dst < src && dst + nr_sects > src)) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		bv[i].bv_sectors =3D nr_sects;
+		bv[i].bv_sector =3D src;
+	}
+
+	ret =3D blkdev_copy_range(bdev, dst, bv, nr, GFP_KERNEL);
+out:
+	if (bv !=3D fast_bv)
+		kfree(bv);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
@@ -605,6 +662,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
 		return blk_ioctl_secure_erase(bdev, mode, argp);
 	case BLKCPY:
 		return blk_ioctl_copy(bdev, mode, argp);
+	case BLKCPY_VEC:
+		return blk_ioctl_copy_vec(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e39ba0e91d43e..a77f2298754b5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1182,6 +1182,8 @@ int blkdev_issue_secure_erase(struct block_device *=
bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
 		sector_t src_sector, sector_t nr_sects, gfp_t gfp);
+int blkdev_copy_range(struct block_device *bdev, sector_t dst_sector,
+		struct bio_vec *bv, int nr_vecs, gfp_t gfp);
=20
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 534f157ce22e9..aed965f74ea2c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -218,6 +218,20 @@ struct fsxattr {
 /* [0] =3D destination lba, [1] =3D source lba, [2] =3D number of sector=
s */
 #define BLKCPY _IOWR(0x12,142,__u64[3])
=20
+struct copy_source {
+	__u64 src_sector;
+	__u64 nr_sectors;
+};
+
+struct copy_range {
+	__u64	dst_sector;
+	__u16	nr_ranges;
+	__u8	rsvd[6];
+	__u64	sources; /* user space pointer to struct copy_source[] */
+};
+#define BLKCPY_VEC _IOWR(0x12,143,struct copy_range)
+
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
--=20
2.47.1


