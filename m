Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B50CC6B3A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=; b=LEJeloEE5ycjSCw3IMfaUUajbC
	IC8lYEfxj0TfptoASAdhgFyOvnChdVszPJGpyHyk3fqnbMNP6UswHRvMRU/rpblWUP4qWqucLOTBC
	uXIBzLDkNbhPzPO9VJIhGNwWU1tvah4bxwtTgj8cO9Kr6De+zsAmILL3k1ZattZgD2VHDCoyuJsUP
	4XyL+YcactpvD+da9XMCZzNUgaPL1mWAisqwhNsyFl7oqxFkv+9uVulA1sdbHG5HsN19TQ0EjFV7E
	KcKsBKyEHSbTjwyvWgpbAY4L7XIuxteGKDe68MoFEmeJ2G9UavKirfpC+IOLP4NOoChoZgatFCZJ7
	z5Er1qBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxZ-00000000TGc-2Vzr;
	Thu, 15 Oct 2026 15:01:33 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjWo-0000000E3Di-10AZ
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:19 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so31001685e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924916; x=1792529716; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=;
        b=Ms8s4MKTFc1Z/sRUT/cmZ2Ej3NTrdYIRGNqIRkG5xXwpx/dd6vH0OAU7EJXdL3PMRb
         E8g3HL7QmwRj5Qssq4iVTEHGFMoZtGVMNOp+lmxZJHfyCHI2YcOC7WP9jCe5flgs6qwi
         rXZZ8BRTj8ymGqlAKI+VKIxk0Qu3y5UY3YjMBZ6t8LUA8CSbkKLx6AwmVS0kfCP5g01y
         zaLfXapbCXHBq6L0Qj1Ycj9JVxx448vIt6V8/jZd0cqmmKyTynGxjGYDtXupFX9C7H4d
         FxQHk7uRkdhJZwyxSk7B1C1PIgH61BIYSvO/8bYMsg+9qG/AYnaOk6hmYTfgyaFXiYn6
         5zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924916; x=1792529716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=;
        b=2dQUe/fPGEPuwa1fNE/yjR0pFIWBa1CXhm364krBVd5L0Ha/0n8IG5Ews+JC2oUECH
         nGsmG9xFE0FVfC4T22u+eucARjda/254edyIkjiY3v8CA7qnQizZQBfmdGRzRI491X25
         Zg3huRW/x67PCcQ5MmZk8GAwi5ADmWmhbf85OMil2voxVVi9bAszTwSyill3lqejfmYo
         JNeRsPyeIYmqY7nDeOKL5LQRRj4HS4BARjOs4OsDclNKlXfKCw2oes721pvm0VuOqKkl
         vIcgI2zuFpl4xfRpIgw6cpTEpmhNXc22mUWfXdCt7StVAnWEXmKt8xzFIj6DLkDnWVj0
         kIhA==
X-Forwarded-Encrypted: i=1; AKwUvBwg7RcI39upavi9wPcWfcz51yxAXyrAYJW4BLL9k+qjG8sqeTjVtRh/odKv0nr3h1efbQriQC/yuEGe@lists.infradead.org
X-Gm-Message-State: AFq9FYJsu4PVEsxvZF2c3rGdyHSOyLxKy5QIOzvCxgcwVq3XFhHZbmJS
	EtEYjAkKiIYVc+rVzCkJlGNGeSqUpRHjGwzhaRBmEk6IAQlE7TnClKqZ
X-Gm-Gg: AYBFou3Ly26aMuqv/Reedyqtd/1Cff3JZEd4a126pQBvNl/OEoN91zNq1CpLAj97aZX
	IuvfM/WRljrMRduytJ0D0MPHZbA8HJgn/qg+08AwK9Ew3sK4q+94m3g8n0c8e2fUnTi26tH5BVW
	ajlFhz0r0iPALd3eTnOPZPOMj415GxREU/2w+ZG76IMOPz/ncsqld0EO2NDKwMHlgoX71gEIjb2
	vjWihWqdfvPCCcYfDY87u5jGLT26qjnNXSpkqUocBT3VerhNudceof/+JuxCIethg0KfG7Bmsrt
	zSK9skulf3+o5dKkg/H1jmvVQKX9KoxESGcq6lsqOPP4klDM5pNGzwLlsN1zddtnyg1U1bNTbzS
	lgUP0wfJfkl1MjoMMiKOOxS1iV122n5Mw9GkWeSV76tIk7AehWWxzyPjndRK3YIMqN6rEqDgQpO
	oRr3wFV+EjOQu83KVGVlAciM2G0Zhy+IAjIng7dioZmN8RIp65UprD0OhmYqTy4iRQwyx3B7v2M
	Edf5Xnd/mSXjcESc5BFbbppp0XWWkyrvU+naCP6UaiIkx8esmptMrnzwP47bnF+blZn4uj3dWXk
X-Received: by 2002:a05:600c:1553:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4a18e443ea6mr263806405e9.4.1791924916136;
        Tue, 13 Oct 2026 13:55:16 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:13 -0700 (PDT)
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
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v10 02/13] iov_iter: add iterator type for dmabuf maps
Date: Tue, 13 Oct 2026 21:54:46 +0100
Message-ID: <20b8e9c900c7656e43e039a0d97213a2a781ba4f.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135518_315216_6B98EC44 
X-CRM114-Status: GOOD (  22.06  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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
 include/linux/iov_iter.h |  2 ++
 include/linux/uio.h      | 11 +++++++++++
 lib/iov_iter.c           | 29 +++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index f9a17fbbd398..2f91884d733b 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -310,6 +310,8 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
+	if (WARN_ON_ONCE(iov_iter_is_dmabuf_map(iter)))
+		return 0;
 	return iterate_discard(iter, len, priv, priv2, step);
 }
 
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


