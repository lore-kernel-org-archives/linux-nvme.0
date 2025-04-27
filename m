Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AFDC369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCa76q1ahoLrStPUZ1HORo3uEnrl9RES5uxwWZe7CmU=; b=2NQWjywZz748mcKgJd2wiMK4YS
	WPi6PFKP/wWZsKBpXuo+6qN3ooBpNjb3S1IoKZg3Q7a98xF4E9nfno99rt9vibUB9EEOP92yR0ynr
	FcMgCXOhFEmtfbFmf18kC484s2mqpM61BJf0FJC2lH6qhYkgfN4+8mWDbikNQUJuyU0o+rTX5Ul2F
	1kBP99OKK1VNdNf2VYcpPFYBHk0u+PM083mg2XhdXzW2P3MQw4Iv85YLg1Dq3+lLxgDsIfceemHko
	0GNySeop4A5H2q+nbC7FGNIIgru8Fnk4v7DKEUlaIO7DEVWwH2Rj4pRn/9irK1YH/qib7eKdlWNu1
	/3aji66A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9f-00000006JTW-3num;
	Mon, 28 Apr 2025 13:04:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8wqa-0000000388O-421F
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 07:54:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D8CCC61157;
	Sun, 27 Apr 2025 07:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0855AC4CEE3;
	Sun, 27 Apr 2025 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745740484;
	bh=Del72uuLK4HjhoyvAuoYd0zF0NkA3zOArQZGDqNBzxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuhJkBrkNS4zwAXk7vhnnjTRZkEidT0ML4s+9rRbQ/rk7cTAt0pbTsqWAepTmBVWl
	 5AfnI/cgdAGSNmV4OtvHzHVqZhuz50Cf5oQnXgSPE590Z0og8OdcRKn9XbJDelW+UI
	 KcY7yLSDQOGGLvnH6aXAbHKg2fTfrqJ2/1hToU+wGxgFKB8y5jpuflRKtTuHFow3c/
	 AcSBIxFBVboHWrcPdTuGaTQ6qglA8niAauD8MT1BQRbl3OVnUBIUFmBpPnUOOsHCBM
	 DToX3YsnhAxRwlCrJ7Z4xLOVkIGDKPmgikA0N4H6UuIg1CNUJMIx8fR6GdZ4hW2y/U
	 KWMW5Qk/iOztg==
Date: Sun, 27 Apr 2025 10:54:39 +0300
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
Subject: Re: [PATCH v9 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <20250427075439.GD5848@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
 <aAwuMuR3tpWtyCTa@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAwuMuR3tpWtyCTa@bombadil.infradead.org>
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

On Fri, Apr 25, 2025 at 05:52:02PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 23, 2025 at 11:12:54AM +0300, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > For the upcoming IOVA-based DMA API we want to use the interface batch the
> > sync after mapping multiple entries from dma-iommu without having a
> > scatterlist.
> 
> This reads odd, how about:
> 
> For the upcoming IOVA-based DMA API, we want to batch the sync operation
> after mapping multiple entries from dma-iommu without requiring a
> scatterlist.
> 
> Other than that:
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I used Jason's proposal
https://lore.kernel.org/all/20250423171537.GJ1213339@ziepe.ca

Thanks

> 
>   Luis

