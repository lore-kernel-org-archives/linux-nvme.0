Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A803C54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYSEuAz/VcQQ9oYOdYsxLecJdgLxoOHzBKYScKbWY7E=; b=hXwjfci80VE2WBM0F9vyUi/XbP
	TvstiKXBQBNR5w2BNYf4bskWhZLnf0tjefU474/iKALDKxqKlPGxHw/2h/1WQoL79JxnDj7spOMam
	raKIF+z7n0w37DbRRFUiSaW/MMJF2ukeq6FYLmghiBMujo+sfTWOxt3iDBKLgdcXLizC7gbkgcVBy
	HSkIx3/MRvD+105PqRtJ6HX+ykBItCIiOr3ClFpycSyf8lcz3mwtJIV2f2AXrId23HchUOK+59dXO
	ip3S73YG8Yija+FRLH7Yyhvg95KpZCAvrNCaHD8i6TTcsDu8UcYxxDRHhRDAMYXyLlA9uBK26iyPE
	+KUQxqlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUyE-0000000DoQ7-0gF5;
	Tue, 05 Mar 2024 13:36:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhRwm-0000000D11d-34yt
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 10:22:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E895560D2F;
	Tue,  5 Mar 2024 10:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE75C433F1;
	Tue,  5 Mar 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634175;
	bh=E8ahaIx2eHfPJk0G81HhbupoEvLGKO0ealmbIxFQ2TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uf0bag2dpmDC8WdvfUXP0lkuZiQqs9DSJTSOiPPopdM6nI4sfZIJ0gQomOcvskrGu
	 MOxNhWnWeQzF8psuVrHloTQHZ3y5OfUMLvGmZVJ8bj12nFrsThqO2Nf/u2Scfc7Ic6
	 WOdHTd6fO8gOxhkZWpdeLx4+Ll731HcWVEMEZoqag+JGLFnnevqGqgpxU1OH8SxFJO
	 erdae4KD42Zn0tQ0EmfXiUntVaXwk1IPMov8zjBLwxhVOaPYEQhdr5c03QiCskzsio
	 KvRmPU99U3M92DNV9W6cdaFD2MMSN60bxyY4tmOPu4V7bove1OSlwQrZQqn+Q8uvZe
	 8d0Ve/1K0suEw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC 07/16] RDMA/umem: Preallocate and cache IOVA for UMEM ODP
Date: Tue,  5 Mar 2024 12:22:08 +0200
Message-ID: <47cc27fbaf9f4bd19edbcaac380bdd9684c5d12f.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_022257_105908_C7D4ACF6 
X-CRM114-Status: GOOD (  18.46  )
X-Mailman-Approved-At: Tue, 05 Mar 2024 05:32:59 -0800
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
Message-ID: <20240305102208.ql3iAsHqocj2Y3046jA9RR9hk0_b2gO9yTrHjv79CN0@z>

From: Leon Romanovsky <leonro@nvidia.com>

As a preparation to provide two step interface to map pages,
preallocate IOVA when UMEM is initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 16 +++++++++++++++-
 include/rdma/ib_umem_odp.h         |  1 +
 include/rdma/ib_verbs.h            | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d31c23..f69d1233dc82 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -50,6 +50,7 @@
 static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 				   const struct mmu_interval_notifier_ops *ops)
 {
+	struct ib_device *dev = umem_odp->umem.ibdev;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
@@ -87,15 +88,25 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 			goto out_pfn_list;
 		}
 
+		umem_odp->iova.dev = dev->dma_device;
+		umem_odp->iova.size = end - start;
+		umem_odp->iova.dir = DMA_BIDIRECTIONAL;
+		ret = ib_dma_alloc_iova(dev, &umem_odp->iova);
+		if (ret)
+			goto out_dma_list;
+
+
 		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
 						   umem_odp->umem.owning_mm,
 						   start, end - start, ops);
 		if (ret)
-			goto out_dma_list;
+			goto out_free_iova;
 	}
 
 	return 0;
 
+out_free_iova:
+	ib_dma_free_iova(dev, &umem_odp->iova);
 out_dma_list:
 	kvfree(umem_odp->dma_list);
 out_pfn_list:
@@ -262,6 +273,8 @@ EXPORT_SYMBOL(ib_umem_odp_get);
 
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 {
+	struct ib_device *dev = umem_odp->umem.ibdev;
+
 	/*
 	 * Ensure that no more pages are mapped in the umem.
 	 *
@@ -274,6 +287,7 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 					    ib_umem_end(umem_odp));
 		mutex_unlock(&umem_odp->umem_mutex);
 		mmu_interval_notifier_remove(&umem_odp->notifier);
+		ib_dma_free_iova(dev, &umem_odp->iova);
 		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->pfn_list);
 	}
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 0844c1d05ac6..bb2d7f2a5b04 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -23,6 +23,7 @@ struct ib_umem_odp {
 	 * See ODP_READ_ALLOWED_BIT and ODP_WRITE_ALLOWED_BIT.
 	 */
 	dma_addr_t		*dma_list;
+	struct dma_iova_attrs iova;
 	/*
 	 * The umem_mutex protects the page_list and dma_list fields of an ODP
 	 * umem, allowing only a single thread to map/unmap pages. The mutex
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b7b6b58dd348..e71fa19187cc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4077,6 +4077,24 @@ static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
 	return dma_mapping_error(dev->dma_device, dma_addr);
 }
 
+static inline int ib_dma_alloc_iova(struct ib_device *dev,
+				    struct dma_iova_attrs *iova)
+{
+	if (ib_uses_virt_dma(dev))
+		return 0;
+
+	return dma_alloc_iova(iova);
+}
+
+static inline void ib_dma_free_iova(struct ib_device *dev,
+				    struct dma_iova_attrs *iova)
+{
+	if (ib_uses_virt_dma(dev))
+		return;
+
+	dma_free_iova(iova);
+}
+
 /**
  * ib_dma_map_single - Map a kernel virtual address to DMA address
  * @dev: The device for which the dma_addr is to be created
-- 
2.44.0


