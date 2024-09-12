Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C887AEEB593
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQMfrCX4WgbAaPgUWX5Mw3xDMJN+RJdskHrVgeXWM5Y=; b=wSdylqR6vPLBp5N8f3x7t64b1Y
	VcM8y+Jj7tTof/Drbc3zV9CzS1t+PfxzhAORDRQ0mzKhTRFSQ5fX+JyuzJa3JDxkGSt0wWH8DHFeT
	KvRpSBdzCSN5YrmpR3SmQZNF3p37zmmi9oJ+VqfsgUgNGgp/bvhN19WzoOpgFtsiXDlPHanlZDuS6
	l/KGlA7wfqjzlTLg9r//+2f9PibIF0k5aPjkIb1V+DoqddRES/HZXLCf8m2ndFvWiEUAzPc+HIeDH
	XQv+NDikFx63M2pLWYcQoq8qe0Mjr+qSvnGNgq8tOxm8c4SyNaTH+jXMFVOzVT/Q6qDe28Va+4Vai
	vkHkkTsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoi-0000000CnoS-2Nz4;
	Thu, 12 Sep 2024 11:16:52 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoY-0000000CngE-3sAA
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2F99DA45273;
	Thu, 12 Sep 2024 11:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A155AC4CEC3;
	Thu, 12 Sep 2024 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139801;
	bh=cWTZ/vX5KH29DDePm3J0/PIuPOYHHrOmAmy/4Xsjr4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaNgzGuYutMZ4S+zhyYnCR1nQ7/cVUpL4cqJdHGuAEl1wmik2EzqsRYrKwjzPSgGy
	 sfidRPgO4zHN72I0olnabe+xMFut7ZSLfoMfElMezA5aKgxLkIlLNFrWStvp5nrBQe
	 WIU+RNQrJtth1GJ+9XevvCvmshuuvPMj21JSNCgv1OQQ6sBN2NPFmAViYUr2n9nfgn
	 dbjpF0kXfzUGO92UMShptYWEvda0Nuu3fgD16HzX7heBADacYrIS4+3hYZbE1tbiNB
	 QNt5RqCvZK/+hGQmCeSmU9XwJusDixnsAIA3mt2lH8BGiBECYIR+WZoJ5CVwVtemKh
	 8zM6C899KSD3A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 10/21] RDMA/umem: Preallocate and cache IOVA for UMEM ODP
Date: Thu, 12 Sep 2024 14:15:45 +0300
Message-ID: <f3f32e72d5ae48305ae270a27fce09c70cd07dac.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041643_330804_D904DB23 
X-CRM114-Status: GOOD (  14.54  )
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

As a preparation to provide two step interface to map pages,
preallocate IOVA when UMEM is initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 13 ++++++++++++-
 include/rdma/ib_umem_odp.h         |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d31c23..01cbf7f55b3a 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -50,6 +50,7 @@
 static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 				   const struct mmu_interval_notifier_ops *ops)
 {
+	struct ib_device *dev = umem_odp->umem.ibdev;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
@@ -87,15 +88,24 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 			goto out_pfn_list;
 		}
 
+		dma_init_iova_state(&umem_odp->state, dev->dma_device,
+				    DMA_BIDIRECTIONAL);
+		ret = dma_alloc_iova(&umem_odp->state, end - start);
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
+	dma_free_iova(&umem_odp->state);
 out_dma_list:
 	kvfree(umem_odp->dma_list);
 out_pfn_list:
@@ -274,6 +284,7 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 					    ib_umem_end(umem_odp));
 		mutex_unlock(&umem_odp->umem_mutex);
 		mmu_interval_notifier_remove(&umem_odp->notifier);
+		dma_free_iova(&umem_odp->state);
 		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->pfn_list);
 	}
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 0844c1d05ac6..c0c1215925eb 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -23,6 +23,7 @@ struct ib_umem_odp {
 	 * See ODP_READ_ALLOWED_BIT and ODP_WRITE_ALLOWED_BIT.
 	 */
 	dma_addr_t		*dma_list;
+	struct dma_iova_state state;
 	/*
 	 * The umem_mutex protects the page_list and dma_list fields of an ODP
 	 * umem, allowing only a single thread to map/unmap pages. The mutex
-- 
2.46.0


