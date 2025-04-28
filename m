Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F4C3ABA5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGlOlezkhgI6QuHWn2/EHVmM7aanqBpvV0CGwTvAhbQ=; b=1FliMz1aJtvdNB3af4emMD7d+s
	/5DlcRyukfrsbUAe5B6s+FP/JqcqdmLFlrJaUOjBuwok0Xe+MrIWCZxmhD3C3KXVl3K1rRdSq+ezz
	8UGT2Xr2uREnw4xiCPix7BQpjZnXAw2Bh3ib63KggIobi4TZ7eVsdF8VoL6Dn/rW4LgDhahMpRhXn
	L0tqO1Ype1EjRRHKZw7wa8rbo4sAJV+gmJTiRJUh36YncxQcCy9T7cYf9iAlJEjP256v03foZ11xx
	AflnjwfAO3SDbSg1RmEboI9rVrfwHPrcgIQsvGeYLxzQ4DGDW6Gjbzr6z4cEOMGxQVUIwN8+9fu9J
	pQkSpHHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9l-00000006JcN-0uin;
	Mon, 28 Apr 2025 13:04:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9KhX-00000005aHm-1k47
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:22:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C7BC61157;
	Mon, 28 Apr 2025 09:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89BCC4CEE9;
	Mon, 28 Apr 2025 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832178;
	bh=qAutkCz37Tu8LslKD8JBH5oib5UnssVkdsFDkEx7ZAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOOf6Y0mFh8eaLlqUYaStweSkz4DuWDmM5g52GCOkAPYc1JLbqg3lvf3YSZedB5hq
	 I7YPao5jZ7PVdb5yLDFgUlyfFUAdsvYrD2O+N1GQL1ugH3GyJMizhP+2zRdTDutTtm
	 6Arc5CR8SWcEOS618cLmUutubaOWsAUZ5S4w8pnYyGc8EOww19gd9qY57pmnTY3446
	 rDQDtBCTbwMHdkeWYFbIL0Q2+lz4lvUQC5JkKCvPRuSzjFCPq/I4yB/O49lx3fBh5+
	 nC3MNGBucQEWuM+Rb3Ho6G75E6IdHFTfEgvjbUMPUx4zAeeNoTPV8AE+YhZUqvYG++
	 2+GCFe1W9EuRw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jake Edge <jake@lwn.net>,
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v10 04/24] iommu: add kernel-doc for iommu_unmap_fast
Date: Mon, 28 Apr 2025 12:22:10 +0300
Message-ID: <6c4bbb539bec7b827b9e9cc24779c9e9c43fc3ed.1745831017.git.leon@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

Add kernel-doc section for iommu_unmap_fast to document existing
limitation of underlying functions which can't split individual ranges.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 02960585b8d4..8619c355ef9c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2621,6 +2621,25 @@ size_t iommu_unmap(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
+/**
+ * iommu_unmap_fast() - Remove mappings from a range of IOVA without IOTLB sync
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the range starting from @iova
+ * @iotlb_gather: range information for a pending IOTLB flush
+ *
+ * iommu_unmap_fast() will remove a translation created by iommu_map().
+ * It can't subdivide a mapping created by iommu_map(), so it should be
+ * called with IOVA ranges that match what was passed to iommu_map(). The
+ * range can aggregate contiguous iommu_map() calls so long as no individual
+ * range is split.
+ *
+ * Basically iommu_unmap_fast() is the same as iommu_unmap() but for callers
+ * which manage the IOTLB flushing externally to perform a batched sync.
+ *
+ * Returns: Number of bytes of IOVA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */
 size_t iommu_unmap_fast(struct iommu_domain *domain,
 			unsigned long iova, size_t size,
 			struct iommu_iotlb_gather *iotlb_gather)
-- 
2.49.0


