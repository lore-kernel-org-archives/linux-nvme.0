Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1F5D149F4
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 21:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bbO7+T7xIMipIdGfjCh1Iup93mutgTnr5qBkMOWpsVo=; b=fFXMOQE3dmiyl0j6IAONyvL4iN
	7chfz3/PBz+aFXOqvIUDwFB4yV/aRxVS4Izdhgmm36yhXFUlq9eri2rpFK4DzPtYhv+Y/U31M6qhh
	+gE0czfXITDNpYAQu2p/xBnF8dYxBt68rtHWo1lpEfUNB3NOyPqX2EWGqUe6LS8SBcf+1R25RpOd7
	123XMSbrEcbJP4Rp7BqyEabUoUax86sDut8wB6Vj4W4nUfW2tBaTMcr4X8Ln+EPN7ovo3aXRHTxAP
	VPtktP4oCGp4oXfLPu8fFkEs2I864wZugNEYpdrNFW3F1pdad7W8ct/tnIar7V4Tza4uwHscRghBl
	eFQONKLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4S0Z-00000005KKX-056R;
	Fri, 25 Oct 2024 21:38:11 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Rzg-00000005K2m-2Qhj
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 21:37:18 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PKXc79001080
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=bbO7+T7xIMipIdGfjCh1Iup93mutgTnr5qBkMOWpsVo=; b=WPxiNNfTRj09
	A5JlvhnAHjSuURvFLa1qVSAhgSzqCpIcTGAwzpCM3NWMD78RJ3RUTFDcDPL70nnN
	q9pUVcivGvyZWujeDvMfRfvdaPVrQnbQXV/lJzshfM2GXOZdDFovVtHSZaGHm86f
	Zodqxsv55dr1fiG82JCZjsu/C9trclqU5VHa36eYomneDJnF1Vxg5+RBdmjK/MLM
	VJklxJtiyZKtQAc2BNMDQsBvbSav6VExPlu1S8NhompBuzhBX5++4zcMENiMl+aI
	2oR/xoZrNDpuMg2mbDUToWOFL+FMe4FcBlC5Z4TuZg6yeXFc3A6ue1z0IENEPwiG
	nk7aUgih/Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ga1xv7gu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:37:14 -0700 (PDT)
Received: from twshared22321.07.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:37:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7AFF91476D73B; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv9 3/7] block: allow ability to limit partition write hints
Date: Fri, 25 Oct 2024 14:36:41 -0700
Message-ID: <20241025213645.3464331-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
References: <20241025213645.3464331-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2fvoZQhB0TruDQkeYVTvrkroO5JD_aI-
X-Proofpoint-GUID: 2fvoZQhB0TruDQkeYVTvrkroO5JD_aI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_143716_769540_C1A6216A 
X-CRM114-Status: GOOD (  16.74  )
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
 block/bdev.c              | 15 +++++++++++++
 block/partitions/core.c   | 46 +++++++++++++++++++++++++++++++++++++--
 include/linux/blk_types.h |  1 +
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7f..5d23648db457b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -414,6 +414,7 @@ void __init bdev_cache_init(void)
=20
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
+	unsigned short max_write_hints;
 	struct block_device *bdev;
 	struct inode *inode;
=20
@@ -440,6 +441,20 @@ struct block_device *bdev_alloc(struct gendisk *disk=
, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk =3D disk;
+
+	max_write_hints =3D bdev_max_write_hints(bdev);
+	if (max_write_hints) {
+		int size =3D BITS_TO_LONGS(max_write_hints) * sizeof(long);
+
+		bdev->write_hint_mask =3D kmalloc(size, GFP_KERNEL);
+		if (!bdev->write_hint_mask) {
+			free_percpu(bdev->bd_stats);
+			iput(inode);
+			return NULL;
+		}
+		memset(bdev->write_hint_mask, 0xff, size);
+	}
+
 	return bdev;
 }
=20
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 815ed33caa1b8..c0ea0a7b6fa87 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -203,6 +203,42 @@ static ssize_t part_discard_alignment_show(struct de=
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
+	if (max_write_hints)
+		return sprintf(buf, "%*pb\n", max_write_hints, bdev->write_hint_mask);
+	else
+		return sprintf(buf, "0");
+}
+
+static ssize_t part_write_hint_mask_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct block_device *bdev =3D dev_to_bdev(dev);
+	unsigned short max_write_hints =3D bdev_max_write_hints(bdev);
+	unsigned long *new_mask;
+	int size;
+
+	if (!max_write_hints)
+		return count;
+
+	size =3D BITS_TO_LONGS(max_write_hints) * sizeof(long);
+	new_mask =3D kzalloc(size, GFP_KERNEL);
+	if (!new_mask)
+		return -ENOMEM;
+
+	bitmap_parse(buf, count, new_mask, max_write_hints);
+	bitmap_copy(bdev->write_hint_mask, new_mask, max_write_hints);
+
+	return count;
+}
+
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
 static DEVICE_ATTR(start, 0444, part_start_show, NULL);
 static DEVICE_ATTR(size, 0444, part_size_show, NULL);
@@ -211,6 +247,8 @@ static DEVICE_ATTR(alignment_offset, 0444, part_align=
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
@@ -225,6 +263,7 @@ static struct attribute *part_attrs[] =3D {
 	&dev_attr_discard_alignment.attr,
 	&dev_attr_stat.attr,
 	&dev_attr_inflight.attr,
+	&dev_attr_write_hint_mask.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
@@ -245,8 +284,11 @@ static const struct attribute_group *part_attr_group=
s[] =3D {
=20
 static void part_release(struct device *dev)
 {
-	put_disk(dev_to_bdev(dev)->bd_disk);
-	bdev_drop(dev_to_bdev(dev));
+	struct block_device *part =3D dev_to_bdev(dev);
+
+	kfree(part->write_hint_mask);
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


