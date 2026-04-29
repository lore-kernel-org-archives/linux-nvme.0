Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84625CCFA13
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUujl6+MDkMLMC27AkxpxJZzY2/aRxcdD8WLm5JxhAU=; b=KBNoWJufNPPYOZ6aV/KaH1osei
	+O9bW5eXFY8r7YVG4qpOhlI0NkKa907FeqARXgWlFWSzjdRinx+2L0Mm1buVfFJ2m7XXf901YMIXN
	FDvECaVWdBNOHH7ti12xiOyaUbrSn+EuoGSeR4xVnu4JHx0AxgzUXck/uVDzslfn1lGaSghKEUTkD
	pWRlazIsCFWUswJnPPzz1vvJluyI/eZmY52EaotHdujcEq9tEZBD6rImelU7wxUfXOLbDLm/Zx6gI
	kjlWYiYoU1fuhCI/6OfwAQqQrXJy2eWn5rFHdyAQvUx3r74j/xDEMOXLuju0vDpZ3974W9JnQUoDi
	27nHEh+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6of-00000003qYg-30ZJ;
	Wed, 29 Apr 2026 15:27:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oe-00000003qX5-2NHc
	for linux-nvme@bombadil.infradead.org;
	Wed, 29 Apr 2026 15:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lUujl6+MDkMLMC27AkxpxJZzY2/aRxcdD8WLm5JxhAU=; b=a8K0gc+ADCB+3tNOIxiQ1YEqvv
	L1WHLzrM4UCKKAE7bOUM/8cIPkm6GN7RCjoTQvQ6cdsh6XqHIIbAEKV3JdYnupUeuUoiNEyGiGEBa
	J/HQnpAeVe7SUhGc6lVsBa5GWBmyWOt9gl5Jj3XnZELK62wL+dcnjKSYbePZ9fSA+eZDKTjmSusYC
	Hgit7opRfdHTO2ZtIQNmNVgNvsIX1WucoHievHm6CYzK8zIpQ+NYzq1/qN4uzdxV81MUDN+89v+hd
	Cjlb+SokuiZ/yuZAOaVL6WszkPn+D9HHDwYdGsyWKjAGPyQHhNki9SEXBpeMAhYGJVmjBZYxnQm3V
	t6pXF9Jw==;
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6ob-00000005hlt-31Mz
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:27:07 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so8176156f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476423; x=1778081223; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUujl6+MDkMLMC27AkxpxJZzY2/aRxcdD8WLm5JxhAU=;
        b=F32yBPoXPl0kiNa48rGwYRgt8NdZI02OZOhivM7ItmAl2tRe2bGhFMuSYYtkZTAYz3
         xDPxxZzUyIK2b8FkeR0PTuvNoTkcN+CT7v7lalATI9ciuqMcBllHXYccZGzBEw8Ac8pM
         OblOmrC5ReXdpc8IDi0adsH6o0JP3RsBQEEeuKEYgQXZIFOjgrsG4o/V3NZSh5iI6rNP
         P95nOIi1u2G5vpOlsKAfTIq0xnw5y8mVutf0ncaszNbwpWG5Ef1qzmYGDk8lqaZ9zTzS
         2kIrJ3jV2nI0Cv3KL4xz0MB5ZHWBfKuJdbbh8RyJHDuKmiS60rzoePfNx1ups9Kndt0D
         +4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476423; x=1778081223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUujl6+MDkMLMC27AkxpxJZzY2/aRxcdD8WLm5JxhAU=;
        b=mft1a45dh+Rv7UPH+DHX5G+TT6kya1Dg3RQCWcGkvBwxkBAtby3ZtHpo4uQVleqKde
         lcttEd5VyVHwZD/VVV2GRhIOEbPjmNeohaaCFveMo3ZMaaXVxHa6LeYsjJnBZiiHX++R
         paNbcd0UOYDYXaAamVDMVFOXXMnZty22MVzs/YVOMyyK8GlBU4ALTX9rLpmsEppz17EB
         ZM25PdDoL2ar6C7ekpDdA88FVKj+SMmHXiiCId6/vVUHXo1V8mYU/YgrN4UpjDJnt6FV
         2Gvnx33T6Fc6ostyRmEu34s12ox8GaKX3g6RyAeu4VAmiqkaTBbYKu4iNqVHggvcSATa
         X1UA==
X-Forwarded-Encrypted: i=1; AFNElJ80Oz9HLVBfL5En5zbmoPHO9pQfXHFOI7JGIXWhoDs6wsLcYwdD8LvBXe+8GE0+PM+8tWLiEWfYlF8R@lists.infradead.org
X-Gm-Message-State: AOJu0YzaSh1mD8+6i9CH3hPeajZoZb4gosLiDguRn6yn25RYW2ho4W+L
	PmuE1jF+07x65A3vC0+znPBCwqgJz3ILGmpt/FOuYrZqhugAbMvcKzZr
X-Gm-Gg: AeBDiesem03QvlitkU+DAmghAhMpOy0x0kV6LL1OHIqt9MjDX6czwHriuZsAgulKmaW
	ZxLCelDQeymmNMCgbqegYvh/eaX+9UJC9fmZnC1RKKn0jEDqmkBIGsGLyZisNHz/V1UrwmHoJkr
	yVuyisPkMmngHoSC3Ya90GwY5Qbx3KLkVEytOJIpL5sg8UOU1yOQiq2p3uH5YVkLjo+jcPl71JY
	gA3hwIzl0aiyBNxcvwWYluM8UFxInopibARQvIKdQGNkC2gTsK8P4SvHoVWQhK9Kjc/zfikTgXV
	XCm0J+OY5H+HHMYEVJJhQuF/Lv6hqe0+Pbs4PtuRYB4zkG/ZMD8ucczq8axbd35Mx67VgGtHVFu
	+ZVEJln6N1Bg2mMtnKPsuyJW01pqW3HgPR4+GVqk/CasWH5qksAgvA1zp/NrPmTYwY5T5hb5Gh6
	niBwnxuZSqJOejpbkqlPTh3yYsJsdTBhvuNXwP9FCGS4UFUQrmsRv1R+RZ0PD0z+8ULaL0h4Az4
	mh/+TttCUFy2uGyPXP+Mu7qbgOsO6RFSc5th6WcX0wo
X-Received: by 2002:a05:6000:2903:b0:43d:4b00:9ee7 with SMTP id ffacd0b85a97d-4464b1b8722mr14754743f8f.33.1777476423217;
        Wed, 29 Apr 2026 08:27:03 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:27:02 -0700 (PDT)
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
Subject: [PATCH v3 09/10] io_uring/rsrc: extend buffer update
Date: Wed, 29 Apr 2026 16:25:55 +0100
Message-ID: <a97e2d1338029380995653824dea6bbb09d71775.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_162705_840641_872460CD 
X-CRM114-Status: GOOD (  23.95  )
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

We need to pass more information to buffer registration than we can fit
into a single struct iovec. This patch allows users to optionally pass
struct io_uring_regbuf_desc. Apart from having more space for future use
cases, it also introduces registration types.

Currently, the type can be either of IO_REGBUF_TYPE_UADDR, which mirrors
the iovec path, or IO_REGBUF_TYPE_EMPTY for leaving a buffer table slot
empty. The next patch introduces a dmabuf backed type, and can be useful
for other extensions like splicing a list of user addresses (i.e.
iovec[]), interoperability with zcrx, kernel allocated memory like was
brough up by Cristoph. Note, the type only represents a registration
option, which is distinct from how io_uring internally stores it.

The flags field is not used yet but always useful to have, e.g. we can
encode read-only / write-only restrictions using it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring.h | 27 +++++++++++++-
 io_uring/rsrc.c               | 69 ++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 17ac1b785440..05c3fd078767 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -790,13 +790,38 @@ struct io_uring_rsrc_update {
 
 struct io_uring_rsrc_update2 {
 	__u32 offset;
-	__u32 resv;
+	__u32 flags;
 	__aligned_u64 data;
 	__aligned_u64 tags;
 	__u32 nr;
 	__u32 resv2;
 };
 
+/* struct io_uring_rsrc_update2::flags */
+enum io_uring_rsrc_reg_flags {
+	/*
+	 * Use the extended descriptor format for buffer updates,
+	 * see struct io_uring_regbuf_desc
+	 */
+	IORING_RSRC_UPDATE_EXTENDED		= 1U << 1,
+};
+
+/* Buffer registration type, passed in struct io_uring_regbuf_desc::type */
+enum io_uring_regbuf_type {
+	IO_REGBUF_TYPE_EMPTY,
+	IO_REGBUF_TYPE_UADDR,
+
+	__IO_REGBUF_TYPE_MAX,
+};
+
+struct io_uring_regbuf_desc {
+	__u32 type; /* enum io_uring_regbuf_type */
+	__u32 flags;
+	__u64 size;
+	__u64 uaddr;
+	__u64 __resv[7];
+};
+
 /* Skip updating fd indexes set to this value in the fd table */
 #define IORING_REGISTER_FILES_SKIP	(-2)
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index ba00238941ed..f8696b01cb54 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,11 +27,6 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
-struct io_uring_regbuf_desc {
-	__u64 uaddr;
-	__u64 size;
-};
-
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 					struct io_uring_regbuf_desc *desc,
 					struct page **last_hpage);
@@ -46,9 +41,12 @@ static void io_iov_to_regbuf_desc(const struct iovec *iov,
 				  struct io_uring_regbuf_desc *desc)
 {
 	*desc = (struct io_uring_regbuf_desc) {
+		.type = IO_REGBUF_TYPE_UADDR,
 		.uaddr = (u64)iov->iov_base,
 		.size = iov->iov_len,
 	};
+	if (!desc->uaddr)
+		desc->type = IO_REGBUF_TYPE_EMPTY;
 }
 
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
@@ -236,6 +234,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
+	if (up->flags)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		u64 tag = 0;
@@ -292,10 +292,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 				   struct io_uring_rsrc_update2 *up,
 				   unsigned int nr_args)
 {
+	bool extended = up->flags & IORING_RSRC_UPDATE_EXTENDED;
 	u64 __user *tags = u64_to_user_ptr(up->tags);
-	struct iovec fast_iov, *iov;
 	struct page *last_hpage = NULL;
-	struct iovec __user *uvec;
 	u64 user_data = up->data;
 	__u32 done;
 	int i, err;
@@ -304,29 +303,49 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->buf_table.nr)
 		return -EINVAL;
+	if (up->flags & ~IORING_RSRC_UPDATE_EXTENDED)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
-		uvec = u64_to_user_ptr(user_data);
-		iov = iovec_from_user(uvec, 1, 1, &fast_iov, io_is_compat(ctx));
-		if (IS_ERR(iov)) {
-			err = PTR_ERR(iov);
-			break;
-		}
 		if (tags && copy_from_user(&tag, &tags[done], sizeof(tag))) {
 			err = -EFAULT;
 			break;
 		}
 
-		io_iov_to_regbuf_desc(iov, &desc);
+		if (extended) {
+			if (copy_from_user(&desc, u64_to_user_ptr(user_data),
+					   sizeof(desc))) {
+				err = -EFAULT;
+				break;
+			}
+			user_data += sizeof(desc);
+		} else {
+			struct iovec __user *uvec = u64_to_user_ptr(user_data);
+			struct iovec fast_iov, *iov;
+
+			if (io_is_compat(ctx))
+				user_data += sizeof(struct compat_iovec);
+			else
+				user_data += sizeof(struct iovec);
+
+			iov = iovec_from_user(uvec, 1, 1, &fast_iov, io_is_compat(ctx));
+			if (IS_ERR(iov)) {
+				err = PTR_ERR(iov);
+				break;
+			}
+			io_iov_to_regbuf_desc(iov, &desc);
+		}
+
 		node = io_sqe_buffer_register(ctx, &desc, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
 		}
+
 		if (tag) {
 			if (!node) {
 				err = -EINVAL;
@@ -337,10 +356,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		i = array_index_nospec(up->offset + done, ctx->buf_table.nr);
 		io_reset_rsrc_node(ctx, &ctx->buf_table, i);
 		ctx->buf_table.nodes[i] = node;
-		if (io_is_compat(ctx))
-			user_data += sizeof(struct compat_iovec);
-		else
-			user_data += sizeof(struct iovec);
 	}
 	return done ? done : err;
 }
@@ -375,7 +390,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -389,7 +404,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -489,12 +504,9 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_uring_rsrc_update2 up2;
 	int ret;
 
+	memset(&up2, 0, sizeof(up2));
 	up2.offset = up->offset;
 	up2.data = up->arg;
-	up2.nr = 0;
-	up2.tags = 0;
-	up2.resv = 0;
-	up2.resv2 = 0;
 
 	if (up->offset == IORING_FILE_INDEX_ALLOC) {
 		ret = io_files_update_with_index_alloc(req, issue_flags);
@@ -791,8 +803,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!uaddr) {
-		if (size)
+	if (desc->type >= __IO_REGBUF_TYPE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
+		return ERR_PTR(-EINVAL);
+
+	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
+		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
-- 
2.53.0


