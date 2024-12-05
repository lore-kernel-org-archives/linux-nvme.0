Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C2FE7717C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ufN3FHn90uJODz3lZznMDmn2tX4yEQe0kEyo2vbDgPE=; b=GaY0esWUzQkLkRNESgi6coODgS
	cVkID9mnU2YYsqnNZ8mvQa+I9bRvg2pd81sEFKoJR3W1rpKtLXlHUFP7mNLboTK7+CHFSbTpNLH38
	p6XOh9x2CdUKL1eYLkg/U9t84hTuHi2tMTtwyTzyGqcJBIAFMUxXo3EodrkQ3cS87sXSeH6FVVQpP
	n0tTTHjM64ntrh842ewTXBCBcHhEy7TT4bOT7kidzcZgJ/hwWQkq/ewzm+x2dv8AOVBGgawpBPyKl
	Ky5DVZ4ea+x4zTV6kMEaHiVDbOxrEHTMeskXxEa8+PWKlbEpta0TugULSj6MpwaS0dLbfj3SmDGtY
	tvUNqrKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCr3-0000000GKiF-2VqA;
	Thu, 05 Dec 2024 14:29:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBo5-0000000G6qT-38xy
	for linux-nvme@bombadil.infradead.org;
	Thu, 05 Dec 2024 13:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ufN3FHn90uJODz3lZznMDmn2tX4yEQe0kEyo2vbDgPE=; b=Ik5Yq2qU8qdbXkBkDlFuDPRXar
	U6ZHsd3pC7/QYX/xoWfPG4400WQ9bdqDzHa99oks0C8JNHVrt+GNhTDvXye0ABk2aCp4a0x5zGins
	lSvvVyvPAdIIBkvJkPtKE61FLNyZG7sVZL1oOT5m8goy9COrcQZucUzuA5mbXcIYaRWc7onYt5R56
	+2yGMhBPAhYh9AiRoSaM+bH56iDD4+o5Lye/MpxHBjCDW0yhBX20vf1MvFKAkRKzF9LXyWal9x0V9
	HuNOfnH15kgPOgOR42cGhlN0SA0QC6UFUJNr13iC6a9eFaGzG2I63hga+oUM0+CYRnLAhPOIdN0xI
	eOCpUjwQ==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBo1-00000002uBn-0BHy
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 13:22:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CAA64A43841;
	Thu,  5 Dec 2024 13:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF702C4CED1;
	Thu,  5 Dec 2024 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733404927;
	bh=YpLncFZbCC4w0IIg6h/rxYvmMz7724GLt2jYf2BJ9P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSt1+gaqmzXel703ljo60m8NU49Cw25z8my6mmvfnNJdEBSIcS8PxdxToWjPQe06n
	 h3kHS/393oidMe2+xKTaLMmTTmN3QjJQdUQU/qd6pS04igYrv5S2NCUs/kaKNgTqgS
	 AbkmkMFplFZY6vhEfpArLyyPA0P8twNZX0ED3dPphkqV6DJGOcwQqXisaNlbUJxeWZ
	 5Y7fwKmXc+QBK/K6u5qUyQF7r0/3STOK9aHpuakuGhH8F0hZ11UsDSZBqpt434eTeu
	 hySxMWnn3TBjhxcCqCkhxuXcRj2m3xRrDZ4cgMy6LZzZO+Kx4UZIBrxm7NUabKqbe7
	 gxdefDMVn9RqA==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 10/18] docs: core-api: document the IOVA-based API
Date: Thu,  5 Dec 2024 15:21:09 +0200
Message-ID: <e0c4b6f062e3c5446129d731c7a8aec8444b2e61.1733398913.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733398913.git.leon@kernel.org>
References: <cover.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_132210_217714_5BF5F433 
X-CRM114-Status: GOOD (  18.61  )
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
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 8e3cce3d0a23..61d6f4fe3d88 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -530,6 +530,76 @@ routines, e.g.:::
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
+		enum dma_data_direction dir, unsigned long attrs);
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
2.47.0


