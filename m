Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F878CC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=; b=2U0kLHn+3JWcTEloPHoNrYZqx9
	czE9C5WdqS65Fx27ReglGmKq5++TpdHJgVkCDbeGTG65NqbVKYdrU5MKgt+Qm8hFMK8/xYF/Scq9V
	msesftkCHEDg34k3/OE86zyNyrXQ7NXsGoxwLVVO821jzA2HcOvsASBMcOu5MLWUtvOrXb12ovd28
	33uaZcfk/+ajfxri+PAuFpEVen5iYh3zMmDbI+Cy6fwzRfyIYobqFe3l0jgqQdEWwkar/zefEj054
	ZnYdAf7zXOOjP4LeI4I3DSgh5qWFLJLtbWLJgs7llPnDNqWpb+EPt5LMm3esahhRaYqT+df3WlxBe
	aaUbByPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMy8-00000000To2-0jSA;
	Thu, 15 Oct 2026 15:02:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwkd-0000000FH2N-1KEH
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:02:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=; b=c2X7C6lY7CdOxs4ZWLIVfQru+s
	iwbd4v2Ii7hve2Optg0wDzA4a6/s630N22+/tx+WLdJKB/g7njavR1Kgj1qR2swd8XMlNgQWkXVhR
	02j5lwFlDwatg3/UCRmbFX6VhI1CfOVYiDGlAjcCMDhZzqajZO9lf4V6DakG287Ke5dfiEbsf9O0x
	1xcs9og1zZM5+ha3WvGQkiYcVWeupOwUoZ1UU6fFeDRxsNYHkkn2ZRI2ke+3ozuSUK1DIYdinmmzd
	i6puXVsva168Ow4zpmmcWbtmWUxYDLsVwu9/cF2KX7Gh7Tl9LC1BLEMX3FPUqDXJl4KgyzNXLA7Yq
	4lzSoBNA==;
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwka-0000000Gf1H-2YVP
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:26 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4a1af482519so13100355e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975743; x=1792580543; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=;
        b=OxOueD0wkWa5/s4F6UHELZ5cMT+N7281kNY76E91+zwQbyCjPO0hP74lsFV4ANyPan
         ei/vwZwJf66VIH7j4PDjBesJ19FjtK7lEmwujTBtbyICji5YtqLE6dG+bH98zRcvVuKJ
         9CCLEPWU2ELJekW1CWlCghqGaGqR+9C0vAPxQrqAG65yBYE5SdbQS5LAiv3R1vXUhlCt
         B2k0Rs73woOhAABiH19QMMWJLpHu+V4kZSyslE0hxJAH4cPTGq/aHjHptCN/iUSscxmp
         ILzavVIcQMfxkmEui9S1hpaxCtdObCOFkI21QLKuc7iPfXTK4GXNwmU+8yIMoYV1elYh
         iiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975743; x=1792580543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=;
        b=XtM7+j089XJSY91QXbKMPymz9R2AU2k4D66YSPgV3nMG4J9076gzL2q585cFtgyaj9
         E1vl70VMuutnvHzRAAMXtbxUl3xsTfLFEv1bMW20r2mwkNcZJV3lWauza9dyiiWY9z1D
         qxKXS9ayIVM/wWODJgiJb1vRvQ9iXXuMfWKobUgo5+w9QWfp91iQoCPiJ2dD6t0EnikM
         Ktjy8jdmCZrc0C4inLOkwgl6Ea/7pMTi3f1i0ViBIsslRLoXc8ynVW3OWgdVOEySgyhe
         CUTV5BkPiFajGNZzgKIs5TcHSEF6H24/KI4LWfLiDO5QPmx6UFIRfmhkjEF2gtqcGSeO
         ZUQA==
X-Forwarded-Encrypted: i=1; AKwUvBy0MJypESVOtZLaZxVD0MiG35BqoTxbsU77BDFyD98fOHAIAZCcV/jbhXrdUQRUaTL35hmqRTysX93A@lists.infradead.org
X-Gm-Message-State: AFq9FYJ+4NV116FiYeFlAWCev0TTUPZWjD+xgcbEq8RIXSgSwt7Bkwr9
	UPryCEI+2HDBaocoK+lBNMIseww+kKAg8m/6kijuak0x7mzXEiJMlHoH
X-Gm-Gg: AYBFou0U0R5oGexCjDCpKg731FsgzdmAjxWCCPlcXAu+tA4dtPPDcj7EgIM94NeJZlP
	NS9O6LgAQLul3NatErH0WCu6cF1zt0Sid8iBgSZ9XTDBZzzB/CmIVbEfKyoCAaagBQiCdB7GN1L
	4pIl1Jk5GB9zVUZhYGU20ZWp2BUSt/0DFFq4CNzQDe8EEXSi+AcJ1SoOfb+/EZbVggtry9VS4Jf
	n3B6mJWCYBLlh+VOCy4fJ1acxfq2iMi0v0lXr3vCVSDP6tqCbE2meMfvXjzIW/MveZM9zr15xZ+
	kJhpODYyS/I7C1tCFmsXyEh72Qh8v+v9SrJBPSkbJ2WB3RsPYCSG8GWIIc4oiR5cVBR+nidzxE0
	FSV5SDZvBeZGVMVwQJcYMKwmPhUUuiWHLVqy+NSiG2xAnu0ubRG2JfDMu8aPhwsYk9EvZM9/MWD
	pc4uMK23cL5fZivRKRiB8JeXgkVxDsJY8pZl0CVmG/GQsDcGDhwDBkp95hpa4EggeHx60Q+QkHi
	FOSqwovgVazwk6RT4fuRTUvQzh1R9VsBJMMnTTF4qP039M577t7j5rfPjJhr4L4xzSh8E8eUEaz
X-Received: by 2002:a05:600c:3146:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a18e4a7cb9mr304322515e9.14.1791975742685;
        Wed, 14 Oct 2026 04:02:22 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:21 -0700 (PDT)
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
Subject: [PATCH v11 02/13] iov_iter: add iterator type for dmabuf maps
Date: Wed, 14 Oct 2026 12:02:00 +0100
Message-ID: <6aedb1c606f20ae5bd7fa358829966384c6e738f.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120224_811523_99C6FD7F 
X-CRM114-Status: GOOD (  23.07  )
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


