Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6EFC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Al0q0uimyLX0AHAwflhCX/ownoDnvBB+e7WXRUT8iRY=; b=xDs9729tOvntNpievxazyOnSUQ
	m0mNbJhkP+nM9KJwIaOKY9mfVUMVl0VxAeXUjgcJArnGOo3tyzS/xs2tAvz6i79Tw/4YBmtqsg5Yk
	OJS5g87EQGddDeIE0wQ3vRBqxCaGEbfwlN6crBeXkPqRFLi1okaifYoPnFiayWbIwpx1dOU7GAeGk
	ZKxV9/56oUzYOg4cqltS4dkWe9sXxhLs725+dEUIXMeLvgRrh+iiP1TF9RM926BdIoqEjrCoHTji4
	Pdoh5V4w6srtnYZKmX1xtHoJU2JwQRexl8gXdWhSuWv/yiOvHL5CkuxjsSVjmteje4d6Idyag6yMd
	ELfEmmQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra2F6-0000000BG1Q-1JCm;
	Tue, 13 Feb 2024 23:31:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra2F3-0000000BG0h-0QQR
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 23:31:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 75D986175C;
	Tue, 13 Feb 2024 23:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4B0C433C7;
	Tue, 13 Feb 2024 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707867068;
	bh=+1XO1udNmWXaAaAH+rF9p1f8AZwXVEeDmta7ROf/3XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9YUNyUn0t7j5CNHgYBkSAnYHa0C6gVdTD9py7ZxdxGyeK94mU494TH7GrLxx2swf
	 gTg+oaApSBgHuPbZ3VQVQ2fJwsGShy/HHQD8LGP/dy4NdeVnuRwY3X18ntO8FIuJ3L
	 sOAh3UAefrnDqRzqD0z3kZNtZpOrFUjv4k+0i4jkdSi97N/lceDsj7Z2h2ECR0wLQ9
	 9kyJRk81RrB5Wtxm8qVAxGiqYYCrz5WspPCBZp8RhTcCeR5D5y1PiqSgPj50z5pRvQ
	 3VNuJHmd0KXNJyID1bcgSGNftoRjUkrMPcyBrZ09dxUJDXgvny61k2fTM5z751JJGy
	 eEietQT1NiWtA==
Date: Tue, 13 Feb 2024 16:31:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <Zcv7uI6VrMc2EuGT@kbusch-mbp>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_153109_206378_AE93E37B 
X-CRM114-Status: UNSURE (   7.36  )
X-CRM114-Notice: Please train this message.
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

On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
>  	else
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> -	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
>  	dma_set_max_seg_size(&pdev->dev, 0xffffffff);

I recall we had to do this for POWER because they have 64k pages, but
page aligned addresses IOMMU map to 4k, so we needed to allow the lower
dma alignment to efficiently use it.

