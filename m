Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62BFE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wohjECrItiTe3wGt73yRaTZkJ8cJH9lXeliHlLBqbI=; b=CtwXQLesdj88tGvL4bBfAWzewk
	hadXWaNGGbNKdOrs4Ove56iXgM1psKvDYSWCEfAFv1LuaOPWRq3Jx31vm24PqeNDQTHAVP+TeXVtR
	gdXaxVZv7bP+RFJNYHyCmT4bTkjEeFgl2STD77CdbVL8cQ/em0rjvEYt4IzHJG9p+/gsN53BCf95/
	MhCuV/2KQU4zC8SKQT0grkuItPC2UD71nCGjQlbBjOsMGcq1JPYrHj/j6Wfl02O99oLOrpuM9n9YW
	/6yPVBlnPXxzcF4LvEEyUmIkHAYIny5vkHnd4ihHfqrCBvsYVZH6D6Fi7g2YYPjlFZAygM05YwaNB
	aFsFJ/TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNXDG-0000000DSoZ-2lvn;
	Tue, 17 Dec 2024 13:02:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNXD1-0000000DSZb-0g3r
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 13:01:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 723C45C2C39;
	Tue, 17 Dec 2024 13:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A69C4CED3;
	Tue, 17 Dec 2024 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440514;
	bh=faZKR+GLvGy07GeNnto8v510/6+S1UMSrHjOqNZtBkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwtijajh4ypb7fKZt6k7x4HGup1gTYl0XkljPI7PwxMJuEdG4LvZC2Wkmd+6h0KR0
	 POnm5xMGOPzSpDi1TnhuSrGzZu6ZTFmvnvbNRQuN3MGJV07HVmi7mGPmC28ntAMKd6
	 i4zQydEhFNcPmTcgyxQIgkbm89neiWRp0nS57D2/scu6c7ZyQrGZsnd5g300H/Dc6c
	 ssfuuORUh3pBLcdDFCRqn9HPuMABkGdaZ5oZUyyxgTk/SVrFPlNoIXSLoWeqYmG/h8
	 y6qZ8wi+SPyxvkEHb4689+1w0nzdecfQswNJY8uM2y8icydIHPgzfKdMw9iZH/OHtS
	 CofUCjidyETzw==
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
Subject: [PATCH v5 14/17] RDMA/umem: Separate implicit ODP initialization from explicit ODP
Date: Tue, 17 Dec 2024 15:00:32 +0200
Message-ID: <7e1538594c048f3d3b41e53dc3875f399909dee8.1734436840.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734436840.git.leon@kernel.org>
References: <cover.1734436840.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_050155_285838_943090BC 
X-CRM114-Status: GOOD (  16.84  )
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

Create separate functions for the implicit ODP initialization
which is different from the explicit ODP initialization.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 30cd8f353476..51d518989914 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -48,41 +48,44 @@
 
 #include "uverbs.h"
 
-static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
-				   const struct mmu_interval_notifier_ops *ops)
+static void ib_init_umem_implicit_odp(struct ib_umem_odp *umem_odp)
+{
+	umem_odp->is_implicit_odp = 1;
+	umem_odp->umem.is_odp = 1;
+	mutex_init(&umem_odp->umem_mutex);
+}
+
+static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
+			    const struct mmu_interval_notifier_ops *ops)
 {
 	struct ib_device *dev = umem_odp->umem.ibdev;
+	size_t page_size = 1UL << umem_odp->page_shift;
+	unsigned long start;
+	unsigned long end;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
 	mutex_init(&umem_odp->umem_mutex);
 
-	if (!umem_odp->is_implicit_odp) {
-		size_t page_size = 1UL << umem_odp->page_shift;
-		unsigned long start;
-		unsigned long end;
-
-		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
-		if (check_add_overflow(umem_odp->umem.address,
-				       (unsigned long)umem_odp->umem.length,
-				       &end))
-			return -EOVERFLOW;
-		end = ALIGN(end, page_size);
-		if (unlikely(end < page_size))
-			return -EOVERFLOW;
-
-		ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
-					(end - start) >> PAGE_SHIFT,
-					1 << umem_odp->page_shift);
-		if (ret)
-			return ret;
-
-		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
-						   umem_odp->umem.owning_mm,
-						   start, end - start, ops);
-		if (ret)
-			goto out_free_map;
-	}
+	start = ALIGN_DOWN(umem_odp->umem.address, page_size);
+	if (check_add_overflow(umem_odp->umem.address,
+			       (unsigned long)umem_odp->umem.length, &end))
+		return -EOVERFLOW;
+	end = ALIGN(end, page_size);
+	if (unlikely(end < page_size))
+		return -EOVERFLOW;
+
+	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
+				(end - start) >> PAGE_SHIFT,
+				1 << umem_odp->page_shift);
+	if (ret)
+		return ret;
+
+	ret = mmu_interval_notifier_insert(&umem_odp->notifier,
+					   umem_odp->umem.owning_mm, start,
+					   end - start, ops);
+	if (ret)
+		goto out_free_map;
 
 	return 0;
 
@@ -106,7 +109,6 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
 {
 	struct ib_umem *umem;
 	struct ib_umem_odp *umem_odp;
-	int ret;
 
 	if (access & IB_ACCESS_HUGETLB)
 		return ERR_PTR(-EINVAL);
@@ -118,16 +120,10 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
 	umem->ibdev = device;
 	umem->writable = ib_access_writable(access);
 	umem->owning_mm = current->mm;
-	umem_odp->is_implicit_odp = 1;
 	umem_odp->page_shift = PAGE_SHIFT;
 
 	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
-	ret = ib_init_umem_odp(umem_odp, NULL);
-	if (ret) {
-		put_pid(umem_odp->tgid);
-		kfree(umem_odp);
-		return ERR_PTR(ret);
-	}
+	ib_init_umem_implicit_odp(umem_odp);
 	return umem_odp;
 }
 EXPORT_SYMBOL(ib_umem_odp_alloc_implicit);
@@ -248,7 +244,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_odp_get);
 
-void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
+static void ib_umem_odp_free(struct ib_umem_odp *umem_odp)
 {
 	struct ib_device *dev = umem_odp->umem.ibdev;
 
@@ -258,14 +254,19 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 	 * It is the driver's responsibility to ensure, before calling us,
 	 * that the hardware will not attempt to access the MR any more.
 	 */
-	if (!umem_odp->is_implicit_odp) {
-		mutex_lock(&umem_odp->umem_mutex);
-		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
-					    ib_umem_end(umem_odp));
-		mutex_unlock(&umem_odp->umem_mutex);
-		mmu_interval_notifier_remove(&umem_odp->notifier);
-		hmm_dma_map_free(dev->dma_device, &umem_odp->map);
-	}
+	mutex_lock(&umem_odp->umem_mutex);
+	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
+				    ib_umem_end(umem_odp));
+	mutex_unlock(&umem_odp->umem_mutex);
+	mmu_interval_notifier_remove(&umem_odp->notifier);
+	hmm_dma_map_free(dev->dma_device, &umem_odp->map);
+}
+
+void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
+{
+	if (!umem_odp->is_implicit_odp)
+		ib_umem_odp_free(umem_odp);
+
 	put_pid(umem_odp->tgid);
 	kfree(umem_odp);
 }
-- 
2.47.0


