Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED80C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LfidzsRhpq5PFrYr0wjyVtBtgUgg1IId9b2eimOy6Iw=; b=BWHu6vtdEeYP0tzjlwWJHCgHVT
	/HyFxPZFQ/RJ/2ku2v6tEQB9YCY/kyxHQsKfRI4/d77YcDpI3LsBziaKNFqoJzr3yx6/of5PanCkG
	juPT/mAI0gXvvDZVrdJfOTw5fFqKizvu7V1pvr13l38XHm9KbezMn3cj7p6W2gvFa+FEhln8zpHoC
	W30XCuzc7jhK0YJKjkMqRYbyJy+w3fXgfJsIKMVmJZF2lCK3Sh9X3yRsP5UGlFVynd+X718FhHHXN
	3tk95tQkWRO7aS8WHqh5R6GuOx8X33MKY1E0MEN2OUSVU6WdSyE/9zV8BsiARmRc4c46nNNIEcH82
	Rj9fwVqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8lAM-001POr-JZ; Tue, 05 Jul 2022 16:12:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8lAK-001PMj-6o
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 16:12:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B875B67373; Tue,  5 Jul 2022 18:12:40 +0200 (CEST)
Date: Tue, 5 Jul 2022 18:12:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705161240.GB13721@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de> <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com> <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de> <20220705135102.GE23621@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705135102.GE23621@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_091244_435851_B9E1B558 
X-CRM114-Status: GOOD (  18.08  )
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

On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
> > In fact I'm not even sure this should be a character device, it seems
> > to fit it way better with the PCI sysfs hierchacy, just like how we
> > map MMIO resources, which these are anyway.  And once it is on sysfs
> > we do have a uniqueue inode and need none of the pseudofs stuff, and
> > don't need all the glue code in nvme either.
> 
> Shouldn't there be an allocator here? It feels a bit weird that the
> entire CMB is given to a single process, it is a sharable resource,
> isn't it?

Making the entire area given by the device to the p2p allocator available
to user space seems sensible to me.  That is what the current series does,
and what a sysfs interface would do as well.

