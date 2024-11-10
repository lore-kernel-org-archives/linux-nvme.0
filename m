Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C32D12D40
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wohjECrItiTe3wGt73yRaTZkJ8cJH9lXeliHlLBqbI=; b=gcnCtI465QaiymjyQ0jp42K9x/
	IXXT6XmoKw24MWTAHPE0b+jp6RsxL7fD5odzsgujOFgmAbA/JZ8dntFvF5WN8VttpTfpMcX21uItg
	a19dyO07+Q6q2z33F9gv/D+Dzj0+hEmSYWtQhcIcioX0LpVMn+Uk1mnmOsa8ufnrCLqTfuKX7ud60
	NktxB0zN+xsxgDlyaWQ8ILRvD7XR2GTAucs5sz3bnHSaR65gjWH9w89uh0w0F18QzWrSplS0pJchA
	Dd8mWghiZe83HkNGOvZkJv1ABNnOYEixiMOA1xxyvMXyx02Quv7TfCPbZku2XGgzlJVZhROkcMcvD
	G8cK4uFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9QH-0000000F4Hv-1a9q;
	Sun, 10 Nov 2024 15:00:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA8J1-0000000ExRD-20L3
	for linux-nvme@bombadil.infradead.org;
	Sun, 10 Nov 2024 13:48:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9wohjECrItiTe3wGt73yRaTZkJ8cJH9lXeliHlLBqbI=; b=TQNej5q0p89SqKBjMtNjch/HdF
	LhYgT/NzLVK5pGKCduHtivR+sAtuUa+Cg+lpWd03R7y7UVjRNKr4lcFf/TzGOORrF+WcqsAAYKxWD
	Dx0S1fhQB5ypVHdyl826kP2J3E3lJu/Es0tRe0TxHCfnvt9hLI8gyLNWxAMmn1K4ePA4nTNNFbwV3
	5ofRhM5sXYQjkeejSs0J3lCADBDZ2ATphBdvKL0Dl9bK2xGGVuCOdItPgDAz8/mxKELCeFzA2xNzk
	iwWdXml3nAqZyVPiefmEApXdZkOjdMwudLerMyHu972MQo6ezZXRRDdIiPXgxAp6uEwiJqH3I9gi5
	XYnHPk0w==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA8Ip-0000000Cer7-13eH
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 13:48:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 94B07A40D06;
	Sun, 10 Nov 2024 13:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F719C4CED0;
	Sun, 10 Nov 2024 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731246509;
	bh=faZKR+GLvGy07GeNnto8v510/6+S1UMSrHjOqNZtBkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZqOjdQdeucnpQjwxEkZ3eHNOrLAHuPXqFA+rkeoPQNnbMEMED4/1APfMaS2VAkvl
	 rLzo8I5d3cTWDyvtQAw6GetM/pXaLgdtyjkTbOMP04Gbpw7rebxfJIUG39XWZjAUHC
	 JGWMb5rqS9GCk/zzg8r5kvegLt8mnOV9U3rhXtXKbNuaKlpOPReGPD1exn9r1CMgAr
	 g8Ef0ettthz2D42h+w+IplD8y8ij8IGY4ZnR432YPo0BvhAwsvwE1dBDHfo85OWy2N
	 x797zDgcIHKGYceA13Lx+R4ckiP9GOINwblEDprMsodj69+OGCPA0/pTz8sp3vKKJ9
	 2XFK1MUvbZZqA==
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
Subject: [PATCH v3 14/17] RDMA/umem: Separate implicit ODP initialization from explicit ODP
Date: Sun, 10 Nov 2024 15:47:01 +0200
Message-ID: <1e5645ca12e94a74d8ec5e3aea75e38553ed6614.1731244445.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731244445.git.leon@kernel.org>
References: <cover.1731244445.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_134831_945463_48293C76 
X-CRM114-Status: GOOD (  17.00  )
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


