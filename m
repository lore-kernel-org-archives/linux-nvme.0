Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF291C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 05:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRY7ymDB7G/y3N9byL6waHMk5WHTws/bwQqq3msJblk=; b=oM5in6cKygdPoE6UDxuIWaWj3F
	ejoLnZzYQF+ttXkjA86zSsNKpTT2M8PxwU0GGJ5gfEmsUyJ4RZhs6gi6eBHMI6lxflQaTSs9Jk6RF
	SkC0np3XI43AHdcqJdCpkoGXjR6Sx03DJhkN8u+r6YH0IrKuPWUgR3weDl4/5/q4MVigEmGP8zY3p
	H3B5SErDOBcu+LESgU2WvblVrBb4LPY8uW8GB1B88N8Mt1Oqp0zXkWqCrtmJP+sKo3qWOqTKlUfs3
	SuYCo5kxk7HIX0js0d5wlq6Azi8DsBsVx8wCFyBtjrX/u6lW0KTtV8yyoaD9GDIuhyAoAUXw9Sa+d
	BRoo+oUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u75mh-00000005pKr-0EiW;
	Tue, 22 Apr 2025 05:03:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u75QQ-00000005non-3xCv
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 04:40:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89EBF68BFE; Tue, 22 Apr 2025 06:39:56 +0200 (CEST)
Date: Tue, 22 Apr 2025 06:39:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
Message-ID: <20250422043955.GA28077@lst.de>
References: <cover.1744825142.git.leon@kernel.org> <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_214003_126463_58720CEF 
X-CRM114-Status: GOOD (  18.41  )
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

On Fri, Apr 18, 2025 at 09:47:54AM +0300, Leon Romanovsky wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> blk_rq_dma_map API is costly for single-segment requests.
> Avoid using it and map the bio_vec directly.

This needs to be folded into the earlier patches or split prep patches
instead of undoing work done earlier, preferably combined with a bit
of code movement so that the new nvme_try_setup_prp_simple stays in
the same place as before and the diff shows it reusing code.

E.g. change

"nvme-pci: use a better encoding for small prp pool allocations" to
already use the flags instead of my boolean, and maybe include 
abort in the flags instead of using a separate bool so that we
don't increase hte iod size.

Slot in a new patch after that that dropping the single SGL segment
fastpath if we think we don't need that, although if we need the PRP
one I suspect that one would still be very helpful as well.

Add a patch if we want the try_ version of, although when keeping
the optimization for SGLs as well that are will look a bit different.

I'm happy to give away my patch authorship credits if that helps with
the folding.

