Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540E2C02198
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KcdVDY3nkPjZIk2xsNfw4g8jnbbHUTBzu+xP34Eyl+k=; b=aC4L8TI3OIAyq2THTSRdwe7oMY
	9eBtpGMbWVuptsD5XjachHXRmYF2XK6Rluy4QNx/nXbEBbyWU1yQILWiCgdvVkOHbIbLrLX7esuUA
	U6/MS9yZMD+gHckZJhc6RnQKz+4F/y3QwfTiI5KlfN2o91xqFa8Nwpi1f5y1OYq97FY8GuEN9GaR+
	L7GihCcusa3ZFpmU9ubML523I5nV6oTbWX/q5DU1lBEMzUbEqr7VPSV0iQR3uXuLoXJNIXc3awKfc
	42wyXp5n/O4q7ikDLyxNe1POlq/hwPRw8hPM+Qa4iY+L2zWFUS/ZQMIezt8QjeLh6QXbgGvqaYddY
	CE0Seimg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhbp-00000003pv3-357B;
	Wed, 05 Feb 2025 15:46:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfgaS-00000003ZbY-2J25
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 14:41:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3B0335C6C94;
	Wed,  5 Feb 2025 14:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E9DC4CEDD;
	Wed,  5 Feb 2025 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738766467;
	bh=0zY9wH2OP9d22rL1O7KXuZTa/ogQAL5HzMoIiMUubaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paVneeAJqn/ltBJv6BGhRXTQ/1o7gRgteq2iCdVfu0se6SR44/XZ19uVDs57AYcx5
	 G6SYFwf9oPkm9cSNiuGfKntNAWNpRrba6qFPBtdsBpcbKc4/ygjDK7v9rRTgtNgXJY
	 wMEOH+TPUG4apPSNsLSopbZGBVV/xLPSIuqZV6NOJslRLA1vKskQA0UyhxlHcTpCDu
	 DL1YnlM5CiKBwg4+D+3xSdmQ51egLGcf890c1UIfYj2+bGGKlIShSQq08wTw6gpzyw
	 F/J3DHrDVo1YPqcaiE1BNjK2tJyO9YQnTqr6eKZ8NQTx3Y+qbGNoPheStWyzcZwbPr
	 fZsxDVy3Q2DYg==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
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
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 04/17] iommu: add kernel-doc for iommu_unmap and iommu_unmap_fast
Date: Wed,  5 Feb 2025 16:40:24 +0200
Message-ID: <49d9ef3273ab03821931114329c49ae02b1cd902.1738765879.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738765879.git.leonro@nvidia.com>
References: <cover.1738765879.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_064108_676352_101CB6A1 
X-CRM114-Status: GOOD (  14.36  )
X-Mailman-Approved-At: Wed, 05 Feb 2025 07:46:36 -0800
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

Add kernel-doc section for iommu_unmap and iommu_unmap_fast to document
existing limitation of underlying functions which can't split individual
ranges.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 32b161988c4b..89b538eec5cb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2590,6 +2590,25 @@ size_t iommu_unmap(struct iommu_domain *domain,
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
2.48.1


