Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C89D3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qA+NGz+6KM5521lpDTzCtjJ24sEMb14jQTfwKkFiwJc=; b=0LQfFbXZWgfJ1JriGBDelXibEo
	vbN25lNeDjX+vZ0n7bnYFE39JAkU4Sc48Tb+4BY1pttAQgJ6HWzjmNrxtAa+u1mSXUH2CoRkAa/Q6
	u2FeUUS53dBjlsSChIhdbRvqNU/xWxAo+0+GDGF3fmfY3o9GvWeD9W+7Ke5LSl0Qot3OKJiMKKpgs
	oEBA30X5EHGLjx59wEq9SF1Ys0KZ+NTyLB1cEbyH4DydrdddEpT0Y3dsyiDg6KFsyxTsIuAaApvGS
	CRHiJDVsVdCIrYEqLW2//iSS3Sd7QuwYwWedO4layWjPfk0UIFbbgpeEoI3XK3gA1B6QOzlTD1iYF
	sFIkMiWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o3R-0000000EtVJ-1mZr;
	Tue, 29 Oct 2024 15:22:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o0c-0000000EsbK-0MNE
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:19:51 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEaXlc009750
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:19:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=qA+NGz+6KM5521lpDTzCtjJ24sEMb14jQTfwKkFiwJc=; b=Iy4uN0QeAnJo
	fblju/KuxVMSg2VrDQlMo4Lu9MTYEXkSULblzcwPZ6jk8IUqfa4I8imCJXuJNs4P
	xhxPIT8k6ybNErCpUNyU+xus9yJPN3rxpm7rmGhdAghKzbEfYXq2HdP7hNkJLhlu
	IzFCkZckw8M0izhlhDxtBmhokwvTkilNq6KrCkw7oI9JgEtcTcQWuXeS3R/iJH2w
	jBxdLnJJCPlw9rfMQ/uHC/Uir4th1yiTqe0D9+leiYUzr+CF82znP0ds5E/DAdu7
	cpJhbBUjIC7jmvyrGmzN3W9jNN+RqTVN8MZ84xfqy4htzm6x2ShT0roiyr6rOSqF
	gu/1cH/cmA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42k1m9rd37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:19:47 -0700 (PDT)
Received: from twshared22321.07.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1049714920EA3; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 4/9] block: allow ability to limit partition write hints
Date: Tue, 29 Oct 2024 08:19:17 -0700
Message-ID: <20241029151922.459139-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0-eFXbsYyenC2In1HPDKOxQqeM-ZcYQA
X-Proofpoint-ORIG-GUID: 0-eFXbsYyenC2In1HPDKOxQqeM-ZcYQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_081950_357381_B46B9E9F 
X-CRM114-Status: GOOD (  17.34  )
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

When multiple partitions are used, you may want to enforce different
subsets of the available write hints for each partition. Provide a
bitmap attribute of the available write hints, and allow an admin to
write a different mask to set the partition's allowed write hints.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block |  6 ++++
 block/bdev.c                         | 13 ++++++++
 block/partitions/core.c              | 44 ++++++++++++++++++++++++++--
 include/linux/blk_types.h            |  1 +
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index f2db2cabb8e75..8ab9f030e61d1 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -187,6 +187,12 @@ Description:
 		partition is offset from the internal allocation unit's
 		natural alignment.
=20
+What:		/sys/block/<disk>/<partition>/write_hint_mask
+Date:		October 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		The mask of allowed write hints. You can limit which hints the
+		block layer will use by writing a new mask.
=20
 What:		/sys/block/<disk>/<partition>/stat
 Date:		February 2008
diff --git a/block/bdev.c b/block/bdev.c
index 9a59f0c882170..0c5e87b111aed 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -415,6 +415,7 @@ void __init bdev_cache_init(void)
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
 	struct block_device *bdev;
+	unsigned short write_hint;
 	struct inode *inode;
=20
 	inode =3D new_inode(blockdev_superblock);
@@ -440,6 +441,18 @@ struct block_device *bdev_alloc(struct gendisk *disk=
, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk =3D disk;
+
+	write_hint =3D bdev_max_write_hints(bdev);
+	if (write_hint) {
+		bdev->write_hint_mask =3D bitmap_alloc(write_hint, GFP_KERNEL);
+		if (!bdev->write_hint_mask) {
+			free_percpu(bdev->bd_stats);
+			iput(inode);
+			return NULL;
+		}
+		bitmap_set(bdev->write_hint_mask, 0, write_hint);
+	}
+
 	return bdev;
 }
=20
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 815ed33caa1b8..24e1a79972f75 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -203,6 +203,40 @@ static ssize_t part_discard_alignment_show(struct de=
vice *dev,
 	return sprintf(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
 }
=20
+static ssize_t part_write_hint_mask_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct block_device *bdev =3D dev_to_bdev(dev);
+	unsigned short max_write_hints =3D bdev_max_write_hints(bdev);
+
+	if (!max_write_hints)
+		return sprintf(buf, "0");
+	return sprintf(buf, "%*pb\n", max_write_hints, bdev->write_hint_mask);
+}
+
+static ssize_t part_write_hint_mask_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct block_device *bdev =3D dev_to_bdev(dev);
+	unsigned short max_write_hints =3D bdev_max_write_hints(bdev);
+	unsigned long *new_mask;
+
+	if (!max_write_hints)
+		return count;
+
+	new_mask =3D bitmap_alloc(max_write_hints, GFP_KERNEL);
+	if (!new_mask)
+		return -ENOMEM;
+
+	bitmap_parse(buf, count, new_mask, max_write_hints);
+	bitmap_copy(bdev->write_hint_mask, new_mask, max_write_hints);
+	bitmap_free(new_mask);
+
+	return count;
+}
+
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
 static DEVICE_ATTR(start, 0444, part_start_show, NULL);
 static DEVICE_ATTR(size, 0444, part_size_show, NULL);
@@ -211,6 +245,8 @@ static DEVICE_ATTR(alignment_offset, 0444, part_align=
ment_offset_show, NULL);
 static DEVICE_ATTR(discard_alignment, 0444, part_discard_alignment_show,=
 NULL);
 static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
+static DEVICE_ATTR(write_hint_mask, 0644, part_write_hint_mask_show,
+		   part_write_hint_mask_store);
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 static struct device_attribute dev_attr_fail =3D
 	__ATTR(make-it-fail, 0644, part_fail_show, part_fail_store);
@@ -225,6 +261,7 @@ static struct attribute *part_attrs[] =3D {
 	&dev_attr_discard_alignment.attr,
 	&dev_attr_stat.attr,
 	&dev_attr_inflight.attr,
+	&dev_attr_write_hint_mask.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
@@ -245,8 +282,11 @@ static const struct attribute_group *part_attr_group=
s[] =3D {
=20
 static void part_release(struct device *dev)
 {
-	put_disk(dev_to_bdev(dev)->bd_disk);
-	bdev_drop(dev_to_bdev(dev));
+	struct block_device *part =3D dev_to_bdev(dev);
+
+	bitmap_free(part->write_hint_mask);
+	put_disk(part->bd_disk);
+	bdev_drop(part);
 }
=20
 static int part_uevent(const struct device *dev, struct kobj_uevent_env =
*env)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6737795220e18..af430e543f7f7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -73,6 +73,7 @@ struct block_device {
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
 #endif
+	unsigned long		*write_hint_mask;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
--=20
2.43.5


