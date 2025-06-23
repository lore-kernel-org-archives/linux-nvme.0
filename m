Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBE9C83013
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zs/Q+vX9v7GYc1Ov3PYzPMbKCnALctBhUqj3QmQUtDs=; b=OYjlJ30H5JBxbXdi6S4g3RpcZN
	V+ifH1o0gq6t3qQSASHJrVQajIRm69iUAzaLoMlUKF6d7PJAPPtvRCaYku7MZodV2vSwUHLUrWpnY
	VY9p53buiexBrSpZhgfJRXrVSy5++isH/NulDM/vOlsZznWjQn5lJQIxbenAHIY9xeDkKMILHNe4x
	AMmewEsoqEkPZjb+S8wECTtF3ccl1XfBg80gxUjB07h7h1QQ48etqM6O8KDRiv9e326zYxKvkUSiY
	7bInDXy4FNw81S7tLEur9uBOyfY9CCOfGD3DLK4pVh5i/v0c5i4Dj1wFcQoujBVRiFLii/jbJ551N
	F4sCXUUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3R-00000003pCf-1PL9;
	Mon, 23 Jun 2025 19:42:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjL6-00000003HlH-1qc1
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:44:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DC89861360;
	Mon, 23 Jun 2025 15:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA0C4CEEA;
	Mon, 23 Jun 2025 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693447;
	bh=OSSbYV4s1eA20gHgWKrDQn++rtQfoP6FQbDvciPIb2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=po+EwlzkjKODiK24Pe5UW52fGQ13j43yKEuP9BMperlgXeqCEvhS8y+YNv0MC22a3
	 8AaOCytka3W+DtMqjVJD6ovYd79eZtha/kkSMBfuPMEUOlYPAsD5mkhwBGHKqKHjZo
	 bXN2wGSEmEvvJXHxg04IbVyknPE2v0SWZ/E6O3UgZXB710xlnbjcKG5798FPi6hcjB
	 RmvBTppWY9DEnOOU+eGgR6oItZLiJ46HbWeTF5+EuQyWEnujcrg0NtfCbVZBO4o8y1
	 5I7zkOVk1xHrTqvQKNuRVoQuOtHWccqvARLxvX6b+Buw8Wg6cd9NEcWw638Kovr8UX
	 KOdTchTKnhluA==
Date: Mon, 23 Jun 2025 09:44:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
Message-ID: <aFl2RWQWaldHce4x@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-7-hch@lst.de>
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

On Mon, Jun 23, 2025 at 04:12:28PM +0200, Christoph Hellwig wrote:
> Use the blk_rq_dma_map API to DMA map requests instead of scatterlists.
> This removes the need to allocate a scatterlist covering every segment,
> and thus the overall transfer length limit based on the scatterlist
> allocation.
> 
> Instead the DMA mapping is done by iterating the bio_vec chain in the
> request directly.  The unmap is handled differently depending on how
> we mapped:
> 
>  - when using an IOMMU only a single IOVA is used, and it is stored in
>    iova_state
>  - for direct mappings that don't use swiotlb and are cache coherent,
>    unmap is not needed at all
>  - for direct mappings that are not cache coherent or use swiotlb, the
>    physical addresses are rebuild from the PRPs or SGL segments
> 
> The latter unfortunately adds a fair amount of code to the driver, but
> it is code not used in the fast path.
> 
> The conversion only covers the data mapping path, and still uses a
> scatterlist for the multi-segment metadata case.  I plan to convert that
> as soon as we have good test coverage for the multi-segment metadata
> path.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

