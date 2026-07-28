Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9AC53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uu/V2cY9fiEPZWKdFNoipI3xUZZg8n/4RaaqV8GEYhU=; b=EtljBVNpVQd3zdorjznTtdpHdI
	EDli5lJVS6xrpfMJZ5gj4tHIgFrj9HzbLSA283d/5exVS7TZA1M2EgtCnGN7OTC/K3SHe8/EWgL0M
	VgDL/dWmCW0nXTpWRuGwvouqi3OHUdITdkHdV2x7yUfyUnhtCwe8KQk20AUWTBNJBG34OT+F6Fpjs
	hUJUtZteUibWPgVrELfQoWn0NjVFwnHWIicpwEp3QuZLYVr2Z7TfkjZM0KPNMH+v/zmV3TTXVc6Qt
	Qgqb5HLeT5GbZXcJZUQ+WfLECabSt+yC262elHcqIXgsb+WNl7eiOF+TQX2VL/I+ZUPkDhRP+Wpud
	a5MY8THA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqF-00000006fQV-0jEH;
	Wed, 29 Jul 2026 02:16:19 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopMy-00000006KHC-0Os7
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:29:49 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47f96c5b722so199055f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274186; x=1785878986; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uu/V2cY9fiEPZWKdFNoipI3xUZZg8n/4RaaqV8GEYhU=;
        b=YpK3crf2f6A8QATsqEyHFGKoCJ76a8Bfh8kzDa2mQKsjyulL6IRgr0jD4UKkMXygoa
         P8Ps4KdnHofsEq1ai6jDqeliyxArjMVvmqyzD2I0mj5nejtumH+rDPd0oqscCCL2aVIN
         23edZe6xtsKMholgd6McfjJYbHPFGfsPe9JodgmM0u7RvPYj7kzElbf7X8SMn4aeluRe
         8ij6epmi8XBd77c+13CE/kZPZIc+CfBCHXeDQKPnrAnwkSWBgKr/bZXXfDgjNZXTU4qf
         4fYEA5YENe1JTTctMSM9P6pcbjB1wfxQuABwcK0izo0HgVqbi+ycZ6NxEQSjQn2iWl1O
         luGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274186; x=1785878986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uu/V2cY9fiEPZWKdFNoipI3xUZZg8n/4RaaqV8GEYhU=;
        b=R7yd7YNbs5OhKV6oQPnE8yHmPKfazPEBmwufEo3rwjCsQBtCAGzuFpUIX2+DFsXL61
         eehcQexVOJh955c/5YXmsqhNhWveqeoX0/Sg57E/QfnCzVdhnK6D/e2FzXiuG4/3Te5y
         mCb1DnVEpv+m4ZxVZBylGH+CjCRPNwTZwFOPjYTpVIbatSEt7Lb0oKbbXjxn92DmTyUf
         eOyOM45Io/lLFr7XYJRNKKRItpf4HFSOj1SM0PijWX81j7m+WkxK4lmfYa1OadQc3DBi
         Om5VkzVl1Fr3JdF1b8Q8HmQkLbIGAA2f25WA0Kj8MYOLrqwU6FyPeAax5IFWqI1sRf+7
         rosQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKQrg2A8dmJYlHe0sosdoXSsBVcOt+FltCc6wvcjpWCKM+HpKwXJs7v8j5L54YGlofI15eazyPo5tN@lists.infradead.org
X-Gm-Message-State: AOJu0YzeJnMdWAQoGcOTF/TSA5V59trZEBwcpzJC/ocWokSWyHfNt00x
	+hugpAIkhpztdfPu94PUUCHjcVjsn9c3bSGZxgO4z+WR79hKiMibWX5B
X-Gm-Gg: AR+sD120px7G4CmY0iXS4ssbb+YlaUZ0UJd/pAwt53p58wRd+z8M4hl2i0WZQMP9OtY
	yD/Bn6jGgCH28ZKcX0bkdnRtgA/RIqWRgMHd8iM+XsIoOsU/gAnHLQx1Q5i6JThomCwyXdS1PGf
	MnI/0MK0DH0wlxnziPweMbsuVe9LeNPGztGbzYJWiE7z0gACfpxBonCMdepc/dkyTAGGySzStgY
	ulqa/1H1z6yinWs+LeQMg6PKTyVtQSAKmYrTLW4AvBePXgH53iIwZXSGQuHAJbLIccqtLroFzgA
	0BXpq+qYFFRqR+Twti5VOWz4JQ1LAUDjkdD7nBmUU3VkXfobELc9oc7viKvV53v4lhbn/ZliJTu
	fI5/0hkrpN5GhSHZX9R4JQOsmn39k/IDgGaVtIYEY5h7Pb23pRkuXy9cETmVekX00BbLzcYlSvJ
	IIBiFnbPvDj2mnOSvEaor0B5qTDJvWwBKCdzFTn5bziailCJOgLn4KhtDbkRJb1VZRi32vak6ZZ
	wjYZEmRCjkjg+2Eyco=
X-Received: by 2002:a5d:584c:0:b0:47f:95ce:6f48 with SMTP id ffacd0b85a97d-47fb1ec9671mr5039007f8f.11.1785274186132;
        Tue, 28 Jul 2026 14:29:46 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:45 -0700 (PDT)
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
Subject: [PATCH v4 02/14] iov_iter: add iterator type for dmabuf maps
Date: Tue, 28 Jul 2026 22:29:14 +0100
Message-ID: <132442812a40277a5904cb2a8ca1e02f4f6e82a2.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_142948_190885_5FC7B666 
X-CRM114-Status: GOOD (  20.84  )
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

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking. The iterator can only be used by
operations of the file the associated map was created for.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 11 +++++++++++
 lib/iov_iter.c      | 29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..6c31ec131a71 100644
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
index 273919b16161..6398b306d0e2 100644
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
@@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
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


