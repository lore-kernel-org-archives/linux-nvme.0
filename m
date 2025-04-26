Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A498C3ABA5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sE3j07Wu6HWpAty2P7Jg20vlFta/zTQ2qMS7NINOz0M=; b=KoO4fCBdf6w9ZnwI5UA3fUew+c
	9GLIK5VmDofGz1OG0eYfoiC7zceMPtK91LJbb2W3vF7Yj0YFQCvrRG96TAIy1w2gAu6uOoDYSN4it
	f7GoJVPQWgOWDJVfLxVZxeq2DMgKNBZVFzHL9Z/lBpkq4wHCIm5PnK8rYIaSdKOU8AZlU3XGWlYat
	tlt2rzuOq3f+IlhEAuTbpo+Adhh2kzdeO60Q395/gGzkW2/Btuco2vNFCvTF+KndirkKCYdhqJtn6
	MsUlpu8GfyCw3bVfkKAHtw9woBHVOJ+NuHBkXr8LIDqZp7o9ZIirjoeiJIeNVTFIlty/0p6icYgcC
	Jw9eAXuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9Y-00000006JLu-19Vj;
	Mon, 28 Apr 2025 13:04:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8TUo-00000001CYu-0Awo
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 00:34:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9EAC843F30;
	Sat, 26 Apr 2025 00:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610E9C4CEE4;
	Sat, 26 Apr 2025 00:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745627657;
	bh=gP3gwxgNw7FZrnmpPmzzPgN9aXPBN23+6+4ANBvGC9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5REWfbHKSUvcglP1TpsrQx/rq1FAKn2v2KHy+BXjjaPljIS5n6SQK9pVphFinRnx
	 iiZmWQcYqMCRenOrXGgkymILO6xDnjVdTIYpTwlC3124iJI/lqBnVkjVDeyHa3k2Zi
	 AonqUn2JHmINYqVkRLWYeWOCDjqFjcathYX0Qq+u6FkpKKd0j1WSGxWchvgjaJDyxN
	 2P31MVsu9VM6jv5ZklMDygNJJkrtglm54XJC2zPLQA1Asos5rowVnKiOk52+CPyCFW
	 vYxLICwro5pr/DvALNKeCg7BcMKkO1MMGoCQvVAYmjFgzzR23x5OnOOsuVFqTivGU6
	 Jb/EjtzwtiErw==
Date: Fri, 25 Apr 2025 17:34:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 02/24] dma-mapping: move the PCI P2PDMA mapping
 helpers to pci-p2pdma.h
Message-ID: <aAwqBvLP3kaZsEdZ@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <493a6ab31fdd73e84e16662578858f194e9f87b9.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493a6ab31fdd73e84e16662578858f194e9f87b9.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_173418_112833_FBB10836 
X-CRM114-Status: GOOD (  16.22  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:58 -0700
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

On Wed, Apr 23, 2025 at 11:12:53AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> +enum pci_p2pdma_map_type {
> +	/*
> +	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> +	 * type hasn't been calculated yet. Functions that return this enum
> +	 * never return this value.
> +	 */

This last sentence is confusing. How about:

* PCI_P2PDMA_MAP_UNKNOWN: Used internally as an initial state before
* the mapping type has been calculated. Exported routines for the API
* will never return this value.

> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +
> +	/*
> +	 * Not a PCI P2PDMA transfer.
> +	 */
> +	PCI_P2PDMA_MAP_NONE,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> +	 * traverse the host bridge and the host bridge is not in the
> +	 * allowlist. DMA Mapping routines should return an error when
> +	 * this is returned.
> +	 */
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +
> +	/*
> +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to

You mean   PCI_P2PDMA_MAP_BUS_ADDR

> + * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer

Hrm, maybe with a bit more clarity:

Translate a physical address to a bus address for a  PCI_P2PDMA_MAP_BUS_ADDR
transfer.


Other than that.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

