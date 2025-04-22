Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C581C369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 05:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hecHTTFiHoubGNs1ml9EB1UZx9/d9a75345Icg87B1M=; b=o3UUEo25EMWjSul2WxDCcq/y9i
	0oNs0bQtHOKIHGYRiAjJjBVJldUQyDUvQnQsx81SNsxUVAN7UMqrWZQ1RVirHaTaJoVdptO5QKEZP
	HYX8lw47YNIzjxDv/Ma5q5BU9zSW62U6jO4SvaRuvYO+SMFIExJg2avfxAUI3xV6iWezm19vlBCxG
	TE8xRYRtBL4DBc5IxIhvcNon7bZ+8TShQoBqQXu1QuQuH1aM+sTcYi8jltCxI67xx/U6CRvjCcBZl
	4EJl2t1FmgLpLrKaj2MMFiomQWm2OmHNEU6tHKesYtXBSxJ5HnPEaI156ZoP7ENzKZYG1np/3kikE
	OzHCUASA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u75mh-00000005pLY-31mL;
	Tue, 22 Apr 2025 05:03:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u75kf-00000005p3s-0BcT
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 05:00:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1414268BFE; Tue, 22 Apr 2025 07:00:51 +0200 (CEST)
Date: Tue, 22 Apr 2025 07:00:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250422050050.GB28077@lst.de>
References: <cover.1744825142.git.leon@kernel.org> <f06a04098cb14e1051bddec8a7bdebe1c384d983.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06a04098cb14e1051bddec8a7bdebe1c384d983.1744825142.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_220057_217904_5BEDDDD8 
X-CRM114-Status: GOOD (  19.22  )
X-Mailman-Approved-At: Mon, 21 Apr 2025 22:01:33 -0700
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

> +	dma_len = min_t(u32, length, NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));

And overly long line slipped in here during one of the rebases.

> +		/*
> +		 * We are in this mode as IOVA path wasn't taken and DMA length
> +		 * is morethan two sectors. In such case, mapping was perfoormed
> +		 * per-NVME_CTRL_PAGE_SIZE, so unmap accordingly.
> +		 */

Where does this comment come from?  Lots of spelling errors, and I
also don't understand what it is talking about as setors are entirely
irrelevant here.

> +	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_state, iod->total_len)) {
> +		if (iod->cmd.common.flags & NVME_CMD_SGL_METABUF)
> +			nvme_free_sgls(dev, req);

With the addition of metadata SGL support this also needs to check
NVME_CMD_SGL_METASEG.

The commit message should also really mentioned that someone
significantly altered the patch for merging with latest upstream,
as I as the nominal author can't recognize some of that code.

> +	unsigned int entries = req->nr_integrity_segments;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  
> +	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_meta_state,
> +			      iod->total_meta_len)) {
> +		if (entries == 1) {
> +			dma_unmap_page(dev->dev, iod->meta_dma,
> +				       rq_integrity_vec(req).bv_len,
> +				       rq_dma_dir(req));
> +			return;
>  		}
>  	}
>  
> +	dma_pool_free(dev->prp_small_pool, iod->meta_list, iod->meta_dma);

This now doesn't unmap for entries > 1 in the non-IOVA case.


