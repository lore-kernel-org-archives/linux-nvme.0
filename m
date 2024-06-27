Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DBC2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PrcEO1vdOL3Ccf1DejRfz8kdMHtxupuDPQq8o4Ezxrk=; b=qla499Yfuob7HSv1+3QOkCflhu
	gXQsA8A1tMvMrrsXazXElty8WKNQQJDH+UkDRHDexaDyFuqjSsb7hsDdkVvUUJnxX8AUBq8y4J0jC
	uE6Cd6CKTXOJu01fwdqU/myuJ0Ld2RY9pTs+bDwfRGRUztayWR7cbllEreVEkFDCx9+fm/Ud32wq5
	TkGePgrYt4zzQyayZWbOp4Pl7rKeV+e9Otrksb6kl89pr0DlAPdfTxgL/OegjwWJj534OEZg/jwso
	JmXlTkrn41eKaMbtQV39qYb+pa/+qYfeI+EN7xmBSLR5j0/4E/erwKoiNy9O+DuAmKLIpaVSXyoN8
	PEbmOrHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnwr-0000000AHcW-34O2;
	Thu, 27 Jun 2024 12:09:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnwe-0000000AHYH-04Mm
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 12:09:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC68F68BFE; Thu, 27 Jun 2024 14:09:33 +0200 (CEST)
Date: Thu, 27 Jun 2024 14:09:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 05/10] block: introduce BIP_CLONED flag
Message-ID: <20240627120933.GA8620@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101519epcas5p163b0735c1604a228196f0e8c14773005@epcas5p1.samsung.com> <20240626100700.3629-6-anuj20.g@samsung.com> <20240627062142.GC16047@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627062142.GC16047@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_050945_235115_9C92194C 
X-CRM114-Status: GOOD (  28.24  )
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

On Thu, Jun 27, 2024 at 08:21:42AM +0200, Christoph Hellwig wrote:
> this is probably best done by moving the bip_flags checks out of
> bio_integrity_free and have bio_integrity_free just do the
> unconditional freeing, and have a new helper for
> __bio_integrity_endio / bio_integrity_verify_fn to also
> free the payload.

Something like the patch below, against my "integrity cleanups" series
from yesterday.  Lightly tested.

---
From f312de8ae5e329569c4810ddf977195e997e03ec Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 27 Jun 2024 13:25:28 +0200
Subject: block: don't free submitter owned integrity payload on I/O completion

Currently __bio_integrity_endio unconditionally frees the integrity
payload.  While this works really well for block-layer generated
integrity payloads, it is a bad idea for those passed in by the
submitter, as it can't access the integrity data from the I/O completion
handler.

Change bio_integrity_endio to only call __bio_integrity_endio for
block layer generated integrity data, and leave freeing of submitter
allocated integrity data to bio_uninit which also gets called from
the final bio_put.  This requires that unmapping user mapped or copied
integrity data is done by the caller now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 68 ++++++++++++++++++++-----------------------
 block/blk-map.c       |  3 ++
 block/blk.h           |  4 ++-
 include/linux/bio.h   |  4 +--
 4 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 20bbfd5730dadd..d21ad6624f0062 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -22,9 +22,17 @@ void blk_flush_integrity(void)
 	flush_workqueue(kintegrityd_wq);
 }
 
-static void __bio_integrity_free(struct bio_set *bs,
-				 struct bio_integrity_payload *bip)
+/**
+ * bio_integrity_free - Free bio integrity payload
+ * @bio:	bio containing bip to be freed
+ *
+ * Description: Free the integrity portion of a bio.
+ */
+void bio_integrity_free(struct bio *bio)
 {
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bio_set *bs = bio->bi_pool;
+
 	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
 		if (bip->bip_vec)
 			bvec_free(&bs->bvec_integrity_pool, bip->bip_vec,
@@ -33,6 +41,8 @@ static void __bio_integrity_free(struct bio_set *bs,
 	} else {
 		kfree(bip);
 	}
+	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 
 /**
@@ -49,19 +59,21 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 						  gfp_t gfp_mask,
 						  unsigned int nr_vecs)
 {
-	struct bio_integrity_payload *bip;
 	struct bio_set *bs = bio->bi_pool;
+	bool has_mempool = bs && mempool_initialized(&bs->bio_integrity_pool);
+	struct bio_integrity_payload *bip;
 	unsigned inline_vecs;
 
 	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
-		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
-		inline_vecs = nr_vecs;
-	} else {
+	if (has_mempool) {
 		bip = mempool_alloc(&bs->bio_integrity_pool, gfp_mask);
 		inline_vecs = BIO_INLINE_VECS;
+	} else {
+		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs),
+				gfp_mask);
+		inline_vecs = nr_vecs;
 	}
 
 	if (unlikely(!bip))
@@ -86,7 +98,10 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 
 	return bip;
 err:
-	__bio_integrity_free(bs, bip);
+	if (has_mempool)
+		mempool_free(bip, &bs->bio_integrity_pool);
+	else
+		kfree(bip);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
@@ -118,9 +133,10 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 	bio_integrity_unpin_bvec(copy, nr_vecs, true);
 }
 
-static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
+void bio_integrity_unmap_user(struct bio *bio)
 {
-	bool dirty = bio_data_dir(bip->bip_bio) == READ;
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	bool dirty = bio_data_dir(bio) == READ;
 
 	if (bip->bip_flags & BIP_COPY_USER) {
 		if (dirty)
@@ -131,28 +147,7 @@ static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
 
 	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt, dirty);
 }
-
-/**
- * bio_integrity_free - Free bio integrity payload
- * @bio:	bio containing bip to be freed
- *
- * Description: Used to free the integrity portion of a bio. Usually
- * called from bio_free().
- */
-void bio_integrity_free(struct bio *bio)
-{
-	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct bio_set *bs = bio->bi_pool;
-
-	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
-		kfree(bvec_virt(bip->bip_vec));
-	else if (bip->bip_flags & BIP_INTEGRITY_USER)
-		bio_integrity_unmap_user(bip);
-
-	__bio_integrity_free(bs, bip);
-	bio->bi_integrity = NULL;
-	bio->bi_opf &= ~REQ_INTEGRITY;
-}
+EXPORT_SYMBOL_GPL(bio_integrity_unmap_user);
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
@@ -252,7 +247,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 		goto free_bip;
 	}
 
-	bip->bip_flags |= BIP_INTEGRITY_USER | BIP_COPY_USER;
+	bip->bip_flags |= BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
 	return 0;
 free_bip:
@@ -272,7 +267,6 @@ static int bio_integrity_init_user(struct bio *bio, struct bio_vec *bvec,
 		return PTR_ERR(bip);
 
 	memcpy(bip->bip_vec, bvec, nr_vecs * sizeof(*bvec));
-	bip->bip_flags |= BIP_INTEGRITY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_iter.bi_size = len;
 	return 0;
@@ -479,6 +473,8 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 	struct bio *bio = bip->bip_bio;
 
 	blk_integrity_verify(bio);
+
+	kfree(bvec_virt(bip->bip_vec));
 	bio_integrity_free(bio);
 	bio_endio(bio);
 }
@@ -499,13 +495,13 @@ bool __bio_integrity_endio(struct bio *bio)
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
-	    (bip->bip_flags & BIP_BLOCK_INTEGRITY) && bi->csum_type) {
+	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status && bi->csum_type) {
 		INIT_WORK(&bip->bip_work, bio_integrity_verify_fn);
 		queue_work(kintegrityd_wq, &bip->bip_work);
 		return false;
 	}
 
+	kfree(bvec_virt(bip->bip_vec));
 	bio_integrity_free(bio);
 	return true;
 }
diff --git a/block/blk-map.c b/block/blk-map.c
index 71210cdb34426d..e7fc1f13f6b8d4 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -757,6 +757,9 @@ int blk_rq_unmap_user(struct bio *bio)
 			bio_release_pages(bio, bio_data_dir(bio) == READ);
 		}
 
+		if (bio_integrity(bio))
+			bio_integrity_unmap_user(bio);
+
 		next_bio = bio;
 		bio = bio->bi_next;
 		blk_mq_map_bio_put(next_bio);
diff --git a/block/blk.h b/block/blk.h
index 7917f86cca0ebd..5de7ce11f149b5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -205,7 +205,9 @@ bool __bio_integrity_endio(struct bio *);
 void bio_integrity_free(struct bio *bio);
 static inline bool bio_integrity_endio(struct bio *bio)
 {
-	if (bio_integrity(bio))
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
 		return __bio_integrity_endio(bio);
 	return true;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d5379548d684e1..622cf9c36c7e87 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -327,8 +327,7 @@ enum bip_flags {
 	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
-	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
-	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
+	BIP_COPY_USER		= 1 << 5, /* Kernel bounce buffer in use */
 };
 
 /*
@@ -731,6 +730,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
+void bio_integrity_unmap_user(struct bio *bio);
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
-- 
2.43.0


