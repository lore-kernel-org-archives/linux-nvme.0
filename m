Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7311C3ABA6
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/ESNbeAy5rYsesg0kvfKdFruu1rtfwC9E4bjfH7dDA=; b=CVEnTFFXRFuYaCz6VFNiQsg/rg
	ZEWcbM1HoEyA7k9CFNY79DLBeVK4aJRqcuzt5cBrrDeGwsvL+IYPuG2I1dGDj0fyLkumGJRh7ncnJ
	cjB9P41IJykZpcdWq0+RmnbQj8RFtJ4kUNJ4e7f3NiHghD4XdimHy8ko1DbyNDuNXbJXLtpTIjbVg
	lhheytjNvMydsgLYSWw0QF7nnYwkMh9nn8PRMQURlXQip4obiGy2Lbf+AVWoxaCS4piEmpH84ztjh
	W2EetxIPqwdN2+CQQKHGRGQbuP+3zpXf1+Hf5OV8VcgxqQMHrS8b0eDvUMxl4v3KIPLq0bpkrmwLA
	sXKAg5ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9e-00000006JRg-03WX;
	Mon, 28 Apr 2025 13:04:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8wOE-000000035uU-3znP
	for linux-nvme@bombadil.infradead.org;
	Sun, 27 Apr 2025 07:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J/ESNbeAy5rYsesg0kvfKdFruu1rtfwC9E4bjfH7dDA=; b=DjD4+Mp0JVbKZWEhgcCkHh2HH2
	HyMGwD+o3dTL6X+C12Ek8ds2cohfKuxwGG8H3zi6Ugn7t8STQVeBmoKxOxM9j2DU5xX3ywp61auNs
	4d/WQTKL13Xm8gEBHs90UfGMWg++yAWztopfgPwKNcLRpI9aXWDoevWLS0uB2K16drU/CN/5A3bkZ
	ICyMFr3w8wl45/b7l8yz9JstIlEGqFxrejiPdNAklAWYV+66Qeous+P7AtaWc3pu5xnMf0qupHuoK
	EPRL8X7F3Crer2dnNEg4DA1zlT4iwY2ASjOyKAnt+ASRZw0hIOuC9Tz4yGgbm/2eNOo9jwhBVGtmM
	Y8/NBdBg==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8wOA-0000000CQZD-1AwU
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 07:25:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 68D30A45C08;
	Sun, 27 Apr 2025 07:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40495C4CEE3;
	Sun, 27 Apr 2025 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745738712;
	bh=bERqNoVKbx4P/SwDDUOXyFXrxjwzNnYFUoDcCNKCVfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1xqE+mqwh8U+55fROspjUrKNzRVSIzJfDGM+Ls83njMJYStvF3kCZtrxDGnS8SVT
	 FH2Y3/4QmPSaIrhVwSXIBJfNKQb2jOqg/0R9XOlNO+8e0XTTOVDsgTNzItS/cuPjFL
	 PJCX+bYuGxOwMqFXAxDt9oJubodYIurQ+knbiSyXMkoJmOUGIl6AyOiN49LQkcuXwW
	 lX4Zt8yUC+E7ZRN3ptmo7qa1Dn9p3RQqNw+5yoy5YM9m0zO7K7IBGHJkXHsUDSieM4
	 qCQegX3jtiPkdIH87I9vQ2L9GafYOjlgT1bfZh8UZrFfu8pXhN2WP2XoeZGCszveQ5
	 tJLYM5tBLk6AQ==
Date: Sun, 27 Apr 2025 10:25:07 +0300
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
Subject: Re: [PATCH v9 01/24] PCI/P2PDMA: Refactor the p2pdma mapping helpers
Message-ID: <20250427072507.GB5848@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <3a962f9039f0265de939f4c81924ee8208fc93a6.1745394536.git.leon@kernel.org>
 <aAwnJwLeOs7rfkHL@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAwnJwLeOs7rfkHL@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_082522_757056_2E66067D 
X-CRM114-Status: GOOD (  24.31  )
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

On Fri, Apr 25, 2025 at 05:21:59PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 23, 2025 at 11:12:52AM +0300, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > The current scheme with a single helper to determine the P2P status
> > and map a scatterlist segment force users to always use the map_sg
> > helper to DMA map, which we're trying to get away from because they
> > are very cache inefficient.
> > 
> > Refactor the code so that there is a single helper that checks the P2P
> > state for a page, including the result that it is not a P2P page to
> > simplify the callers, and a second one to perform the address translation
> > for a bus mapped P2P transfer that does not depend on the scatterlist
> > structure.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Might make it easier for patch review to split off adding
> __pci_p2pdma_update_state() in a seprate patch first.

Original code __pci_p2pdma_update_state() had this code and was
dependent on SG, which we are removing in this patch.

       if (state->map == PCI_P2PDMA_MAP_BUS_ADDR) {
               sg->dma_address = sg_phys(sg) + state->bus_off;
               sg_dma_len(sg) = sg->length;
               sg_dma_mark_bus_address(sg);
       }

So to split, we would need to introduce new version of __pci_p2pdma_update_state(),
rename existing one to something like __pci_p2pdma_update_state2() and
remove it in next patch. Such pattern of adding and immediately deleting
code is not welcomed.

> Other than that, looks good.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kenrel.org>

Thanks

> 
>   Luis

