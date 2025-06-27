Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F8DC83026
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6K4ICGJi7vg8mrghmwBGB30DHKQkSgsdxVP0aH+0Cg=; b=QjN6QfnCOOmH4//f8y3eV3pdOi
	n7PI0BtE4mnZn10big4QvGgMiuMXnrTUTgy2LpVL0nzPbnnmYiHSDTmtCBrmPuYOHOtN8ftli+R8j
	uqew1ALM9iKDPqyvLgKfZsIReYl3+WluSwtb3L3gYf23h20kqvcIiBIClZ1tATjK08+w4ngffevXB
	9+wEPsYClQCLfORk/+bQ3s70aBT2jzZy9d5nwyMkTS7NzXhSEX4OEeelLd78iHJ51Ps8l0WrE+dFG
	tRsZlemLHWbMYLq41Fz3dn9F+dEKWNG1Ucor9/Td6QCV+p6X6Zw20EnVZdIB3I2Dp+824mPAxIL/e
	iS9lv3+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvC-0000000F4JZ-2Dza;
	Fri, 27 Jun 2025 15:23:22 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhn-0000000F140-3ojm
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:33 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so412501366b.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036970; x=1751641770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6K4ICGJi7vg8mrghmwBGB30DHKQkSgsdxVP0aH+0Cg=;
        b=dZ5WvRQRzLvDyy8I+MgrmDZMgXg6/7YnVgUbn9SPecUlUyZNQ0psMzZ6tuCw/FGb8t
         3l9yOgOapsJBwS2g50CXeVvH+ArszXEZo+2Ilhwc6cRRjStQuD2fA8xg2IZ0wV2Mto5V
         yCJS89ZtM7MzN9aRfc6rlueqTtxYA02JreZSKBfWzIJtYWswwYBwaErryqZqaEcJGkgn
         R6OKs1bG2d25nk/BoYxGKYLnqTjA/YOzuh1OcBGKYsnlzMZ2iZMDiMgEeB5Um/BVrxNr
         siQF3UN3TjdETYIptdWffczucmDgnfdWvbqaSMphMAAatR4Rke8oEEXqbSsmzRqn0bIr
         YTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036970; x=1751641770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6K4ICGJi7vg8mrghmwBGB30DHKQkSgsdxVP0aH+0Cg=;
        b=bQELlHi4yDtY6C7IsfQGdOh3cBuuegtO/qLqSnz4akVExIB9K7FHjoSIcn7qN/TDuO
         kNWiBeIlBgiHfydF0ch6z5emorgq7ffk/82DsPAELGiEmwhc5DKuecQKU1XjvRmk2kAc
         KZehbdMCgkjJ46NFvFtDHIz8m/lsEnVpcnHQlDObuj1TsYNJ90NfLTrfLxfkerOFaCDH
         5C9HAxrWnh1ep05xAZiyubwGQbGOguhwTEXQkvhkDs0rUXu39q4A6Nz+uJxxPnYE86Zu
         2W0Dni6H7BQMYPJcdN6i8a/eDAsGOivKy5YhYpYfwqUrhYiQ1ZnOHEEbdootm+aJkKLZ
         jrBw==
X-Forwarded-Encrypted: i=1; AJvYcCXZqtCI2Pg9SYi5vKMA2SE4WchRfAEw8t6dbIg63KE4ZROx7GLJaz9yUMuqeHyG00wEtRBmSwCwlHDW@lists.infradead.org
X-Gm-Message-State: AOJu0Yz37TUKkA2H+rl29RweWtH9tlH8eagjKVD6e+EsJhsp9wRHUs7J
	LjAaFrmPzjmUcxxVjfW2p0wfzsrWhDx6deCMBIDb2j6OE4LFDwAkaK4F
X-Gm-Gg: ASbGncuvCqxpILXgA0Qssq8tkBNKwO7PfggfiDXV9poXAaxOE2wZG2wMZmnkNOm/T93
	jjCDyILfT2dZCUv3gqD+dPyyLCFtLgv7/hWdezYRgGzOn5W82m0lxahLB2dPc0h1XokY38VQ1qI
	yw3z+jLvMBDBhqhF6TiWAAINOk3cKsB6gNUyzfHkUr7mjJiOls77iMfNUw+lOtV+bxI6ZO6YJSD
	IDf7BjMnsFN0AeXvLszWDbI+lErTIx3eoOdEVYJDtvmSjc97ku8LnrQjfO2y20L7uNcgE2rsxFi
	BWzC7xl7fYjzPwd1xSFUFMrcGd0qCvLQuTAkH2ilexhbgh5wJCLVwwPp1LfeSD9iRwNX84EUyTD
	lMulHr3mfjlY=
X-Google-Smtp-Source: AGHT+IFniYWNPN+8mcNe7yckcEafkcrp2VyFKI7PCA7fqDb6yhPHxmixUldj16eAhWFieB+CcI2xwg==
X-Received: by 2002:a17:907:1b03:b0:ae3:6744:3677 with SMTP id a640c23a62f3a-ae367443a46mr38239666b.32.1751036969574;
        Fri, 27 Jun 2025 08:09:29 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:28 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 07/12] io_uring/rsrc: extended reg buffer registration
Date: Fri, 27 Jun 2025 16:10:34 +0100
Message-ID: <99fe7ef408aaf60ea064d574735f6d4f89f6de28.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080931_975916_24033B80 
X-CRM114-Status: GOOD (  19.63  )
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

We'll need to pass extra information for buffer registration apart from
iovec, add a flag to struct io_uring_rsrc_update2 that tells that its
data fields points to an extended registration structure, i.e.
struct io_uring_reg_buffer. To do normal registration the user has to
set target_fd and dmabuf_fd fields to -1, and any other combination is
currently rejected.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring.h | 13 ++++++++-
 io_uring/rsrc.c               | 53 +++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index cfd17e382082..596cb71bd214 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -725,15 +725,26 @@ struct io_uring_rsrc_update {
 	__aligned_u64 data;
 };
 
+/* struct io_uring_rsrc_update2::flags */
+enum io_uring_rsrc_reg_flags {
+	IORING_RSRC_F_EXTENDED_UPDATE		= 1,
+};
+
 struct io_uring_rsrc_update2 {
 	__u32 offset;
-	__u32 resv;
+	__u32 flags;
 	__aligned_u64 data;
 	__aligned_u64 tags;
 	__u32 nr;
 	__u32 resv2;
 };
 
+struct io_uring_reg_buffer {
+	__aligned_u64		iov_uaddr;
+	__s32			target_fd;
+	__s32			dmabuf_fd;
+};
+
 /* Skip updating fd indexes set to this value in the fd table */
 #define IORING_REGISTER_FILES_SKIP	(-2)
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index c592ceace97d..21f4932ecafa 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -26,7 +26,8 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
-static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
+static struct io_rsrc_node *
+io_sqe_buffer_register(struct io_ring_ctx *ctx, struct io_uring_reg_buffer *rb,
 			struct iovec *iov, struct page **last_hpage);
 
 /* only define max */
@@ -226,6 +227,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 
 	if (!ctx->file_table.data.nr)
 		return -ENXIO;
+	if (up->flags)
+		return -EINVAL;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
 
@@ -280,10 +283,18 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 	return done ? done : err;
 }
 
+static inline void io_default_reg_buf(struct io_uring_reg_buffer *rb)
+{
+	memset(rb, 0, sizeof(*rb));
+	rb->target_fd = -1;
+	rb->dmabuf_fd = -1;
+}
+
 static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 				   struct io_uring_rsrc_update2 *up,
 				   unsigned int nr_args)
 {
+	bool extended_entry = up->flags & IORING_RSRC_F_EXTENDED_UPDATE;
 	u64 __user *tags = u64_to_user_ptr(up->tags);
 	struct iovec fast_iov, *iov;
 	struct page *last_hpage = NULL;
@@ -294,14 +305,32 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 
 	if (!ctx->buf_table.nr)
 		return -ENXIO;
+	if (up->flags & ~IORING_RSRC_F_EXTENDED_UPDATE)
+		return -EINVAL;
 	if (up->offset + nr_args > ctx->buf_table.nr)
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_reg_buffer rb;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
-		uvec = u64_to_user_ptr(user_data);
+		if (extended_entry) {
+			if (copy_from_user(&rb, u64_to_user_ptr(user_data),
+					   sizeof(rb)))
+				return -EFAULT;
+			user_data += sizeof(rb);
+		} else {
+			io_default_reg_buf(&rb);
+			rb.iov_uaddr = user_data;
+
+			if (ctx->compat)
+				user_data += sizeof(struct compat_iovec);
+			else
+				user_data += sizeof(struct iovec);
+		}
+
+		uvec = u64_to_user_ptr(rb.iov_uaddr);
 		iov = iovec_from_user(uvec, 1, 1, &fast_iov, ctx->compat);
 		if (IS_ERR(iov)) {
 			err = PTR_ERR(iov);
@@ -314,7 +343,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		err = io_buffer_validate(iov);
 		if (err)
 			break;
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+		node = io_sqe_buffer_register(ctx, &rb, iov, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -329,10 +358,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		i = array_index_nospec(up->offset + done, ctx->buf_table.nr);
 		io_reset_rsrc_node(ctx, &ctx->buf_table, i);
 		ctx->buf_table.nodes[i] = node;
-		if (ctx->compat)
-			user_data += sizeof(struct compat_iovec);
-		else
-			user_data += sizeof(struct iovec);
 	}
 	return done ? done : err;
 }
@@ -367,7 +392,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -381,7 +406,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -485,7 +510,7 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 	up2.data = up->arg;
 	up2.nr = 0;
 	up2.tags = 0;
-	up2.resv = 0;
+	up2.flags = 0;
 	up2.resv2 = 0;
 
 	if (up->offset == IORING_FILE_INDEX_ALLOC) {
@@ -769,6 +794,7 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
+						   struct io_uring_reg_buffer *rb,
 						   struct iovec *iov,
 						   struct page **last_hpage)
 {
@@ -781,6 +807,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
+	if (rb->dmabuf_fd != -1 || rb->target_fd != -1)
+		return NULL;
+
 	if (!iov->iov_base)
 		return NULL;
 
@@ -872,6 +901,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_reg_buffer rb;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -898,7 +928,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+		io_default_reg_buf(&rb);
+		node = io_sqe_buffer_register(ctx, &rb, iov, &last_hpage);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.49.0


