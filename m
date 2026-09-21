Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF52C982FB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lhfYmNfKHeufPvJ/pLV04jPXJys5SvK0KBUyCDM0noo=; b=0N0LOxwkwSvVs74dEpTlcQbek+
	FTToiJUWAM7JdH3i1e7RiBPgeai2YEvrOB8yS1fszqyyBSkrxbbImnExURfv52b8LmPKpe3VoY+HR
	qB7/jIGoi5dkyExa6QSlZa5Qt1B4j5ZFUWc9T8fj39HYJ5T3i1sCRQZxRbuQuRgFsNqkbxZUlQo93
	azcLMAgZJ7twXsQmbPW39xokKcdVdZeHdwlcMA90PVxFA0NAyDQ5DLVpPE+Z/JxS2Hoqv6U8nKsnT
	ypA2MmengP4DXD432FfSErBdNmjpgscNBLDE64K2P/a5WcoWa0FsbSi7NJjBHZeDcYREtOmk5xP4x
	v4Fa9k8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWF-00000002Vgw-2k5w;
	Mon, 21 Sep 2026 15:01:23 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eEy-00000002GRC-3oQ9
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:30 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1417430f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997967; x=1790602767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhfYmNfKHeufPvJ/pLV04jPXJys5SvK0KBUyCDM0noo=;
        b=Dyv6fOmpBkvHFqH+lkB1CE0Tt3ZWkXR3dbUc3Wu56H35UV4SEXckzYfLxony0nUh1a
         J87z24BmnqKc94cj2sl/W/xV5WGKWOu9+jqBgys6p30nX/Osv6P5PHL+9F4bd2DpiSv6
         45iH8ZTt1M4K8HJyZqoFMmwxGeSHnU5BAEVmlYrg3RBjYTo9jB/jcn/s8NbGJIgEebL3
         EjK6kZ1rc3+WjgBZ4ziTioX6J+WSaCqagjfkcfRvvepZTQU75qiuDeQbZ8v6q0b2TDRR
         8l92eL+HFG7tvFiDgLXPQl+g5PmS+6No2dzvMDFnNl7Oo55mgsLSwHxpS/hz1Z6Zov7b
         6o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997967; x=1790602767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhfYmNfKHeufPvJ/pLV04jPXJys5SvK0KBUyCDM0noo=;
        b=m9vYr2uIc7w3T4eB/e8U82R34t3sH4De4q/IwSI7dLR3GBbOHG19PX9s8AbM6lyL2u
         Z7DzDSGz/3XAuuK0QrKt6rI/puNkJpaDFV2T+oKdvYzsoXHDy8fVUJm22PZezvXm5Nah
         aSoXi5Lku72rLN+eCxsyD7uiFIVpHD984XYl245aYq+abGmlRBl7qi14SuRH0aahE6oD
         NhmEY6UnpkQoHLWaOk61AiIes5RIBOOC8CBfwUSFQbzHKwrE3pZAI98IEa+xRVkfEksK
         RJxYmKu94qC7yenj6r1GS91Afsb+0jmQypWZCKm5ekhhScjHqgEIxYtimNqBENYY06NL
         5GMA==
X-Forwarded-Encrypted: i=1; AKwUvBw2U0OJzdTrKqcTc1yzxqQSCz7WGMuXEfm1TF7vAcknn/CNnwQIYTOo5WNFe2tcCSAY63Huhxsf3bGv@lists.infradead.org
X-Gm-Message-State: AFuF++nAeuUcZeDTr+DcUf1Km1DgIHsPJraMtK4KCUIL/KCatRWgN2nt
	Dy+LNsOCou9nodrzAY523VCwcNXzs9WpwWesQD5V2qnzAwNG1o2CA45G
X-Gm-Gg: AYBFou0/ysUeCKkgqMMPs5cskzcYc7eGa1/a6Suuu0bq4m4zsRVthMrkCsDxar6IH/s
	cMYl+lTXIWASTha1g1o5rUjVz/ILQRVbImlaN0YsTzgEmskhXn8IahnmfxfZjUU5l6WeDWN9q5b
	dgfQ4OXqeRR7c60+XHEhA3q3tdK/yYM9B0b316FA9x3nA3sH3DYWI2Em+6+GklAYayDVzXhP9sa
	zddzzC3rn/GQbv/Aghl0En9qw3gH5WKB+21yCzoAsOasdHnM9Kqf/cxZghgIKR2OL536E+KyGL1
	1CVkDLBzVJd2+zOMpG0iILOfsOFeP9timCuYgAdB0HBb9BKNCKCxoD7VquRRXd6kt8aRPCTAh+6
	Z6JO1Gljf0HbjZsg7qQtuvDhHjQo4oMsJoV1hClko5S25/QW9SizZNwbRRqhIk1ff6+1GNE/olM
	82FuWED3PXa8wozH60eWJs7zAja7MLekg+TxY7T9LjCfrfBDYTPMGJQGnWTik4bgi1wU5gk4m3Q
	5bDC1+6RYyRZBKT9Xv3ftrkLCb/RmrN06Zib4wmpRs2/69A/NkY7+a1xercjY8JB82YpLXdRTGm
	DHv0yCj2TxIp7/a7CG0Z+tH8AaawTw==
X-Received: by 2002:a05:600c:19cb:b0:49e:8184:f619 with SMTP id 5b1f17b1804b1-49fc57410f2mr151435725e9.22.1789997966776;
        Mon, 21 Sep 2026 06:39:26 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:26 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 02/13] iov_iter: add iterator type for dmabuf maps
Date: Mon, 21 Sep 2026 14:38:46 +0100
Message-ID: <6b78003332b57ec3a4552d7393464636793aff76.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063929_012679_6472A8AF 
X-CRM114-Status: GOOD (  21.43  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:20 -0700
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

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking. The iterator can only be used by
operations of the file the associated map was created for.

Suggested-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 11 +++++++++++
 lib/iov_iter.c      | 29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index fe2e985d74d2..638c1116e912 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct dma_buf_io_map;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -29,6 +30,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMABUF_MAP,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +73,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_buf_io_map *dmabuf_map;
 			};
 			size_t count;
 		};
@@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMABUF_MAP;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			struct dma_buf_io_map *map,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2072c04e99d0..6831a5d9396e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dmabuf_map(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dmabuf_map(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			 struct dma_buf_io_map *map,
+			 loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMABUF_MAP,
+		.data_source = direction,
+		.dmabuf_map = map,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -856,7 +872,7 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 		return iov_iter_alignment_bvec(i);
 
 	/* With both xarray and folioq types, we're dealing with whole folios. */
-	if (iov_iter_is_folioq(i))
+	if (iov_iter_is_folioq(i) || iov_iter_is_dmabuf_map(i))
 		return i->iov_offset | i->count;
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
@@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dmabuf_map(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.54.0


