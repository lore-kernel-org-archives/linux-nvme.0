Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F627C369C2
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Apr 2025 02:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z70/ocLe9ndcQrFKMiE0tdyuA0H8cSwf3KgSSnH+OZY=; b=L6eKy+67TLdcCnYyLIHvowK/rC
	jFdMCajPzVrZxTG/2xcpKEuKaogKSQrknDEdJba2u13YXLg1PSRA1loseefJIfn32hc8Bp6ZiV7Mc
	EEThtPATNi4hnzq9l1bgE1qPNSi2ZlpfZHK/PnCujm5+ojlW51ruw4IG8VOv6/9l43c0swgM/xxpz
	wmeNlpZm3BF3DxOMaA/80kgFVggqsMLRC88axvMzAb0rhWHF+ftSVgb/VWAcxKf8+Vg+IdCYzweLn
	cm86sUqyZL1/BQu5YmhcYOTKejDqZ6UDJ0ghM4zrfbkuQp/GdqWHUrjJlvJuY91ni457YWcX2k6z9
	3Htgx/RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxU-00000001Hr5-2zV0;
	Sat, 26 Apr 2025 02:08:00 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxR-00000001Hpq-1BIY
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 02:07:58 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-227e29b6c55so4993015ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745633276; x=1746238076; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z70/ocLe9ndcQrFKMiE0tdyuA0H8cSwf3KgSSnH+OZY=;
        b=U0n3tKdK4DsHvTjmkrDDG3Xv8/vepEm67Wkq/qVN4gNi/BxTZwGYj75pYoYve5HdNI
         N9ufKmnEUMXaRH/r3rl4ckk1LmMcTnIy0XD5soNxw0gLCUUXBAqeC0n2cdU8Mf7aBV3j
         0fnNt8pQXxd0skmNIG/MTB59FNRMIhl3pV3EA+JGcg1X0bmOfWr8P63EXOOGDn2vvYZL
         Zl2vmuQvu7ZV5x64PLj1i5Fao+FQBVrFefR13iI1I1ItwrvvOlGWTmcwx6G2PrebABEd
         k6vSCYp9O1lpatpkRsQwwhgPDdTJwev6NVDyi1BUBckyBGyrCzx1cxNMhGJ/CdNJ5yyE
         BgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745633276; x=1746238076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z70/ocLe9ndcQrFKMiE0tdyuA0H8cSwf3KgSSnH+OZY=;
        b=h4qcFClXCRrGYbhAw9swuGZW60CPJqheFLbT6mRaeuhcDxuNkD+2Uztq701mvspQ4a
         DtCP5uz6Ik5FAo5v8NcFnl4A2/uMuizc1jWSR7vLJWC8w7SaL9OoN/bXl530Rd8OVNgi
         UYN5Xy4tGN/w7VSpDQvwRychulFzxmBAZi+HHkbuYQxyW8oSxgu4tordBLzlwvhTp8Ht
         2qQQNBJ2J+AWKahOqPXX6dzN5bR7Zw1vCyPsh2AkeD5cKS554LtonJABhwk/jsNftTHX
         YRaZcKmj5mCmdRYYVhvrYgxO2KsNG8K+qeT8x66eClLFMOFPUmQVz9aTuj1WsQZZ7MQo
         P/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWQtdqILZBjrfVlCWbB+soi94YvNLPUK5wVNYKJV1PmUjgCRTWAoJ8khYxWbX606hNQqFqEX1qGbMUw@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6ukgW+quBmYjN7qWoAFw0GLX5DOuda5Q71K4jfoJEb6CHmRmq
	qxZbIa5cGwMtQruTsMvKvnfI0fRxqTFgx1qAz1b73jrMza9I+qpWSrdER+ybsRMsYEna+lTlw6V
	FPUMiy64O0qpxpOUduPx1A6WnvdiG9lLPVmCRTxar72pSV9Vo
X-Gm-Gg: ASbGnctViADXo7dEcrJc33EXYQ/cCsGymt/3fwAhw7B0fhfm6U4dSQaXRt2mTv7svvP
	qkn+HfsRyc7MXUHIiUvC8xJuhwoipZ3qgxioK4z1RMYcq5rkLmsiKYRECeTL8lZ+MccD1uCE30T
	4cseOocgMJ2rDD+jnmho7jhoBu99gWm23u0T7irI491W5cJAgRVi0omr/lS6RZAeaFIQmexSxDH
	GYLNMDnONOEUockn9xyfYpFsGF2g+5PnLpWmXf85LSzPojcRaQV9bKsB6iJNZ8bUex5qEeVjD0P
	o1JeHiEDDtd7En8CrXusYy01X+EqTw==
X-Google-Smtp-Source: AGHT+IEulsOmKO4sgUil3cqmh9Xg2ydaQ8ijeOqIsJOY/rWdqDrzJZvwB2xMFq9zFifYJhH8Z0JN0UgN+RXx
X-Received: by 2002:a17:902:d590:b0:21f:3e2d:7d43 with SMTP id d9443c01a7336-22dbf73b05dmr23686325ad.13.1745633276515;
        Fri, 25 Apr 2025 19:07:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db4f4523csm2250405ad.69.2025.04.25.19.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 19:07:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D32F7340231;
	Fri, 25 Apr 2025 20:07:55 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D0AABE41C66; Fri, 25 Apr 2025 20:07:55 -0600 (MDT)
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
Subject: [PATCH v6 1/3] dmapool: add NUMA affinity support
Date: Fri, 25 Apr 2025 20:06:34 -0600
Message-ID: <20250426020636.34355-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250426020636.34355-1-csander@purestorage.com>
References: <20250426020636.34355-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_190757_322562_301213E6 
X-CRM114-Status: GOOD (  21.57  )
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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


