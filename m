Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8545F8E49F
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g++H+r0qfX5K115kzK83mAIHId7HSerOrnUwj7zT4F8=; b=U66P7JQlL4ulg3WevBTSy5TWM8
	HAM594W60G6ZoMBsjjjccwkiD565eQ1HJez6snXaNR9ju2tCgIxOE1dXHW2E49LhPIXjCeTr8gJS/
	oyHbkts0gpSE4a35bWqrJRvFUy7zWakW9haPwpm9eEFJvvFgpnRKF0oKaik2oDx6Y45+jk+QKZ1j/
	fU7BKBAVJMFu/V0XmfeQsp1dYvkXBCIv6AkU6QbifWyvqPlPS8XPq3sHQ/b7JOM27KtyVHjY3hzp7
	xuCHnp22vhvN4/bublwoL6MDeuGhYmAMW51SJzJTQdoUJ1UxxWhKb6kRbi/duEt1ecJbckjMgC6Z+
	r2ARAorA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSn-00000003IGI-3Nws;
	Fri, 17 Apr 2026 01:57:45 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSj-00000003IDy-4809
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:44 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-35e4617924eso36881a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g++H+r0qfX5K115kzK83mAIHId7HSerOrnUwj7zT4F8=;
        b=fBZyb+YTiq5tWluZYeYQY5ESKJWcWGLBj5JCKyZyVWHnwSM/2ogoZHFyMzX+0nUNDh
         wDTqCu0lUgQPPz80NJY89F9pV1qPfY0oXht2QOVG/LmnJPXg3Xo10pF2IznmsZ786NQL
         RLr/2wx0kHeIl41lRTuGhQ4KOyEccpgcs6zfhB12NMd2cKGzlGIdZiKIX7Cf8zXxi5rz
         fgl20sa6prOrrGdz9RHYyaPkyClmMdt8mnxr3bGTRCkzeAOOLktDavP3xGZT5vywbVIC
         WCiwSWLUrSJpE5cCrPrfe0kFy889k6jQe6DQlzRy4EBSlFJ3URgWbog7/RfceNIfevwn
         CD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g++H+r0qfX5K115kzK83mAIHId7HSerOrnUwj7zT4F8=;
        b=RfMcKN/eVOPuHOpuvtzJs90d3YpDIwtigFuL2lXCEah4NMOq2ScfbBaCty/mvOBue1
         TuUVvp3S84lWCdcYR6YjWqkhOASLrv/SnHM6AKEHLKBr6U0Gh4lTUMSrk0UKjEFsC4t/
         RW1jfkj583BAwa1mIhKRNPBFNefPRapp8Iw0E79o/GkqHx6M0+TvJQRt5A21wf/4ihIH
         g/ITq8XTgf0+7HRE2TDQwbbi+pcKMf9IsoGdKSoFSHnpVGYdtJqeF31xLxtrE0omiOWj
         T0xqULZ++2/MlQU8BE2pjG4GOwwbM09hU5D99Riif5jc0CcVJxSaF6uksRGCk1hpbBXY
         DzAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CeQ55x8H3QdB9Qo66fAsIeho1yesTzsYQeDu6EzkzDIAyN0GxqATWUX87qfZEmOkYZUk7G+il8qCQ@lists.infradead.org
X-Gm-Message-State: AOJu0YypidSMhYDxazgY12vu2fQ86E4oGrdvjqy0rllrdmP8VVjZ2XbK
	rqpFCch7eV9dXENC6mgZMoK7rCrXi9CD73Gao8ASI+AC+oPOoIHTuxhtopuHVdo1w2/pqFmVBHH
	udW1UXwXIfhXfBYaaTuEzUDvL7lDkYf9GSdRVWRcMB918tztAczAa
X-Gm-Gg: AeBDievIzIKQpg6l2hUcF4GmKcWuAwrE/Ez8yc19z7aNOkURsbF0FUrDmZMkl2uoXvD
	ptzlxVUay7heWgrnZeWa0e4KHLU4P1hcu8HrCCWI1zoo0PUJBAkexyhw5MzYzuN7ysKFtH3Jgci
	v1DtGeDGlFpHkPTwv/zmYHYQzCCvnFeFV6+sxuj560gylUjLPw6hj2+3ME7wAjCjTfT1bgzhxgz
	Y59pCFmYvK6xb5gR4xB3S3oaU6DuszFm3I4mHMfKb3lEE4VqabL8ddAZo45+TpGfbGR1zuyIoME
	dhz1EW0HeKiG73okM2y0W1PtxgR5p6+flgpdQ2ISz5flW3dKnet94QdTnz9oXZG5bsaSCl1ZFrp
	mY6MMbDPcDT4UsYAPGi2p29w8lhiWjm8Ttlxrv5eeZ6EQLu/Avg==
X-Received: by 2002:a17:90b:268b:b0:35f:b47e:7225 with SMTP id 98e67ed59e1d1-361404991ecmr456269a91.6.1776391061376;
        Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-361410a19d3sm38091a91.7.2026.04.16.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8FFA0341D23;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8601FE499D2; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 6/6] blk-integrity: avoid sector_t in bip_{get,set}_seed()
Date: Thu, 16 Apr 2026 19:57:32 -0600
Message-ID: <20260417015732.2692434-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185742_027705_101E961C 
X-CRM114-Status: GOOD (  17.62  )
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

bip_set_seed() and big_get_seed() take/return a sector_t value that's
actually an integrity interval number. This is confusing, so pass
struct bio instead to bip_set_seed() and convert the bio's device
address to integrity intervals.

Open-code the access to bip->bip_iter.bi_sector in the one caller of
bip_set_seed() that doesn't use the bio device address for the seed.
Open-code bip_get_seed() in its one caller.

Add a comment to struct bvec_iter's bi_sector field explaining its
alternate use for bip_iter.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c               |  5 ++---
 block/t10-pi.c                      |  2 +-
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 13 +++++++++++++
 include/linux/bvec.h                |  1 +
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3ad6a6799f17..8549d9148b0b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -103,13 +103,12 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 
-	bip_set_seed(bip, seed);
+	bip_set_seed(bio);
 
 	if (bi->csum_type) {
 		bip->bip_flags |= BIP_CHECK_GUARD;
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bip->bip_flags |= BIP_IP_CHECKSUM;
@@ -472,11 +471,11 @@ int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
 
 	it.count = integrity_bytes;
 	ret = bio_integrity_map_user(bio, &it);
 	if (!ret) {
 		bio_uio_meta_to_bip(bio, meta);
-		bip_set_seed(bio_integrity(bio), meta->seed);
+		bio_integrity(bio)->bip_iter.bi_sector = meta->seed;
 		iov_iter_advance(&meta->iter, integrity_bytes);
 		meta->seed += bio_integrity_intervals(bi, bio_sectors(bio));
 	}
 	return ret;
 }
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 787950dec50a..71367fd082bd 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -510,11 +510,11 @@ static void blk_reftag_remap_prepare(struct blk_integrity *bi,
 static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 			       unsigned *intervals, u64 *ref, bool prep)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bvec_iter iter = bip->bip_iter;
-	u64 virt = bip_get_seed(bip);
+	u64 virt = bip->bip_iter.bi_sector;
 	union pi_tuple *ptuple;
 	union pi_tuple tuple;
 
 	if (prep && bip->bip_flags & BIP_MAPPED_INTEGRITY) {
 		*ref += bio->bi_iter.bi_size >> bi->interval_exp;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..65fce51b024a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-		     (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bio);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1087d1d17c36..1aeb5be529a8 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-				  (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bio);
 
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index af5178434ec6..edcd0855abba 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -56,21 +56,10 @@ static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
 		return bip->bip_flags & flag;
 
 	return false;
 }
 
-static inline sector_t bip_get_seed(struct bio_integrity_payload *bip)
-{
-	return bip->bip_iter.bi_sector;
-}
-
-static inline void bip_set_seed(struct bio_integrity_payload *bip,
-				sector_t seed)
-{
-	bip->bip_iter.bi_sector = seed;
-}
-
 void bio_integrity_init(struct bio *bio, struct bio_integrity_payload *bip,
 		struct bio_vec *bvecs, unsigned int nr_vecs);
 struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 		unsigned int nr);
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 825d777c078b..c82b2f6fe194 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -85,10 +85,23 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
+/**
+ * bip_set_seed - Set bip reference tag seed from bio device address
+ * @bio:	struct bio whose integrity payload's ref tag seed to initialize
+ */
+static inline void bip_set_seed(struct bio *bio)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	bip->bip_iter.bi_sector =
+		bio_integrity_intervals(bi, bio->bi_iter.bi_sector);
+}
+
 static inline bool blk_integrity_rq(const struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
 }
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d36dd476feda..3dc88f5cd367 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -76,10 +76,11 @@ static inline void bvec_set_virt(struct bio_vec *bv, void *vaddr,
 
 struct bvec_iter {
 	/*
 	 * Current device address in 512 byte sectors. Only updated by the bio
 	 * iter wrappers and not the bvec iterator helpers themselves.
+	 * For bip_iter, this is overloaded to represent the integrity interval.
 	 */
 	sector_t		bi_sector;
 
 	/*
 	 * Remaining size in bytes.
-- 
2.45.2


