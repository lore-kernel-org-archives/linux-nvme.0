Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C28CFD2F6
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtyRM3SiK93qfGEm4pAX9GDP/9MNGPDztBsVCrDNvOw=; b=PHR5qpioQ3u5aDAgLZsAgc4NSt
	aDh1zye3HpoS/gfpkLHm+RGTIw3YxK5PCGUJ9m95k1CIzw6T/D/ZPW7C/L4C9Tu4Zdxo31cfOIM4z
	BIn2PBDDmb6xGxpifgBSGelU+8NGp4DgNmeA+vzPdfOoz2Aeh4fMN+KFFIx+T/w8SH6rWebTOCxYx
	9FLnoFd6qaQnN2tdIel7Kcn7v9v7OccdvgR+PtJW+fZ745CCZn9Ngv3o2owOYyhnU4SY5n9JVABfZ
	lG0Ep9yrXaZsKsShYArA0Cqqv20YZXCIvYeMzQv5/naQIu0HIaqD4StgqZqLCVl4Z5FGHc2mowKUD
	Aa0jispw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvz-0000000Aklv-2ekr;
	Sun, 23 Nov 2025 22:51:55 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvw-0000000Akj5-48vY
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:54 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-42bb288c17bso2197144f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938311; x=1764543111; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtyRM3SiK93qfGEm4pAX9GDP/9MNGPDztBsVCrDNvOw=;
        b=FIJcsPcPcfirJQvA/Sdo7iBtMbhxvENF8NkO26j5d7Au2axzfRoNwqbKPmMcaISMwe
         khytgltjV9xNh5XT0MvJjIxcP92PygGSR5VYQAhez7jce+ngbTe5QyNtsmxqat1SKoOo
         9MtDILbltWgI8hAQiZh0XgdUqTCCgwwCS/uC/WXwzn3fD/q/cgHth3d7vtAze2FU9Hoa
         gDsBjsizM+JIPCmGVOfucbtQTrNSSqv7Yck0ehGpHHGZI98ecd3V2wtWm7RTJ9h41Tcp
         jgrjYpgKcRuw3HyXloU+lccevtwdE61NTQ0DG4DRLOkHu5ITn5NQy+IefD43DUXSFvuB
         lBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938311; x=1764543111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtyRM3SiK93qfGEm4pAX9GDP/9MNGPDztBsVCrDNvOw=;
        b=AWe0WJqJjgQFT94wtHoOKkOob2wXSGvQ2oBSVbebaM0a1heoIwGQqAJ2WBw9Afjzai
         3tfEXTY2W1Z+B2rrtIQHtB6qd6ruigEZCuc80dKO2JZmqHksxADrVSGjuyo9vPYIS6R2
         COom7iAXWYmV6WA6IL4Kt6Jkmty4CAfNJ6JS6ABS1AjqdNZNj/osfYQbwfJ8+fQYt9Wy
         VT8rp0r8l+gztwXAaPL80+Xog4qAkE7eRf51QH4V34fGEoyiDIZm7PMQqsDaTcOwZB/g
         fer75FqA/msO6jnHMBR6Lm/PP/273cmOSZNaidREAOifFopBSuUxkWu8zjyJE/tMCCRO
         q6yg==
X-Forwarded-Encrypted: i=1; AJvYcCVYg5nEg8b19C1aCZJu/zohz+bxtCxIEnrMBxIdyrc4auj9LDgnJFO+c+CnYxlkrYefZrHEQnKywQMX@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3VAH8ibaG5f4cN1xECmdy0Jt5o93yTQnGw+NrPfxR7VqyVVmJ
	GdrHaKrfSS8NfHU13TBUMaPoAwZ1xDI516qiKfZaI8Q+dIXNPog1cEWl1okzvw==
X-Gm-Gg: ASbGncvaSrgWjs5Zrm7p0y5ivqBQab6ONK+tfxhZC/H88vfb5v8glGSYeQYLyn2eMH2
	tMtNicmVVmDSIo9BYg8txa/J/EH9rZHoOT5jX2tDZkADF2rwJJC0LCqdEZykxi5Ed7Gp7OB0YJ4
	yMUV/w0tOON5kLFDLznfLbmBBsEm0Cd484dMxNdmqBE2o3PUWcF9TkXNu4yGZMkUhX1ZS4PjaTZ
	DSAN+TCeJZUku7i/lYdnRbT+84rLvKoMBleDGXs6J2KvIPwETkWZi4J7I38SwoONjsDJ/IaAAFD
	4te3fmkSNxLQMCckMziDlwx1a0V5Pix2E//QZTPZ3afV1kkuei0z0upz0lp2WiTiVHZJCEEyJeL
	CREsc/2GYZ/4qqdPs/Kf6Qny7zrLaFew6sHQH3q+6YDAxxUdX/f205cNC+V2aO9rYPwURvhPS31
	PKuw289mGb0kv9EQ==
X-Google-Smtp-Source: AGHT+IGfOL+4KpbQvV0qNRfo8OovcJ37mYapE/bWdNNKsAObOGKg7LEW9kMhWjZqfvqDPLpynO+F1g==
X-Received: by 2002:a05:6000:3102:b0:429:d40e:fa40 with SMTP id ffacd0b85a97d-42cc1d0cab6mr8756848f8f.45.1763938310890;
        Sun, 23 Nov 2025 14:51:50 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:50 -0800 (PST)
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
Subject: [RFC v2 05/11] block: add infra to handle dmabuf tokens
Date: Sun, 23 Nov 2025 22:51:25 +0000
Message-ID: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145153_170052_572F360C 
X-CRM114-Status: GOOD (  30.47  )
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

Add blk-mq infrastructure to handle dmabuf tokens. There are two main
objects. The first is struct blk_mq_dma_token, which is an extension of
struct dma_token and passed in an iterator. The second is struct
blk_mq_dma_map, which keeps the actual mapping and unlike the token, can
be ejected (e.g. by move_notify) and recreated.

The token keeps an rcu protected pointer to the mapping, so when it
resolves a token into a mapping to pass it to a request, it'll do an rcu
protected lookup and get a percpu reference to the mapping.

If there is no current mapping attached to a token, it'll need to be
created by calling the driver (e.g. nvme) via a new callback. It
requires waiting, thefore can't be done for nowait requests and couldn't
happen deeper in the stack, e.g. during nvme request submission.

The structure split is needed because move_notify can request to
invalidate the dma mapping at any moment, and we need a way to
concurrently remove it and wait for the inflight requests using the
previous mapping to complete.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/Makefile                   |   1 +
 block/bdev.c                     |  14 ++
 block/blk-mq-dma-token.c         | 236 +++++++++++++++++++++++++++++++
 block/blk-mq.c                   |  20 +++
 block/fops.c                     |   1 +
 include/linux/blk-mq-dma-token.h |  60 ++++++++
 include/linux/blk-mq.h           |  21 +++
 include/linux/blkdev.h           |   3 +
 8 files changed, 356 insertions(+)
 create mode 100644 block/blk-mq-dma-token.c
 create mode 100644 include/linux/blk-mq-dma-token.h

diff --git a/block/Makefile b/block/Makefile
index c65f4da93702..0190e5aa9f00 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_DMA_SHARED_BUFFER) += blk-mq-dma-token.o
diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..da89d20f33f3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/stat.h>
+#include <linux/blk-mq-dma-token.h>
 #include "../fs/internal.h"
 #include "blk.h"
 
@@ -61,6 +62,19 @@ struct block_device *file_bdev(struct file *bdev_file)
 }
 EXPORT_SYMBOL(file_bdev);
 
+struct dma_token *blkdev_dma_map(struct file *file,
+				 struct dma_token_params *params)
+{
+	struct request_queue *q = bdev_get_queue(file_bdev(file));
+
+	if (!(file->f_flags & O_DIRECT))
+		return ERR_PTR(-EINVAL);
+	if (!q->mq_ops)
+		return ERR_PTR(-EINVAL);
+
+	return blk_mq_dma_map(q, params);
+}
+
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = BD_INODE(bdev);
diff --git a/block/blk-mq-dma-token.c b/block/blk-mq-dma-token.c
new file mode 100644
index 000000000000..cd62c4d09422
--- /dev/null
+++ b/block/blk-mq-dma-token.c
@@ -0,0 +1,236 @@
+#include <linux/blk-mq-dma-token.h>
+#include <linux/dma-resv.h>
+
+struct blk_mq_dma_fence {
+	struct dma_fence base;
+	spinlock_t lock;
+};
+
+static const char *blk_mq_fence_drv_name(struct dma_fence *fence)
+{
+	return "blk-mq";
+}
+
+const struct dma_fence_ops blk_mq_dma_fence_ops = {
+	.get_driver_name = blk_mq_fence_drv_name,
+	.get_timeline_name = blk_mq_fence_drv_name,
+};
+
+static void blk_mq_dma_token_free(struct blk_mq_dma_token *token)
+{
+	token->q->mq_ops->clean_dma_token(token->q, token);
+	dma_buf_put(token->dmabuf);
+	kfree(token);
+}
+
+static inline void blk_mq_dma_token_put(struct blk_mq_dma_token *token)
+{
+	if (refcount_dec_and_test(&token->refs))
+		blk_mq_dma_token_free(token);
+}
+
+static void blk_mq_dma_mapping_free(struct blk_mq_dma_map *map)
+{
+	struct blk_mq_dma_token *token = map->token;
+
+	if (map->sgt)
+		token->q->mq_ops->dma_unmap(token->q, map);
+
+	dma_fence_put(&map->fence->base);
+	percpu_ref_exit(&map->refs);
+	kfree(map);
+	blk_mq_dma_token_put(token);
+}
+
+static void blk_mq_dma_map_work_free(struct work_struct *work)
+{
+	struct blk_mq_dma_map *map = container_of(work, struct blk_mq_dma_map,
+						free_work);
+
+	dma_fence_signal(&map->fence->base);
+	blk_mq_dma_mapping_free(map);
+}
+
+static void blk_mq_dma_map_refs_free(struct percpu_ref *ref)
+{
+	struct blk_mq_dma_map *map = container_of(ref, struct blk_mq_dma_map, refs);
+
+	INIT_WORK(&map->free_work, blk_mq_dma_map_work_free);
+	queue_work(system_wq, &map->free_work);
+}
+
+static struct blk_mq_dma_map *blk_mq_alloc_dma_mapping(struct blk_mq_dma_token *token)
+{
+	struct blk_mq_dma_fence *fence = NULL;
+	struct blk_mq_dma_map *map;
+	int ret = -ENOMEM;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence)
+		goto err;
+
+	ret = percpu_ref_init(&map->refs, blk_mq_dma_map_refs_free, 0,
+			      GFP_KERNEL);
+	if (ret)
+		goto err;
+
+	dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
+			token->fence_ctx, atomic_inc_return(&token->fence_seq));
+	spin_lock_init(&fence->lock);
+	map->fence = fence;
+	map->token = token;
+	refcount_inc(&token->refs);
+	return map;
+err:
+	kfree(map);
+	kfree(fence);
+	return ERR_PTR(ret);
+}
+
+static inline
+struct blk_mq_dma_map *blk_mq_get_token_map(struct blk_mq_dma_token *token)
+{
+	struct blk_mq_dma_map *map;
+
+	guard(rcu)();
+
+	map = rcu_dereference(token->map);
+	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
+		return NULL;
+	return map;
+}
+
+static struct blk_mq_dma_map *
+blk_mq_create_dma_map(struct blk_mq_dma_token *token)
+{
+	struct dma_buf *dmabuf = token->dmabuf;
+	struct blk_mq_dma_map *map;
+	long ret;
+
+	guard(mutex)(&token->mapping_lock);
+
+	map = blk_mq_get_token_map(token);
+	if (map)
+		return map;
+
+	map = blk_mq_alloc_dma_mapping(token);
+	if (IS_ERR(map))
+		return NULL;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_BOOKKEEP,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	ret = ret ? ret : -ETIME;
+	if (ret > 0)
+		ret = token->q->mq_ops->dma_map(token->q, map);
+	dma_resv_unlock(dmabuf->resv);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	percpu_ref_get(&map->refs);
+	rcu_assign_pointer(token->map, map);
+	return map;
+}
+
+static void blk_mq_dma_map_remove(struct blk_mq_dma_token *token)
+{
+	struct dma_buf *dmabuf = token->dmabuf;
+	struct blk_mq_dma_map *map;
+	int ret;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	ret = dma_resv_reserve_fences(dmabuf->resv, 1);
+	if (WARN_ON_ONCE(ret))
+		return;
+
+	map = rcu_dereference_protected(token->map,
+					dma_resv_held(dmabuf->resv));
+	if (!map)
+		return;
+	rcu_assign_pointer(token->map, NULL);
+
+	dma_resv_add_fence(dmabuf->resv, &map->fence->base,
+			   DMA_RESV_USAGE_KERNEL);
+	percpu_ref_kill(&map->refs);
+}
+
+blk_status_t blk_rq_assign_dma_map(struct request *rq,
+				   struct blk_mq_dma_token *token)
+{
+	struct blk_mq_dma_map *map;
+
+	map = blk_mq_get_token_map(token);
+	if (map)
+		goto complete;
+
+	if (rq->cmd_flags & REQ_NOWAIT)
+		return BLK_STS_AGAIN;
+
+	map = blk_mq_create_dma_map(token);
+	if (IS_ERR(map))
+		return BLK_STS_RESOURCE;
+complete:
+	rq->dma_map = map;
+	return BLK_STS_OK;
+}
+
+void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token)
+{
+	blk_mq_dma_map_remove(token);
+}
+
+static void blk_mq_release_dma_mapping(struct dma_token *base_token)
+{
+	struct blk_mq_dma_token *token = dma_token_to_blk_mq(base_token);
+	struct dma_buf *dmabuf = token->dmabuf;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	blk_mq_dma_map_remove(token);
+	dma_resv_unlock(dmabuf->resv);
+
+	blk_mq_dma_token_put(token);
+}
+
+struct dma_token *blk_mq_dma_map(struct request_queue *q,
+				  struct dma_token_params *params)
+{
+	struct dma_buf *dmabuf = params->dmabuf;
+	struct blk_mq_dma_token *token;
+	int ret;
+
+	if (!q->mq_ops->dma_map || !q->mq_ops->dma_unmap ||
+	    !q->mq_ops->init_dma_token || !q->mq_ops->clean_dma_token)
+		return ERR_PTR(-EINVAL);
+
+	token = kzalloc(sizeof(*token), GFP_KERNEL);
+	if (!token)
+		return ERR_PTR(-ENOMEM);
+
+	get_dma_buf(dmabuf);
+	token->fence_ctx = dma_fence_context_alloc(1);
+	token->dmabuf = dmabuf;
+	token->dir = params->dir;
+	token->base.release = blk_mq_release_dma_mapping;
+	token->q = q;
+	refcount_set(&token->refs, 1);
+	mutex_init(&token->mapping_lock);
+
+	if (!blk_get_queue(q)) {
+		kfree(token);
+		return ERR_PTR(-EFAULT);
+	}
+
+	ret = token->q->mq_ops->init_dma_token(token->q, token);
+	if (ret) {
+		kfree(token);
+		blk_put_queue(q);
+		return ERR_PTR(ret);
+	}
+	return &token->base;
+}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2650c97a75e..1ff3a7e3191b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/blk-mq-dma-token.h>
 
 #include <trace/events/block.h>
 
@@ -439,6 +440,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->nr_integrity_segments = 0;
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
+	rq->dma_map = NULL;
 
 	blk_crypto_rq_set_defaults(rq);
 	INIT_LIST_HEAD(&rq->queuelist);
@@ -794,6 +796,7 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 
+	blk_rq_drop_dma_map(rq);
 	if (rq->tag != BLK_MQ_NO_TAG) {
 		blk_mq_dec_active_requests(hctx);
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
@@ -3214,6 +3217,23 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
+	if (bio_flagged(bio, BIO_DMA_TOKEN)) {
+		struct blk_mq_dma_token *token;
+		blk_status_t ret;
+
+		token = dma_token_to_blk_mq(bio->dma_token);
+		ret = blk_rq_assign_dma_map(rq, token);
+		if (ret) {
+			if (ret == BLK_STS_AGAIN) {
+				bio_wouldblock_error(bio);
+			} else {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+			}
+			goto queue_exit;
+		}
+	}
+
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
 		bio->bi_status = ret;
diff --git a/block/fops.c b/block/fops.c
index 41f8795874a9..ac52fe1a4b8d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -973,6 +973,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.dma_map	= blkdev_dma_map,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blk-mq-dma-token.h b/include/linux/blk-mq-dma-token.h
new file mode 100644
index 000000000000..4a8d84addc06
--- /dev/null
+++ b/include/linux/blk-mq-dma-token.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BLK_MQ_DMA_TOKEN_H
+#define BLK_MQ_DMA_TOKEN_H
+
+#include <linux/blk-mq.h>
+#include <linux/dma_token.h>
+#include <linux/percpu-refcount.h>
+
+struct blk_mq_dma_token;
+struct blk_mq_dma_fence;
+
+struct blk_mq_dma_map {
+	void				*private;
+
+	struct percpu_ref		refs;
+	struct sg_table			*sgt;
+	struct blk_mq_dma_token		*token;
+	struct blk_mq_dma_fence		*fence;
+	struct work_struct		free_work;
+};
+
+struct blk_mq_dma_token {
+	struct dma_token		base;
+	enum dma_data_direction		dir;
+
+	void				*private;
+
+	struct dma_buf			*dmabuf;
+	struct blk_mq_dma_map __rcu	*map;
+	struct request_queue		*q;
+
+	struct mutex			mapping_lock;
+	refcount_t			refs;
+
+	atomic_t			fence_seq;
+	u64				fence_ctx;
+};
+
+static inline
+struct blk_mq_dma_token *dma_token_to_blk_mq(struct dma_token *token)
+{
+	return container_of(token, struct blk_mq_dma_token, base);
+}
+
+blk_status_t blk_rq_assign_dma_map(struct request *req,
+				   struct blk_mq_dma_token *token);
+
+static inline void blk_rq_drop_dma_map(struct request *rq)
+{
+	if (rq->dma_map) {
+		percpu_ref_put(&rq->dma_map->refs);
+		rq->dma_map = NULL;
+	}
+}
+
+void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token);
+struct dma_token *blk_mq_dma_map(struct request_queue *q,
+				 struct dma_token_params *params);
+
+#endif /* BLK_MQ_DMA_TOKEN_H */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b54506b3b76d..4745d1e183f2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -94,6 +94,9 @@ enum mq_rq_state {
 	MQ_RQ_COMPLETE		= 2,
 };
 
+struct blk_mq_dma_map;
+struct blk_mq_dma_token;
+
 /*
  * Try to put the fields that are referenced together in the same cacheline.
  *
@@ -170,6 +173,8 @@ struct request {
 
 	unsigned long deadline;
 
+	struct blk_mq_dma_map	*dma_map;
+
 	/*
 	 * The hash is used inside the scheduler, and killed once the
 	 * request reaches the dispatch list. The ipi_list is only used
@@ -675,6 +680,21 @@ struct blk_mq_ops {
 	 */
 	void (*map_queues)(struct blk_mq_tag_set *set);
 
+	/**
+	 * @map_dmabuf: Allows drivers to pre-map a dmabuf. The resulting driver
+	 * specific mapping will be wrapped into dma_token and passed to the
+	 * read / write path in an iterator.
+	 */
+	int (*dma_map)(struct request_queue *q, struct blk_mq_dma_map *);
+	void (*dma_unmap)(struct request_queue *q, struct blk_mq_dma_map *);
+	int (*init_dma_token)(struct request_queue *q,
+			      struct blk_mq_dma_token *token);
+	void (*clean_dma_token)(struct request_queue *q,
+				struct blk_mq_dma_token *token);
+
+	struct dma_buf_attachment *(*dma_attach)(struct request_queue *q,
+					struct dma_token_params *params);
+
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
 	 * @show_rq: Used by the debugfs implementation to show driver-specific
@@ -946,6 +966,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue_nomemsave(struct request_queue *q);
 void blk_mq_unfreeze_queue_nomemrestore(struct request_queue *q);
+
 static inline unsigned int __must_check
 blk_mq_freeze_queue(struct request_queue *q)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cb4ba09959ee..dec75348f8dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1777,6 +1777,9 @@ struct block_device *file_bdev(struct file *bdev_file);
 bool disk_live(struct gendisk *disk);
 unsigned int block_size(struct block_device *bdev);
 
+struct dma_token *blkdev_dma_map(struct file *file,
+				 struct dma_token_params *params);
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-- 
2.52.0


