Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B3C7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmMOYmQm36AfFR2PiBgH1bfR0Zfit3a8B/IEd61TVHE=; b=aaUTK1PlzfYXf7dTSsx3MbY9tS
	ki18zqKS3Fy5jLjrOdwkRMafLTrdkbWWyE82oGv0W1VLI5L3TwnS0hwN1dqVGLQ2AHSw4NDyNrueC
	KQFHyx/eyHtBYPoJ5Y7jetMXLKAfraVwbuTg1TuWx+EIIuhN/dkhFjD+xVfvbV69R/UtjAtfrH1n+
	LTp82B2Imy9iBH7E0aGHacwLa/vgT1rUnfr1v/LNU2A86sceqbVPKkac0tWxCCmXScGIlCJNQ93EY
	rNQ1tXsimruJNhRHc6x6lBWeIf7XNt2wl2m4ZD23JHeIID90ebVUkLMN47Q+eGC9JXj5HIs7y4mCE
	SKUBXpgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRljD-000000097b7-3b4f;
	Wed, 18 Jun 2025 05:52:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRljA-000000097XJ-3aMB
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 05:52:54 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250618055246epoutp035d04cf6841dfba047ab5faa9bb3e026b~KDT5GWVnh2651726517epoutp03B
	for <linux-nvme@lists.infradead.org>; Wed, 18 Jun 2025 05:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250618055246epoutp035d04cf6841dfba047ab5faa9bb3e026b~KDT5GWVnh2651726517epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750225966;
	bh=PmMOYmQm36AfFR2PiBgH1bfR0Zfit3a8B/IEd61TVHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0tXEcFcvhKRYTr9thsa3e03yfFgf79PMpuccwtQD2zw2vbgTAwELUKFoqwDU4oCE
	 DXKzF6rrYGmDYm9N0eFFfS3oU3Pcsr4hd4/OuDoa4z4igORQLV4gjVpZJMsgk3rOGy
	 CS6mAy+pUoxXhftB1wwDCc5GWiP29fTKsY910HbI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250618055245epcas5p28b87af47205e7ca34d8628857c1a0430~KDT4qHkEz2190621906epcas5p2u;
	Wed, 18 Jun 2025 05:52:45 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.177]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bMXvc0Xxkz6B9mV; Wed, 18 Jun
	2025 05:52:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250618055213epcas5p32ccbe13f8ed11ffa0beddaddb9a51595~KDTaHV5jB2512525125epcas5p3H;
	Wed, 18 Jun 2025 05:52:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618055210epsmtip25598d7d450ccdfee96746e9ffa09bacb~KDTX_67fQ3171631716epsmtip2a;
	Wed, 18 Jun 2025 05:52:10 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v4 1/4] block: rename tuple_size field in
 blk_integrity to metadata_size
Date: Wed, 18 Jun 2025 11:21:50 +0530
Message-Id: <20250618055153.48823-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618055153.48823-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618055213epcas5p32ccbe13f8ed11ffa0beddaddb9a51595
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618055213epcas5p32ccbe13f8ed11ffa0beddaddb9a51595
References: <20250618055153.48823-1-anuj20.g@samsung.com>
	<CGME20250618055213epcas5p32ccbe13f8ed11ffa0beddaddb9a51595@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_225253_209024_ABB5EE59 
X-CRM114-Status: GOOD (  20.39  )
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

The tuple_size field in blk_integrity currently represents the total
size of metadata associated with each data interval. To make the meaning
more explicit, rename tuple_size to metadata_size. This is a purely
mechanical rename with no functional changes.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity-auto.c        |  4 ++--
 block/blk-integrity.c             |  2 +-
 block/blk-settings.c              |  6 +++---
 block/t10-pi.c                    | 16 ++++++++--------
 drivers/md/dm-crypt.c             |  4 ++--
 drivers/md/dm-integrity.c         | 12 ++++++------
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  2 +-
 include/linux/blk-integrity.h     |  4 ++--
 include/linux/blkdev.h            |  2 +-
 12 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 9c6657664792..687952f63bbb 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -54,10 +54,10 @@ static bool bi_offload_capable(struct blk_integrity *bi)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		return bi->tuple_size == sizeof(struct crc64_pi_tuple);
+		return bi->metadata_size == sizeof(struct crc64_pi_tuple);
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		return bi->tuple_size == sizeof(struct t10_pi_tuple);
+		return bi->metadata_size == sizeof(struct t10_pi_tuple);
 	default:
 		pr_warn_once("%s: unknown integrity checksum type:%d\n",
 			__func__, bi->csum_type);
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9..c1102bf4cd8d 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -239,7 +239,7 @@ static ssize_t format_show(struct device *dev, struct device_attribute *attr,
 {
 	struct blk_integrity *bi = dev_to_bi(dev);
 
-	if (!bi->tuple_size)
+	if (!bi->metadata_size)
 		return sysfs_emit(page, "none\n");
 	return sysfs_emit(page, "%s\n", blk_integrity_profile_name(bi));
 }
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..787500ff00c3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -114,7 +114,7 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 {
 	struct blk_integrity *bi = &lim->integrity;
 
-	if (!bi->tuple_size) {
+	if (!bi->metadata_size) {
 		if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE ||
 		    bi->tag_size || ((bi->flags & BLK_INTEGRITY_REF_TAG))) {
 			pr_warn("invalid PI settings.\n");
@@ -875,7 +875,7 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 		return true;
 
 	if (ti->flags & BLK_INTEGRITY_STACKED) {
-		if (ti->tuple_size != bi->tuple_size)
+		if (ti->metadata_size != bi->metadata_size)
 			goto incompatible;
 		if (ti->interval_exp != bi->interval_exp)
 			goto incompatible;
@@ -891,7 +891,7 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 		ti->flags |= (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) |
 			     (bi->flags & BLK_INTEGRITY_REF_TAG);
 		ti->csum_type = bi->csum_type;
-		ti->tuple_size = bi->tuple_size;
+		ti->metadata_size = bi->metadata_size;
 		ti->pi_offset = bi->pi_offset;
 		ti->interval_exp = bi->interval_exp;
 		ti->tag_size = bi->tag_size;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 851db518ee5e..0c4ed9702146 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -56,7 +56,7 @@ static void t10_pi_generate(struct blk_integrity_iter *iter,
 			pi->ref_tag = 0;
 
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 }
@@ -105,7 +105,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 next:
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 
@@ -125,7 +125,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 static void t10_pi_type1_prepare(struct request *rq)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
@@ -177,7 +177,7 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
 	unsigned intervals = nr_bytes >> bi->interval_exp;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
@@ -234,7 +234,7 @@ static void ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 			put_unaligned_be48(0ULL, pi->ref_tag);
 
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 }
@@ -289,7 +289,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 
 next:
 		iter->data_buf += iter->interval;
-		iter->prot_buf += bi->tuple_size;
+		iter->prot_buf += bi->metadata_size;
 		iter->seed++;
 	}
 
@@ -299,7 +299,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 static void ext_pi_type1_prepare(struct request *rq)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
@@ -340,7 +340,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
 	unsigned intervals = nr_bytes >> bi->interval_exp;
-	const int tuple_sz = bi->tuple_size;
+	const int tuple_sz = bi->metadata_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
 	u8 offset = bi->pi_offset;
 	struct bio *bio;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 9dfdb63220d7..3d6d06b94c9f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1189,11 +1189,11 @@ static int crypt_integrity_ctr(struct crypt_config *cc, struct dm_target *ti)
 		return -EINVAL;
 	}
 
-	if (bi->tuple_size < cc->used_tag_size) {
+	if (bi->metadata_size < cc->used_tag_size) {
 		ti->error = "Integrity profile tag size mismatch.";
 		return -EINVAL;
 	}
-	cc->tuple_size = bi->tuple_size;
+	cc->tuple_size = bi->metadata_size;
 	if (1 << bi->interval_exp != cc->sector_size) {
 		ti->error = "Integrity profile sector size mismatch.";
 		return -EINVAL;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 4395657fa583..efeee0a873c0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3906,8 +3906,8 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		struct blk_integrity *bi = &limits->integrity;
 
 		memset(bi, 0, sizeof(*bi));
-		bi->tuple_size = ic->tag_size;
-		bi->tag_size = bi->tuple_size;
+		bi->metadata_size = ic->tag_size;
+		bi->tag_size = bi->metadata_size;
 		bi->interval_exp =
 			ic->sb->log2_sectors_per_block + SECTOR_SHIFT;
 	}
@@ -4746,18 +4746,18 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 			ti->error = "Integrity profile not supported";
 			goto bad;
 		}
-		/*printk("tag_size: %u, tuple_size: %u\n", bi->tag_size, bi->tuple_size);*/
-		if (bi->tuple_size < ic->tag_size) {
+		/*printk("tag_size: %u, metadata_size: %u\n", bi->tag_size, bi->metadata_size);*/
+		if (bi->metadata_size < ic->tag_size) {
 			r = -EINVAL;
 			ti->error = "The integrity profile is smaller than tag size";
 			goto bad;
 		}
-		if ((unsigned long)bi->tuple_size > PAGE_SIZE / 2) {
+		if ((unsigned long)bi->metadata_size > PAGE_SIZE / 2) {
 			r = -EINVAL;
 			ti->error = "Too big tuple size";
 			goto bad;
 		}
-		ic->tuple_size = bi->tuple_size;
+		ic->tuple_size = bi->metadata_size;
 		if (1 << bi->interval_exp != ic->sectors_per_block << SECTOR_SHIFT) {
 			r = -EINVAL;
 			ti->error = "Integrity profile sector size mismatch";
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 423dcd190906..2a1aa32e6693 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1506,7 +1506,7 @@ static int btt_blk_init(struct btt *btt)
 	int rc;
 
 	if (btt_meta_size(btt) && IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY)) {
-		lim.integrity.tuple_size = btt_meta_size(btt);
+		lim.integrity.metadata_size = btt_meta_size(btt);
 		lim.integrity.tag_size = btt_meta_size(btt);
 	}
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..b027dda38e69 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1866,7 +1866,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		break;
 	}
 
-	bi->tuple_size = head->ms;
+	bi->metadata_size = head->ms;
 	bi->pi_offset = info->pi_offset;
 	return true;
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index eba42df2f821..42fb19f94ab8 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -65,7 +65,7 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 		return;
 
 	if (bi->csum_type == BLK_INTEGRITY_CSUM_CRC) {
-		ns->metadata_size = bi->tuple_size;
+		ns->metadata_size = bi->metadata_size;
 		if (bi->flags & BLK_INTEGRITY_REF_TAG)
 			ns->pi_type = NVME_NS_DPS_PI_TYPE1;
 		else
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index ae6ce6f5d622..18bfca1f1c78 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -52,7 +52,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp, struct queue_limits *lim)
 	if (type != T10_PI_TYPE3_PROTECTION)
 		bi->flags |= BLK_INTEGRITY_REF_TAG;
 
-	bi->tuple_size = sizeof(struct t10_pi_tuple);
+	bi->metadata_size = sizeof(struct t10_pi_tuple);
 
 	if (dif && type) {
 		bi->flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c7eae0bfb013..d27730da47f3 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -33,7 +33,7 @@ int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
 {
-	return q->limits.integrity.tuple_size;
+	return q->limits.integrity.metadata_size;
 }
 
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
@@ -74,7 +74,7 @@ static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
-	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
+	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
 static inline bool blk_integrity_rq(struct request *rq)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a59880c809c7..ccda87d06a38 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -116,7 +116,7 @@ enum blk_integrity_checksum {
 struct blk_integrity {
 	unsigned char				flags;
 	enum blk_integrity_checksum		csum_type;
-	unsigned char				tuple_size;
+	unsigned char				metadata_size;
 	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
-- 
2.25.1


