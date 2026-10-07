Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8648ECA9EC6
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RDZ31Mwy7qTs5cKwN/Ctw4FRuFm1jTcDEgRrcGxHyww=; b=zV6o1pJUQrpvKmh74L8PhT6PlH
	zYX8FSQ8t6jQCBc+tbaq9kzS94StUTY8MZUHE/9esvcSq9Ksppoc34uQSakvSSV7PXkUgTKjGTk3V
	ipk/JEUpuIV5fQ68NlhW3ZOINFGQlE6d8PVAnV3NffMNe6punEPZzv0aCxVhv8HikRYC4KNrA1YOm
	t+P8JlWVDRaGEVMEe0gvpfk2NwUCy9J4ZpX1Uv7EImW8PW6xzdcVHidoXE6hL2zk+bN58Y2D9intR
	amUVELjv5q3HrqFY3cYIgtQEkNpb92IMx+hRNMMsAooVoRB/qYJ6i+V63tzoiI4N2Tkawj2OUZs8b
	dHy9ZcYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtr-00000006hyU-3qz7;
	Fri, 09 Oct 2026 16:56:51 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgq-00000001cID-1V65
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:30 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4a02718da81so10913715e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337407; x=1791942207; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDZ31Mwy7qTs5cKwN/Ctw4FRuFm1jTcDEgRrcGxHyww=;
        b=XqPetaK3qpRqnAkvAzJL8qEVP4Bp/X6UJNSc9/rq7EPBElvxjeqd8N4IFzyRFGPVWA
         WDq1T69ZTh4xFixiHrSDM1rPQ5AKoZkTnrHwS0x5HWtAzf/I3A0hZreQVWCPoor+liMM
         D5ntEltrDIzwmKwIiYSW66WWKxtSIUjmq5+2xmiTqqy5H1KcAMTPDZ1cx0ilXDjEhsli
         FiniRk+qr2R6jfotqNpSkPLfHAjbvlKBi7vmRfvW7J+Y3anI2vi41yeYTKK1iffE2L5t
         ZijXbzj3YXIKmIbsc9udSLQoPS88oWU+MNYVBOBHiPUBMMwtYbKS9x6QBDvmXp8/ePbk
         pQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337407; x=1791942207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDZ31Mwy7qTs5cKwN/Ctw4FRuFm1jTcDEgRrcGxHyww=;
        b=QsXmToHke7aEGB8HmofTdagsQt2aKrBgz9GmDEYUwmYXy+oD6dWe28VM/wx+sQ2eh2
         ZWTrOCSKTBacezBfF7RDkC3x2bwwNzZ0+qCY/Lbxayp5Ow5OROcPiAO2Y1jlUavtSjtt
         VnfE8nyxuFh4OkxgAR4gMayjwiW5oPC7G60kcAKUf1NqxVRNlRbHJr/jevP5G8VOHlRV
         1Bgv0RaSqp/407mxyEbFcdA/29pxWdLif4T8/Nefd2H9FVwtS9mn6b3RyNTHLo5xEhkn
         Pa5FvtMKa4I0NzLZQ9awaY64Gc5Dr3q/PVjVg4DXF7UGtLJw8oY0ndoU+GZuFzhzVGpk
         uyuw==
X-Forwarded-Encrypted: i=1; AKwUvBz8npJCA6Rw8wxryKJMEvdEtscdtWcsxaaPQIrdGsXIma01hCagy+kA4hoKRyMJCMQebyC1oTwz47Jf@lists.infradead.org
X-Gm-Message-State: AFuF++l5n4lLAEBhUNPimeZpVHYSQBQM1gQCQJoS26Z5A7pk+f9Ropsg
	+ntQO+gGjL9v6YoGhooWBt+HaUf67xZyjqcZXisFQbXDO5w3NjDUNlsN
X-Gm-Gg: AYBFou0K9+rCLxvYW3iKwwm95fPl9aBP91JAFome01CIIY0iF2L7G1PZkAwAeA4gO4J
	pbtk98JJHVVhJUyg2wtPAfYOAppimZ/tqwjU/obDTyB5o75vqPmmC/5u6btlkWvt01ZRyuq7tGo
	B0/YThz9JtTEbyDFm8hOHr1UhqVY7uj1DcO4z9K62Bu8DknL7vl7MIJM8P/QbsY22PH1yn+vX9B
	eKazH/yCMqafWnyn/u6TJ9xXR8e0x3RQgLwuQ4eS1XHCHxlBuqxkjhh2pSxcIWkqiP8Wd90Ni4k
	a+Pfpxgps0l2/KChoQF8soRSxhEhnJ1PY3S8n4aui7qsV1SX+0zmtOTnZz15mPN6bVvb42L2yWN
	g43Ei2ty5ffAQtvM2eolfvozBZIfordvGH0DQmL60sNRTYDwRWZtSE3/87iQDk4d8BhH8/b2+s0
	GMws2F2hIrJKOpFsf7CTZHKNy/3E7DCtDaFl6LIxrz0yakei231TOBzLdu+p1Gb5RgDztyF2tXj
	SD1aWnjx3DXy28zx52qatyNB4YlKa6xvTzo6iScdJHNWWl/U9woz//TQ/hn9BC4aN8y8IF0A7Sg
	YGjII21c6K4=
X-Received: by 2002:a05:600c:8706:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4a18041bf42mr6648355e9.20.1791337406696;
        Tue, 06 Oct 2026 18:43:26 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:25 -0700 (PDT)
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
Subject: [PATCH v9 10/13] io_uring/rsrc: extend buffer update
Date: Wed,  7 Oct 2026 02:42:53 +0100
Message-ID: <5c4d7c45c9bbf29b7b1b14a0ef1ef3bb12f903cf.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184328_433454_4A5440B6 
X-CRM114-Status: GOOD (  24.04  )
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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
index b42b66b424a7..abb590833a0f 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -791,13 +791,38 @@ struct io_uring_rsrc_update {
 
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
index 7e58e9d96055..77e6929f665d 100644
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
 						   struct io_uring_regbuf_desc *desc);
 
@@ -90,9 +85,12 @@ static void io_iov_to_regbuf_desc(const struct iovec *iov,
 				  struct io_uring_regbuf_desc *desc)
 {
 	*desc = (struct io_uring_regbuf_desc) {
+		.type = IO_REGBUF_TYPE_UADDR,
 		.uaddr = (u64)(uintptr_t)iov->iov_base,
 		.size = iov->iov_len,
 	};
+	if (!desc->uaddr)
+		desc->type = IO_REGBUF_TYPE_EMPTY;
 }
 
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
@@ -340,6 +338,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
+	if (up->flags)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		u64 tag = 0;
@@ -399,9 +399,8 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 				   struct io_uring_rsrc_update2 *up,
 				   unsigned int nr_args)
 {
+	bool extended = up->flags & IORING_RSRC_UPDATE_EXTENDED;
 	u64 __user *tags = u64_to_user_ptr(up->tags);
-	struct iovec fast_iov, *iov;
-	struct iovec __user *uvec;
 	u64 user_data = up->data;
 	__u32 done;
 	int i, err;
@@ -410,29 +409,49 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
 		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
 		}
+
 		if (tag) {
 			if (!node) {
 				err = -EINVAL;
@@ -443,10 +462,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -481,7 +496,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -495,7 +510,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -595,12 +610,9 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
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
@@ -899,8 +911,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!uaddr) {
-		if (size)
+	if (desc->type >= __IO_REGBUF_TYPE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)) || desc->flags)
+		return ERR_PTR(-EINVAL);
+
+	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
+		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
-- 
2.54.0


