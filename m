Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F10EC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfvMg22TNSU0WaNnrJj+24dnlpUM18FoGW37aprSsuA=; b=EqpWlS60nmu8dehVjm4pA6jltZ
	Uvuf0D1wkbQHScP2p8yQsjk9l2jopA/X6wt6ruWyb8Z1ShhuffY2ecKl0D8KA2u2MRyQrCx3J8AnD
	xzrqn8oMaLg0fkGTdKZEgqDK2nDqPCxqUqIhSln1x2KMvoQQQ+NRWhp+nqel1vYv51PngWC8TLzQ9
	yW3xjNKGhWz4xi2iQJM3hT+h2NSxQPoj3XeMfsnE8ndq9+7+kCDExwUZm7zguMXz7A+of4H5iRZoc
	C0FM9E7NP+VIFL4wpFxtzntntC4ucfwM6qH+ck89DhBH4i2ofOwu8n4RByhpD3xLqQuLPh4OXei7d
	8Q0JqRHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IXR-00000008CVu-08rA;
	Tue, 22 Apr 2025 18:40:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Hj3-000000083LM-30Tq
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 17:48:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18E6A6112D;
	Tue, 22 Apr 2025 17:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A223C4CEE9;
	Tue, 22 Apr 2025 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745344082;
	bh=9R+Cf90mu3T0JORLd0H9EtQSXnYP+uLphYhUM+1N30g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SotAurz+nkXj5Gf6vpop4SQSYFnlC3FI5agC0HNCqyf27ygMtyk1qtXJp+DIlrS8N
	 zfJyAnwU/yhUlK0TogsF04JexILmPcpXslwlfyVcRM4QmTHt7gcZQKrhblaxqG1tE+
	 zjHB9kjn/AHw0V2ecLgY/QtIi9C7z6fhE6yzaIDYlq6JYu3D4FKErm+NKysY2I/aXf
	 pqkuao4WPADk792tpFDLVtSmS165joyX+E51PYIJYz+/DLP5HBX++KgcCE7A3Dqy5P
	 qKQR7iZf4A812KMg4EcUE1s7Hn4awc3qccqEhSK/ERj6RZzTdobRzOiD7aaqmXRlUE
	 qxTbJgtvN89lA==
Date: Tue, 22 Apr 2025 11:48:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] nvme/pci: PRP list DMA pool partitioning
Message-ID: <aAfWUGAMTpwsHf2b@kbusch-mbp.dhcp.thefacebook.com>
References: <20250422161959.1958205-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422161959.1958205-1-csander@purestorage.com>
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

On Tue, Apr 22, 2025 at 10:19:57AM -0600, Caleb Sander Mateos wrote:
> This reduces the _raw_spin_lock_irqsave overhead by about half, to
> 1.2%.

Could you try this atop your series? I hope to see if we can squeeze a
little more out by keeping the spinlock and list links local to the node
using them.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cbd7734922f91..08a1488155084 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -412,9 +412,10 @@ nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
 	if (prp_pools->small)
 		return prp_pools; /* already initialized */
 
-	prp_pools->large = dma_pool_create("prp list page", dev->dev,
+	prp_pools->large = dma_pool_create_node("prp list page", dev->dev,
 						NVME_CTRL_PAGE_SIZE,
-						NVME_CTRL_PAGE_SIZE, 0);
+						NVME_CTRL_PAGE_SIZE, 0,
+						numa_node);
 	if (!prp_pools->large)
 		return ERR_PTR(-ENOMEM);
 
@@ -422,8 +423,9 @@ nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
 		small_align = 512;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	prp_pools->small = dma_pool_create("prp list 256", dev->dev,
-						256, small_align, 0);
+	prp_pools->small = dma_pool_create_node("prp list 256", dev->dev,
+						256, small_align, 0,
+						numa_node);
 	if (!prp_pools->small) {
 		dma_pool_destroy(prp_pools->large);
 		prp_pools->large = NULL;
diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index f632ecfb42384..36cb5f66111c6 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -18,8 +18,16 @@ struct device;
 
 #ifdef CONFIG_HAS_DMA
 
-struct dma_pool *dma_pool_create(const char *name, struct device *dev, 
-			size_t size, size_t align, size_t allocation);
+struct dma_pool *dma_pool_create_node(const char *name, struct device *dev,
+			size_t size, size_t align, size_t allocation, int node);
+
+static inline struct dma_pool *dma_pool_create(const char *name,
+			struct device *dev, size_t size, size_t align,
+			size_t allocation)
+{
+	return dma_pool_create_node(name, dev, size, align, allocation,
+				    NUMA_NO_NODE);
+}
 
 void dma_pool_destroy(struct dma_pool *pool);
 
@@ -35,6 +43,10 @@ struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
 void dmam_pool_destroy(struct dma_pool *pool);
 
 #else /* !CONFIG_HAS_DMA */
+static inline struct dma_pool *dma_pool_create_node(const char *name,
+	struct device *dev, size_t size, size_t align, size_t allocation,
+	int node);
+{ return NULL; }
 static inline struct dma_pool *dma_pool_create(const char *name,
 	struct device *dev, size_t size, size_t align, size_t allocation)
 { return NULL; }
diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4e..e07242b18c576 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -56,6 +56,7 @@ struct dma_pool {		/* the pool */
 	unsigned int size;
 	unsigned int allocation;
 	unsigned int boundary;
+	int node;
 	char name[32];
 	struct list_head pools;
 };
@@ -199,12 +200,13 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
 
 
 /**
- * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
+ * dma_pool_create_node - Creates a pool of consistent memory blocks, for dma.
  * @name: name of pool, for diagnostics
  * @dev: device that will be doing the DMA
  * @size: size of the blocks in this pool.
  * @align: alignment requirement for blocks; must be a power of two
  * @boundary: returned blocks won't cross this power of two boundary
+ * @node: NUMA node to use when allocating structs 'dma_pool' and 'dma_page'
  * Context: not in_interrupt()
  *
  * Given one of these pools, dma_pool_alloc()
@@ -221,8 +223,8 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
  * Return: a dma allocation pool with the requested characteristics, or
  * %NULL if one can't be created.
  */
-struct dma_pool *dma_pool_create(const char *name, struct device *dev,
-				 size_t size, size_t align, size_t boundary)
+struct dma_pool *dma_pool_create_node(const char *name, struct device *dev,
+			size_t size, size_t align, size_t boundary, int node)
 {
 	struct dma_pool *retval;
 	size_t allocation;
@@ -251,13 +253,14 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 
 	boundary = min(boundary, allocation);
 
-	retval = kzalloc(sizeof(*retval), GFP_KERNEL);
+	retval = kzalloc_node(sizeof(*retval), GFP_KERNEL, node);
 	if (!retval)
 		return retval;
 
 	strscpy(retval->name, name, sizeof(retval->name));
 
 	retval->dev = dev;
+	retval->node = node;
 
 	INIT_LIST_HEAD(&retval->page_list);
 	spin_lock_init(&retval->lock);
@@ -335,7 +338,7 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
 {
 	struct dma_page *page;
 
-	page = kmalloc(sizeof(*page), mem_flags);
+	page = kmalloc_node(sizeof(*page), mem_flags, pool->node);
 	if (!page)
 		return NULL;
 
--

