Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69EC02181
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tCJUyiPn/Ws20D2od7v+Q9HKfGuNfrmrIPXnVcImIHs=; b=kcV9lDVD2pjlfDPpBGrIjaWm47
	/o4jdzn1jJJvhai971PyE62wodz6tP6hFHutH4jV5MELMrjUdMPdJ/uZCltV3I4fNnEYXM+BUyjIh
	SyJX0u4p9NOTDmJJbwsol8kUwzy0OWA+rltojF2bafrsuwIRUibGmloiLETsoMZzTkTRpVRu+oiJ4
	W8aUetOOjZ3xh4+Tq6edhnf2QBv184C6mWuBu157sPBhIcHnwW+KTQOx/vslmAJD3Jl3NZ0TSWDXT
	tPVD60cUolmr9SD/JFRFaaletvz+MVRoZzFICN7v7C/wml4MxPl8zYCGnFA3cE4K+WLNWE0W7pfbs
	PFSYkUvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taUzS-00000009aIj-073v;
	Wed, 22 Jan 2025 07:17:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taUy6-00000009a8f-1bbe
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 07:16:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7CF655C5C48;
	Wed, 22 Jan 2025 07:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F05C4CEE2;
	Wed, 22 Jan 2025 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737530164;
	bh=tSo5YKl5X3DFM1qWK3NIAZZXFJGx8VgXV6QXZ6sOkCs=;
	h=Date:From:To:Cc:Subject:From;
	b=bE38QQ6vnaUxbTv5Xsmn18B0iOF4kSDFj4rpFxv8Mms3apibukB9coTAosEmDhXdg
	 pLpiMUba7Pt7NmZ3Vb4ilncay0Exvoo31IIQA333KVqd1sh9VoDfEZAXO9Xnw1/DSp
	 g0J8O5XqJReO4BkUd4VTMv9ZTpHZ84Rkwxfh+v5Z5y5wLuR89QxJzsMKUiYUZklyUP
	 yPR2Py/GUuBXWQJsriiuwLQMQ1HxSiwm/6J5ZKG8HezsuhGG43G5CCqEpPQjZCyhJL
	 Of7JJzziQa8zqgoKWKtc4uWtJRP2OCSNdWAaC/F62hPvfJ6fqfv9Sr9OWVB33vw9Ku
	 v0X2rrbjIBfTg==
Date: Wed, 22 Jan 2025 09:16:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] DMA mapping API in complex scenarios
Message-ID: <20250122071600.GC10702@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_231606_559031_81C37D60 
X-CRM114-Status: GOOD (  13.09  )
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

Currently the only efficient way to map a complex memory description through
the DMA API is by using the scatterlist APIs. The SG APIs are unique in that
they efficiently combine the two fundamental operations of sizing and allocating
a large IOVA window from the IOMMU and processing all the per-address
swiotlb/flushing/p2p/map details.

This uniqueness has been a long standing pain point as the scatterlist API
is mandatory, but expensive to use. It prevents any kind of optimization or
feature improvement (such as avoiding struct page for P2P) due to the
impossibility of improving the scatterlist.

Several approaches have been explored to expand the DMA API with additional
scatterlist-like structures (BIO, rlist), instead split up the DMA API
to allow callers to bring their own data structure [1].

The API is split up into parts:
 - Allocate IOVA space:
    To do any pre-allocation required. This is done based on the caller
    supplying some details about how much IOMMU address space it would need
    in worst case.
 - Map and unmap relevant structures to pre-allocated IOVA space:
    Perform the actual mapping into the pre-allocated IOVA. This is very
    similar to dma_map_page().

In this topic, I would like to present existing DMA API abuses and present path
to move forward with the help of new DMA API.

In this topic I will briefly present the new API and have a forward
looking discussion about how such a significant change is expected to
impact the kernel.

Particularly how this API fits with Matthew's phyr sketch, and where
we might see this go in the storage layer (David's proposal for iter [2]).
In addition, we will discuss the roadmap of converting DMABUF and RDMA to
SG-free world (Jasons's vision [3]):

 1) The new DMA API lands
 2) We improve the new DMA API to be fully struct page free, including
    setting up P2P
 3) VFIO provides a dmbuf exporter using the new DMA API's P2P
    support. We'd have to continue with the scatterlist hacks for now.
    VFIO would be a move_notify exporter. This should work with RDMA
 4) RDMA works to drop scatterlist from its internal flows and use the
    new DMA API instead.
 5) VFIO/RDMA implement a new non-scatterlist DMABUF op to
    demonstrate the post-scatterlist world and deprecate the scatterlist
    hacks.
 6) We add revoke semantics to dmabuf, and VFIO/RDMA implements them
 7) iommufd can import a pinnable revokable dmabuf using CPU pfns
    through the non-scatterlist op.
 8) Relevant GPU drivers implement the non-scatterlist op and RDMA
    removes support for the deprecated scatterlist hacks.

[1] https://lore.kernel.org/all/cover.1737106761.git.leon@kernel.org
[2] https://lore.kernel.org/all/886959.1737148612@warthog.procyon.org.uk/
[3] https://lore.kernel.org/all/20250120175901.GP5556@nvidia.com

----------------------------------------------------------------------------
 LWN coverage:
Dancing the DMA two-step - https://lwn.net/Articles/997563/
----------------------------------------------------------------------------

Thanks

