Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985D3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZqqaYvLLm7nlkYYFWJXBen8SmfxRo+OGjemEa1gtfU=; b=FBbu8UpiXL+g3kHC/1j+s00Bxb
	mfby6WgYNGiLOt7if+qRvHUzBU9NIqqtP53ohHSyFT98J0Fw5e5+5w0QG/hm36h7bnLYqXvnQoxgE
	8aDQ67KKAz7Lpp8jKNxgqxyFCH1eL8+x1KpXuKQ4RSaWwp+WpnKmrFaVIOIZV+B9TnwIpNP7xPVZG
	6UtQH4VXw+0hkj0iWgDNXrjCE5DvLFtJ13keHnc78PpAeJhxv0WozyUOOmEO5QUqfeOZZbHO3PZVv
	bDx4fj+svvstBeke+60gJNkcMRDY/JCGb7oxUywTBEHkPdHhkWV9iU6u9cgJV0dc5UoKOjdDHfUxJ
	tbjrIR+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyQk-00DTFC-3b; Tue, 01 Feb 2022 19:03:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPL-00DShs-Vl
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AFDA8B82F6F;
 Tue,  1 Feb 2022 19:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8C5C340ED;
 Tue,  1 Feb 2022 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742098;
 bh=X74BnOg4IqWFvwMGEZm0zB6g12VahyiocXPpi50JsKY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CRRqNDjjYZhgwQtE7XZ8/vIlNgBt61b7qpm9gneiXK9qdpGcBLMPfVDTOZ27iu10C
 skPHcuhlFXf138w4PoPrdQpoieVNduSp8u/oogwSVSGqRTiEusEqA+ctk/n4rzvUH4
 8if3/XAjqjmHzZt1Bb/LI+u3YCf6FKHMIDenJWG8FKlsLumZtYf/1hRi5AkqVXGYRu
 T/OKzDUxMWFWu8xo+mTsU+zrU5cAqIB3VQf3T89lvViTFGJoCpqwnxSh6iEC1C26sW
 ZwMm0Ss0Bz62DxQzS8yS4lJ/t4XZ6ykuESW7ERDtGCUUDC5E3BAfeWfWLQ/Q6B8/tp
 1ZSqV4gIZ0+NQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 6/7] block: add pi for nvme enhanced integrity
Date: Tue,  1 Feb 2022 11:01:27 -0800
Message-Id: <20220201190128.3075065-7-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110140_324624_A9523DC5 
X-CRM114-Status: GOOD (  19.59  )
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

The NVMe specification defines larger data integrity formats beyond the
t10 tuple. Add support for the specification defined CRC64 formats,
assuming the reference tag does not need to be split with the "storage
tag".

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/Kconfig          |   1 +
 block/t10-pi.c         | 194 +++++++++++++++++++++++++++++++++++++++++
 include/linux/t10-pi.h |  20 +++++
 3 files changed, 215 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 205f8d01c695..e3ce9196ad07 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -75,6 +75,7 @@ config BLK_DEV_INTEGRITY_T10
 	tristate
 	depends on BLK_DEV_INTEGRITY
 	select CRC_T10DIF
+	select CRC64
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 758a76518854..7bfefe970bc5 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -7,8 +7,10 @@
 #include <linux/t10-pi.h>
 #include <linux/blk-integrity.h>
 #include <linux/crc-t10dif.h>
+#include <linux/crc64.h>
 #include <linux/module.h>
 #include <net/checksum.h>
+#include <asm/unaligned.h>
 
 typedef __be16 (csum_fn) (void *, unsigned int);
 
@@ -278,4 +280,196 @@ const struct blk_integrity_profile t10_pi_type3_ip = {
 };
 EXPORT_SYMBOL(t10_pi_type3_ip);
 
+static __be64 nvme_pi_crc64(void *data, unsigned int len)
+{
+	return cpu_to_be64(crc64_rocksoft(~0ULL, data, len));
+}
+
+static blk_status_t nvme_crc64_generate(struct blk_integrity_iter *iter,
+					enum t10_dif_type type)
+{
+	unsigned int i;
+
+	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
+		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
+
+		pi->guard_tag = nvme_pi_crc64(iter->data_buf, iter->interval);
+		pi->app_tag = 0;
+
+		if (type == T10_PI_TYPE1_PROTECTION)
+			put_unaligned_be48(iter->seed, pi->ref_tag);
+		else
+			put_unaligned_be48(0ULL, pi->ref_tag);
+
+		iter->data_buf += iter->interval;
+		iter->prot_buf += iter->tuple_size;
+		iter->seed++;
+	}
+
+	return BLK_STS_OK;
+}
+
+static bool nvme_crc64_ref_escape(u8 *ref_tag)
+{
+	static u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) == 0;
+}
+
+static blk_status_t nvme_crc64_verify(struct blk_integrity_iter *iter,
+				      enum t10_dif_type type)
+{
+	unsigned int i;
+
+	for (i = 0; i < iter->data_size; i += iter->interval) {
+		struct nvme_crc64_pi_tuple *pi = iter->prot_buf;
+		u64 ref, seed;
+		__be64 csum;
+
+		if (type == T10_PI_TYPE1_PROTECTION) {
+			if (pi->app_tag == T10_PI_APP_ESCAPE)
+				goto next;
+
+			ref = get_unaligned_be48(pi->ref_tag);
+			seed = iter->seed & 0xffffffffffffull;
+			if (ref != seed) {
+				pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
+					iter->disk_name, seed, ref);
+				return BLK_STS_PROTECTION;
+			}
+		} else if (type == T10_PI_TYPE3_PROTECTION) {
+			if (pi->app_tag == T10_PI_APP_ESCAPE &&
+			    nvme_crc64_ref_escape(pi->ref_tag))
+				goto next;
+		}
+
+		csum = nvme_pi_crc64(iter->data_buf, iter->interval);
+		if (pi->guard_tag != csum) {
+			pr_err("%s: guard tag error at sector %llu " \
+			       "(rcvd %016llx, want %016llx)\n",
+				iter->disk_name, (unsigned long long)iter->seed,
+				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
+			return BLK_STS_PROTECTION;
+		}
+
+next:
+		iter->data_buf += iter->interval;
+		iter->prot_buf += iter->tuple_size;
+		iter->seed++;
+	}
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t nvme_pi_type1_verify_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_verify(iter, T10_PI_TYPE1_PROTECTION);
+}
+
+static blk_status_t nvme_pi_type1_generate_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_generate(iter, T10_PI_TYPE1_PROTECTION);
+}
+
+static void nvme_pi_type1_prepare(struct request *rq)
+{
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u64 virt = bip_get_seed(bip) & 0xffffffffffffull;
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		/* Already remapped? */
+		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
+			break;
+
+		bip_for_each_vec(iv, bip, iter) {
+			unsigned int j;
+			void *p;
+
+			p = bvec_kmap_local(&iv);
+			for (j = 0; j < iv.bv_len; j += tuple_sz) {
+				struct nvme_crc64_pi_tuple *pi = p;
+				u64 ref = get_unaligned_be48(pi->ref_tag);
+
+				if (ref == virt)
+					put_unaligned_be48(ref_tag, pi->ref_tag);
+				virt++;
+				ref_tag++;
+				p += tuple_sz;
+			}
+			kunmap_local(p);
+		}
+
+		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
+	}
+}
+
+static void nvme_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
+{
+	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u64 ref_tag = nvme_pi_extended_ref_tag(rq);
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u64 virt = bip_get_seed(bip) & 0xffffffffffffull;
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		bip_for_each_vec(iv, bip, iter) {
+			unsigned int j;
+			void *p;
+
+			p = bvec_kmap_local(&iv);
+			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
+				struct nvme_crc64_pi_tuple *pi = p;
+				u64 ref = get_unaligned_be48(pi->ref_tag);
+
+				if (ref == ref_tag)
+					put_unaligned_be48(virt, pi->ref_tag);
+				virt++;
+				ref_tag++;
+				intervals--;
+				p += tuple_sz;
+			}
+			kunmap_local(p);
+		}
+	}
+}
+
+static blk_status_t nvme_pi_type3_verify_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_verify(iter, T10_PI_TYPE3_PROTECTION);
+}
+
+static blk_status_t nvme_pi_type3_generate_crc(struct blk_integrity_iter *iter)
+{
+	return nvme_crc64_generate(iter, T10_PI_TYPE3_PROTECTION);
+}
+
+const struct blk_integrity_profile nvme_pi_type1_crc64 = {
+	.name			= "NVME-DIF-TYPE1-CRC64",
+	.generate_fn		= nvme_pi_type1_generate_crc,
+	.verify_fn		= nvme_pi_type1_verify_crc,
+	.prepare_fn		= nvme_pi_type1_prepare,
+	.complete_fn		= nvme_pi_type1_complete,
+};
+EXPORT_SYMBOL(nvme_pi_type1_crc64);
+
+const struct blk_integrity_profile nvme_pi_type3_crc64 = {
+	.name			= "NVME-DIF-TYPE3-CRC64",
+	.generate_fn		= nvme_pi_type3_generate_crc,
+	.verify_fn		= nvme_pi_type3_verify_crc,
+	.prepare_fn		= t10_pi_type3_prepare,
+	.complete_fn		= t10_pi_type3_complete,
+};
+EXPORT_SYMBOL(nvme_pi_type3_crc64);
+
+MODULE_LICENSE("GPL");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index c635c2e014e3..fd3a9b99500a 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -53,4 +53,24 @@ extern const struct blk_integrity_profile t10_pi_type1_ip;
 extern const struct blk_integrity_profile t10_pi_type3_crc;
 extern const struct blk_integrity_profile t10_pi_type3_ip;
 
+struct nvme_crc64_pi_tuple {
+	__be64 guard_tag;
+	__be16 app_tag;
+	__u8   ref_tag[6];
+};
+
+static inline u64 nvme_pi_extended_ref_tag(struct request *rq)
+{
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (rq->q->integrity.interval_exp)
+		shift = rq->q->integrity.interval_exp;
+#endif
+	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffffffffull;
+}
+
+extern const struct blk_integrity_profile nvme_pi_type1_crc64;
+extern const struct blk_integrity_profile nvme_pi_type3_crc64;
+
 #endif
-- 
2.25.4


