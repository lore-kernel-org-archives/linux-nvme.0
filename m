Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374AC7EE39
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KuP4KAiQsKpw4mqMpH1zHHPSC2k3DoFrHQQ6pz0kICU=; b=C98f+Dsfw4fBdBc7EdvtocQg5X
	T64r25IqWt2wewds2MI62C7SvdfgsW6u/ZHyDkS83nSz1NOFrYR/QOoSh0MYuqNf69P/dwUh5Tx62
	IQ29Wvj00cAqKWg2Y4OVhEQmAsoyUPYGkhu1AadIlAFxszukz+CjFgSiU5nvXaYnZhn/gNFBMKEUC
	wagboeP+YfyiuGw6UbNwZcxHHoWVMnSo190Igf3NqD0My18/9y2BPTNSenOBQqFDEWqAlUIaQs/5g
	0hR+RJqSriosmXt4qgbym5TU1EqwqOtQMHdGYCUzAeLBx0VL9PbBvwVWBJWBpaWdHyo1hD2kKiv/2
	ZHBjlLag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAVb-00000001hj7-0x1r;
	Mon, 30 Jun 2025 09:09:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAVZ-00000001hhD-0KKR
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 09:09:02 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250630090858epoutp01fc411d48e6b8648eaced220279ac903f~NxunnKroY2136421364epoutp01Z
	for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 09:08:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250630090858epoutp01fc411d48e6b8648eaced220279ac903f~NxunnKroY2136421364epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751274538;
	bh=KuP4KAiQsKpw4mqMpH1zHHPSC2k3DoFrHQQ6pz0kICU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1NXGnmvvPfIIUuAdxOlwc0KXheU1GyCIaqWk+PZbT7ahTGC9j8S1V9AWEujWfLFF
	 UWR2xUuquPn1MdTKM+qrcwyYhtxZSJuR+izRA+DaUjgb2GhJUgOJU/PEGthO5F9m2N
	 Y+7Tz2BcBvspcczwKrX1Q9/HCX1BvmBqkRc131jA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250630090857epcas5p4cc423d6634783953db3ff103947b4232~NxunJau9j2849428494epcas5p4b;
	Mon, 30 Jun 2025 09:08:57 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.182]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bW0hS0Cp3z6B9m8; Mon, 30 Jun
	2025 09:08:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090616epcas5p2a9ca118ca83586172d69213e22b635a1~NxsRQh7E41144511445epcas5p2m;
	Mon, 30 Jun 2025 09:06:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090614epsmtip2f8167ee603d818ac154ac73d76a49336~NxsPKrF8q1134211342epsmtip2j;
	Mon, 30 Jun 2025 09:06:14 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v5 4/4] fs: add ioctl to query metadata and
 protection info capabilities
Date: Mon, 30 Jun 2025 14:35:48 +0530
Message-Id: <20250630090548.3317-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250630090616epcas5p2a9ca118ca83586172d69213e22b635a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090616epcas5p2a9ca118ca83586172d69213e22b635a1
References: <20250630090548.3317-1-anuj20.g@samsung.com>
	<CGME20250630090616epcas5p2a9ca118ca83586172d69213e22b635a1@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_020901_423113_AB8D988F 
X-CRM114-Status: GOOD (  27.16  )
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

Add a new ioctl, FS_IOC_GETLBMD_CAP, to query metadata and protection
info (PI) capabilities. This ioctl returns information about the files
integrity profile. This is useful for userspace applications to
understand a files end-to-end data protection support and configure the
I/O accordingly.

For now this interface is only supported by block devices. However the
design and placement of this ioctl in generic FS ioctl space allows us
to extend it to work over files as well. This maybe useful when
filesystems start supporting  PI-aware layouts.

A new structure struct logical_block_metadata_cap is introduced, which
contains the following fields:

1. lbmd_flags: bitmask of logical block metadata capability flags
2. lbmd_interval: the amount of data described by each unit of logical
block metadata
3. lbmd_size: size in bytes of the logical block metadata associated
with each interval
4. lbmd_opaque_size: size in bytes of the opaque block tag associated
with each interval
5. lbmd_opaque_offset: offset in bytes of the opaque block tag within
the logical block metadata
6. lbmd_pi_size: size in bytes of the T10 PI tuple associated with each
interval
7. lbmd_pi_offset: offset in bytes of T10 PI tuple within the logical
block metadata
8. lbmd_pi_guard_tag_type: T10 PI guard tag type
9. lbmd_pi_app_tag_size: size in bytes of the T10 PI application tag
10. lbmd_pi_ref_tag_size: size in bytes of the T10 PI reference tag
11. lbmd_pi_storage_tag_size: size in bytes of the T10 PI storage tag

The internal logic to fetch the capability is encapsulated in a helper
function blk_get_meta_cap(), which uses the blk_integrity profile
associated with the device. The ioctl returns -EOPNOTSUPP, if
CONFIG_BLK_DEV_INTEGRITY is not enabled.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-integrity.c         | 52 ++++++++++++++++++++++++++++++
 block/ioctl.c                 |  4 +++
 include/linux/blk-integrity.h |  7 +++++
 include/uapi/linux/fs.h       | 59 +++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index c1102bf4cd8d..9d9dc9c32083 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/t10-pi.h>
 
 #include "blk.h"
 
@@ -54,6 +55,57 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 	return segments;
 }
 
+int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
+		     struct logical_block_metadata_cap __user *argp)
+{
+	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
+	struct logical_block_metadata_cap meta_cap = {};
+	size_t usize = _IOC_SIZE(cmd);
+
+	if (!argp)
+		return -EINVAL;
+	if (usize < LBMD_SIZE_VER0)
+		return -EINVAL;
+	if (!bi)
+		goto out;
+
+	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
+		meta_cap.lbmd_flags |= LBMD_PI_CAP_INTEGRITY;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		meta_cap.lbmd_flags |= LBMD_PI_CAP_REFTAG;
+	meta_cap.lbmd_interval = 1 << bi->interval_exp;
+	meta_cap.lbmd_size = bi->metadata_size;
+	meta_cap.lbmd_pi_size = bi->pi_tuple_size;
+	meta_cap.lbmd_pi_offset = bi->pi_offset;
+	meta_cap.lbmd_opaque_size = bi->metadata_size - bi->pi_tuple_size;
+	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
+		meta_cap.lbmd_opaque_offset = bi->pi_tuple_size;
+
+	meta_cap.lbmd_guard_tag_type = bi->csum_type;
+	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
+		meta_cap.lbmd_app_tag_size = 2;
+
+	if (bi->flags & BLK_INTEGRITY_REF_TAG) {
+		switch (bi->csum_type) {
+		case BLK_INTEGRITY_CSUM_CRC64:
+			meta_cap.lbmd_ref_tag_size =
+				sizeof_field(struct crc64_pi_tuple, ref_tag);
+			break;
+		case BLK_INTEGRITY_CSUM_CRC:
+		case BLK_INTEGRITY_CSUM_IP:
+			meta_cap.lbmd_ref_tag_size =
+				sizeof_field(struct t10_pi_tuple, ref_tag);
+			break;
+		default:
+			break;
+		}
+	}
+
+out:
+	return copy_struct_to_user(argp, usize, &meta_cap, sizeof(meta_cap),
+				   NULL);
+}
+
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
  * @rq:		request to map
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c6..9ad403733e19 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -13,6 +13,7 @@
 #include <linux/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/blk-integrity.h>
 #include <uapi/linux/blkdev.h>
 #include "blk.h"
 #include "blk-crypto-internal.h"
@@ -566,6 +567,9 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 {
 	unsigned int max_sectors;
 
+	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
+		return blk_get_meta_cap(bdev, cmd, argp);
+
 	switch (cmd) {
 	case BLKFLSBUF:
 		return blkdev_flushbuf(bdev, cmd, arg);
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index d27730da47f3..e04c6e5bf1c6 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -29,6 +29,8 @@ int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
+int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
+		     struct logical_block_metadata_cap __user *argp);
 
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -92,6 +94,11 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
 				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
+static inline int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
+				   struct logical_block_metadata_cap __user *argp)
+{
+	return -EOPNOTSUPP;
+}
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 					    struct bio *b)
 {
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0098b0ce8ccb..83720a2fd20d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -91,6 +91,63 @@ struct fs_sysfs_path {
 	__u8			name[128];
 };
 
+/* Protection info capability flags */
+#define	LBMD_PI_CAP_INTEGRITY		(1 << 0)
+#define	LBMD_PI_CAP_REFTAG		(1 << 1)
+
+/* Checksum types for Protection Information */
+#define LBMD_PI_CSUM_NONE		0
+#define LBMD_PI_CSUM_IP			1
+#define LBMD_PI_CSUM_CRC16_T10DIF	2
+#define LBMD_PI_CSUM_CRC64_NVME		4
+
+/* sizeof first published struct */
+#define LBMD_SIZE_VER0			16
+
+/*
+ * Logical block metadata capability descriptor
+ * If the device does not support metadata, all the fields will be zero.
+ * Applications must check lbmd_flags to determine whether metadata is
+ * supported or not.
+ */
+struct logical_block_metadata_cap {
+	/* Bitmask of logical block metadata capability flags */
+	__u32	lbmd_flags;
+	/*
+	 * The amount of data described by each unit of logical block
+	 * metadata
+	 */
+	__u16	lbmd_interval;
+	/*
+	 * Size in bytes of the logical block metadata associated with each
+	 * interval
+	 */
+	__u8	lbmd_size;
+	/*
+	 * Size in bytes of the opaque block tag associated with each
+	 * interval
+	 */
+	__u8	lbmd_opaque_size;
+	/*
+	 * Offset in bytes of the opaque block tag within the logical block
+	 * metadata
+	 */
+	__u8	lbmd_opaque_offset;
+	/* Size in bytes of the T10 PI tuple associated with each interval */
+	__u8	lbmd_pi_size;
+	/* Offset in bytes of T10 PI tuple within the logical block metadata */
+	__u8	lbmd_pi_offset;
+	/* T10 PI guard tag type */
+	__u8	lbmd_guard_tag_type;
+	/* Size in bytes of the T10 PI application tag */
+	__u8	lbmd_app_tag_size;
+	/* Size in bytes of the T10 PI reference tag */
+	__u8	lbmd_ref_tag_size;
+	/* Size in bytes of the T10 PI storage tag */
+	__u8	lbmd_storage_tag_size;
+	__u8	pad;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -247,6 +304,8 @@ struct fsxattr {
  * also /sys/kernel/debug/ for filesystems with debugfs exports
  */
 #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get logical block metadata capability details */
+#define FS_IOC_GETLBMD_CAP		_IOWR(0x15, 2, struct logical_block_metadata_cap)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1


