Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6082CA0EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Py7VOBxcd4HwAc7HHDB+PTMRXMSLHO8b88vcAnVEU6A=; b=iwu4oN+YomEyrKo+WbphpLIm87
	cEqVPYaGYnkdEjbUyZjAJhINOdxStxiQ1d69CEK/u0LoRPfm00g3lK0/5SKXYPmULvpmWoLr4CIEC
	g4YZP7X1j9Vc74iZhP/NmDE4xMJpROS1GvhgKzPMjsJIma425pWTdU/CW0wCEWjudP26sNuDE8mwm
	qUMwCw7u92ejiGZxmBl/SUj3jbG0mtpJSnwomycQ2DfdnmsGduNx/926Wgl9vlLjloJfmPzZncbes
	fBfYG+5mAx2mToOfFq86hWoYZ2j730RAQ4Gfjvi4G6eIlU2s9FcPCAZe2jNOdN4tOTlYRs+BEB7Ih
	d9k4DAqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unbNS-00000005aaA-0PEW;
	Sun, 17 Aug 2025 11:16:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umcAJ-00000000Fda-1icD
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 17:55:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ED6975C71E8;
	Thu, 14 Aug 2025 17:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7099C4CEF6;
	Thu, 14 Aug 2025 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755194102;
	bh=0mJoy+46tPnckyRiCMrZ6rM11HgiRAqoXhfeDURewQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5y8UPYbkB2gzf2uIya/X3vdHYBLt5p8f2+4LvAOXumYTMXCUY8KcMUO+hVWuG5Mi
	 7MzmZa8BOiq3ncXs0zot46eTEMUqsrH0jSfmEBc4Rd3RC/EnHrCaD8bS0umwGI1rMd
	 UdLZ+i6qVKHnzlk0T5qsMDg7gCo2PKlNRDcnn29eXsO4dvTPBeiyKX3kJYqrunChzP
	 vBTtaqwfzFacD2KSsvNKIuqP2BySwh9+2MLpaW2otrJlck+iVxAf0mH6nSYGwNIHe7
	 pVOlSpgYbdrZ6NMFd3ZlatqJdHDz1ybQq38chzBmAVKpPy4QK8iQXExLGVHCiU/RcX
	 j/D9of2rZm+xA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 10/16] xen: swiotlb: Open code map_resource callback
Date: Thu, 14 Aug 2025 20:54:01 +0300
Message-ID: <be7c97a559d2482c99e41b7714400934251c53cd.1755193625.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755193625.git.leon@kernel.org>
References: <cover.1755193625.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_105503_516211_747A6F89 
X-CRM114-Status: GOOD (  13.83  )
X-Mailman-Approved-At: Sun, 17 Aug 2025 04:16:29 -0700
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

General dma_direct_map_resource() is going to be removed
in next patch, so simply open-code it in xen driver.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/xen/swiotlb-xen.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index da1a7d3d377c..dd7747a2de87 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -392,6 +392,25 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 	}
 }
 
+static dma_addr_t xen_swiotlb_direct_map_resource(struct device *dev,
+						  phys_addr_t paddr,
+						  size_t size,
+						  enum dma_data_direction dir,
+						  unsigned long attrs)
+{
+	dma_addr_t dma_addr = paddr;
+
+	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
+		dev_err_once(dev,
+			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		WARN_ON_ONCE(1);
+		return DMA_MAPPING_ERROR;
+	}
+
+	return dma_addr;
+}
+
 /*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
@@ -426,5 +445,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 	.max_mapping_size = swiotlb_max_mapping_size,
-	.map_resource = dma_direct_map_resource,
+	.map_resource = xen_swiotlb_direct_map_resource,
 };
-- 
2.50.1


