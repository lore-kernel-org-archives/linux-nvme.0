Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57611C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3duo+Csxu3imlxdQHveRRBWNAS1YAjez61JSWKYAhc=; b=c1a/XmI/bzXkydyOP//rhpeX72
	JxUGIa4w+1H84hgPRv7qFlFK7GnZ2ES/+wUobJu2bGldvTRVjTfYzLSZHQ85y0OizIGfazE4ecAOY
	zxhx2k0bH4JsBeNmiXncC5IA/lCZ8LNyoaB907h+LlbzfFGaP7rUIXgaDaTIEu2eZIeRYm45FmcnI
	fmTldmYv5+r0F1Yleo/YWbjJ1FSerKnPWAByRPisrTrGQmpCvvPb3dRZo+LRPARuRKHJ5im2Np1np
	wA3NqYsUGR8xSAmT3rntuqy2lp4JuDMzYZsTNMWPHvcYjGcJ8C6LNb7ePR6SxBMPfwWSoE/M9U7vF
	LMxzg4dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7M4S-00000008iMO-0v29;
	Tue, 22 Apr 2025 22:26:28 +0000
Received: from mail-yw1-x1164.google.com ([2607:f8b0:4864:20::1164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Lob-00000008g5z-1wsK
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 22:10:06 +0000
Received: by mail-yw1-x1164.google.com with SMTP id 00721157ae682-703f3830906so1650647b3.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745359804; x=1745964604; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3duo+Csxu3imlxdQHveRRBWNAS1YAjez61JSWKYAhc=;
        b=W+A8nUj7M5280psKcn0xqxUCveNwCQsuqhkUcf3tQ9nP8szeTpMY76e1C76N2cpyKo
         oNAMxRi+qFlADCtGoXzuK/BAWZNTR+u2oZipRM8W8tcJ9TENHyrs6XKQYs17YrZ8AqU0
         sBNZVkUo58TotjuVv1q8QgycHxI7p4OJMgKXiOXrMF8pLy/vAyLPyuJIYLyPV1HK/hN3
         aSsbE/cUo+UxD7lirW0wQZbdog54EC6EqdbjFVivJKyqMfZ41ivZqKIa/hwcCsjII27C
         tug/pnEuX7w7aqgAr85JVkewp58dq9Ug+85UVLK8UVKm+s6JX1RY1vxkPKE0IEIFsNSN
         mkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359804; x=1745964604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3duo+Csxu3imlxdQHveRRBWNAS1YAjez61JSWKYAhc=;
        b=cqSqxVOJ7omhu66m33M6ytpZ3btEZhayG2PRCykRYTtP3+0HMfr85oyIUhjlRdiTeS
         8ZKooOm9jhDu/56uP9HFPOfq1978A4jiSUO/OsTi/Kize/GsN3IVmyVjtM9U7NGGr1jQ
         oVJS5HGDr3NljNejXW7JsSc760ksE+82X53NdkdKLW1JDEYKWQIg+AZw4jPcOdZNtDaq
         jngWAn7RQbIrkDWDAR9ne+j94sce9SzI3P6Z0E5bx/LsDBonPzc3f9p128vVBEhn14NC
         8fmd7bdeX/F9BebbgQPwspninjCjII9dvtteRckfx/cutzRlLtLUDl3nhk6KT4cjfZG9
         /Xxg==
X-Forwarded-Encrypted: i=1; AJvYcCXaYD2leWheUriqmnx+R8IReaQodpaAVsCQsqCAFj7TYaP2Tdkc63A6K0DL3zn0uZOu2fHqQxHhHFQf@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2s7cmkiy6HMaZliKrppxhkPOkdDxyWH26/ug632xTTOWgVa7o
	TaMXAlaXAS/V+44QWW8cOUIMFNIfGbJXQtWb1AyHkdfZjudXhfYcu+1aq6CRC91/fvnWj/EFuNT
	OXEAv53tryEKvTDaH5hzokgJvqbXXzyDw1l361WAl2J4vMkPO
X-Gm-Gg: ASbGncvoGONhdDpTwBYEU//xIIHkFnDfTIMasUnGxve6IA0aj/BsIsEf02bgdX07DSb
	8NbeiwqPCoS+UoPfTEtAw0DCu+L1CjE+n8RZh/Rb4NAEf1rXpyCxueTknfvi4tHajMTRhb9FnSc
	Ql18NQspPx+T7s+7jp7Ae5EXWbx9GqkFaTiOnI0ZLrPm3vvMREgmfMDZt5IJU50xlbSfavfWNTV
	mY1ex13hPbdSggZvW5ArIU9BqT7lL3gwLJinlxseaEXxb7T5ITpGSzaVsSWUTrxc58cuHSe9YKA
	cYXBixND7lH/XA2O02s/sS+6hV4+lg==
X-Google-Smtp-Source: AGHT+IEYwgoo4RLAGc+GeQs8g8qLOVHt34WI8ndT0WmR16dcscV7Ta6VOH8lfCbw/+EtF9tG8Y5HbI0z+x3U
X-Received: by 2002:a05:690c:39b:b0:703:ac44:d369 with SMTP id 00721157ae682-706ccdda133mr109130937b3.5.1745359804156;
        Tue, 22 Apr 2025 15:10:04 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-706ca475061sm6640437b3.2.2025.04.22.15.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:10:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9035B340159;
	Tue, 22 Apr 2025 16:10:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8DF5EE41D69; Tue, 22 Apr 2025 16:10:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 1/3] dmapool: add NUMA affinity support
Date: Tue, 22 Apr 2025 16:09:50 -0600
Message-ID: <20250422220952.2111584-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250422220952.2111584-1-csander@purestorage.com>
References: <20250422220952.2111584-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_151005_511209_C2BC96F0 
X-CRM114-Status: GOOD (  21.91  )
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

From: Keith Busch <kbusch@kernel.org>

Introduce dma_pool_create_node(), like dma_pool_create() but taking an
additional NUMA node argument. Allocate struct dma_pool on the desired
node, and store the node on dma_pool for allocating struct dma_page.
Make dma_pool_create() an alias for dma_pool_create_node() with node set
to NUMA_NO_NODE.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/dmapool.h | 17 +++++++++++++----
 mm/dmapool.c            | 16 ++++++++++------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index f632ecfb4238..bbf1833a24f7 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -9,19 +9,20 @@
  */
 
 #ifndef LINUX_DMAPOOL_H
 #define	LINUX_DMAPOOL_H
 
+#include <linux/nodemask_types.h>
 #include <linux/scatterlist.h>
 #include <asm/io.h>
 
 struct device;
 
 #ifdef CONFIG_HAS_DMA
 
-struct dma_pool *dma_pool_create(const char *name, struct device *dev, 
-			size_t size, size_t align, size_t allocation);
+struct dma_pool *dma_pool_create_node(const char *name, struct device *dev,
+			size_t size, size_t align, size_t boundary, int node);
 
 void dma_pool_destroy(struct dma_pool *pool);
 
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle);
@@ -33,12 +34,13 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
 				  size_t size, size_t align, size_t allocation);
 void dmam_pool_destroy(struct dma_pool *pool);
 
 #else /* !CONFIG_HAS_DMA */
-static inline struct dma_pool *dma_pool_create(const char *name,
-	struct device *dev, size_t size, size_t align, size_t allocation)
+static inline struct dma_pool *dma_pool_create_node(const char *name,
+	struct device *dev, size_t size, size_t align, size_t boundary,
+	int node)
 { return NULL; }
 static inline void dma_pool_destroy(struct dma_pool *pool) { }
 static inline void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 				   dma_addr_t *handle) { return NULL; }
 static inline void dma_pool_free(struct dma_pool *pool, void *vaddr,
@@ -47,10 +49,17 @@ static inline struct dma_pool *dmam_pool_create(const char *name,
 	struct device *dev, size_t size, size_t align, size_t allocation)
 { return NULL; }
 static inline void dmam_pool_destroy(struct dma_pool *pool) { }
 #endif /* !CONFIG_HAS_DMA */
 
+static inline struct dma_pool *dma_pool_create(const char *name,
+	struct device *dev, size_t size, size_t align, size_t boundary)
+{
+	return dma_pool_create_node(name, dev, size, align, boundary,
+				    NUMA_NO_NODE);
+}
+
 static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
 				    dma_addr_t *handle)
 {
 	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
 }
diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4..4de531542814 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -54,10 +54,11 @@ struct dma_pool {		/* the pool */
 	size_t nr_pages;
 	struct device *dev;
 	unsigned int size;
 	unsigned int allocation;
 	unsigned int boundary;
+	int node;
 	char name[32];
 	struct list_head pools;
 };
 
 struct dma_page {		/* cacheable header for 'allocation' bytes */
@@ -197,16 +198,17 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
 	pool->next_block = block;
 }
 
 
 /**
- * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
+ * dma_pool_create_node - Creates a pool of consistent memory blocks, for dma.
  * @name: name of pool, for diagnostics
  * @dev: device that will be doing the DMA
  * @size: size of the blocks in this pool.
  * @align: alignment requirement for blocks; must be a power of two
  * @boundary: returned blocks won't cross this power of two boundary
+ * @node: optional NUMA node to allocate structs 'dma_pool' and 'dma_page' on
  * Context: not in_interrupt()
  *
  * Given one of these pools, dma_pool_alloc()
  * may be used to allocate memory.  Such memory will all have "consistent"
  * DMA mappings, accessible by the device and its driver without using
@@ -219,12 +221,13 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
  * boundaries of 4KBytes.
  *
  * Return: a dma allocation pool with the requested characteristics, or
  * %NULL if one can't be created.
  */
-struct dma_pool *dma_pool_create(const char *name, struct device *dev,
-				 size_t size, size_t align, size_t boundary)
+struct dma_pool *dma_pool_create_node(const char *name, struct device *dev,
+				      size_t size, size_t align, size_t boundary,
+				      int node)
 {
 	struct dma_pool *retval;
 	size_t allocation;
 	bool empty;
 
@@ -249,11 +252,11 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	else if ((boundary < size) || (boundary & (boundary - 1)))
 		return NULL;
 
 	boundary = min(boundary, allocation);
 
-	retval = kzalloc(sizeof(*retval), GFP_KERNEL);
+	retval = kzalloc_node(sizeof(*retval), GFP_KERNEL, node);
 	if (!retval)
 		return retval;
 
 	strscpy(retval->name, name, sizeof(retval->name));
 
@@ -262,10 +265,11 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	INIT_LIST_HEAD(&retval->page_list);
 	spin_lock_init(&retval->lock);
 	retval->size = size;
 	retval->boundary = boundary;
 	retval->allocation = allocation;
+	retval->node = node;
 	INIT_LIST_HEAD(&retval->pools);
 
 	/*
 	 * pools_lock ensures that the ->dma_pools list does not get corrupted.
 	 * pools_reg_lock ensures that there is not a race between
@@ -293,11 +297,11 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 		}
 	}
 	mutex_unlock(&pools_reg_lock);
 	return retval;
 }
-EXPORT_SYMBOL(dma_pool_create);
+EXPORT_SYMBOL(dma_pool_create_node);
 
 static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 {
 	unsigned int next_boundary = pool->boundary, offset = 0;
 	struct dma_block *block, *first = NULL, *last = NULL;
@@ -333,11 +337,11 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 
 static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
 {
 	struct dma_page *page;
 
-	page = kmalloc(sizeof(*page), mem_flags);
+	page = kmalloc_node(sizeof(*page), mem_flags, pool->node);
 	if (!page)
 		return NULL;
 
 	page->vaddr = dma_alloc_coherent(pool->dev, pool->allocation,
 					 &page->dma, mem_flags);
-- 
2.45.2


