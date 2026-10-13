Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2B7CC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XiFKLTnTKwy5b9069TX0uLlXDgkgGZV94GstLdAPJNY=; b=aJnBbyxHdqEbQG2D+TzYSPhhh2
	oDrte+734dojxCimJmE+VIkF+xuaL9L96nid33beSBmE7kgoYKyu+FzWw2rjc/f8tPPtkb30OsFJ6
	5Wr1PJvmfhEOz5XhauS7dK6CLgKsQYQz20AA59uQsV/glMp6Ix6NrBERm/ldUxeJXtiziP2fjlxv1
	XBfTeWul00FMMo3hr3ZPLDyuEU7hlEDPXCVe7Zq20a9fbDd+tlbk473xldho/OCsh7ftnlet66xv3
	KtH3DTrvX2ghufcn4o0dRo+Y9QHgut1rFbhbounGczZ/iz0m52P43Gch8Za4fXrqQZkyDp/qk23HC
	aUui+BqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxZ-00000000TGF-124c;
	Thu, 15 Oct 2026 15:01:33 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjWk-0000000E3Cz-35po
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:15 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2119469f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924913; x=1792529713; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiFKLTnTKwy5b9069TX0uLlXDgkgGZV94GstLdAPJNY=;
        b=CYcoSE1tPaMT16TXUqqRQtGFD5kphwn/VZfFdQNIR/T9QcUzllgk4S3TDPAfDXZJU0
         Fq0QNi6GKroNs4Z/bUPpO635suSceATPINkoOJUOnunxxzzGiimoBbTodlYVvV3K1oyl
         zfpBMCTkzVA5KG4aztaK2xakubUO1FYTA8/+jjGkwZw1/bLDHVMk42F2nWbjoshtmHW1
         aW+P0WEnRcum8NGkdmfr4jN01WdyWQ1+5YROamXXcctz4L3Yii3UEpgc3bmlpz7fxko8
         LN+/yfTQ0+IvuUP7gMn/GFMl+K9Lvnz2QGheymZORTUmn0Ju8EVuvujOQmh6Ly07lGVZ
         sgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924913; x=1792529713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiFKLTnTKwy5b9069TX0uLlXDgkgGZV94GstLdAPJNY=;
        b=Z7gkOqvpikglsMReD9vHo6KXHI0sKMA6oxurw+xDCHJ/q8aCj5by8VsnNJ8R+gGVh6
         +G9G7gwVPJ3GZwKr0KnL3HvBscid9FHk1//UheRaPA2CYLd3eSzmuhn7rKsxuv4ntygy
         Q4VnK/cX0T3woQw0h8QTfqRCETyJz2KTXS2jbvcTikBMU0973dr3AkIeiYXc3wqgJKmX
         +O5uvedAAob53hMTT527zLL/ZDnxNbz9CnYJseXa510La36NJr9wDhaObVLgp4BEZ0/8
         mf7CB/9UgJWUZKYhAe6RFQyN3KtarRgTZZqmEeS8yjxHO1wHZtDIC5XWrO0KGueE2xdP
         ZQ8A==
X-Forwarded-Encrypted: i=1; AKwUvBzuhMxb0jknxWLm/S0XL7cj71TXp027A9IiGAGuP0BezDMYkwWzl0vG+NWVdcMLSqjIXaFa7SkpLiKe@lists.infradead.org
X-Gm-Message-State: AFq9FYLDreaYCuJgPGlI4clUHlJoLdDI7b6ns3b/C2OCw1CrBkjcgFY0
	cR0HuNp3ivUOLmoiJi1TPPEcQkiR0QCapZGwZnY914sbTLDOtWgQg9qW
X-Gm-Gg: AYBFou3ZrzqobXw2zZ955whVjy6jy6De9nTvZM2k96vTVluaR+e0niwq7fS1YYXaJTw
	9c5pbhJBs5efIUwUnac1tqvskZuzBP3Of/ZuvNOMQCHmEbsZZ8oJUi4jXAgR137Q632vkBb3cyL
	34ugimm59ZSA8xa1NRWyzbYUaA9Wf4rJLSkZLJ6e683kGU5RITpuzQk40EMxWgatwJyefQEPB+A
	3iooc4gjVXR1zHt2JC6YUVCqwI2xjfz61ITN8hYm+skzQJBbhMEQe9jZnMPzsJ2u4b+OaPtCyct
	NRIGbIFXAgVrnqMrJurM3jYmwP4wnAXQyM7Is6xrOZDcX+nu+5TtWxdbgYRLPcVKuYBxPwlKtm0
	Tuk2aKG9Axjqmhu2UEM5Qmb0/iw5A5DIXjug9FHRnKiUTnrj86GlEfM0EQi3whqeM8dMTp6ouGv
	1GNN2/ZDxa6l+VkraZ6v4wbGDj2KJ1JKI024k14+QNz7rRd7nVo+DCqU4uGuYATd8y+dY8DTsSE
	wdPpn+GO4ZBpJ7NhrHmTyvYEfDhhm3KS0Rs2nwk26wWDu/AoF8gsQEhyniTcQ9ioGrzJdc+IxDy
	FGAtjSi1jsQ=
X-Received: by 2002:a05:6000:4308:b0:488:823d:5060 with SMTP id ffacd0b85a97d-48dbacf1667mr24882320f8f.48.1791924912617;
        Tue, 13 Oct 2026 13:55:12 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:11 -0700 (PDT)
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
Subject: [PATCH v10 01/13] dma-buf: introduce initial file I/O infrastructure
Date: Tue, 13 Oct 2026 21:54:45 +0100
Message-ID: <1caebf340d205f6d4c5137e7a8a548ea3cf3b87d.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135514_858436_E00C83D4 
X-CRM114-Status: GOOD (  34.32  )
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

The goal is to be able to natively use dma-buf in the read-write / IO
path. This patch adds basic building blocks serving as a glue and API
between drivers and upper layer subsystems providing the uAPI. Later
patches implement it for NVMe raw block devices and expose it to the
user space via io_uring.

There are two main objects. struct dma_buf_io_ctx and struct
dma_buf_io_map. The ctx is used during initial registration and serves
as an interface between the upper layer user like io_uring and to the
importer subsystem / driver. The map represents the actual dma map
established for the target device[s] with dma_buf_map_attachment() and
stored in a device specific format. The context is created via a new
file operation ->init_dma_buf_io_ctx.

The ctx-map separation exists to facilitate map invalidation (see
dma_buf_io_invalidate_mappings()). A ctx can create
multiple maps during its lifetime, but there can only be no more than
one (active) map attached to it. Invalidation drops the active map
if present, and any new I/O request will try to create a new one.

The primary task of dma_buf_io_map is to count requests using it
and wait for their completion when we want to destroy the DMA map.

[un]mapping and any work with dma addresses is delegated to the
importer driver via an ops table stored in the ctx, see struct
dma_buf_io_ops. Only the target driver / subsystem knows about devices
it wants to use the dma-buf with, especially in case of multi-device
filesystems or stacking in the future.

Acked-by: Matthew Brost <matthew.brost@intel.com>
Tested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/Makefile     |   2 +-
 drivers/dma-buf/dma-buf-io.c | 183 +++++++++++++++++++++++++++++++++++
 include/linux/dma-buf-io.h   | 105 ++++++++++++++++++++
 include/linux/fs.h           |   2 +
 4 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index b25d7550bacf..523731b0f83e 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
-	 dma-fence-unwrap.o dma-resv.o dma-buf-mapping.o
+	 dma-fence-unwrap.o dma-resv.o dma-buf-mapping.o dma-buf-io.o
 obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
 obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
new file mode 100644
index 000000000000..9ba9c17f900a
--- /dev/null
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common infrastructure for supporing dma-buf in the I/O path.
+ *
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+#include <linux/dma-buf-io.h>
+#include <linux/dma-resv.h>
+
+static void dma_buf_io_map_release(struct dma_buf_io_map *map)
+{
+	struct dma_buf_io_ctx *ctx = map->ctx;
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	percpu_ref_exit(&map->refs);
+	ctx->dev_ops->unmap(ctx, map);
+}
+
+static void dma_buf_io_map_refs_cb(struct percpu_ref *ref)
+{
+	struct dma_buf_io_map *map = container_of(ref, struct dma_buf_io_map, refs);
+
+	complete(&map->drained);
+}
+
+static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_io_map *map;
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	map = rcu_dereference_protected(ctx->map,
+				dma_resv_held(ctx->dmabuf->resv));
+	if (!map)
+		return;
+
+	rcu_assign_pointer(ctx->map, NULL);
+	percpu_ref_kill(&map->refs);
+	/* make sure the map is not visible via ctx->map */
+	synchronize_rcu_expedited();
+	wait_for_completion(&map->drained);
+	dma_buf_io_map_release(map);
+}
+
+int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
+			struct sg_table *sgt)
+{
+	unsigned seg_shift = ~0U;
+	struct scatterlist *sg;
+	unsigned long tmp;
+	int ret;
+
+	for_each_sgtable_dma_sg(sgt, sg, tmp)
+		seg_shift = min(seg_shift, __ffs(sg_dma_len(sg)));
+
+	ret = percpu_ref_init(&map->refs, dma_buf_io_map_refs_cb, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+	init_completion(&map->drained);
+	map->min_seg_shift = seg_shift;
+	map->ctx = ctx;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_init_map, "DMA_BUF");
+
+static struct dma_buf_io_map *__dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf *dmabuf = ctx->dmabuf;
+	struct dma_buf_io_map *map;
+	long ret;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (ctx->is_dead)
+		return ERR_PTR(-ENOENT);
+
+	map = __dma_buf_io_get_map(ctx);
+	if (map)
+		return map;
+
+	map = ctx->dev_ops->map(ctx);
+	if (IS_ERR(map))
+		return map;
+
+	if (WARN_ON_ONCE(!map->min_seg_shift))
+		return ERR_PTR(-EFAULT);
+
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (ret <= 0) {
+		if (!ret)
+			ret = -EAGAIN;
+		dma_buf_io_map_release(map);
+		return ERR_PTR(ret);
+	}
+
+	/* get a reference for the caller */
+	percpu_ref_get(&map->refs);
+	rcu_assign_pointer(ctx->map, map);
+	return map;
+}
+
+struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_io_map *map;
+	int ret;
+
+	ret = dma_resv_lock_interruptible(ctx->dmabuf->resv, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	map = __dma_buf_io_create_map(ctx);
+	dma_resv_unlock(ctx->dmabuf->resv);
+	return map;
+}
+
+static void dma_buf_io_ctx_shutdown(struct dma_buf_io_ctx *ctx)
+{
+	dma_resv_lock(ctx->dmabuf->resv, NULL);
+	ctx->is_dead = true;
+	dma_buf_io_kill_map(ctx);
+	dma_resv_unlock(ctx->dmabuf->resv);
+}
+
+int dma_buf_io_ctx_create(struct file *file,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir,
+			   struct dma_buf_io_ctx **out_ctx)
+{
+	struct dma_buf_io_ctx *ctx;
+	int ret;
+
+	if (!file->f_op->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->dir = dir;
+	ctx->dmabuf = dmabuf;
+	get_dma_buf(dmabuf);
+
+	ret = file->f_op->init_dma_buf_io_ctx(file, ctx);
+	if (ret) {
+		kfree(ctx);
+		dma_buf_put(dmabuf);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!ctx->dev_ops ||
+			 !ctx->dev_ops->map ||
+			 !ctx->dev_ops->unmap ||
+			 !ctx->dev_ops->release))
+		return -EINVAL;
+
+	*out_ctx = ctx;
+	return 0;
+}
+
+void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_ctx_shutdown(ctx);
+
+	if (WARN_ON_ONCE(rcu_dereference_protected(ctx->map, true)))
+		return;
+
+	ctx->dev_ops->release(ctx);
+	dma_buf_put(ctx->dmabuf);
+	kfree(ctx);
+}
+
+void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_kill_map(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_invalidate_mappings, "DMA_BUF");
+
+void dma_buf_io_detach(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_ctx_shutdown(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_detach, "DMA_BUF");
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
new file mode 100644
index 000000000000..8ac338df51ff
--- /dev/null
+++ b/include/linux/dma-buf-io.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DMA_BUF_IO_H__
+#define __DMA_BUF_IO_H__
+
+#include <linux/dma-buf.h>
+
+struct dma_buf_io_ctx;
+struct dma_buf_io_map;
+
+struct dma_buf_io_ops {
+	/*
+	 * Create a new map for the given ctx. Called with the reservation
+	 * lock held.
+	 */
+	struct dma_buf_io_map *(*map)(struct dma_buf_io_ctx *ctx);
+
+	/*
+	 * Clean up device specific parts of the @map. Called with the
+	 * reservation lock held.
+	 */
+	void (*unmap)(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map);
+
+	/*
+	 * The user tries to destroy the ctx. Release all device specific
+	 * parts of the token.
+	 */
+	void (*release)(struct dma_buf_io_ctx *);
+};
+
+struct dma_buf_io_map {
+	/*
+	 * Counts attached requests and other users. Device specific unmapping
+	 * is deferred until all refs are dropped.
+	 */
+	struct percpu_ref		refs;
+	/*
+	 * Shift for the minimum segment size of the mapping.
+	 */
+	unsigned			min_seg_shift;
+
+	struct dma_buf_io_ctx		*ctx;
+	struct completion		drained;
+};
+
+struct dma_buf_io_ctx {
+	struct dma_buf_io_map __rcu		*map;
+	struct dma_buf				*dmabuf;
+	enum dma_data_direction			dir;
+	bool					is_dead;
+
+	void					*dev_priv;
+	const struct dma_buf_io_ops		*dev_ops;
+};
+
+int dma_buf_io_ctx_create(struct file *file,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir,
+			   struct dma_buf_io_ctx **ctx);
+void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx);
+
+struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx);
+
+static inline struct dma_buf_io_map *
+__dma_buf_io_get_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_io_map *map;
+
+	guard(rcu)();
+
+	map = rcu_dereference(ctx->map);
+	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
+		return NULL;
+
+	return map;
+}
+
+static inline struct dma_buf_io_map *
+dma_buf_io_get_map(struct dma_buf_io_ctx *ctx, bool nowait)
+{
+	struct dma_buf_io_map *map;
+
+	map = __dma_buf_io_get_map(ctx);
+	if (likely(map))
+		return map;
+
+	if (nowait)
+		return ERR_PTR(-EAGAIN);
+	return dma_buf_io_create_map(ctx);
+}
+
+static inline void dma_buf_io_map_drop(struct dma_buf_io_map *map)
+{
+	percpu_ref_put(&map->refs);
+}
+
+/*
+ * Device API
+ */
+
+void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx);
+int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
+			struct sg_table *sgt);
+void dma_buf_io_detach(struct dma_buf_io_ctx *ctx);
+
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..05c1ff495732 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1914,6 +1914,7 @@ struct dir_context {
 #define COPY_FILE_SPLICE		(1 << 0)
 
 struct io_uring_cmd;
+struct dma_buf_io_ctx;
 struct offset_ctx;
 
 struct file_operations {
@@ -1960,6 +1961,7 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.54.0


