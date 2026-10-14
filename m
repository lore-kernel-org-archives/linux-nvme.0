Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC55CC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=; b=x1kqEpxFNNeAj3FuoJOYmxM7g2
	o9xhvvMWnK2weepsQ8iGC1qUJvrrZJgXTJG03VtJz2tsemrO6iZFX0U8RzOyxma+fd+th5FWlILmV
	O9741MmwjWiA/iHRlaNq9rjssMzDi3P1n4KbMAxzIWstrrGhFZZ8XrIE//Nm4WT7BZLeZUBOV5dhI
	tBSCyonNxxIHP3iCoeL+SUkySAfpS9gKkbsA86ET9rmW3AeDtpAncNfB5t4n/ecbEqwUfQnCHg4zg
	G2paK4fUFcXCNHVzQ7GlvekC0B7LqUF0i2YEx8RwymQf37ma3zAF2iXQDNkz1Nh5mAJBbAkYTIVKM
	Z0bVhqxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMyY-00000000U5t-0rx5;
	Thu, 15 Oct 2026 15:02:34 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwko-0000000FHAr-0CZM
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:42 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a17baef589so7409915e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975756; x=1792580556; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=;
        b=lSzrKD1M2UOFdDjT+xjbokfhd9KFnQEV/RrKtWHnNQttrwnooJYlxycE9qeFwMJJ6W
         zd2IVKfDNXuqE9uifZ0g+EeUxoTeEhENOIQTygHObbxonDX6f3EwIDtuDc8l1bfsNgTs
         LxgW9REs75THYM3NensoY271MiPlCcpVIO//OSB2kg+9ZyPU6K1sY7J/9Q5F2u/jAeF5
         ArvVMEiby6SdOEeKrBFE7AdcNvMj25zDUyF3mMhqH0t1i+S9bGNzeHPDaaI5TyZiyNP9
         LkKQnMcu3fxNIV/E0AZw7x1xuDi/QDNlD17LdGEF7zbgScjK1/jrJLladxtGBtI7wtv2
         Jbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975756; x=1792580556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=;
        b=GPalti3n821SlFhwpjbps8a1o9Br0+d+ga7h/FC28NZUJnVQqWL/RXuT7/mrHP1riK
         6nYfQcLQg+VvIjd7piAixPPF4c8jOYDf/VR7VZ08BwTZ6EiecZVBvy+yyTuCxB3TS2S4
         lTDHUqInTZCqjcqM+G/gqdiNYnjZqnQMlj5bgnDrA3I7vvmmeFTal2HqNVH5W1fxO/UX
         iVz2E7w+vKXs8I46GRm/JT03BQCr1lsQwULRbGUxQPPFxWoKGRdBVhm0TugxP5iEciNy
         vZtJtGATHkoBjf4b0ZorO8lavOyWw+JLXGAZSTFFxH2SjnYlk/ujbGxmG3yRFKn+DIV5
         RXyg==
X-Forwarded-Encrypted: i=1; AKwUvByDozlXYAt01jNK5qajd+UCBNq5i4LPaISt5EIJOpSW/RY6Df9OuIQfVkg+ZkAM7460pQ7BAXS0gh/n@lists.infradead.org
X-Gm-Message-State: AFq9FYKns2l4wTq+8Gh4mHg/IAXxYzxr/9TBFAkuA9cc/FDRonsiTsSR
	RcwR835oI5InXhE+dAiAJjfyWA+DjE4fs+GJnBf/nOhK4X4gLcgih3QZ
X-Gm-Gg: AYBFou1LGMJ+ZF87SxTIYVAHk7MqQgj29uUpL6vN1kcr1ncFh/t9Y59icuVvOMle6xh
	md+mu+7kJnRLoryvxkJ31phiAQ00m0oOGxv+UXTBHMHONRSSk/nYhfpUpnfjy6Zxo5x/Vs6CZ3F
	yPlg6yF4K+XJmF6RVjnOk6IHcSvNeKj0Ji/GfXMiXV3fHs4wecIpRyvypSw2XnA6TJECsRqBmjr
	tH3TFxbDaZPXq5c+lZ1xJNEE2pYSbjxeswDrPP3CFPF1vU60tjGVkB61tnXjrLwYwHwEE9e2BcF
	zamj2nfkNSAMcmih00WYGj4EAZRbIiMp/7L41bbDmPnlnUfpnHZXE5JjXCZwiHdUMObOrePUedm
	9giQR5pclhQsl1DAdZkzTlhfLOR6teZoyrUq/AUZq6YILrHUz8Pdxt1oq/Wgt3ne5Imj5qgv/Cd
	PwpnCQopel08vZj3rDPXqAsRd2FyPNd5D4L29/ZYfCseGYHaIwABQLkdI8CJ96cX/TPq81A7Lb2
	cwKwzqJDJUfjcM/y8p8vUK17RFHH1/0Wnp8u3fnMeqhY61qXAQOzZxo3ZbJlALRlDhhUntD5lAH
X-Received: by 2002:a05:600c:1549:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a18e491051mr343632765e9.17.1791975755701;
        Wed, 14 Oct 2026 04:02:35 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:35 -0700 (PDT)
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
Subject: [PATCH v11 09/13] io_uring/rsrc: introduce buf registration structure
Date: Wed, 14 Oct 2026 12:02:07 +0100
Message-ID: <178bbcbc7a0a9cf017284e8b15d5434fb546fcaf.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_040239_538909_E96A925B 
X-CRM114-Status: GOOD (  19.47  )
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1efaf29514e8..7234dcdb8372 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,13 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov);
+						   struct io_uring_regbuf_desc *desc);
 
 static int hpage_acct_ref(struct io_ring_ctx *ctx, struct page *hpage,
 			  bool *acct_new)
@@ -81,6 +86,15 @@ static bool hpage_acct_unref(struct io_ring_ctx *ctx, struct page *hpage)
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)(uintptr_t)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -398,6 +412,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -411,7 +426,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -870,26 +887,29 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov)
+						   struct io_uring_regbuf_desc *desc)
 {
+	unsigned long uaddr = (unsigned long)desc->uaddr;
+	size_t size = desc->size;
 	struct io_mapped_ubuf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
-	size_t size;
 	int ret, nr_pages, i;
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!iov->iov_base) {
-		if (iov->iov_len)
+	if (uaddr != desc->uaddr || size != desc->size)
+		return ERR_PTR(-EOVERFLOW);
+
+	if (!uaddr) {
+		if (size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
 	}
 
-	ret = io_validate_user_buf_range((unsigned long)iov->iov_base,
-					 iov->iov_len);
+	ret = io_validate_user_buf_range(uaddr, size);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -898,8 +918,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -921,10 +940,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (ret)
 		goto done;
 
-	size = iov->iov_len;
 	/* store original address for later verification */
-	imu->ubuf = (unsigned long) iov->iov_base;
-	imu->len = iov->iov_len;
+	imu->ubuf = uaddr;
+	imu->len = size;
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
@@ -934,7 +952,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -986,6 +1004,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -1009,7 +1028,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.54.0


