Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B96D5CCB3
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zSWGIO8+eoNDo2boHntx+WY/7C1S7kHkrtB0FlbeWwg=; b=LoYgwCXnoqGICbs2LQ1FHscYlI
	m96mMivZ1cqCMl3E1W4lS+AFswYsGJSKLzVzYy4+t4Qi18WIvwf7RnMAJLRJmVVCIbDiiUlqe2bVK
	QyC0kWTYgzMrdFR3AqIvZt7zdnvRkZDqW0imYFHIpD42DCVG2UxEHaPZpE3AnPy7WRfol8KVHzuZf
	0nS7CREH3Jy7sflTHwkU6xGAQaM7VH/mH9TEg1gJdDWKyw/UNGqRkdD4rD7qPxP4tggQ12xjqaXPu
	QU4pZdZGcgrPd3i0bWE9s0jGGuNunXBcq5F+gnZLFPvjsfKzOE1Ip4ZjWU0mvjGMSPWMo++DjvagI
	gb3iWTvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6APT-00000000oMv-0tTs;
	Wed, 30 Oct 2024 15:14:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AOx-00000000nwy-2nsG
	for linux-nvme@bombadil.infradead.org;
	Wed, 30 Oct 2024 15:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zSWGIO8+eoNDo2boHntx+WY/7C1S7kHkrtB0FlbeWwg=; b=mGkYAS3CRKCSGacVtneZeCLpPK
	va7enYKMfFxjfBioKuIDZEJZTOHEougBpZAvCovUdKakjSTPP27kHWLvzf1yAKPwucaFTKSbQSzc7
	32jl8mqGTiRarI0gEdWFH6U0bnj+k4l0s7Q6Zn4P5eBdfQ91V8GJR0cGC/eWuy1E/UDmBXhcDj7PM
	R10ph9FnAZ/b/eRtBtduXoCnfCwO2cogigZBI1kSaxcdTEdwirNzTDUyRizjePSg1GZTuTAYYYhdi
	44Tyx/YNiSEQhWcj3s0V4RI13V0aMrqGSIJiZ8E7dpyRyvLEhOb9MPtBoU93ADeWLqRWZ/5gCQDX9
	WejsjP3A==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AOu-0000000AHSe-3AI2
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:14:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 91F54A412E2;
	Wed, 30 Oct 2024 15:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6154CC4CED0;
	Wed, 30 Oct 2024 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730301263;
	bh=OlIySM8DodN7dp6laXmryqK8XnG8NlruPsXd0qhOBbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnGwg4JbAdghWJybJUqla2ZegkylUzfKB5TcyGzLPzUbM/IHSIANk1/OjZfOMsIzE
	 xqJbLAd9/auwfxV3a72k98W/n2OkiLBw+b4+AH4591LyeHiEd9zNYC0YcvAAcDzGWU
	 MMfeU7lQ/4g02Dp3UlnJ8gcov4oVJueML9uJF2xMFn03x9KMvtYH7yg8crE8p4oVjp
	 pSLm8g7ZJrlcHiAx4IL0pxQft6UasJBqcwplMv6IxDlVEGvZHcOeI29e4L9G0lUpSe
	 mshIdIFqzfpeNCnjYDIv78wDqXwdSd35IiiouiRcox3+6KBKU3xNITLDmysnSqFBmq
	 +2U4Rit5ap4vQ==
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
	linux-mm@kvack.org
Subject: [PATCH v1 14/17] RDMA/umem: Separate implicit ODP initialization from explicit ODP
Date: Wed, 30 Oct 2024 17:13:00 +0200
Message-ID: <23253254adaf3a1e6953de0c5852ac4598b456bd.1730298502.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
References: <cover.1730298502.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_151425_057787_2D47CA7B 
X-CRM114-Status: GOOD (  17.34  )
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
2.46.2


