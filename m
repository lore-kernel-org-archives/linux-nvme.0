Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF26F433D5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzSVBmed9WYVjt5dbtSGKrtqNS44dOqqrQiFxuenj2U=; b=juTRcAdVOctwWdh3IfhQbMxbkM
	cz8MRY7/PSHiiaVLNlKXjYziIJ2Hm0i1Keh+GtoYN4D0IKBrDt9cmE0/PBvkFCYFodobivI87AC4D
	7I8UYRmRllvH0qK8rhHRB1TOcOL97m81tvbQvLLqxVbWJbIj+sCeP+gS8J41dXaauoXwovnUcd4Qc
	TuIde7gP5I//5XQSvzSoq9NimB/CRZGun/XMNLAkMsxAGv+BoCXdbtS1sEeaA1WO7ETQTVkZjAzZn
	MXpWiQi9nsnp/8fiy3bEptCQC0GTN6L8Vb7cfzOuBNsvB6z2Gw00c6r+WGzcmPsWikRshvCYGYgYp
	I03vcMDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVU-00000001nju-1Cez;
	Thu, 16 Apr 2026 00:22:56 +0000
Received: from mail-oo1-xc61.google.com ([2607:f8b0:4864:20::c61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVP-00000001ngE-0Flo
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:52 +0000
Received: by mail-oo1-xc61.google.com with SMTP id 006d021491bc7-6828cffbcd4so188094eaf.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298969; x=1776903769; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzSVBmed9WYVjt5dbtSGKrtqNS44dOqqrQiFxuenj2U=;
        b=Esqvg7WGiwtpYbwHSL6QdP5plRTeaXwsCLzATm9irf3ehV93WytRQbBzAvo07hxem5
         s8/kDx3x6bPh4M75CmudSAp1hXQKK0Vg+FZwrpe1dvdHPEAMNU6eijUiFwKXdOGDa1MO
         OVGlKgmrucRK1s5VerhsYVjcDqOPPq5GCcsNXoPXEA7s+sneWbT2ZyLVdMCz5XiWZVBY
         e2OpPVjUDyw18E3Pp6ti1MaNcFnf76cpvo+vjxMcSZqiwcVepd2poI3aH3EWf0OnHIHc
         Fn6y5XqWofqNCLPVvVmbIyYG0WWV/C9NncHyorv5GDcJWCFWx9yrrog6OoZQXMpmqes2
         KHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298969; x=1776903769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzSVBmed9WYVjt5dbtSGKrtqNS44dOqqrQiFxuenj2U=;
        b=ZaKkOYWZcEB+BUgH2PRjkN6BZhWF7bRbCLZMexLzyAw1Akvrzprt41H3IWmKdZDxso
         Zciy0Xtd6Cs0EcSJKljeuWqoSMni2OIuN0EFzvDdCVIJ3X6HXzwSWSSzYwF8PVt6sVQ4
         ZMmJS82ogbfm1kxurcpV7HCWcpksMuVXDWSrLhRynrKKo8f9jvfdPCF2blSZpB/LfAjA
         5sBRZyZz5uvKufuxbWJMvZ2RMwXSs797g6UznrTN9x1L0AHsprJR7cOGAwBwlfrNZupN
         rfNUeQEO106U3Wy0cpXFK+k+GKxOa5ldu1VisQfFgQiobQO1SVOj5fmTTza8+TG/RKjk
         YCew==
X-Forwarded-Encrypted: i=1; AFNElJ9MunPl+cFluK+v8FM+xAS1/inbBeA0KcHmHKNK7oDyq36FAShDbwYVQ+sRD02e3HBwOW2BliUDlukC@lists.infradead.org
X-Gm-Message-State: AOJu0YzYv1XzH72OqK71lCHtzOToVulRSXI8jl2PS5LshdEGf92lyPGM
	icjRNPfYSal6Pi8b7oiIb6ead0lPyMKCKa/KrloUTQqXSEHvOPeMiLYV67yJrsGtkf4UTKma+CV
	YlOYlB3x3V7ETCTPr1mqrhkAVmlSxJRjoW7IJUFFWOGsFdHtO4mw8
X-Gm-Gg: AeBDievugZ2eM3Is3k+9bSopykQ7kayusOGCiZWOsxO2E4EVO7LYIvDn6Q73fSBU/Y5
	wNSeTle+5+K+jTOB0EaK6mCMyU6ZuJ2A9iPaa8T/uJH6ctfoI65/Vx8bujfaIR0XR6xDC5VS9Dc
	sxPSmlEtpagTdEKmXcQ9w0szHAy1vUcnkZg/WfjajnpEHicDvaXt6tFV6dBr3wPb1fWIjqAzDbS
	PYTI4w3xGaN/d3GQLzARFS3ddp+6X+dLAB4ActzQOcITJlwRRwdcpR2guW3hKRL25qS6/ysrDfo
	sXTkcjw8QxYIJvbzJy58YFHKlDxwZGf00IWMaHDyQEKzMoxjWbj/Zy9WrON/kgi4ftBevJwMuml
	686heKl18dJvazEXMKmS4WYXUOtSQLlg0QvxnXRgjUjTtEDT3gQ==
X-Received: by 2002:a05:6820:488c:b0:67c:3021:908a with SMTP id 006d021491bc7-69456aa5cd1mr88818eaf.3.1776298968643;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6932ac7f504sm219057eaf.9.2026.04.15.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8BA1E3422C2;
	Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 80EF3E41B93; Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
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
Subject: [PATCH v2 6/6] blk-integrity: avoid sector_t in bip_{get,set}_seed()
Date: Wed, 15 Apr 2026 18:22:14 -0600
Message-ID: <20260416002214.2048150-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172251_118458_AA0D8178 
X-CRM114-Status: GOOD (  17.66  )
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
struct blk_integrity and struct bio instead to bip_set_seed() and
convert the bio's device address to integrity intervals.

Open-code the access to bip->bip_iter.bi_sector in the one caller of
bip_set_seed() that doesn't use the bio device address for the seed.
Open-code bip_get_seed() in its one caller.

Add a comment to struct bvec_iter's bi_sector field explaining its
alternate use for bip_iter.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 block/bio-integrity.c               |  5 ++---
 block/t10-pi.c                      |  2 +-
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 14 ++++++++++++++
 include/linux/bvec.h                |  1 +
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3ad6a6799f17..e9ae5db99f64 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -103,13 +103,12 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 
-	bip_set_seed(bip, seed);
+	bip_set_seed(bip, bi, bio);
 
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
index f2d9e8901df4..2c4b312f2f55 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-		     (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bi, bio);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1087d1d17c36..4e0fa91a08fd 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-				  (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bi, bio);
 
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
index 825d777c078b..3a2e55e809c5 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -85,10 +85,24 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
+/**
+ * bip_set_seed - Set bip reference tag seed from bio device address
+ * @bip:	struct bio_integrity_payload whose ref tag seed to set
+ * @bi:		struct blk_integrity profile for device
+ * @bio:	struct bio whose device address to use for the ref tag seed
+ */
+static inline void bip_set_seed(struct bio_integrity_payload *bip,
+				const struct blk_integrity *bi,
+				const struct bio *bio)
+{
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


