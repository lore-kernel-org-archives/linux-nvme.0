Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73842C77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpWD4+kMQgcu38VQMZMvjMOGf7VzHXvFZWMDq5klZzA=; b=RARAdDHjUodpj9SnuQhDdAEXd1
	VROXv6mCDmK3i6yfbCqHz5WN3iB3TNWP4VOnuq1Qzpv/izeb0xxDev5y7l29EOAft25p2NqBMam8x
	A0WQXRd8pSgbuEzeGOvhLioHdhGekOGCmB0OeoLxTWEcU6c0LvKWztC2rT8tS5Hv1BZKuSxc4J0sf
	q4F2npYR3s8tZxlF9odB/TQHzg2VcLVH7PZ5M42Bq6beb/QvX0y+RGDQv6nS3eWX0BJ2xf4gk30VR
	BzXfz7fk/x+0kgI3uvmt8fk+zPkCuFZS2MbEFGJ4iz6Esp6nSGIas0vLzrpZ9kVKvb8lrT1CHlo6F
	C+VwmgOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAv9-0000000F4Fu-3USC;
	Fri, 27 Jun 2025 15:23:19 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhi-0000000F0xi-1QDD
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:27 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso356040a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036965; x=1751641765; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpWD4+kMQgcu38VQMZMvjMOGf7VzHXvFZWMDq5klZzA=;
        b=A74fnAwPF3wQkQwovOi3wPgk+eYROwAwdoE0fIDFU6iXPSdf4JXY/XucMDtiDExSvL
         Oo7oa2ERckB6pGi5nhwS1GDqpkR7dUQ5M9OSUbIM2FZcNwhl9JtLIqoM2hyXshPRBS7K
         7jo3R+FrNQCa2BNdLt49s5RzbvZ647xpBaxUPwJokZiD9X/l4qg27A+dXWjBeyprO8cV
         AWUPg3OQfSxFywVKRS6nep+XYTefLnIinrCWPvOLFJ/d+6LBQK0MmGXWxpHVm/0679AR
         FBiFTONRAD1P/U82C0JbyN/QTB/tqCj3dAMzsRviNRPjYylUy70btpKa/5yG3vIbmxuo
         S1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036965; x=1751641765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpWD4+kMQgcu38VQMZMvjMOGf7VzHXvFZWMDq5klZzA=;
        b=NAxW6h7vgeyMq2izont25uEtoCSpRP5kibdiFzsZuIGVZjOtKE5Z64bsGo37ANgw3Y
         h9xl5NLw0YgbDf2GLJZIEY8no7Q2jzpBlgoRBjBrRumSfwa10DYHIRpJgupFibgf38zc
         ryvR95EeTA2okyG3ocXradtzKuZrpK29qrm8ps9cQMBiBi/hFoVx35G2XletbYs3PY59
         sJc8+JVEyDwFCXY9TvXwD2/72iZLNdukvWWuu+f6xDmJ5bBjNTLfMo4yRRlW2d8lokLV
         Pl9T74ygZAEWOWoIqEIf7K66mf3tsV/U1uiUcCeNWSii86gTYxabKWcOrQO+cgML7mDf
         /aPw==
X-Forwarded-Encrypted: i=1; AJvYcCUE5+TzZBDH88DMULG5L6/EimpUOeToJTkv6n3efb9sS5xQQJok8MXOKXnnIuGvcbgvUAzmkzUR0kRV@lists.infradead.org
X-Gm-Message-State: AOJu0YwjMzdbvVrO1Qj0Jz3cP3g54DSSrnV3VTI2YoF/pHnO24yFSTfd
	U12fnBTgrYH1p6+VUXw2Wg8OWOOMtVNtf20zPaVR/RSPx6xBeDod6D4X
X-Gm-Gg: ASbGnctIuLqPARHH6KqzKs4i7KBiXtZUcZdryrfqzGD94D11ZWgfaCjiH7gLEA+pPWT
	YBBaISxoJNrjUmO9cZmuvjBqhAV1wLhNk7+6cbYZhoRfvrBjm7TVz6VAny2kWruycw1TtIFFhGL
	eg8bMU2W+c5Fjeuk1hj20tWqL4nhcFkU6E0TjsU2W4dvF6FCUg+g1fm9viXAdeffM/2PcygbJYf
	BxEsvGkOJHMYgXjFhObaCissag1jXLZwIj1jHSuCzODcamUPZZlMcssld7pY+4DmmsxmU5HigJv
	yndB8HMoSeqSraRNG0NsA83kn597btLQ0XOTHHUahbk8vh7MYS8r9xTMEOKTFWcxvMV0MwmXKel
	c
X-Google-Smtp-Source: AGHT+IEv5k45Pnz4J20shFCzhfjwj9GpAntAKXrKttoCW2d3WclD2HmKoC699BkmgmHcg4HQHoePEw==
X-Received: by 2002:a17:907:1b16:b0:ad8:914b:7d0b with SMTP id a640c23a62f3a-ae34fcf46ebmr326692766b.11.1751036964297;
        Fri, 27 Jun 2025 08:09:24 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 04/12] block: introduce dmavec bio type
Date: Fri, 27 Jun 2025 16:10:31 +0100
Message-ID: <6b83e74f1840aab6a91d8e050acbfc408dd62c31.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080926_399480_235038DC 
X-CRM114-Status: GOOD (  25.60  )
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
already been dma mapped. Repurpose the bi_io_vec with the dma vector
as they are mutually exclusive, and provide the setup and to support
dma vectors.

In order to use this, a driver must implement the .get_dma_device()
blk-mq op. If the driver provides this callback, then it must be
aware that any given bio may be using a dma_tag instead of a
bio_vec.

Note, splitting is not implemented just yet.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c               | 21 +++++++++++++++++++++
 block/blk-merge.c         | 32 ++++++++++++++++++++++++++++++++
 block/blk.h               |  2 +-
 block/fops.c              |  2 ++
 include/linux/bio.h       | 29 ++++++++++++++++++++++++++---
 include/linux/blk_types.h |  6 +++++-
 6 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f5..440f89b9e7de 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -838,6 +838,9 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 		bio_clone_blkg_association(bio, bio_src);
 	}
 
+	if (bio_flagged(bio_src, BIO_DMAVEC))
+		bio_set_flag(bio, BIO_DMAVEC);
+
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
 		return -ENOMEM;
 	if (bio_integrity(bio_src) &&
@@ -1156,6 +1159,18 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
+void bio_iov_dmavec_set(struct bio *bio, struct iov_iter *iter)
+{
+	WARN_ON_ONCE(bio->bi_max_vecs);
+
+	bio->bi_vcnt = iter->nr_segs;
+	bio->bi_dmavec = (struct dmavec *)iter->dmavec;
+	bio->bi_iter.bi_bvec_done = iter->iov_offset;
+	bio->bi_iter.bi_size = iov_iter_count(iter);
+	bio->bi_opf |= REQ_NOMERGE;
+	bio_set_flag(bio, BIO_DMAVEC);
+}
+
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
@@ -1322,6 +1337,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_iov_bvec_set(bio, iter);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
+	} else if (iov_iter_is_dma(iter)) {
+		bio_iov_dmavec_set(bio, iter);
+		iov_iter_advance(iter, bio->bi_iter.bi_size);
+		return 0;
 	}
 
 	if (iov_iter_extract_will_pin(iter))
@@ -1673,6 +1692,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	/* Zone append commands cannot be split */
 	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
 		return ERR_PTR(-EINVAL);
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_DMAVEC)))
+		return ERR_PTR(-EINVAL);
 
 	/* atomic writes cannot be split */
 	if (bio->bi_opf & REQ_ATOMIC)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..f932ed61dcb5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,6 +278,35 @@ static unsigned int bio_split_alignment(struct bio *bio,
 	return lim->logical_block_size;
 }
 
+static int bio_split_rw_at_dmavec(struct bio *bio, const struct queue_limits *lim,
+				  unsigned *segs, unsigned max_bytes)
+{
+	struct dmavec *dmav;
+	int offset, length;
+
+	/* Aggressively refuse any splitting, should be improved */
+
+	if (!lim->virt_boundary_mask)
+		return -EINVAL;
+	if (bio->bi_vcnt > lim->max_segments)
+		return -EINVAL;
+	if (bio->bi_iter.bi_size > max_bytes)
+		return -EINVAL;
+
+	dmav = &bio->bi_dmavec[bio->bi_iter.bi_idx];
+	offset = bio->bi_iter.bi_bvec_done;
+	length = bio->bi_iter.bi_size;
+	while (length > 0) {
+		if (dmav->len - offset > lim->max_segment_size)
+			return -EINVAL;
+		length -= dmav->len;
+		dmav++;
+	}
+	*segs = bio->bi_vcnt;
+	return 0;
+}
+
+
 /**
  * bio_split_rw_at - check if and where to split a read/write bio
  * @bio:  [in] bio to be split
@@ -297,6 +326,9 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
 
+	if (bio_flagged(bio, BIO_DMAVEC))
+		return bio_split_rw_at_dmavec(bio, lim, segs, max_bytes);
+
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
 		 * If the queue doesn't support SG gaps and adding this
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..85429f542bd2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -386,7 +386,7 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
-		if (bio_may_need_split(bio, lim))
+		if (bio_may_need_split(bio, lim) || bio_flagged(bio, BIO_DMAVEC))
 			return bio_split_rw(bio, lim, nr_segs);
 		*nr_segs = 1;
 		return bio;
diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..388acfe82b6c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -347,6 +347,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		 * bio_iov_iter_get_pages() and set the bvec directly.
 		 */
 		bio_iov_bvec_set(bio, iter);
+	} else if (iov_iter_is_dma(iter)) {
+		bio_iov_dmavec_set(bio, iter);
 	} else {
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret))
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8349569414ed..49f6b20d77f6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -108,16 +108,36 @@ static inline bool bio_next_segment(const struct bio *bio,
 #define bio_for_each_segment_all(bvl, bio, iter) \
 	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
 
+static inline void bio_advance_iter_dma(const struct bio *bio,
+				    struct bvec_iter *iter, unsigned int bytes)
+{
+	unsigned int idx = iter->bi_idx;
+
+	iter->bi_size -= bytes;
+	bytes += iter->bi_bvec_done;
+
+	while (bytes && bytes >= bio->bi_dmavec[idx].len) {
+		bytes -= bio->bi_dmavec[idx].len;
+		idx++;
+	}
+
+	iter->bi_idx = idx;
+	iter->bi_bvec_done = bytes;
+}
+
 static inline void bio_advance_iter(const struct bio *bio,
 				    struct bvec_iter *iter, unsigned int bytes)
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+	} else if (bio_flagged(bio, BIO_DMAVEC)) {
+		bio_advance_iter_dma(bio, iter, bytes);
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -129,6 +149,8 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
+	else if (bio_flagged(bio, BIO_DMAVEC))
+		bio_advance_iter_dma(bio, iter, bytes);
 	else
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
 }
@@ -396,7 +418,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
  */
 static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 {
-	if (iov_iter_is_bvec(iter))
+	if (iov_iter_is_bvec(iter) || iov_iter_is_dma(iter))
 		return 0;
 	return iov_iter_npages(iter, max_segs);
 }
@@ -443,6 +465,7 @@ int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
+void bio_iov_dmavec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..dc2a5945604a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -266,7 +266,10 @@ struct bio {
 
 	atomic_t		__bi_cnt;	/* pin count */
 
-	struct bio_vec		*bi_io_vec;	/* the actual vec list */
+	union {
+		struct bio_vec		*bi_io_vec;	/* the actual vec list */
+		struct dmavec		*bi_dmavec;
+	};
 
 	struct bio_set		*bi_pool;
 
@@ -308,6 +311,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_DMAVEC, /* Using premmaped dma buffers */
 	BIO_FLAG_LAST
 };
 
-- 
2.49.0


