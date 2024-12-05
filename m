Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E3E7717B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bt1viYiK1SsSKpPlU7M1enBqu7KQc/jtkzFWNQZShjc=; b=zSTzi51CCmiUlt46eu6i3vDqy/
	nZnJZ+ysKOE3ECgJZNbCW2spW6LlNMHpYGGcbQBSEFjQ8QN/Lw8D8HLbqnnt6P7Wz40vYm0eGYKKZ
	q22O6Dc/CAGdK0uWP/ubVuVcKXwEEoZOuYQl4O2OJXz87JtGKiiCGvgFdT4SNKR5p75Xmc4mRN7iT
	I4E5j2r0JU+s9hqaZvQT3sQwFqnbLsQih2OYmYPsanD2ieq+IOUdqpuFhn1c50+mBxrfaOEM2nCOr
	41eNoSUDU32tk152cODO34r01+MrvMkc6uoVWVbfnqOw51GtmxX4WRXFRebJRPdhlO9Uhn+Eb4afD
	PYc4G83A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCr2-0000000GKgq-3fU0;
	Thu, 05 Dec 2024 14:29:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBo0-0000000G6oV-25qL
	for linux-nvme@bombadil.infradead.org;
	Thu, 05 Dec 2024 13:22:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Bt1viYiK1SsSKpPlU7M1enBqu7KQc/jtkzFWNQZShjc=; b=nCbJBKOcbw4fJbY/MRjnpmp1cg
	6NqKjI8fmU0e1OlZ6vSK1BrkzCBOmB3eAdFMR5Z0ajkVoV/Jju10zAQV8ZD9WUzQo+EDePw1xGEV6
	MMkWxXjzVHX3H1rGVhje1u9b3ejljRox8dpJkqOTXkaCa3gZjr50+SS901SDAqRNnyvsyXSLSQIyQ
	Ie5NO0GCVUgDO++GVE2QyPgpsMHwWYt4UEBt+/58LONxA2LNG4Gudcj7Nk3wi7WLbj1DfRTyeOdEL
	wAj8NS7xoQpPPHv2fdxgiOR7LQuPK2mi9NPC2yMnP/xNoofF7283VDkDl3FlQQKLtQ+ePXZbgSmAJ
	hzLLJzCw==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJBnx-00000002uAz-1va4
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 13:22:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 33943A43838;
	Thu,  5 Dec 2024 13:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D91C4CED1;
	Thu,  5 Dec 2024 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733404923;
	bh=c7G0IPK1mqvX8tD+gZt9wA9o0XSfmNwzbfc+aT5KHkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4Mi6PlMc5Kk5ONaki5WsllSppTqpgAa328x+Stl1A9wYBWAFD8nbJXEZENsWBe5a
	 Ox/ODlM7KuZ2PJkCwJ6rb6QzK1So9RSL/tJ6cGOtyUsMiWfwuKrO5m8V9TF3AhQAv5
	 Xi4Z5qhRN/Q+ze5bwYUQYkblhXXN8iF+xHXhL+/qycoVOEVV6zBshynwV90neUbwrq
	 vHCjJ091bFqflzXkFftJ1Gc0N5DSMs4yefOFG2Jrpct8bsXYFWwHCqi2OWod1I6vOy
	 SSOUaxGpz1rvG8uSvOefAqbKaOoCpt+zyiA8qYixIGrcKtaJ8VsUy1/z2EniKDUQjO
	 x6BWHFHmlr3oQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>,
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
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 05/18] dma-mapping: Add check if IOVA can be used
Date: Thu,  5 Dec 2024 15:21:04 +0200
Message-ID: <b23a1e29f00f31f31641479c90f2471aee27fac5.1733398913.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733398913.git.leon@kernel.org>
References: <cover.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_132205_817412_FF2CA6F9 
X-CRM114-Status: GOOD (  13.65  )
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

This patch adds a check if IOVA can be used for the specific
transaction.

In the new API a DMA mapping transaction is identified by a
struct dma_iova_state, which holds some recomputed information
for the transaction which does not change for each page being
mapped.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..0d1fc0a2fc0f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -72,6 +72,20 @@
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
+struct dma_iova_state {
+	size_t __size;
+};
+
+/*
+ * Use the high bit to mark if we used swiotlb for one or more ranges.
+ */
+#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
+
+static inline size_t dma_iova_size(struct dma_iova_state *state)
+{
+	return state->__size & ~DMA_IOVA_USE_SWIOTLB;
+}
+
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 void debug_dma_map_single(struct device *dev, const void *addr,
@@ -277,6 +291,25 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 }
 #endif /* CONFIG_HAS_DMA */
 
+#ifdef CONFIG_IOMMU_DMA
+/**
+ * dma_use_iova - check if the IOVA API is used for this state
+ * @state: IOVA state
+ *
+ * Return %true if the DMA transfers uses the dma_iova_*() calls or %false if
+ * they can't be used.
+ */
+static inline bool dma_use_iova(struct dma_iova_state *state)
+{
+	return state->__size != 0;
+}
+#else /* CONFIG_IOMMU_DMA */
+static inline bool dma_use_iova(struct dma_iova_state *state)
+{
+	return false;
+}
+#endif /* CONFIG_IOMMU_DMA */
+
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir);
-- 
2.47.0


