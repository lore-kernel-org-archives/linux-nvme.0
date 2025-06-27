Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ABEC7EE2A
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2YZLXoFRkCSYAHsnqeTpTF+Exw6OagDw+OX2goqNMro=; b=HUZu7QQauyvf/s/4RLjunFF11X
	OQn82tf7NiH3K4MH2N7O2jqazdLMHCceDKtG2240R3AjvgsW0tXjFquKmAb7WzBoUBVIDMWnB5Qbd
	pPISRdWW9d/VehMPGnt/f5f+u4JhhoYHcAAh8Sav+zjm+l4UjkaRCmt9ucdbsvZCAnUTqNa3jJDDK
	W3EXkIccPp3RZdVG7lplPImL7VsbAiJzQx9A3+EBx1AHKWBQQKE6VdYEiQw0/DAoyDi/U8Xr2NQFe
	RMkXWD1SfJP/jXwWfSSxSwvCbSvlkhSawJOnS1iqaPQuVH/JBoj7VVBeJqYD7LoDqEean2pCvlaB9
	xM4et6OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvF-0000000F4NL-1fh8;
	Fri, 27 Jun 2025 15:23:25 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhs-0000000F1Af-1Ma2
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:37 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3702899a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036975; x=1751641775; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YZLXoFRkCSYAHsnqeTpTF+Exw6OagDw+OX2goqNMro=;
        b=hgkwBgnldMjyYmIhNFeLu9XwrRMKglyYG5kb5mEC3Am6itKPpBjxbkUoiRhIyhidp9
         AeLOhrbqtysiPR95FdKLRmK3gcSWheKmUPm+Ey38GKyYvUgrU94RIOJxY5w4Rpv/57XE
         ivnmCHBo77m53jE/P1a3yj2YyMg9GrZLTYDdqfDwzDq5jQ/JZgjys/B8ku8P3pegot8w
         tQCXWZKxef1LnTg4a43s8RTZcnt5zwh+krj1PxXtvdKzAuRfz0M8jXc8GO1CRBoZ5ftG
         Zu7qxtvvdsuRPgktMKXJA/urhSSf73qVpWT4H9qTrit0lDSiPgXm3xjsK3BjC1A/ZFCc
         v7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036975; x=1751641775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YZLXoFRkCSYAHsnqeTpTF+Exw6OagDw+OX2goqNMro=;
        b=b7Ge5ywV3flvczZPWgApJGQKQMAIXD9ZtimMnumy/f1GzfIR1p+UVDM9fEtMw8pCGU
         OkcbP6ceqIJs+9jKWrIBctaOl3RDzx80MPSUsKfiPQVGECVDMmLZGluZzmpPg9OhYXcp
         uDdceMCidinghaAwFZ0uG8SM5Q2tiDEqUepc0W84a5kJrLptf238ydXTEygmtQHdxtjj
         PhzmXqAu59IyKBnKQWM/DPDP25OqECpfc0tekmu+j+qsiwQ88dwUWWZRNa/I4osYa4Fc
         ja7IoarTT1yvXTO0mm9BtEV7bO6uRLUL1/1FKF/oL3FN77gaEHGInqiWFSQ1yipKsMXL
         FLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUl/zXRgD15SCwObbsJqazMAx6H1L8CPFErhqrzfMd81k6/MEFyXZ6dzrDi/jIksSgyzrBmqRHd+QKC@lists.infradead.org
X-Gm-Message-State: AOJu0YwWcO7R2+v6GlcW5ffSnUfka/dfn+H7ngqrV8DF9jV46UGmHFWm
	8W1idn6/wbHkWbXRvuwQYFgTI6q/4zT3oDZ4SxmwoIL6Ri4/JBFYyxtS5sxdnw==
X-Gm-Gg: ASbGncvdlEte/gsawINuDW1z+93abPjmQF7hHi2LzdW2BWnycVa6LQSVTNn3VSdtGYp
	tlnPoLICC1MS78DG9wg79lmt3kf6Rlj14N1oW8Zq4s08V69JW4yHp86o0aWryrvwqKdqN0fY4f9
	xzGWBK6oFMkj89LCU6m28kKt1TGCPqVhBMyjsWjU8yYm0JGzHwhF2pYvyEE1u8VOSpLm/Iy/Hwq
	kpg45cN+AQwBNZDkCB1eQ8dcsaKR8iTzL6bMLQobR9woNxbZpypcQ0hy02fEYFiHABKQjDfl6CH
	JXbj5xR+8tlQTxNhCAhE/ezYqIoS7GBgPDqZn9r09EKunINh6mF2jJIcAk7C6yb4eLG/26bhSAa
	g
X-Google-Smtp-Source: AGHT+IEDMaNgf7WOM8kyYyBMcDOGvJFoGR6xcOA8m+tsgNKOHS/gPcLRefb2hkTva0eVXEwYG0sVlg==
X-Received: by 2002:a17:906:1446:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-ae3500e3d11mr293023866b.37.1751036974473;
        Fri, 27 Jun 2025 08:09:34 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 10/12] io_uring/rsrc: add dmabuf-backed buffer registeration
Date: Fri, 27 Jun 2025 16:10:37 +0100
Message-ID: <5c11f982536aa26bd03e8d8962919a140a08e473.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080936_375296_020D7C6C 
X-CRM114-Status: GOOD (  19.43  )
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

Add an ability to register a dmabuf backed io_uring buffer. It also
needs know which device to use for attachment, for that it takes
target_fd and extracts the device through the new file op. Unlike normal
buffers, it also retains the target file so that any imports from
ineligible requests can be rejected in next patches.

Suggested-by: Vishal Verma <vishal1.verma@intel.com>
Suggested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
 io_uring/rsrc.h |   1 +
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 274274b80b96..f44aa2670bc5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -10,6 +10,8 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-buf.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -18,6 +20,7 @@
 #include "rsrc.h"
 #include "memmap.h"
 #include "register.h"
+#include "dmabuf.h"
 
 struct io_rsrc_update {
 	struct file			*file;
@@ -793,6 +796,117 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 	return true;
 }
 
+struct io_regbuf_dma {
+	struct io_dmabuf		dmabuf;
+	struct dmavec 			*dmav;
+	struct file			*target_file;
+};
+
+static void io_release_reg_dmabuf(struct io_regbuf_dma *db)
+{
+	if (db->dmav)
+		kfree(db->dmav);
+	io_dmabuf_release(&db->dmabuf);
+	if (db->target_file)
+		fput(db->target_file);
+
+	kfree(db);
+}
+
+static void io_release_reg_dmabuf_cb(void *priv)
+{
+	io_release_reg_dmabuf(priv);
+}
+
+static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
+						struct io_uring_reg_buffer *rb,
+						struct iovec *iov)
+{
+	struct io_rsrc_node *node = NULL;
+	struct io_mapped_ubuf *imu = NULL;
+	struct io_regbuf_dma *regbuf;
+	struct file *target_file;
+	struct scatterlist *sg;
+	struct device *dev;
+	unsigned int segments;
+	int ret, i;
+
+	if (iov->iov_base || iov->iov_len)
+		return ERR_PTR(-EFAULT);
+
+	regbuf = kzalloc(sizeof(*regbuf), GFP_KERNEL);
+	if (!regbuf) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	target_file = fget(rb->target_fd);
+	if (!target_file) {
+		ret = -EBADF;
+		goto err;
+	}
+	regbuf->target_file = target_file;
+
+	if (!target_file->f_op->get_dma_device) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+	dev = target_file->f_op->get_dma_device(target_file);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto err;
+	}
+
+	ret = io_dmabuf_import(&regbuf->dmabuf, rb->dmabuf_fd, dev,
+				DMA_BIDIRECTIONAL);
+	if (ret)
+		goto err;
+
+	segments = regbuf->dmabuf.sgt->nents;
+	regbuf->dmav = kmalloc_array(segments, sizeof(regbuf->dmav[0]),
+				     GFP_KERNEL_ACCOUNT);
+	if (!regbuf->dmav) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for_each_sgtable_dma_sg(regbuf->dmabuf.sgt, sg, i) {
+		regbuf->dmav[i].addr = sg_dma_address(sg);
+		regbuf->dmav[i].len = sg_dma_len(sg);
+	}
+
+	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
+	if (!node) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	imu = io_alloc_imu(ctx, 0);
+	if (!imu) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	imu->nr_bvecs = segments;
+	imu->ubuf = 0;
+	imu->len = regbuf->dmabuf.len;
+	imu->folio_shift = 0;
+	imu->release = io_release_reg_dmabuf_cb;
+	imu->priv = regbuf;
+	imu->flags = IO_IMU_F_DMA;
+	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
+	refcount_set(&imu->refs, 1);
+	node->buf = imu;
+	return node;
+err:
+	if (regbuf)
+		io_release_reg_dmabuf(regbuf);
+	if (imu)
+		io_free_imu(ctx, imu);
+	if (node)
+		io_cache_free(&ctx->node_cache, node);
+	return ERR_PTR(ret);
+}
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 						   struct io_uring_reg_buffer *rb,
 						   struct iovec *iov,
@@ -808,7 +922,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	bool coalesced = false;
 
 	if (rb->dmabuf_fd != -1 || rb->target_fd != -1)
-		return NULL;
+		return io_register_dmabuf(ctx, rb, iov);
 
 	if (!iov->iov_base)
 		return NULL;
@@ -1100,6 +1214,8 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
+	if (imu->flags & IO_IMU_F_DMA)
+		return -EOPNOTSUPP;
 	if (imu->flags & IO_IMU_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 15ad4a885ae5..f567ad82b76c 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -30,6 +30,7 @@ enum {
 
 enum {
 	IO_IMU_F_KBUF			= 1,
+	IO_IMU_F_DMA			= 2,
 };
 
 struct io_mapped_ubuf {
-- 
2.49.0


