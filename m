Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4717CFD31D
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDOUZTVJgMkXOYK0w7myV3C8dq9FH3xgeb/1ORThyV0=; b=YPTifZl6VyKhzxESxsNtxaBYxF
	ye+N/hqaVK1qrwgz93GYflaJ70CyYtQwphQ1HDlOz0rSdwEzT3ANJWIt2V3VsIdHl8uxGlsnQqtqx
	h3M1jc/8hsEqIM26IcipRIXvNbj8TPsxmwSvOrEDemsn5knZvs9WWOu2db0GgaYhdLxDI5euTd86Q
	eSl3oFNZav75zOhxBdeU8+TkUre4UrZ1Rh8kby/HLkgojggHN952KA4jXoUGrjilHEDm23BIhWfmy
	yFLhfx20nJKOFHR7zMfbHF1IVajE9Tpli/CL4eFfjIyIDxXg2qGdJgmm9MHHnAH3EUZKhGM3tKy57
	JZqPAmeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw8-0000000Akt0-20sR;
	Sun, 23 Nov 2025 22:52:04 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw5-0000000AkpJ-0fVv
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:52:02 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so32863825e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938319; x=1764543119; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDOUZTVJgMkXOYK0w7myV3C8dq9FH3xgeb/1ORThyV0=;
        b=Cok9VMsAYfPXM3oHPUjxH7XppE4uJA47KYesItvHRYANlXbpBml8xPR7HWSvwdFsLB
         7YLntPbSQ6BrjwN1EaumSMdSBAZRD7x7RDdx1KpXSMZ4q3IUHu3WzkvE4R0YvnSngHPi
         tswdQu+QSx4+q2hX3rGAh605LCtBJK1z+DLP3DQVG86ZZH/PfmXtwVXobiOpchnnlYyH
         KtCbWzEjv/1OcTxDChE2wwW+uN0ShgKyhn+7ENBiXNhgjXuHigagXov8fAjfP+wX9mtE
         +c4kMhAYNe/9YxvVcJhL2MDyNhOV1S1fDe2p16rf1drqpYoZaR3c0dS2+GFIiOut0fdZ
         tiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938319; x=1764543119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDOUZTVJgMkXOYK0w7myV3C8dq9FH3xgeb/1ORThyV0=;
        b=Wge4xxBUi/YM7WZchUPhNB/a00oAd0vYlCgVtrBn6I/3GhRxmhCxHCjT4Nqsq8Q5NZ
         cUetEA293gisoV+/qHwQ8ligNXpVbe+2WC7G1Ep7yYZof4EJIAQcgkh6QWJSeIK9uK2C
         BNHfRbCzLogqvcyvlkPzVZUgchLwyQBI2ysSvxYC2E6R88Gs6MtPpXJU+lWvXT8m7HjM
         vLyO8U1lwu0GJnFLKnAaGyjv+C8yTH8/TctfNj/o/ThHsN4Z3tug94/qj1lEWBGt6z2n
         laYZ//Fls1nQ9WeduEykOgADyYnZlvk7kSsd1/SgT9r1Yy/zw6DKhEc52sQUEwvH0ysL
         KtGA==
X-Forwarded-Encrypted: i=1; AJvYcCUt8Sq+9TLY0rjMktnNr5LaOm3wMet8ODRvcxQNPy5AZ2ar1LyGLpeE7/xt9Tdr10cNcs0uMV5GuMZW@lists.infradead.org
X-Gm-Message-State: AOJu0YyI9mvn7fI+BHAtmAZcr/kUgN59E4sAzfXWm1tt5w0TBIaVLRtJ
	ViG3tr4AwjBW95p1c5G/PXlSHG1EhAZqT/PZ6LFadDol+YalDaWHMNnQ
X-Gm-Gg: ASbGncucJOzI6CbD9fNTqL3ZECPn82syW09IHicml+gYYMeWNe3uaHHsrOxpKucI1nM
	IAJVTaxp+lIR9jEUrthf/qPB9rxmB87p4bJrI7tYsIOQ7jRtv4Vd03daMTl2tKh4JpTWCd2PVJH
	VF2yTlveovN5bi7wRBGwyMVWRsJH7Tk4JmXfmSrR0p7afrUxaCbyLqDzoO1n7+Mkm6soxBXn4U7
	ChJgmi2liiiouoXCVwjw7R9yDcrhJm14itOvXrDyiH4Zk5PNjjYUNtiU1iXu6zw4fIMxB8YbgLf
	MGVnxI//R2xzVCtS2iidlEhdDoWWNHc+nDEyncD0gGtGIXiaPp6ss/1trUtTQoNNFxtenMYCbZb
	mSPiQGCN2vZzz2xG5TOAF9xzr5ha9hQ8s9pP1HgjbUX4z1+uNExRL5381Rtb0GYLK9HRQiY3rQW
	d0Hki05D1Cqf35Pg==
X-Google-Smtp-Source: AGHT+IEVGZmbP6f6xRHNG0YOhugv/nk9aBAFhUarY2FYYdxDanQ12tfVqCx9OnxuzVxk1JyVJaIagQ==
X-Received: by 2002:a5d:588c:0:b0:42b:4069:428a with SMTP id ffacd0b85a97d-42cc1cd5d0bmr10157686f8f.12.1763938319012;
        Sun, 23 Nov 2025 14:51:59 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:58 -0800 (PST)
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
Subject: [RFC v2 09/11] io_uring/rsrc: extended reg buffer registration
Date: Sun, 23 Nov 2025 22:51:29 +0000
Message-ID: <f2f71704fd54b6063d66ff7da24630b3788e722e.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145201_242738_6D00ED18 
X-CRM114-Status: GOOD (  20.84  )
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
index deb772222b6d..f64d1f246b93 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -765,15 +765,26 @@ struct io_uring_rsrc_update {
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
index 21548942e80d..691f9645d04c 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,7 +27,8 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
-static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
+static struct io_rsrc_node *
+io_sqe_buffer_register(struct io_ring_ctx *ctx, struct io_uring_reg_buffer *rb,
 			struct iovec *iov, struct page **last_hpage);
 
 /* only define max */
@@ -234,6 +235,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 
 	if (!ctx->file_table.data.nr)
 		return -ENXIO;
+	if (up->flags)
+		return -EINVAL;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
 
@@ -288,10 +291,18 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
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
@@ -302,14 +313,32 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 
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
@@ -322,7 +351,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		err = io_buffer_validate(iov);
 		if (err)
 			break;
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+		node = io_sqe_buffer_register(ctx, &rb, iov, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -337,10 +366,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -375,7 +400,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -389,7 +414,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -493,7 +518,7 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 	up2.data = up->arg;
 	up2.nr = 0;
 	up2.tags = 0;
-	up2.resv = 0;
+	up2.flags = 0;
 	up2.resv2 = 0;
 
 	if (up->offset == IORING_FILE_INDEX_ALLOC) {
@@ -778,6 +803,7 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
+						   struct io_uring_reg_buffer *rb,
 						   struct iovec *iov,
 						   struct page **last_hpage)
 {
@@ -790,6 +816,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
+	if (rb->dmabuf_fd != -1 || rb->target_fd != -1)
+		return NULL;
+
 	if (!iov->iov_base)
 		return NULL;
 
@@ -887,6 +916,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_reg_buffer rb;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -913,7 +943,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+		io_default_reg_buf(&rb);
+		node = io_sqe_buffer_register(ctx, &rb, iov, &last_hpage);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.52.0


