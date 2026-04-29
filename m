Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC90BFF887E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GR5ndKNNRfx4IwKN9v/ALZWj8JN4jvbZ2IeaIPIqzHs=; b=U96fUp+zIaabLPk19D6beL6f9G
	FBlUbiLsRHzNWYYRTzCmXH4JX6bJz0+ZuBN5LCCXnumHjCp7wq7vU+wX+zCqQSCaTDkK01vhy9AuS
	uyBPNAGxMYQTjsLAKQyT60L5pA2EbGJcfL2TAzLESm5f2EFCrIqOHjbHSFzKOWy0oG2RbOE+n7iKZ
	9Exhkqas9bvD71V7uBuOup4nPegpcmTS5Kuu6DXYJ/jkAPH9PcRKUOXGiG2aV7YmONBKuxtKBTT0L
	DhhVyPR/sY7SG83jSmUx6UvAsk4L5EkogQxT99D9ZGls1LlLF5GEQWo4/SCgO0daXn/FiMhPKGvHF
	syg4xkYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oL-00000003qGx-0zmI;
	Wed, 29 Apr 2026 15:26:49 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oH-00000003qD5-3jJ8
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:26:47 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so10404896f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476404; x=1778081204; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR5ndKNNRfx4IwKN9v/ALZWj8JN4jvbZ2IeaIPIqzHs=;
        b=KqIPcvj22xFiK2ATCxI9B3F57WN2PMDU4XhJOHqgHSINZCT+7twcYPjLI/DFh/T97V
         zOxbBATXHkSBjgVkLPWXUge8GT76je1WcJYZSYlinck6YuntGtbcQXbRRJzThRYDg0Hs
         VHZ41WmwoTvfDf8z6UHFe+D38y8+iIc4TPW1J/bBMrxkyr0IZbG0mBOQNBd8mTK+cEhP
         km9BqePPkQRfVnlyBId2EcEZRHB8MqCsVRXfxZP2B8ykWCiv4OghozSGwfuUVE/eJQhi
         PL7vtoBS1Idf+FVxXpWqXbMU/KRMNsvM1XFGizC/VE9yCq84R1xwwNs68mBJOB7GNOEo
         zNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476404; x=1778081204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GR5ndKNNRfx4IwKN9v/ALZWj8JN4jvbZ2IeaIPIqzHs=;
        b=QtVeh6+if0iW575HjIcHTo6fiWNQ5TLbSz0RgV3ioB41c+ZXYpHEqMYtb8w7oTxA+l
         J0gn2fkkrsZRe4nJoAxJ00TcNHVuTy2XI5pjv/M+3xUnQ8aV/Y76zAsUPAaskn+95qXz
         oYdz4C+X4AJ0w+8elGmHAe/3cyUNM5veu6aoSOSftoDGlexyx5FxEWtwRiCwvbmF8h5j
         I75dkaJskaMxMXoCDKaFFbYv6u4A0V3ghrfpxXDjIQprtcejWSjms7LXVO1lJhaFU1Sq
         FYWSCvXMUzqsmGQS5cJtXk+gtF8Diqy96HmKxB6jnftqReWtDrqr5Sp/8EC3uYvqbv4q
         5O/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hCkIo3mk7G3aU9PgnOINtEq+x/F0BqHm7xdVr+ZFKApJUpZCa1is1YI0CSO0Gxtzald3NsoIbKy0F@lists.infradead.org
X-Gm-Message-State: AOJu0YzQOSN2cJL99r4VpggR7V3hxdwAiL/rXJYJI8+AGnj90fvWOc+E
	+ahHXKEMSmYxEntqBjbukESU/SY/eNwboutH4ek9yOraNDYA7gxKjsHq
X-Gm-Gg: AeBDievvgyed3dKexID6o3TrD4RRbkkvl7llMUDoja771a6OYN/Dtorn6pzTsupR1O+
	nLJWjqZVZOBEAMUnE9+11AA0zvSiZf/MMx6ISyP8HV90EvxKbhvMAKMob3cxon8PsLi6FzRabif
	Ft/xTVbgC+qirNnKX10YIJeE4OSpZyCsjsgJaFy/xt+s2i5fxYQjbfCwfIzWSiq+3V1bMVrK+24
	creUIROKEohWxRE15MvW0Bpj02UKBtkk9Xal4nBTIEigLNsmRqg+Oc6SjAjH3/p317144V0KV8i
	4s763tMD2oEbFCF+UJUDjLYPmxNZotH03GaE/0wlAWKWZIJzX7EhDPwsDYduJyrsC48JazumIXB
	0nfg9MzF/gnqIwVSHm5DFjaxh7Gp9kzRRdUKlWMKOmM2sq4YAVKrDLDiFia38s1wd7lpcVL+V5q
	PZEdACQ0zoWFC956DN7HaBEwIMoP+1y7KaO3rJX2qjRQzsS1+OjX/i0pHhUD4VyS1hR8jaZY1Qv
	RaHPZ4SNYEuOYkFeE8kwKS7zYliOUoaAbzbdUToK4fY
X-Received: by 2002:a05:6000:2681:b0:441:1ca1:6404 with SMTP id ffacd0b85a97d-4478ee6236amr7736191f8f.18.1777476403705;
        Wed, 29 Apr 2026 08:26:43 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:43 -0700 (PDT)
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
Subject: [PATCH v3 05/10] lib: add dmabuf token infrastructure
Date: Wed, 29 Apr 2026 16:25:51 +0100
Message-ID: <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082646_014927_D77EF9D9 
X-CRM114-Status: GOOD (  36.60  )
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

There are two main objects. struct io_dmabuf_token and struct
io_dmabuf_map. The token is used during initial registration and serves
as an interface between the upper layer user like io_uring and to the
importer subsystem / driver. io_dmabuf_map represens the actual dma map
established for the target device[s] with dma_buf_map_attachment() and
stored in a device specific format.

The separation into two different objects exists to support map
invalidation (see dma_buf_invalidate_mappings()). A token can create
multiple maps during its lifetime, but there can only be one (active)
map attached to it. It's aslo possible to not have an active map.
Invalidation drops the active map if present, and the next map will
only be attempted to be created once there is a new request that
wants to use the token.

The primary task of the io_dmabuf_map object is to count all requests
currently using it, which is done with percpu refcounts. When a map is
invalidated, we remove it from the token, so there can be no new
requests, then it adds a fence to the dmabuf reservation object. Once
all the requests complete, we signal the fence and unmap it.

[un]mapping and any work with dma addresses is delegated to the
importer driver via an ops table stored in the token, see struct
io_dmabuf_token_dev_ops. That's required because the generic layer
doesn't have knowledge about the device it's going to be use with,
and there will be more complex use cases with multiple devices.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_dmabuf_token.h |  92 +++++++++++
 lib/Kconfig                     |   4 +
 lib/Makefile                    |   2 +
 lib/io_dmabuf_token.c           | 272 ++++++++++++++++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 include/linux/io_dmabuf_token.h
 create mode 100644 lib/io_dmabuf_token.c

diff --git a/include/linux/io_dmabuf_token.h b/include/linux/io_dmabuf_token.h
new file mode 100644
index 000000000000..b94bda684812
--- /dev/null
+++ b/include/linux/io_dmabuf_token.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DMA_TOKEN_H
+#define _LINUX_DMA_TOKEN_H
+
+#include <linux/dma-buf.h>
+
+struct io_dmabuf_fence;
+struct io_dmabuf_token;
+struct io_dmabuf_map;
+
+struct io_dmabuf_token_dev_ops {
+	/*
+	 * Create a new map for the given token. It should be initialised
+	 * with io_dmabuf_init_map(). The callback is executed with the
+	 * reservation lock held.
+	 */
+	struct io_dmabuf_map *(*map)(struct io_dmabuf_token *);
+
+	/*
+	 * Clean up device specific parts of the map. The callback is
+	 * executed with the reservation lock held.
+	 */
+	void (*unmap)(struct io_dmabuf_token *, struct io_dmabuf_map *);
+
+	/*
+	 * The user tries to destroy the token. Release all device specific
+	 * parts of the token.
+	 */
+	void (*release)(struct io_dmabuf_token *);
+};
+
+struct io_dmabuf_map {
+	/*
+	 * Counts attached requests and other users. Device specific unmapping
+	 * is deferred until all refs are dropped.
+	 */
+	struct percpu_ref		refs;
+
+	struct work_struct		release_work;
+	struct io_dmabuf_fence		*fence;
+	struct io_dmabuf_token		*token;
+};
+
+struct io_dmabuf_token {
+	struct io_dmabuf_map __rcu	*map;
+	struct dma_buf			*dmabuf;
+	enum dma_data_direction		dir;
+
+	atomic_t			fence_seq;
+	u64				fence_ctx;
+	struct work_struct		release_work;
+	refcount_t			refs;
+
+	void					*dev_priv;
+	const struct io_dmabuf_token_dev_ops	*dev_ops;
+};
+
+int io_dmabuf_token_create(struct file *file,
+			   struct io_dmabuf_token *token,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir);
+void io_dmabuf_token_release(struct io_dmabuf_token *token);
+
+struct io_dmabuf_map *io_dmabuf_create_map(struct io_dmabuf_token *token);
+
+static inline struct io_dmabuf_map *io_dmabuf_get_map(struct io_dmabuf_token *token)
+{
+	struct io_dmabuf_map *map;
+
+	guard(rcu)();
+
+	map = rcu_dereference(token->map);
+	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
+		return NULL;
+
+	return map;
+}
+
+static inline void io_dmabuf_map_drop(struct io_dmabuf_map *map)
+{
+	percpu_ref_put(&map->refs);
+}
+
+/*
+ * Device API
+ */
+
+void io_dmabuf_token_invalidate_mappings(struct io_dmabuf_token *token);
+int io_dmabuf_init_map(struct io_dmabuf_token *token, struct io_dmabuf_map *map);
+
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb9610647..853f10bf8e1a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -636,3 +636,7 @@ config UNION_FIND
 
 config MIN_HEAP
 	bool
+
+config DMABUF_TOKEN
+	def_bool y
+	depends on DMA_SHARED_BUFFER
diff --git a/lib/Makefile b/lib/Makefile
index ea660cca04f4..4a42cfcaa80c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -246,6 +246,8 @@ obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 
 obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 
+obj-$(CONFIG_DMABUF_TOKEN) += io_dmabuf_token.o
+
 # stackdepot.c should not be instrumented or call instrumented functions.
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
 # file.
diff --git a/lib/io_dmabuf_token.c b/lib/io_dmabuf_token.c
new file mode 100644
index 000000000000..808b5ad33dbc
--- /dev/null
+++ b/lib/io_dmabuf_token.c
@@ -0,0 +1,272 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common infrastructure for supporing dma-buf in the I/O path.
+ *
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+#include <linux/io_dmabuf_token.h>
+#include <linux/dma-resv.h>
+
+struct io_dmabuf_fence {
+	struct dma_fence base;
+	spinlock_t lock;
+};
+
+static const char *io_dmabuf_fence_drv_name(struct dma_fence *fence)
+{
+	/* default fence release kfree's the base pointer */
+	BUILD_BUG_ON(offsetof(struct io_dmabuf_fence, base));
+
+	return "DMABUF token";
+}
+
+static const char *io_dmabuf_fence_timeline_name(struct dma_fence *fence)
+{
+	return "DMABUF token";
+}
+
+const struct dma_fence_ops io_dmabuf_fence_ops = {
+	.get_driver_name = io_dmabuf_fence_drv_name,
+	.get_timeline_name = io_dmabuf_fence_timeline_name,
+};
+
+static void io_dmabuf_token_destroy_work(struct work_struct *work)
+{
+	struct io_dmabuf_token *token = container_of(work, struct io_dmabuf_token,
+				  release_work);
+
+	if (WARN_ON_ONCE(refcount_read(&token->refs)))
+		return;
+
+	token->dev_ops->release(token);
+	dma_buf_put(token->dmabuf);
+	kfree(token);
+}
+
+static void io_dmabuf_map_release_work(struct work_struct *work)
+{
+	struct io_dmabuf_map *map = container_of(work, struct io_dmabuf_map,
+					         release_work);
+	struct io_dmabuf_fence *fence = map->fence;
+	struct io_dmabuf_token *token = map->token;
+	struct dma_buf *dmabuf = token->dmabuf;
+
+	/* the release path must wait for fences */
+	if (WARN_ON_ONCE(refcount_read(&token->refs) == 0))
+		return;
+
+	/* Prevent from destoying the token while unmapping */
+	refcount_inc(&token->refs);
+
+	/*
+	 * There are no more requests using the map, we can signal the fence.
+	 * It should be done before taking the resv lock as someone could be
+	 * waiting for the fence while holding the lock.
+	 */
+	dma_fence_signal(&fence->base);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	token->dev_ops->unmap(token, map);
+	dma_resv_unlock(dmabuf->resv);
+
+	dma_fence_put(&fence->base);
+	percpu_ref_exit(&map->refs);
+	kfree(map);
+
+	if (refcount_dec_and_test(&token->refs)) {
+		/*
+		 * Destruction needs to wait for I/O and dma fences. Defer it to
+		 * simplify locking.
+		 */
+		INIT_WORK(&token->release_work, io_dmabuf_token_destroy_work);
+		queue_work(system_wq, &token->release_work);
+	}
+}
+
+static void io_dmabuf_map_refs_release(struct percpu_ref *ref)
+{
+	struct io_dmabuf_map *map = container_of(ref, struct io_dmabuf_map, refs);
+
+	/* might sleep, use a worker */
+	INIT_WORK(&map->release_work, io_dmabuf_map_release_work);
+	queue_work(system_wq, &map->release_work);
+}
+
+int io_dmabuf_init_map(struct io_dmabuf_token *token, struct io_dmabuf_map *map)
+{
+	struct io_dmabuf_fence *fence = NULL;
+	int ret;
+
+	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence)
+		return -ENOMEM;
+
+	ret = percpu_ref_init(&map->refs, io_dmabuf_map_refs_release, 0, GFP_KERNEL);
+	if (ret) {
+		kfree(fence);
+		return ret;
+	}
+
+	spin_lock_init(&fence->lock);
+	dma_fence_init(&fence->base, &io_dmabuf_fence_ops, &fence->lock,
+			token->fence_ctx, atomic_inc_return(&token->fence_seq));
+	map->fence = fence;
+	map->token = token;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(io_dmabuf_init_map, "DMA_BUF");
+
+struct io_dmabuf_map *io_dmabuf_create_map(struct io_dmabuf_token *token)
+{
+	struct dma_buf *dmabuf = token->dmabuf;
+	struct io_dmabuf_map *map;
+	long ret;
+
+retry:
+	/*
+	 * ->dmabuf_map() will be calling dma_buf_map_attachment(), for which
+	 * we'll need to wait for fences. Do a bit nicer and try to wait
+	 * without the resv lock first.
+	 */
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (!ret)
+		ret = -EAGAIN;
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	map = io_dmabuf_get_map(token);
+	if (map) {
+		ret = 0;
+		goto out;
+	}
+
+	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				  true, 0) < 0) {
+		dma_resv_unlock(dmabuf->resv);
+		goto retry;
+	}
+
+	map = token->dev_ops->map(token);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto out;
+	}
+
+	percpu_ref_get(&map->refs);
+	rcu_assign_pointer(token->map, map);
+out:
+	dma_resv_unlock(dmabuf->resv);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	return map;
+}
+
+static void io_dmabuf_drop_map(struct io_dmabuf_token *token)
+{
+	struct dma_buf *dmabuf = token->dmabuf;
+	struct io_dmabuf_map *map;
+	int ret;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	map = rcu_dereference_protected(token->map,
+					dma_resv_held(dmabuf->resv));
+	if (!map)
+		return;
+	rcu_assign_pointer(token->map, NULL);
+
+	ret = dma_resv_reserve_fences(dmabuf->resv, 1);
+	if (WARN_ON_ONCE(ret)) {
+		struct dma_fence *fence = &map->fence->base;
+
+		dma_fence_get(fence);
+		percpu_ref_kill(&map->refs);
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		return;
+	}
+
+	dma_resv_add_fence(dmabuf->resv, &map->fence->base,
+			   DMA_RESV_USAGE_KERNEL);
+	/*
+	 * Delay destruction until all inflight requests using the map are
+	 * gone. It'll also signal the fence then.
+	 */
+	percpu_ref_kill(&map->refs);
+}
+
+void io_dmabuf_token_invalidate_mappings(struct io_dmabuf_token *token)
+{
+	io_dmabuf_drop_map(token);
+}
+EXPORT_SYMBOL_NS_GPL(io_dmabuf_token_invalidate_mappings, "DMA_BUF");
+
+static void io_dmabuf_token_release_work(struct work_struct *work)
+{
+	struct io_dmabuf_token *token = container_of(work, struct io_dmabuf_token,
+						  release_work);
+	struct dma_buf *dmabuf = token->dmabuf;
+	long ret;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	/* Remove the last map, there should be no new ones going forward. */
+	io_dmabuf_drop_map(token);
+	dma_resv_unlock(dmabuf->resv);
+
+	/* Wait until all maps are destroyed. */
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    false, MAX_SCHEDULE_TIMEOUT);
+
+	if (WARN_ON_ONCE(ret <= 0))
+		return;
+	if (WARN_ON_ONCE(rcu_dereference_protected(token->map, true)))
+		return;
+
+	if (refcount_dec_and_test(&token->refs))
+		io_dmabuf_token_destroy_work(&token->release_work);
+}
+
+void io_dmabuf_token_release(struct io_dmabuf_token *token)
+{
+	/*
+	 * Destruction needs to wait for I/O and dma fences. Defer it to
+	 * simplify locking.
+	 */
+	INIT_WORK(&token->release_work, io_dmabuf_token_release_work);
+	queue_work(system_wq, &token->release_work);
+}
+
+int io_dmabuf_token_create(struct file *file,
+			   struct io_dmabuf_token *token,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir)
+{
+	int ret;
+
+	if (!file->f_op->create_dmabuf_token)
+		return -EOPNOTSUPP;
+
+	memset(token, 0, sizeof(*token));
+	token->fence_ctx = dma_fence_context_alloc(1);
+	token->dir = dir;
+	token->dmabuf = dmabuf;
+	refcount_set(&token->refs, 1);
+	get_dma_buf(dmabuf);
+
+	ret = file->f_op->create_dmabuf_token(file, token);
+	if (ret) {
+		memset(token, 0, sizeof(*token));
+		dma_buf_put(dmabuf);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!token->dev_ops ||
+			 !token->dev_ops->map ||
+			 !token->dev_ops->unmap ||
+			 !token->dev_ops->release))
+		return -EINVAL;
+
+	return ret;
+}
-- 
2.53.0


