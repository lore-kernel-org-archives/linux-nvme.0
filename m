Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A4CCCFA13
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Okho95RNKRmNJtlBZrtRfvb3jbBLTZKlsmbr0Q4pBPI=; b=hJTexE3pjq1UeAqRLjBfR/e2WP
	SLiYN0XJziXjP3Lw9E093rNJTM5Mj7yMdWnH3z+gNE55Sb0fhPYrwUc1FN7ZztpUlAlPezzw5wWwM
	5Wh428Wb3SyHGBmO++oLTOZwJsRGHwmEpqiGsj4TFPa5SIfJfm5i1oshVgTRHS4yP0r0X80GipMJO
	4nBaTf5oTT4lOfVjke/jDbFul651dolzxDYNsaSOWk0jaWASuI3t9tNW2MwDIjN5mOizmqNOW25+g
	bIiiAbRcergZmIEb8iuvZQ3JYbhVzIwUVX0EG+x1LJaTguRT+wQUUI4F/LdxfEq00J+1J4u0eHIGj
	PH+N08bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oa-00000003qTn-2UlK;
	Wed, 29 Apr 2026 15:27:04 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oX-00000003qQ9-3Cwq
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:27:03 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-4480f9b5efbso709876f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476420; x=1778081220; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Okho95RNKRmNJtlBZrtRfvb3jbBLTZKlsmbr0Q4pBPI=;
        b=L+gN5ZUfsCLpswLuQrwQTCMj+Eb1zwJP/4PW07yvzea01TlOernkIcIQ4yCLIpny6M
         rTHw2V5tkzsh7ITFf1+0gaqohkWpzl1Gd5CPFsfEcW7gk2zIcB0fmcv6Ce6w73+KX0Qu
         6sxnbgTxdywOIcnEFUN4DYa/CszBZjMnXV0SJazRw/rhlkCnq4meSjTppETQGX1wrSa7
         MzbsbZOQ1rvU5FeseZa9wLNf0OXE+1cNQDXXARJrprEqHmRx/x1Xzs87o2ikzdr8bb6D
         DTWVPmpvAH4fQ5nQyJEZKhPTOFrSGzVtsC/J2Vm1bWfLvt3Tn3n8nXBOHSIFsXXSEFHj
         6Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476420; x=1778081220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Okho95RNKRmNJtlBZrtRfvb3jbBLTZKlsmbr0Q4pBPI=;
        b=dFQpjhwwHNwNH9wzhr7FlyFOsuLQiE+IlO7WNwqBkV7d9PD+JmDP67A5OJ54sVIbLk
         VY2h2oJ5uWUXVv5eRy+3cFtLDjQ3G8/pXLorDOf/CnmklZtUsZ7wdtXj5hDwO12bWjQa
         PIzKQaCyzf3mPzqe2Ugncfgm5uGZMeDFzR6hvX+IUR9SBmdkLh18t6yYu9RVFKbtWBjA
         uGGU1+91j48jAET3ZPGvI0mm6pOJrbrHRLhxHv/hA+O415NoGKY0k8IfnjHK/vzXp/1X
         skuU2gCrQhwzXAJ4pAsq9Sewpk0yTQdyydnZOHLDkXPO7xgfzVYTLo5rSGi0s4Dz3MRC
         JlkA==
X-Forwarded-Encrypted: i=1; AFNElJ+/VVJYcfjFwH26JNUNTx3DDfrc5jsTYfDkTJwMekGf4R/Km+LFFZFB8K8RiZFwxTnYJpyrDNe/oSLC@lists.infradead.org
X-Gm-Message-State: AOJu0YxOpAW1XzYZHrbqhftONDbHw9uIHndjYTNxFI10tLEY4kVLH2Do
	wnaV1PL6b9xyLwTkfdp3o7uzr5GtyDFzQ1zi/WW+KgbYLk/RD5MMW/I3
X-Gm-Gg: AeBDietD1fEHDxnTQJC0NaAWn1XdwXxy0MXkhSSag71CwdefDqh5Z/rJApS/I6DUqj8
	SW1Ibt2DwDZyYdYasuGEzFv6bX8asMbmK7NSUz9Vz994Gmnlmu2LZnXKTpryvZYeQh1iZgB1rya
	aFryG/zFDjN5nRs31gAuGfwRFXT6w+Um9QjK8VQhXPwY6XnhiXNO0T6qltZLLta04Kgf4tvTBuB
	3fwU8wTfz9FEFkWVvU3FTGYSgnWT/bE6iaRq97kFuVPu/2nkEWv/GOIHX37kkQPnYTA7MCcqM3O
	1hLVeQE/wWWcp+FAzA0/EciWSdQUXy37uZcOW5VCnTWtZR5z3ALh6ixVrET3nJiYPrOiMB/Pa/K
	WxaP+tOpRAAdGv+zrfolULdrlxzwcvxjcUEPNI5Hi+ToxDJBmiC4gRoxrEN5QHhf08vWah5/rX2
	4H3El3NYyuMNbE0TjKuA/q31Bmv1NETcHRDIzESvLMtCYw4fvEawlkYtqfagHaY9Hw/81IkbAtz
	RIMJa1ZIQ8N4Yn38LVDfMJrUWmMeh9jQ8tiWg+FsVNt
X-Received: by 2002:a05:6000:1a89:b0:43d:7d6f:f529 with SMTP id ffacd0b85a97d-44790a325e5mr7826316f8f.31.1777476419464;
        Wed, 29 Apr 2026 08:26:59 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:58 -0700 (PDT)
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
Subject: [PATCH v3 08/10] io_uring/rsrc: introduce buf registration structure
Date: Wed, 29 Apr 2026 16:25:54 +0100
Message-ID: <881422d8d613a8370ed98b158d2b57b46bb37230.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082701_963080_36F0E1A6 
X-CRM114-Status: GOOD (  18.99  )
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
 io_uring/rsrc.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index c4a7a77d1ee9..ba00238941ed 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,14 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-			struct iovec *iov, struct page **last_hpage);
+					struct io_uring_regbuf_desc *desc,
+					struct page **last_hpage);
 
 /* only define max */
 #define IORING_MAX_FIXED_FILES	(1U << 20)
@@ -36,6 +42,15 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -291,6 +306,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -304,7 +320,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -760,27 +778,27 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov,
-						   struct page **last_hpage)
+					struct io_uring_regbuf_desc *desc,
+					struct page **last_hpage)
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
 
@@ -789,8 +807,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -812,10 +829,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -825,7 +841,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -878,6 +894,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -901,7 +918,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc, &last_hpage);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.53.0


