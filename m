Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA440CCFA13
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYUNmBP6U3FeRokeO7r7d75tv9vLUxF9835eHvzSe1g=; b=XAyIXW/X335/TWM04P9n300321
	VjcxCMezCLcSSNifd8qFSvhdS+H0h9ApZoYI+AFjui6HOR1pfS33w2Kk0O7FMme52q6+dHcnU7LJ0
	B08UVHHtLTCKP94xGIP5f3Fgq4feWDEDaTXkul3JZGOioDnyOQQfG8dsPj03IXMMHtvGZcP61ogYF
	oNm7cg5d2FEyKfFGV7jLM5Qy/VKs5QCuwVdqPGeDYoSeOceLuMiihi0npihEtgeS2ObU+ckFr5WUC
	CEyCiTHxZsppZDM9ghKFHqPVISsGSRovIv8eXsAvpm3TWvya7OtVR9k5mkFQ3KPKk0vxsVnEVNvJz
	35L5cDjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6o4-00000003q6L-1fLT;
	Wed, 29 Apr 2026 15:26:32 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6o2-00000003q5E-3Ci0
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:26:31 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43d64313c39so9755618f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476389; x=1778081189; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYUNmBP6U3FeRokeO7r7d75tv9vLUxF9835eHvzSe1g=;
        b=sV4ugF50Pg4Ji6ErF5f47UbVN8gJUgq1usApGOhggUWyKjqEgxHAnKcCtAsv5Mewuy
         9NOowvkOGUNPzQ3n83vOGJwlLjNwARwtm8x2lpRXIkkeFkETZGBx6aJ7rrxA5QriTGwE
         rAzH+rsR0+L08bNuMOwXqO1REOdm3yqhpNRODSEgVhdUanydvmpYD6L0RDbAiAV1iyv/
         D7G80us9DkaBgoTbnlSSnEv0oIVOXNe4kkap0WydhakofIXIT1EMpZN906B3OLi5HlNd
         ETWmkhPYE82CkEO7OtULZwUQpePB/HRytqhJ0SNX6rZ6A9zO1Nv2mVVji779ljjCJLG1
         8Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476389; x=1778081189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYUNmBP6U3FeRokeO7r7d75tv9vLUxF9835eHvzSe1g=;
        b=W1OOo6M9LFWzTYMTDVxRK+QqgvVuyjlfu5F5r1oPloQiX6WtJbaXkg0g46i15EbSYm
         TDlIhuheDkUN/VbpFAigzUZj911vk2o4T50VDQesO5ceZ9AL0bo8IgF8HLHigp8AZ8WX
         0CR2ojrIlnImRwEqJCtoAYSMtfy86mu89mzMQrYe0ftyW/6MBwwmhVuMOPr9uMhCc6+Y
         0ky+eJaWZhByUyLh72+PLCLVBjkierthMgef3s6UHuM9SMzooWaUHGMU1cZxs2P2QhnR
         Pf7Ra1e9x2Ork0IPLdsPZMGew2T3OhCJdVJWXyrou/ElN4pNiQwU16vWU/6+jyvH2cRO
         luIg==
X-Forwarded-Encrypted: i=1; AFNElJ/RSMFt4i6qgg8OT9jb+4OWayYeRc/eg24OvujRB8cQS62TT46/CjrXe9byQlZucF+g2oRJ5u/tu5hR@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4Y7asXGMlR4iamnlwu1eI5AhopAxr4CkHXbdOchtHhLncm41B
	rlPuDblqgnct49QiQsM7RLe4UGr1X120Wko2+tZi9xkBoHEoWIahAZDW
X-Gm-Gg: AeBDietIXZcpIMn5lhI0irkGOrkIWYJWmPXAe2c+vuDMFb9VZ4aCy78tYB8m/B01aLI
	Hfjn8gvKwfXobFwUhNmkFsM7lB+v8bIF8qZuaHgWmY0CDtv3+Df1V30u8oazkS4YTkzILSk3dMX
	qA1cvteCYgwFsadG6ojXVdFkceaNROKcuFc27hD89bUGKRHNEUBP1gGBcTCRbZW5OZf2q1wQlDo
	Hy6h1ttliph6wJ8+y5nAzFYF1f/w1bqBeBLRp6v/iNnVXDryYIzWodSdJAFnmsJizF7PYKLajiN
	UGhJhcxZHVPm7miQESWpt8GCotIacnIX2+bmq4PTkcUsrXpFurFgb3Iwc5n7B4LWh0EO+f4W6vl
	W5a+Dxk6zgJhv57zhVR7eyYDJLdg8yacLliiJ9b+jOWAhCNktdmxTSLQNj4YGDTCglBQLKz2gLW
	g8B8cUHK0aNVvmp42g6C6X9hn+f+73q1RbfpC4gr0h/fcJ072bkLcTp46rmaLOIoUnbKyC+Ipqt
	oNjlCDAYjuTyNPUN1edIkZIIBix5TzxBnryJO40/DXOy+mEpZr/LRY=
X-Received: by 2002:a05:6000:26cb:b0:43f:de5a:eb63 with SMTP id ffacd0b85a97d-4478ea89a58mr8097281f8f.11.1777476388358;
        Wed, 29 Apr 2026 08:26:28 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Date: Wed, 29 Apr 2026 16:25:48 +0100
Message-ID: <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082630_830451_5BED294D 
X-CRM114-Status: GOOD (  20.81  )
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
index a9bc5b3067e3..75051aed70de 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct io_dmabuf_map;
 
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
+				struct io_dmabuf_map *dmabuf_map;
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
+			struct io_dmabuf_map *map,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..e2253684b991 100644
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
+			 struct io_dmabuf_map *map,
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
2.53.0


