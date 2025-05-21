Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54325C54E90
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZE38SQlUTxOdL6Eq/GiFvrJf6fdbU3j3t94O5PZNxg4=; b=QTQI+jjvXWwjSb+Z9y4AbC/stA
	TuQ4ix2p7ieWfi6a3rDUC1EnW3cd5WGZ+/j1uXHiqjqoyXAJWAp7X3CguQY+yXDVJOQo8HjufHm/X
	JFTK9WwpyXoWqDXGekXSIhb8j7/mWMQ2/m5jdMkGbXpC4jwnqeBDJBrK1mm/ooiqBpx6ku8c/sbb1
	Kb4tzCWd2DKzlWYgOkUBvlCehb2ZfM8Od9p7SMdP/Q7NnSm9NmwTHMYOAQzPZkc3geDtPKCauPhcg
	oEhbc4VmIXXHVhMPJpRsm7jXpnI1HOvy8N5XyTcBel+MkzulS18sKYeapaLl218883ZhOKZxqHhtO
	d58kx/2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHryF-0000000GvnD-2Ds1;
	Wed, 21 May 2025 22:31:31 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHryD-0000000GvlQ-1URr
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 22:31:30 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQWgK029158
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ZE38SQlUTxOdL6Eq/GiFvrJf6fdbU3j3t94O5PZNxg4=; b=PrsQ227BREKm
	JW2HN66lcmLKUzvFmzqZ7/66VNmkrUbeTBTCeAaW6Xq3pXCyAJY4CyGh685f4ZIV
	2b8rguVrQwcTLyAlsEwF8azpnWx5yD1WO97joUk5ct7u0RA5EmjXVyGAtvRyDhuc
	oCpNGB2w92zpCkGzoEvJPMuJziiFqWDpZmVMTD2plM5IppXsYj5lNbZKTkJnnqOH
	mUC2Xh6w2067ER6g2TVm3avBeIVrpOWSOehmrPvaRq2yuqA0v9zLIlilQudq0/w0
	qPi2MllCYl7j60PZ812q2fbshlObepZ4bE62j0RY2oyNMpaHQKZcPooFdkEqrLCe
	rd3vl1dYAg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sd06wf38-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 15:31:28 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:25 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A1EF21BE54AC4; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/5] block: new sector copy api
Date: Wed, 21 May 2025 15:31:03 -0700
Message-ID: <20250521223107.709131-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
References: <20250521223107.709131-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MaBsu4/f c=1 sm=1 tr=0 ts=682e5440 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=s5lGTWZQ5RyZ_Hens2EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfXxDOevzHPi25x m95iN/bBsC46Odx5cJVn72EkMHORfHMx1tXUIgWmUWq+VAf6o6ExGPFXTzgQ7jjg/X4xJsX89ok rvSc6n2axQnTrodvLHpZNt/7Ez6hz69rz6F0BTGesOziTNW8Gkf+BkR6Dm+s5qfqEV0FaRb957I
 AUN2PM5fn9ODH7hbMkjC3cxW37PLpxSPTZZO2KZlvj//f0uOuVboWItKQnzW+lgAeQTPQuZrBNN LV9CG0nIxVIcWBqfCQSkoSDEc0wnmis/H+06wwSwILXjZKUuIElDd3nR/gLE723lDOvWB1Rpko2 4ZA5Vxfw13Yuq2lOjh6SkRjH03jcsvQZ0H9GNeCrxMyfp/8TZySUEfKXqaBR1tsNfoJsHGh4SQr
 OU+vNwe8dgXdNJJ4w2fGnbHaG6TBzM996yHPefmvzKgx5XPwaSy0KkxvjqzTxOlHfHvuIY0d
X-Proofpoint-ORIG-GUID: ae7KUb4T32PvKG1wQYfTfChpmPUjHWS0
X-Proofpoint-GUID: ae7KUb4T32PvKG1wQYfTfChpmPUjHWS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_153129_518573_2FB27BAE 
X-CRM114-Status: GOOD (  21.59  )
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

Provide a basic block level api to copy a range of a block device's
sectors to a new destination on the same device. This just reads the
source data into host memory, then writes it back out to the device at
the requested destination.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c         | 62 +++++++++++++++++++++++++++++++++++++++++
 block/ioctl.c           | 30 ++++++++++++++++++++
 include/linux/blkdev.h  |  2 ++
 include/uapi/linux/fs.h |  3 ++
 4 files changed, 97 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7b..a819ded0ed3a9 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -368,3 +368,65 @@ int blkdev_issue_secure_erase(struct block_device *b=
dev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_secure_erase);
+
+/**
+ * blkdev_copy - copy source sectors to a destination on the same block =
device
+ * @dst_sector:	start sector of the destination to copy to
+ * @src_sector:	start sector of the source to copy from
+ * @nr_sects:	number of sectors to copy
+ * @gfp:	allocation flags to use
+ */
+int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
+		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
+{
+	unsigned int nr_vecs =3D __blkdev_sectors_to_bio_pages(nr_sects);
+	unsigned int len =3D (unsigned int)nr_sects << SECTOR_SHIFT;
+	unsigned int size =3D min(len, nr_vecs * PAGE_SIZE);
+	struct bio *bio;
+	int ret =3D 0;
+	void *buf;
+
+	if (nr_sects > UINT_MAX >> SECTOR_SHIFT)
+		return -EINVAL;
+
+	buf =3D kvmalloc(size, gfp);
+	if (!buf)
+		return -ENOMEM;
+
+	nr_vecs =3D bio_add_max_vecs(buf, size);
+	bio =3D bio_alloc(bdev, nr_vecs, 0, gfp);
+
+	if (is_vmalloc_addr(buf))
+		bio_add_vmalloc(bio, buf, size);
+	else
+		bio_add_virt_nofail(bio, buf, size);
+
+	while (len) {
+		size =3D min(len, size);
+
+		bio_reset(bio, bdev, REQ_OP_READ);
+		bio->bi_iter.bi_sector =3D src_sector;
+		bio->bi_iter.bi_size =3D size;
+
+		ret =3D submit_bio_wait(bio);
+		if (ret)
+			break;
+
+		bio_reset(bio, bdev, REQ_OP_WRITE);
+		bio->bi_iter.bi_sector =3D dst_sector;
+		bio->bi_iter.bi_size =3D size;
+
+		ret =3D submit_bio_wait(bio);
+		if (ret)
+			break;
+
+		src_sector +=3D size >> SECTOR_SHIFT;
+		dst_sector +=3D size >> SECTOR_SHIFT;
+		len -=3D size;
+	}
+
+	bio_put(bio);
+	kvfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy);
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c60..6f03c65867348 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -212,6 +212,34 @@ static int blk_ioctl_secure_erase(struct block_devic=
e *bdev, blk_mode_t mode,
 	return err;
 }
=20
+static int blk_ioctl_copy(struct block_device *bdev, blk_mode_t mode,
+		void __user *argp)
+{
+	unsigned int lbs =3D bdev_logical_block_size(bdev) >> SECTOR_SHIFT;
+	uint64_t dst, src, end, nr, range[3];
+
+	if (!(mode & BLK_OPEN_WRITE))
+		return -EBADF;
+	if (copy_from_user(range, argp, sizeof(range)))
+		return -EFAULT;
+
+	dst =3D range[0];
+	src =3D range[1];
+	nr =3D range[2];
+
+	if (!(IS_ALIGNED(dst | src | nr, lbs)))
+		return -EINVAL;
+	if (check_add_overflow(src, nr - 1, &end))
+		return -EINVAL;
+	if (end >=3D bdev_nr_sectors(bdev))
+		return -EINVAL;
+	if (src < dst && src + nr > dst)
+		return -EINVAL;
+	if (dst < src && dst + nr > src)
+		return -EINVAL;
+
+	return blkdev_copy(bdev, dst, src, nr, GFP_KERNEL);
+}
=20
 static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
@@ -575,6 +603,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
 		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
 		return blk_ioctl_secure_erase(bdev, mode, argp);
+	case BLKCPY:
+		return blk_ioctl_copy(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d92..b7d71b126ec9b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1176,6 +1176,8 @@ int __blkdev_issue_discard(struct block_device *bde=
v, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector=
,
 		sector_t nr_sects, gfp_t gfp);
+int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
+		sector_t src_sector, sector_t nr_sects, gfp_t gfp);
=20
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index e762e1af650c4..534f157ce22e9 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -215,6 +215,9 @@ struct fsxattr {
 /* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h)=
 */
 /* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
=20
+/* [0] =3D destination lba, [1] =3D source lba, [2] =3D number of sector=
s */
+#define BLKCPY _IOWR(0x12,142,__u64[3])
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
--=20
2.47.1


