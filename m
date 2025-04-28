Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0519C369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hA0xjJpkeFjKQ3aVnnAPliXao8ZHQTVnnNqCPBvGsCM=; b=kijY1ahq1QeoEbgcL+M+jB0jkN
	pjY1gAUD2zulL3xWwtRmn2xVlI6W7XKY3R+ieczWCDdoyagldEptTcfjNQ75RWUdfmjUkkcXsQXlR
	9kUKPODZ/CjTdPZJW8eYXzGXOVZNtwJee1kZvYYiJomSylEhr2Ib5cjRTHx2hGJYRVtQ3IG7cZm/C
	uDK9oMjLR26Xcns3CfnxxcqVi93w5U+l2KgPFdjp5XYiOq10TSy3NEaPfIu0rVt4xPFPL+w24km2J
	Fgdnf4unRBjw0XZmUvY5oeBkxs0mMV5+9MQScrJDP1MqDi4Y+3SoBjFAfFRbKd04AcLW6IF8JvfbE
	oJybKCgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9q-00000006JlG-0CeO;
	Mon, 28 Apr 2025 13:04:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Khr-00000005aTN-1FsG
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:23:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 022986115B;
	Mon, 28 Apr 2025 09:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C251DC4CEE4;
	Mon, 28 Apr 2025 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832198;
	bh=d1+z79zg+kihe5QDvuiZPuBTqwMqD9eJrziwPARATZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUB1lhoO/1KGr0Qc2Y24vqWWVYEtzDQTf470PaEamVy2aHjYRrcXKp64fObLbiKH+
	 bNxqnX7fKat1w5Xi0X35HNlsQwBZlouj12aYi2WunJrqDdDkEZlSfGcPj6HiaI9DBw
	 U4gv7P24gIYOH7FsCzIuDcSsU8D4IKS4z1awHvLgXavst4fRip90kp2o+6YpEv2CE2
	 zYvt45+/xEIlk1NMEv8TEY13AZoY9Cl4xN7/bvC563NKc5l8drOkGBh2g4VXmWHRNK
	 pjPmt5XByo10SIhSxFUP3e5wIu8MqQfto5Bo6kx9K8xXZcJiKA5RQmTVg0LE+SeQWw
	 z7Cz3rAsfEiPw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v10 09/24] docs: core-api: document the IOVA-based API
Date: Mon, 28 Apr 2025 12:22:15 +0300
Message-ID: <3c386dfbff489abb871e550c227af65eb90f920d.1745831017.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

From: Christoph Hellwig <hch@lst.de>

Add an explanation of the newly added IOVA-based mapping API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-api.rst | 71 ++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 8e3cce3d0a23..2ad08517e626 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -530,6 +530,77 @@ routines, e.g.:::
 		....
 	}
 
+Part Ie - IOVA-based DMA mappings
+---------------------------------
+
+These APIs allow a very efficient mapping when using an IOMMU.  They are an
+optional path that requires extra code and are only recommended for drivers
+where DMA mapping performance, or the space usage for storing the DMA addresses
+matter.  All the considerations from the previous section apply here as well.
+
+::
+
+    bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
+		phys_addr_t phys, size_t size);
+
+Is used to try to allocate IOVA space for mapping operation.  If it returns
+false this API can't be used for the given device and the normal streaming
+DMA mapping API should be used.  The ``struct dma_iova_state`` is allocated
+by the driver and must be kept around until unmap time.
+
+::
+
+    static inline bool dma_use_iova(struct dma_iova_state *state)
+
+Can be used by the driver to check if the IOVA-based API is used after a
+call to dma_iova_try_alloc.  This can be useful in the unmap path.
+
+::
+
+    int dma_iova_link(struct device *dev, struct dma_iova_state *state,
+		phys_addr_t phys, size_t offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
+
+Is used to link ranges to the IOVA previously allocated.  The start of all
+but the first call to dma_iova_link for a given state must be aligned
+to the DMA merge boundary returned by ``dma_get_merge_boundary())``, and
+the size of all but the last range must be aligned to the DMA merge boundary
+as well.
+
+::
+
+    int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
+		size_t offset, size_t size);
+
+Must be called to sync the IOMMU page tables for IOVA-range mapped by one or
+more calls to ``dma_iova_link()``.
+
+For drivers that use a one-shot mapping, all ranges can be unmapped and the
+IOVA freed by calling:
+
+::
+
+   void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
+		size_t mapped_len, enum dma_data_direction dir,
+                unsigned long attrs);
+
+Alternatively drivers can dynamically manage the IOVA space by unmapping
+and mapping individual regions.  In that case
+
+::
+
+    void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+
+is used to unmap a range previously mapped, and
+
+::
+
+   void dma_iova_free(struct device *dev, struct dma_iova_state *state);
+
+is used to free the IOVA space.  All regions must have been unmapped using
+``dma_iova_unlink()`` before calling ``dma_iova_free()``.
 
 Part II - Non-coherent DMA allocations
 --------------------------------------
-- 
2.49.0


