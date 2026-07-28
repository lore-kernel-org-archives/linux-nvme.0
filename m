Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F385C53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDZPkMbwSk/lf5c8/cMXuQv/8k90Wcurvg4IHgK0Syc=; b=d8Wbsydqb+tCPbKdKskon4+PMf
	Wx53MWeQ5cvMnXHcGYy5MhcR6EAYzLzjx6al1A71JczDJ8bf/iVBCSIInaBSlblrzlcBHgekWUObh
	oDqy6fAYjPkWCRTtNJBuuA+a+3OwgJ7yYQzAoBCDvMxPst5Q1BMFySQymZEA94c7Z4YOPjeVn6qxY
	sgdl3rmsHRESooskXBgE8Ekxi91946xHZHQzTZoAYyQvzDRZVos6m3+wkqgmZUwqiAapppPwD1qYB
	PK3IRdds205jW79p2uSNfyal30hchUf3/emJi+grlj/W05p8MV5RBxUOESE+a7TY/cuY74Bp2dn7R
	VbqtVHfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqI-00000006fS5-1k8A;
	Wed, 29 Jul 2026 02:16:22 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopN5-00000006KLR-3Zz4
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:29:57 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso2167515e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274194; x=1785878994; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDZPkMbwSk/lf5c8/cMXuQv/8k90Wcurvg4IHgK0Syc=;
        b=R8o+j5RRu98f54eZnnapDbgR9/X5nXBUL1lEc3hkabxSDhnAys1J9UqcJn5Oc9cbEJ
         O8R5P1wwtQrsOlN3B06Q4RIuY59x0rZA09nGsDAzrCtVdnmCO1qVYhGt1rXqOhkBAwbg
         uwE/8cAWPSVUzrGuyeKnYAnoWGk8mKKxrB1V1Hlqzg7ePf7OR5qEDmQq9Qb8Ptioryqz
         SAsVgX1VLb1iRVawgLWEfiw5vYZX/gG45Je1FLKnVTb7sal5gswz0WBS2Sot+DYFHVDm
         vfOMb/8D42H0X6+WodboD0BifVxnNYJcKo5OIBYn+jfuteOWHfUQFRpalbYkNABKcJbq
         TmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274194; x=1785878994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xDZPkMbwSk/lf5c8/cMXuQv/8k90Wcurvg4IHgK0Syc=;
        b=RNzMSmoLhVnIYc5AaOSZwOpSyQEAdH33/iWUHUy3R8A0vLRMPjasgUcLPJLkHyGB0E
         6w07PekB4fAU8LwG/tg9r4uqP0kkaam0vtPwS9pdcMOFDQ65pPxvpx8c4XrVp/qzI0aU
         M9kb/bnbZ/TI+hVDHYmCiM3C6hSI2abSwNfiUdNE+ttx6NNkCDf9yqwbnKFHcoyocrLT
         Aqd9VIjdzGVwlweGgLaG0Q7Jv+H+BTTfhqHOi3Dg0ONcxC+j8TVKm64EV3tjUUmYDusX
         aFUWxsxl1MPLe9m80RPqYLGo2YGauwypLNs+bNkvszEHtn+s6eLHEuoxt3Y5gqIek1sU
         0LPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOyGmwnIAPMisXEhVIuvNuFd/rZTBrQVQft5B795bGkjk/ryGRH/A7KNjU16fWRDL5OwTyg8MQD1ex@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+jrQe9YUtMqfzSai+CuCGlgtzvJkInSy62Sdkl/fBxRXxbRy6
	A9AeLuCRmKgEIcSECOrKntI2jGdhZk7lGwHuOlOFDkJtKcro6l50Y1ZFIrX8DOcOfyo=
X-Gm-Gg: AR+sD13D2c6oeAyCnauKDfReXz2+pqsYURTgzirEziby7bU7nKB9D+iYUUYm3iATSSr
	CqYEOxHGeAaSbuTvDXN5zDaLikdQjXramfj4d790452KV7OeJaZjg1the3Uf71cVUCUu8u0o+iB
	5HXwImjIOMtqEgdY9peaz3+tYMymmKwCqYvZyRQh7BrtvukoNsRvjnUK0Ct9B4AemclAtRWUntw
	08/TnCZaoTdxq1XGIVvKoqpKOV2lru7MlCmpUjhygb9i8aL6NW5OJ+2c1ST9yEoh1Kinlb2wtfe
	6kA7FiP5e2MmUKU1uLJwNqaL2m7r9RIUvjncUEGZ+a10owE7849H2grHqoKwNswwG6GrMQDaAat
	ZlFdkXGkAXjS7sIsnV/CFuuz8XHMp14qhxn4kDe76KALP9hoetEh39dAHJRjI/bUxmgziskMjQC
	S9jKocq7o55zJLHsSyzHRnfQXSQRH1NbYgLLSB4n5s5vkRHfQm1vK49Yo1f+3UYn8EQJSP4HEKo
	2pMw6LGK04aMjvxy0/DBz751Wct0oa40F4lvTfAQXfxUxwU2TAv1VwO0b/Ky3QFmdQ=
X-Received: by 2002:a05:600c:4504:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-496c93d0e44mr30643425e9.15.1785274193855;
        Tue, 28 Jul 2026 14:29:53 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:52 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 06/14] block: introduce dma map backed bio type
Date: Tue, 28 Jul 2026 22:29:18 +0100
Message-ID: <f97985ac5cfff3d9f7777b93f11456af57e253e2.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_142955_941824_E117FCA9 
X-CRM114-Status: GOOD (  25.41  )
X-Mailman-Approved-At: Tue, 28 Jul 2026 19:16:17 -0700
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

Premapped buffers don't require a generic bio_vec since these have
already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
maps as they are mutually exclusive.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c               | 23 ++++++++++++++++++++++-
 block/blk-merge.c         | 15 +++++++++++++++
 block/fops.c              |  2 ++
 include/linux/bio.h       | 10 ++++++----
 include/linux/blk-mq.h    |  7 +++++++
 include/linux/blk_types.h | 14 +++++++++++++-
 include/linux/bvec.h      |  3 ++-
 7 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 57c127aee116..cc2bb9183c1a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,7 +860,12 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
-	bio->bi_io_vec = bio_src->bi_io_vec;
+
+	if (op_is_dmabuf(bio->bi_opf)) {
+		bio->bi_dmabuf_map = bio_src->bi_dmabuf_map;
+	} else {
+		bio->bi_io_vec = bio_src->bi_io_vec;
+	}
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -1192,6 +1197,17 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
+void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter)
+{
+	WARN_ON_ONCE(bio->bi_max_vecs);
+
+	bio->bi_dmabuf_map = iter->dmabuf_map;
+	bio->bi_vcnt = 0;
+	bio->bi_iter.bi_offset = iter->iov_offset;
+	bio->bi_iter.bi_size = iov_iter_count(iter);
+	bio->bi_opf |= REQ_NOMERGE | REQ_DMABUF;
+}
+
 /*
  * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
  * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
@@ -1254,6 +1270,11 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
 	}
+	if (iov_iter_is_dmabuf_map(iter)) {
+		bio_dmabuf_map_set(bio, iter);
+		iov_iter_advance(iter, bio->bi_iter.bi_size);
+		return 0;
+	}
 
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 258a726071d1..6f0cabfe25ef 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -346,6 +346,20 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
 	}
 
+	if (op_is_dmabuf(bio->bi_opf)) {
+		/* single contiguous range into the dma-buf */
+		nsegs = 1;
+
+		if ((bio->bi_iter.bi_offset & start_align_mask) ||
+		    (bio->bi_iter.bi_size & len_align_mask))
+			return -EINVAL;
+		if (bio->bi_iter.bi_size > max_bytes) {
+			bytes = max_bytes;
+			goto split;
+		}
+		goto out;
+	}
+
 	bio_for_each_bvec(bv, bio, iter) {
 		if (bv.bv_offset & start_align_mask ||
 		    bv.bv_len & len_align_mask)
@@ -376,6 +390,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		bvprvp = &bvprv;
 	}
 
+out:
 	*segs = nsegs;
 	bio->bi_bvec_gap_bit = ffs(gaps);
 	return 0;
diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..37d491f45015 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -348,6 +348,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		 * bio_iov_iter_get_pages() and set the bvec directly.
 		 */
 		bio_iov_bvec_set(bio, iter);
+	} else if (iov_iter_is_dmabuf_map(iter)) {
+		bio_dmabuf_map_set(bio, iter);
 	} else {
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
diff --git a/include/linux/bio.h b/include/linux/bio.h
index dea9f567379d..c053e9444514 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -80,7 +80,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	       op_is_dmabuf(bio->bi_opf);
 }
 
 static inline void *bio_data(struct bio *bio)
@@ -399,12 +400,12 @@ static inline void bio_wouldblock_error(struct bio *bio)
 
 /*
  * Calculate number of bvec segments that should be allocated to fit data
- * pointed by @iter. If @iter is backed by bvec it's going to be reused
- * instead of allocating a new one.
+ * pointed by @iter. If @iter is backed by a bvec or a dmabuf, the bvec array /
+ * the dma map are going to be reused, and so no extra allocation is required.
  */
 static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 {
-	if (iov_iter_is_bvec(iter))
+	if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
 		return 0;
 	return iov_iter_npages(iter, max_segs);
 }
@@ -484,6 +485,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		unsigned len_align_mask);
 
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
+void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index af878597afb8..7c7504c84e09 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1017,6 +1017,13 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	return rq + 1;
 }
 
+static inline bool blk_mq_rq_is_dmabuf(struct request *rq)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return false;
+	return rq->bio && op_is_dmabuf(rq->bio->bi_opf);
+}
+
 static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..d605e31712d4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -233,7 +233,12 @@ struct bio {
 	atomic_t		__bi_remaining;
 
 	/* The actual vec list, preserved by bio_reset() */
-	struct bio_vec		*bi_io_vec;
+	union {
+		struct bio_vec		*bi_io_vec;
+		/* Driver specific dma map, valid IFF REQ_DMABUF is set */
+		struct dma_buf_io_map	*bi_dmabuf_map;
+	};
+
 	struct bvec_iter	bi_iter;
 
 	union {
@@ -401,6 +406,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_DMABUF,		/* Using premmaped dma buffers */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -433,6 +439,7 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
+#define REQ_DMABUF	(__force blk_opf_t)(1ULL << __REQ_DMABUF)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 
@@ -486,6 +493,11 @@ static inline bool op_is_discard(blk_opf_t op)
 	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
 }
 
+static inline bool op_is_dmabuf(blk_opf_t op)
+{
+	return op & REQ_DMABUF;
+}
+
 /*
  * Check if a bio or request operation is a zone management operation.
  */
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index fc566ee1c1ff..b63914ff56e3 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -108,7 +108,8 @@ struct bvec_iter {
 	unsigned int		bi_idx;
 
 	/*
-	 * Current offset in the bvec entry pointed to by `bi_idx`.
+	 * Current offset in the bvec entry pointed to by `bi_idx` or into
+	 * a dma-buf map.
 	 */
 	unsigned int		bi_offset;
 } __packed __aligned(4);
-- 
2.54.0


