Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32036C5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IgMpCpQCB/0oEAW9yFN0XoseQTFiwEWY3W91yFt9uFs=; b=u3qvzJnfk+yK5sevzMV3Au9w0H
	jjh0kUHzq+JfXnaF0wwA4vMb6e68fE6OMn3u9hZ9yXc4eHpzF838DGlmgu2TcAP5VUIguhYQvjc7x
	vLKeDgE5bluQDkkQCb2ARG8zlYU049ls/P6UyIBYi4phB8NjXB94dTtofk5eqq25412zEy2s0+clG
	f7nE6DpBiub05nLU3X+fzQsAVIZtAD4nAsY/4D4xzaeFxIbmQ8hhacMUngor9DThTAhMQzZP/1E1z
	r8x69f5aZvgKI1Ec6iEUfaRxAC8R//s+yKKxm2i8h0+0EdL94tBSGxKD1Vcgo5rQIpwo0b6RkWI0S
	Ei17N87Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1S5-00000007PHO-46zL;
	Tue, 10 Jun 2025 16:03:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOyt6-00000006w9h-2T3M
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 13:19:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9D2BA629FA;
	Tue, 10 Jun 2025 13:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A14CC4CEEF;
	Tue, 10 Jun 2025 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561575;
	bh=ExmpJqdt8Nx9vpB3PyBR9XWBoIYWiy6bz8HbtpMRh+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqOfg63HR/s/tuogH6KHzMOtRRVp4rQn2r2Wuur5YJc/Y7FVtOt6zn4qq6Aal05g0
	 ofBAkt/N0MUH7B7mfRr0XY1NiJ7fPi2ywLGNfMWmc6QuasNis1KlbDVpk52asx0wws
	 7UMRYLIFrxW7EgnWPem7OOvyF0PBdXl8v6hRLzn3cR/ZLwIzEU3qt6a3WLUcOgPLM+
	 XoOr1xwrCx2cTJMZZ7oXEIDULH+Pl1QAsQkOyfel0mLUbAgrYxlSbUuoux9GcBRhAb
	 sT/UK4oeTPVy2dxIS9e5aU8ROYgn/4krBdD8ejnNn7EGOMsEeFFU8IzNVivBPYrPV8
	 EHSf6t63o22xg==
Date: Tue, 10 Jun 2025 16:19:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250610131929.GI10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>
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

On Tue, Jun 10, 2025 at 07:06:45AM +0200, Christoph Hellwig wrote:
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
>  - for direct mappings that don't use swiotlb and are cache coherent no
>    unmap is needed at al

s/unmap is needed/unmap is not needed

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
> 
> Thanks to Chaitanya Kulkarni for an initial attempt at a new DMA API
> conversion for nvme-pci, Kanchan Joshi for bringing back the single
> segment optimization, Leon Romanovsky for shepherding this through a
> gazillion rebases and Nitesh Shetty for various improvements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 388 +++++++++++++++++++++++++---------------
>  1 file changed, 242 insertions(+), 146 deletions(-)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

