Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49E8D5B154
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=7+9/DynagSBshpDkDEO/Qo39ekOeeQhW1Ny/1R9HdQo=; b=XI4eGN+lwHqDSS
	FRoFYCeLQHADLBE5iSUmjeUPfVSmWzLmdiQZ6cgrgfyxG25LOD2H1P380BQoeT8gNUBpxNeXtuaSB
	CYGk9QUK/WibT3I6s6XYSIIqOEYQmgLA1LuwFPOhrOLvG12CB2amLnjZG93xFme7gzUqNS3wxqbGj
	VaoAEY3nVVH7dE4fi5c4PLv9uAkO1BkhxgCzf+JMYDLHqNovkFjAJK+dM0Aslm3B7qvtZma2k+N2T
	CVKy8HVagnuVq+lQo5Q5Ou1kmO14y5jPkTX3ArVNxV5FAwpsCoIF1EkRI5fJCSPsWTc5YTzuoCuHP
	BnyILuzqk2a+ei6SEjog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5X6z-0000000CJYa-0HIz;
	Mon, 28 Oct 2024 21:17:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5WpO-0000000CGvQ-1Fx3
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 20:59:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2DE955C5B58;
	Mon, 28 Oct 2024 20:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8324C4CEC3;
	Mon, 28 Oct 2024 20:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149144;
	bh=XDchRQtmy6pHQo4VldmyUQn5KpIMSBE9FuRx/IQ/fLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YHWCjZnSvGD0FLXm38frIZRba2sQQ98rHEmaoqo7+IGWHJUxibwDnNsBZgESkMQf2
	 TsIZgg66kDAZi3cQ/raC0xLCHxFt/n+Q+GfpSPikoPYWogMwVVkT2YGGo6r+mvlpQs
	 LYcYZiWraEirilGEQRB7r1dSqxIlLl6PnIyzBEG69k5H5ZL/4V51yCX9ue/AQ9hoao
	 YtQPx9n4wU6TLKUu3BMoGWW4nbSLG6WcdHPvYzg+727B9k+tQFNcmm7b2B+OIclaEr
	 WoCdB/gjnaxlHYJSzABbNThj3fTHRWtRg5gmc802RNwzAtTGyuBAMLTzhdJzsWVOka
	 YksEeTIOFMwbA==
Date: Mon, 28 Oct 2024 15:59:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/18] PCI/P2PDMA: refactor the p2pdma mapping helpers
Message-ID: <20241028205902.GA1114413@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d93ca45f7ad09105a1cf347e6b6d6b6fb7e303.1730037276.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_135906_447689_B5495A4F 
X-CRM114-Status: GOOD (  25.50  )
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

Prefer subject capitalization in drivers/pci:

  PCI/P2PDMA: Refactor ...

On Sun, Oct 27, 2024 at 04:21:01PM +0200, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The current scheme with a single helper to determine the P2P status
> and map a scatterlist segment force users to always use the map_sg
> helper to DMA map, which we're trying to get away from because they
> are very cache inefficient.
> ...

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

A couple minor nits below.

> @@ -1412,28 +1411,29 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		size_t s_length = s->length;
>  		size_t pad_len = (mask - iova_len + 1) & mask;
>  
> -		if (is_pci_p2pdma_page(sg_page(s))) {
> -			map = pci_p2pdma_map_segment(&p2pdma_state, dev, s);
> -			switch (map) {
> -			case PCI_P2PDMA_MAP_BUS_ADDR:
> -				/*
> -				 * iommu_map_sg() will skip this segment as
> -				 * it is marked as a bus address,
> -				 * __finalise_sg() will copy the dma address
> -				 * into the output segment.
> -				 */
> -				continue;
> -			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> -				/*
> -				 * Mapping through host bridge should be
> -				 * mapped with regular IOVAs, thus we
> -				 * do nothing here and continue below.
> -				 */
> -				break;
> -			default:
> -				ret = -EREMOTEIO;
> -				goto out_restore_sg;
> -			}
> +		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
> +		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +			/*
> +			 * Mapping through host bridge should be mapped with
> +			 * regular IOVAs, thus we do nothing here and continue
> +			 * below.
> +			 */

I guess this is technically not a fall-through to the next case
because there's no executable code here, but since the comment
separates these two cases, I would find it easier to read if you
included the break here explicitly.

> +		case PCI_P2PDMA_MAP_NONE:
> +			break;

> +void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
> +		struct device *dev, struct page *page);
> +
> +/**
> + * pci_p2pdma_state - check the P2P transfer state of a page
> + * @state: 	P2P state structure

Checkpatch complains about space before tab here.

> + * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
> + * @state: 	P2P state structure

And here.

> @@ -462,34 +462,32 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  		enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct pci_p2pdma_map_state p2pdma_state = {};
> -	enum pci_p2pdma_map_type map;
>  	struct scatterlist *sg;
>  	int i, ret;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> -		if (is_pci_p2pdma_page(sg_page(sg))) {
> -			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> -			switch (map) {
> -			case PCI_P2PDMA_MAP_BUS_ADDR:
> -				continue;
> -			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> -				/*
> -				 * Any P2P mapping that traverses the PCI
> -				 * host bridge must be mapped with CPU physical
> -				 * address and not PCI bus addresses. This is
> -				 * done with dma_direct_map_page() below.
> -				 */
> -				break;
> -			default:
> -				ret = -EREMOTEIO;
> +		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
> +		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +			/*
> +			 * Any P2P mapping that traverses the PCI host bridge
> +			 * must be mapped with CPU physical address and not PCI
> +			 * bus addresses.
> +			 */

Same fall-through comment.

> +		case PCI_P2PDMA_MAP_NONE:
> +			sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
> +					sg->offset, sg->length, dir, attrs);
> +			if (sg->dma_address == DMA_MAPPING_ERROR) {
> +				ret = -EIO;
>  				goto out_unmap;
>  			}
> -		}

