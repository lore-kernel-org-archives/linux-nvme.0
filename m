Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DC1C79FB6
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaILBiW8UVywRg2XqjSRQl5ll5pe+zqen2OGZ/aVaeY=; b=f4+zQb4574yEcKUldThoybBdOz
	8M0lGmrowMHEPM5IiV6vw7hRWSITt5HmO+nBQ2XjO/bIHSCFiEXy05uyPhQpzweeT6wtWC9uGOerv
	ZTkOpZJGUw4lCHaj6kXp/XruxYQ3qBbF9xQm6Zo9Cw5KTNkg+zOG88mjP4aSPieCwuvi8RecLgPqj
	0+NNs+i8bhq3GkukyKGnfcA/dmWwi4FjFz8A6noRjyfU7MpnOnsHJrZLNUZNlH8fg+Xmamn49/vzR
	b2S3qfRdI+tc24hekuSxz+Iqa2opSKoNrnvuePDbD89MrRX3YS+GC8yhPn8UPRqXPEXlPM6Eh92UU
	zcfyKFEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qn5-0000000D0px-1LfH;
	Wed, 09 Sep 2026 22:29:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qn0-0000000D0m0-27TS
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 22:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SaILBiW8UVywRg2XqjSRQl5ll5pe+zqen2OGZ/aVaeY=; b=o3VawFo4tLStBuekRe66K6/DKk
	UUhYCbNEsyV2W6bCfIysFVB+qyRIA71kSBkdZFYZDBXVJnoyIahGhtMk0oAOJG7SB9XUL9PMe63Gb
	qb8YEX9lViOOZB8COdpUpUZI0YXQfassaoGhmEsOEZ51uuwDqljaEvOAP2qOzdaj2+bzftVLPODao
	KZXCZ3FLsAFse+g1xyoliqNP9PD1L4UAAwlLbSsokgzzo3+2jAephD1ckxEskZPDgFT+GAl6NnQ6r
	VuKdLXNJ+/bjbmi/QTC7XwxtCk4hPe4Rs5vvIzbDYoW7QGczecAnmmv2d0JpH/fp3t+VAqlfKC/kP
	Vz55yiLg==;
Received: from mail-qk1-x764.google.com ([2607:f8b0:4864:20::764])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Qmw-00000001kxc-3TCq
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 22:29:09 +0000
Received: by mail-qk1-x764.google.com with SMTP id af79cd13be357-92e51302fc6so7246585a.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaILBiW8UVywRg2XqjSRQl5ll5pe+zqen2OGZ/aVaeY=;
        b=IKPN12h1QaXv2Ve2pjg5hODQgJljWqJ+sXVQQJ+XFHq06r65BXmK5hmezwYKRPj45D
         6yoXnUAvPBfivVMtQPSQ/OgQ1jSBMlLCMOH2ALRVXfsuNiJhu26YkmMUDgx432qn8vL+
         7idmNAPQxbncUa3HkFJlFBOzuZpsvzfr9vJNhIQDXaxckmyUVhVmp1Vy8Y9ELd01hsNw
         hxu1Vr2NDgN1YbVSLQzXq5WpNHKPwPykaSE0Z5JcR6ARJ5fxF7jC9SSSzGWvEKGo1XcU
         RT8Egszm+MLLzx+8hKRGbY0/ulTsJvO7PGdWVe8bDvG/zbhFwmidkBnWaxVJPjQsGskP
         Z+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SaILBiW8UVywRg2XqjSRQl5ll5pe+zqen2OGZ/aVaeY=;
        b=Kg375hSx64PzX3mPApGm3dktH+jRuXR2ydjmdrdiGXtmafYv5dREtZuggA13eFbLjP
         gVD3m6qmZePiYkx/4Oklodg9Z4tld36X64F2VLZKBrqPxo2zGspV6Fikzow2JRCSvukq
         VyaAR0HXYuLJcSGoSJo9UpNPh+lpqJj5K4Dli6V5LJ+Z0/a69zW1KdJEn5b9CmGkxNjY
         BEdCvk4q7NVmoZ3c5Ogu0UXBzlGqfNWB+4Ui9MxZZGvI49u3Ej/l2PnWV01y2K1ODLpu
         9o0xZOx0iTRUjTIzAUD6wQFGz1WNLAK8Iwxhx8VSbT0hmfhWjPTn3quRTH5OD7u6fX4F
         zytQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs0YXp9O86A6xQnZ8dls0upKh57wAjuH/fxWhZe+elpnceJ5QVNdMRxU9uo1SbLDrMWHmJ5GOtXsgH@lists.infradead.org
X-Gm-Message-State: AFuF++nrqk3XxM76LdHS4+RsQLq0mVIQVJDEWtMcNT+DWQjt9ztrEG5R
	4kLZBa0/8ZcbsARbIvMKCVcNvCVMRI3kxr64+lImoybk+aD52ec1W/qBvcXU2EZyhiJ9G6ltSzR
	x0Pt5CkzGSRmmUIOrtlpXTsinTSR/bB6MveYnZPwmA5FfEv/CeAv8
X-Gm-Gg: AYBFou3aNQej/iiYxxMo+3I0KWAIWyRK+MmO2ZiWgASXOdbQVZScErnytkP+7pt3lt1
	M4vAPnTcatgTbC8S/G3EcvIVfxkb9fSU0Cxw7heVlnqmnJnXs/hl5iCXBK2cTmnNHNP1Uxk8PUf
	czZaNi27RKdWmjuuIIukzydcPDZrfz8LfcPu0lOO/BF/jso9TM9eU4BeoWRiJo+P/aH2SP8a2su
	TiJEhlLoHqrZv7vswuWlHWCqgFfoXNFidkv0XNSw4J3K/keuMxoicgPzgkkGeDZ8UxmXkpIbgyx
	vfWd6AAgAWavHr1PT4pu/8oWyj8oSWYq1o3ARWyiUvW6NWvteLGqKxRfYgXfyv3k+GhLvSF7TBF
	VT8CuEX4s3IbqfA+wUA==
X-Received: by 2002:a05:620a:e85:b0:939:94c4:b799 with SMTP id af79cd13be357-93994c4b856mr1986140585a.5.1788992944190;
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-939981ed680sm140542785a.3.2026.09.09.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 8F14E402A4;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CB61E40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/6] io_uring/cmd: support fixed buffer for metadata
Date: Wed,  9 Sep 2026 16:28:35 -0600
Message-ID: <20260909222836.2475352-6-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_232907_458789_276040F2 
X-CRM114-Status: GOOD (  25.60  )
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

Allow a "metadata" io_uring fixed buffer to be imported by uring_cmds in
addition to the existing data buffer node. NVMe passthrough requests
will use the new buffer node for their metadata buffers if requested.

Provide a function io_uring_cmd_import_fixed_metadata() analogous to
io_uring_cmd_import_fixed() that initializes an iov_iter for a user
address range contained within a fixed buffer. The buffer node is stored
in previously unused space in struct io_uring_cmd so it can be reused if
imported multiple times and released once the uring_cmd completes.

Whereas a fixed data buffer is indicated by io_uring_sqe's
uring_cmd_flags bit IORING_URING_CMD_FIXED and buf_index, how the fixed
metadata buffer is specified is left up to the uring_cmd implementation.

io_get_buf_node() is split out of io_find_buf_node() and moved to rsrc.h
so it can be reused for the metadata buffer. io_import_fixed() is made
extern so it can be called from uring_cmd.c, and io_rsrc_node is passed
instead of io_mapped_ubuf so uring_cmd.c doesn't have to reach into
io_rsrc_node.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 12 +++++++++++-
 io_uring/rsrc.c              | 28 +++++++++++-----------------
 io_uring/rsrc.h              | 17 +++++++++++++++++
 io_uring/uring_cmd.c         | 30 +++++++++++++++++++++++++++++-
 4 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 2e4368d611ee..6df5f3bf5628 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -16,11 +16,11 @@ struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
 	u32		cmd_op;
 	u32		flags;
 	u8		pdu[32]; /* available inline for free use */
-	u8		unused[8];
+	struct io_rsrc_node *metadata_node;
 };
 
 #define io_uring_sqe128_cmd(sqe, type)	({					\
 	BUILD_BUG_ON(sizeof(type) > ((2 * sizeof(struct io_uring_sqe)) -	\
 				     offsetof(struct io_uring_sqe, cmd)));	\
@@ -68,10 +68,14 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  const struct iovec __user *uvec,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
+int io_uring_cmd_import_fixed_metadata(struct io_uring_cmd *ioucmd,
+				       u16 buf_index, u64 ubuf, size_t len,
+				       int ddir, struct iov_iter *iter,
+				       unsigned int issue_flags);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
  *
@@ -125,10 +129,16 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 						int ddir, struct iov_iter *iter,
 						unsigned issue_flags)
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_cmd_import_fixed_metadata(
+	struct io_uring_cmd *ioucmd, u16 buf_index, u64 ubuf, size_t len,
+	int ddir, struct iov_iter *iter, unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
 				       unsigned issue_flags)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 174f74cbbf60..4bd69803c470 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1134,14 +1134,14 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
 	iov_iter_bvec(iter, ddir, imu->bvec, imu->nr_bvecs, count);
 	iov_iter_advance(iter, offset);
 	return 0;
 }
 
-static int io_import_fixed(int ddir, struct iov_iter *iter,
-			   struct io_mapped_ubuf *imu,
-			   u64 buf_addr, size_t len)
+int io_import_fixed(int ddir, struct iov_iter *iter, struct io_rsrc_node *node,
+		    u64 buf_addr, size_t len)
 {
+	struct io_mapped_ubuf *imu = node->buf;
 	const struct bio_vec *bvec;
 	size_t folio_mask;
 	unsigned nr_segs;
 	size_t offset;
 	int ret;
@@ -1189,28 +1189,22 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 }
 
 inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 					     unsigned issue_flags)
 {
-	struct io_ring_ctx *ctx = req->ctx;
 	struct io_rsrc_node *node;
 
 	if (req->flags & REQ_F_BUF_NODE)
 		return req->buf_node;
-	req->flags |= REQ_F_BUF_NODE;
 
-	io_ring_submit_lock(ctx, issue_flags);
-	node = io_rsrc_node_lookup(&ctx->buf_table, req->buf_index);
-	if (node) {
-		node->refs++;
-		req->buf_node = node;
-		io_ring_submit_unlock(ctx, issue_flags);
-		return node;
-	}
-	req->flags &= ~REQ_F_BUF_NODE;
-	io_ring_submit_unlock(ctx, issue_flags);
-	return NULL;
+	node = io_get_buf_node(req, req->buf_index, issue_flags);
+	if (!node)
+		return NULL;
+
+	req->flags |= REQ_F_BUF_NODE;
+	req->buf_node = node;
+	return node;
 }
 
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags)
@@ -1218,11 +1212,11 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	struct io_rsrc_node *node;
 
 	node = io_find_buf_node(req, issue_flags);
 	if (!node)
 		return -EFAULT;
-	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
+	return io_import_fixed(ddir, iter, node, buf_addr, len);
 }
 
 static int io_buffer_acct_cloned_hpages(struct io_ring_ctx *ctx,
 					struct io_mapped_ubuf *imu)
 {
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index eacfdb70f203..277e2007803d 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -4,10 +4,11 @@
 
 #include <linux/bvec.h>
 #include <linux/io_uring_types.h>
 #include <linux/lockdep.h>
 #include <linux/uio.h>
+#include "io_uring.h"
 
 #define IO_VEC_CACHE_SOFT_CAP		256
 
 enum {
 	IORING_RSRC_FILE		= 0,
@@ -64,10 +65,12 @@ void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node);
 void io_rsrc_data_free(struct io_ring_ctx *ctx, struct io_rsrc_data *data);
 int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
+int io_import_fixed(int ddir, struct iov_iter *iter, struct io_rsrc_node *node,
+		    u64 buf_addr, size_t len);
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags);
 int io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
@@ -100,10 +103,24 @@ static inline struct io_rsrc_node *io_rsrc_node_lookup(struct io_rsrc_data *data
 	if (index < data->nr)
 		return data->nodes[array_index_nospec(index, data->nr)];
 	return NULL;
 }
 
+static inline struct io_rsrc_node *
+io_get_buf_node(const struct io_kiocb *req, u16 buf_index, unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_rsrc_node *node;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	node = io_rsrc_node_lookup(&ctx->buf_table, buf_index);
+	if (node)
+		node->refs++;
+	io_ring_submit_unlock(ctx, issue_flags);
+	return node;
+}
+
 static inline void io_put_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 {
 	lockdep_assert_held(&ctx->uring_lock);
 	if (!--node->refs)
 		io_free_rsrc_node(ctx, node);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 3d5d8b5f4ebb..e4b384094392 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -25,19 +25,25 @@ void io_cmd_cache_free(const void *entry)
 
 static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac = req->async_data;
+	struct io_ring_ctx *ctx = req->ctx;
 
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
 
+	if (ioucmd->metadata_node) {
+		io_put_rsrc_node(ctx, ioucmd->metadata_node);
+		ioucmd->metadata_node = NULL;
+	}
+
 	io_alloc_cache_vec_kasan(&ac->vec);
 	if (ac->vec.nr > IO_VEC_CACHE_SOFT_CAP)
 		io_vec_free(&ac->vec);
 
-	if (io_alloc_cache_put(&req->ctx->cmd_cache, ac)) {
+	if (io_alloc_cache_put(&ctx->cmd_cache, ac)) {
 		ioucmd->sqe = NULL;
 		io_req_async_data_clear(req, REQ_F_NEED_CLEANUP);
 	} else {
 		io_vec_free(&ac->vec);
 	}
@@ -194,10 +200,11 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (!ac)
 		return -ENOMEM;
 	if (ac->vec.iovec)
 		req->flags |= REQ_F_NEED_CLEANUP;
 	ioucmd->sqe = sqe;
+	ioucmd->metadata_node = NULL;
 	return 0;
 }
 
 /*
  * IORING_SETUP_SQE128 contexts allocate twice the normal SQE size for each
@@ -303,10 +310,31 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 	return io_import_reg_vec(ddir, iter, req, &ac->vec, uvec_segs,
 				 issue_flags);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
 
+int io_uring_cmd_import_fixed_metadata(struct io_uring_cmd *ioucmd,
+				       u16 buf_index, u64 ubuf, size_t len,
+				       int ddir, struct iov_iter *iter,
+				       unsigned int issue_flags)
+{
+	struct io_rsrc_node *buf_node = ioucmd->metadata_node;
+
+	if (!buf_node) {
+		struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+		buf_node = io_get_buf_node(req, buf_index, issue_flags);
+		if (!buf_node)
+			return -EFAULT;
+
+		req->flags |= REQ_F_NEED_CLEANUP;
+		ioucmd->metadata_node = buf_node;
+	}
+	return io_import_fixed(ddir, iter, buf_node, ubuf, len);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_metadata);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	io_queue_iowq(req);
-- 
2.55.0


