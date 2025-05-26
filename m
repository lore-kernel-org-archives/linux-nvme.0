Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD737C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=oEQfyNRCcF96rAB00+i4LTDnH6eyExMGUimV2Hx1YDM=; b=n+UAW09laJbFU8sswpiM585kxg
	WmkXyYqzK34yj8W4R8OpKWABwWIhl60KLdlzGSZp+ZjZt9iDjUktYumBgA42/wRxLRxdH+SgG08O3
	r8LZLn+Ln+2fFvgPuXlg+TuL8dvvZFPgBGTkrGFidYdOfgTs7di1e4hE+AlgmT3ubgnGSebD754/0
	KUPTV0ywGImUL2uXEWHSylrkfKQfkobY18EVN1Ikq6t56uEcqCWsbjgpbO6FQiUwzAhcspVWwAgLU
	rcsMFQawdkYWTTbQMUIyqdw6iKTd4gkLkO+PM1fKJWbpnBGYnkrQ6D3q79AAHNYRJmt3EhE2YunnP
	unVe5ryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJXJq-00000008pJm-3wy0;
	Mon, 26 May 2025 12:52:42 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJWfm-00000008lJJ-16yM
	for linux-nvme@lists.infradead.org;
	Mon, 26 May 2025 12:11:20 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250526121112euoutp020939f6f970e100a8dc72a890f537db4f~DEovd-X3V0823508235euoutp02J;
	Mon, 26 May 2025 12:11:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250526121112euoutp020939f6f970e100a8dc72a890f537db4f~DEovd-X3V0823508235euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748261472;
	bh=oEQfyNRCcF96rAB00+i4LTDnH6eyExMGUimV2Hx1YDM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QzVzaho+gT//bWlkOTURTWXtnc4hEIbMGV8JGp+3YxyiCKTP2iSsBUjdf1+HZQ4kU
	 KfdrZt6CeW5/LJ23tYHTuLXJ3kJbiO3M7rL7lK/fpNvKAIkHIo4/mt7rD+GA9hvsRQ
	 YvWT05wESqHMdmy9XXFENm1m1Kn4J6FrqN3/kJzQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250526121111eucas1p277b74b79fe4ae4323fc687a06039044d~DEovH6I0i1358313583eucas1p2X;
	Mon, 26 May 2025 12:11:11 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250526121110eusmtip1782073e50a70b6e2a3e0c1a2ca4e7eda~DEotgHSUL0843308433eusmtip13;
	Mon, 26 May 2025 12:11:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Leon Romanovsky <leon@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Jake Edge <jake@lwn.net>, Jonathan Corbet
	<corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun
	<zyjzyj2000@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
	<logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, Niklas Schnelle
	<schnelle@linux.ibm.com>, Chuck Lever <chuck.lever@oracle.com>, Luis
	Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>, Dan
	Williams <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [GIT PULL] dma-mapping update for Linux 6.16
Date: Mon, 26 May 2025 14:11:05 +0200
Message-Id: <20250526121105.434835-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250526121111eucas1p277b74b79fe4ae4323fc687a06039044d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250526121111eucas1p277b74b79fe4ae4323fc687a06039044d
X-EPHeader: CA
X-CMS-RootMailID: 20250526121111eucas1p277b74b79fe4ae4323fc687a06039044d
References: <CGME20250526121111eucas1p277b74b79fe4ae4323fc687a06039044d@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250526_051118_568934_3380D717 
X-CRM114-Status: GOOD (  13.80  )
X-Mailman-Approved-At: Mon, 26 May 2025 05:51:32 -0700
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

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.16-2025-05-26

for you to fetch changes up to 3ee7d9496342246f4353716f6bbf64c945ff6e2d:

  docs: core-api: document the IOVA-based API (2025-05-06 08:36:54 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.16:

- new two step DMA mapping API, which is is a first step to a long path
  to provide alternatives to scatterlist and to remove hacks, abuses and
  design mistakes related to scatterlists; this new approach optimizes
  some calls to DMA-IOMMU layer and cache maintenance by batching them,
  reduces memory usage as it is no need to store mapped DMA addresses to
  unmap them, and reduces some function call overhead; it is a combination
  effort of many people, lead and developed by Christoph Hellwig and Leon
  Romanovsky

----------------------------------------------------------------
Christoph Hellwig (6):
      PCI/P2PDMA: Refactor the p2pdma mapping helpers
      dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
      iommu: generalize the batched sync after map interface
      iommu/dma: Factor out a iommu_dma_map_swiotlb helper
      dma-mapping: add a dma_need_unmap helper
      docs: core-api: document the IOVA-based API

Leon Romanovsky (3):
      iommu: add kernel-doc for iommu_unmap_fast
      dma-mapping: Provide an interface to allow allocate IOVA
      dma-mapping: Implement link/unlink ranges API

 Documentation/core-api/dma-api.rst |  71 ++++++
 drivers/iommu/dma-iommu.c          | 482 ++++++++++++++++++++++++++++++++-----
 drivers/iommu/iommu.c              |  84 ++++---
 drivers/pci/p2pdma.c               |  38 +--
 include/linux/dma-map-ops.h        |  54 -----
 include/linux/dma-mapping.h        |  85 +++++++
 include/linux/iommu.h              |   4 +
 include/linux/pci-p2pdma.h         |  85 +++++++
 kernel/dma/direct.c                |  44 ++--
 kernel/dma/mapping.c               |  18 ++
 10 files changed, 764 insertions(+), 201 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

