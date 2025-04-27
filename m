Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B2C369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KuxxJHp390FlsAEnJEhHlKbgyQwkcp7dCcj24iOjCQA=; b=l/n1VJ5M8zyUwDiqogIwpnNp+S
	y0a6vfDRHfjmdrTHwg5p6mHeTN1fmg9zMWhjrFWcKMGaowdGqlSGpvlWmtfhPcIrZgazng0CS1iHM
	4DMr70n5wj+W4aAWIlmkWtNGPijHORwlhsLflEbYDAHtSnULu8JqeqjwROacURZAugjz0o8S6uXnP
	kScnz+YdcNU7xppTjVOtcosoby1Cr3lw8oN+HI8LX5qegRpar1gbiCHkYfGcRcJrQK9vdKGPkLDWk
	ymTOdkDtKI4fLizAWyKpQsTlgbO19avPLDOtQNjpY04zzmUzL01oklgPPkVeY0QvoRS3DRI3XscOq
	Z9FmCe6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9e-00000006JSV-3DXh;
	Mon, 28 Apr 2025 13:04:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8wpZ-000000037vJ-35K3
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 07:53:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8259061166;
	Sun, 27 Apr 2025 07:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CD1C4CEE3;
	Sun, 27 Apr 2025 07:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745740418;
	bh=iKyTQwydNmAM/0HcUlde1DtC+bZbAuPZo0BeWV99Sn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmokyrrKogcvAy75PZnoqbf/SV/3tN6a/jr9gHE56cV2aAUja1b1vR87w7sFYp9SM
	 2MTW/5zl9jZEDztFGGMRMoytnKxQ/fH3Nx6Llyyms85hrYsAaXPnI47FYKgA+tncyk
	 mkQJNR/IXAW+albRz+ErujsbIoPBM+w7flk409Lh3ddIk6MNaLOs5tByMzgIIbhf5K
	 jRQYMV0yr7lWDCaipx7Aq5g43zt2+567TjgKvYuKc8lxRSBlEQo2Qk0Kj38yk4NdCj
	 I1x37331Ys/wwpuT1EUyEcmT/tN7FXyY29DcKZ5RlQ/ztukgb7skj9uPZ3RY+pbnTx
	 CTtopc3JapJnQ==
Date: Sun, 27 Apr 2025 10:53:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 02/24] dma-mapping: move the PCI P2PDMA mapping
 helpers to pci-p2pdma.h
Message-ID: <20250427075332.GC5848@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <493a6ab31fdd73e84e16662578858f194e9f87b9.1745394536.git.leon@kernel.org>
 <aAwqBvLP3kaZsEdZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAwqBvLP3kaZsEdZ@bombadil.infradead.org>
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

On Fri, Apr 25, 2025 at 05:34:14PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 23, 2025 at 11:12:53AM +0300, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > +enum pci_p2pdma_map_type {
> > +	/*
> > +	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> > +	 * type hasn't been calculated yet. Functions that return this enum
> > +	 * never return this value.
> > +	 */
> 
> This last sentence is confusing. How about:
> 
> * PCI_P2PDMA_MAP_UNKNOWN: Used internally as an initial state before
> * the mapping type has been calculated. Exported routines for the API
> * will never return this value.

This patch moved code as is, but sure, let's update the comments.

> 
> > +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> > +
> > +	/*
> > +	 * Not a PCI P2PDMA transfer.
> > +	 */
> > +	PCI_P2PDMA_MAP_NONE,
> > +
> > +	/*
> > +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> > +	 * traverse the host bridge and the host bridge is not in the
> > +	 * allowlist. DMA Mapping routines should return an error when
> > +	 * this is returned.
> > +	 */
> > +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> > +
> > +	/*
> > +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> 
> You mean   PCI_P2PDMA_MAP_BUS_ADDR

done

> 
> > + * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
> 
> Hrm, maybe with a bit more clarity:
> 
> Translate a physical address to a bus address for a  PCI_P2PDMA_MAP_BUS_ADDR
> transfer.
> 
> 
> Other than that.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks

> 
>   Luis
> 

