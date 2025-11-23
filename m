Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5C1CFD313
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=; b=2H/4vhYbG4wWjiaQLDQfcHPHNn
	G8Yskc5nl0tEuP0J/AfIx5hUaBMN+w5ZXcmhURuAy/1QCD/NCR189JHi+qqPa3/oWcMF4TirWHqnI
	8OqorvQAtMCHvdkbb5lPfkb5z7FCDryyDZuOGYRfRfOH9T2gJdZliaL6iyrskgw5ed1C4b+wIBApB
	DOdE0oWBx1QYvGk6bvhQtx0YSGkW5cCTYuCcSxvdI8weAJsIqH43aA2xgg8iIt9VaKTzfVuSb+4MY
	rXLpqYoaeWujGxjI5Dq1RkL+TEOebKMHMBKEafNCQVKJmAWntd7NPYhlh7jpLkZgZTJlI+9VoFD//
	sEc/ZGSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvt-0000000Akhr-0B6Q;
	Sun, 23 Nov 2025 22:51:49 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvq-0000000Akg3-14lB
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:47 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-42b31c610fcso3194221f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938304; x=1764543104; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=;
        b=c+lX2l/Zy5bQLdAT5jJGXgujMPnSQCCZiRN1jStkFjCBREaN1NzEzm/jF7kdrQxUy4
         HQzZTkChfF1F5rAjIm2QCi+EqSb9JB4QrbNUpoQcfAhaC0+B3QgtqT6HKMQk/5fPBXn3
         yJ8FiFnE1J9ljDzWa1cmB6G3JHdNzNGxQky950bU+ISwtgVGZn4g05U1fKYGL9YrJX9O
         MGdwP21TyX1MdZ/MDmz1fqGsN6L0PVaqj8dpKDdfRJdI8OMk1/x51n4oClVyDf+FxLC4
         X9PLxbEXFk/9QpFfhGrmpxo0bK6ensN8DRErZ5kDWYeedea6NKL+81MECStITKDvyHBX
         gFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938304; x=1764543104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=;
        b=P2KRsbAJmeNfupmUJDNjWJvzOEBapqS0C2AjSz9s0w8MP+AgfQSMahcxzk95ohtPWx
         ABkcFQ0y17F5T73gcywye/TtIlBZDzNghGTC345RMhDApPDe2t3JY6laDS8qHZ1Bqf24
         nY48+sihmg5EKk4RGlAbUBurNKn/jPLMGLOuT9HuRW+NhCJGFfe5Pm+MZXrrf0zxsc++
         K9EeFsVWdxuZC3uE3+olCTyWbAVMz9vpVqNdebzHP1KyfqoCCngjc5pVlD2qs9ETCFyS
         LPwmf8KttAPFJOW5PxNJwRQmSrNCutBVANgsEzVXU1CjO9SmISS6zzQH2CvZ9Y02OuRT
         5yVg==
X-Forwarded-Encrypted: i=1; AJvYcCUR9U0xm+jPH/zMg+xsJcOpon00YTGA92kv0aGSnz9DsfxA06YkmSMgQQqKdOxLHjUBtcRtCz0X1nv7@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0+LWO7iXLGpOQ2DozcBBAgKX3BiigiG7Kjs+K7d4HVuI4D5FE
	iUOBoI5xP8+Xh56ErCAAZeYvg7U4/QX+jrON/1K01SU/OzI9WHqYFQBx
X-Gm-Gg: ASbGnctDGU90yDPNMXFIWBWrXITWbKv72FbfahOhcXU9rfA5hUVz7xiyZmFylASp37V
	EZSOS3fPMAr34ulGyRXiKNyqE86q633IPtItxeWecYnaHMD98R3Z9yZMSp4aRV433ld57/B0NXg
	AeEgYcdmBhnDWAuu3R4ywMjsrxDE9sGGzGKZLS86Ufm2nyYvTHPCYCIZyyh/Xx4THBGWKHsI4TV
	x9ja5QwbKIQ504MxpfwY+E/yxmTHb3aYyk8ZXaB3FoDq5jIKFpmYrY4ee8MUZcewDno7NeTZIGj
	F7Yh+Jku1l/I8ftiKGEy+DcP7MAPZ8GiQq3m0+6hmloVFhfIO1JCMEEcSM45QOxTNNov9KkCyke
	XCRpHiMznKIMXMCX3TStxBYUB3a8pAbRAx3WTuFDWCXK369JxYmqVeLIodL0/MVkLCYXCONkupO
	0spIcW4eZszQgUsg==
X-Google-Smtp-Source: AGHT+IED8z7T9BZIQ3+G6TZGcukyRm9aG9PTE7rjzPMs+94mQ+eXcoj3xDrYuPfTG51yWGc4ynh5VQ==
X-Received: by 2002:a05:6000:601:b0:42b:5592:ebd1 with SMTP id ffacd0b85a97d-42cc19f0b39mr11000772f8f.0.1763938304146;
        Sun, 23 Nov 2025 14:51:44 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:43 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered dma
Date: Sun, 23 Nov 2025 22:51:22 +0000
Message-ID: <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145146_345215_A6464F3E 
X-CRM114-Status: GOOD (  19.29  )
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

Introduce a new iterator type backed by a pre mapped dmabuf represented
by struct dma_token. The token is specific to the file for which it was
created, and the user must avoid the token and the iterator to any other
file. This limitation will be softened in the future.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 10 ++++++++++
 lib/iov_iter.c      | 30 ++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5b127043a151..1b22594ca35b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMA_TOKEN,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +72,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_token *dma_token;
 			};
 			size_t count;
 		};
@@ -155,6 +157,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dma_token(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMA_TOKEN;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +307,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
+			struct dma_token *token,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2fe66a6b8789..26fa8f8f13c0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -563,7 +563,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dma_token(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -619,7 +620,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dma_token(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -763,6 +765,21 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
+			struct dma_token *token,
+			loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMA_TOKEN,
+		.data_source = direction,
+		.dma_token = token,
+		.iov_offset = 0,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -829,7 +846,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dma_token(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
@@ -860,7 +877,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dma_token(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1457,11 +1474,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dma_token(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dma_token(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.52.0


