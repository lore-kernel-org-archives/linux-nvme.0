Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512DCC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VFHBqUHwwYoA8FWyemsM9JmzLGwAB1VPkIrcaKdDl6s=; b=dH+ehZAPQyRuWa9nAuGnkhum8H
	EJj/0teKC6zsB8R7/lPU4ezGHN0KxcJGs2zwPZSH2hybLyeL+ODZEy6CoEospjHRbT1Ap2Pe0o2OE
	nUkJIvC5xlyGd8+HLUr1sWJTmtByTn1F16BQ3Zu9FkbPpJCe4QOOgrVfpatBgH+KBJaBEHRyUAxNf
	/6GvxYnypxRlfzonyAQn/WxPbEFRnHu1P2nW75yTKn9Ek3/tuyJyBMJCEH/NaiJc8ngCG9FoqYA3h
	1lu1VHXsI4EY3TCfY8rVnU0x091f8RiXPyeYgYS35gA2ZnNw9ZXJV0N0bO6LEldeU2QNxPxufVgE1
	Ne75B7Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8llA-001bPN-4i; Tue, 05 Jul 2022 16:50:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ll6-001bLa-KZ
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 16:50:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C89A168AA6; Tue,  5 Jul 2022 18:50:39 +0200 (CEST)
Date: Tue, 5 Jul 2022 18:50:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705165039.GB14566@lst.de>
References: <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de> <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com> <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de> <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de> <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com> <20220705164315.GB14484@lst.de> <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_095044_843620_B9240573 
X-CRM114-Status: GOOD (  13.90  )
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

[note for the newcomers, this is about allowing mmap()ing the PCIe
P2P memory from the generic PCI P2P code through sysfs, and more
importantly how to revoke it on device removal]

On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
> We might be able to. I'm not sure. I'll have to figure out how to find
> that inode from the p2pdma code. I haven't found an obvious interface to
> do that.

I think the right way to approach this would be a new sysfs API
that internally calls unmap_mapping_range internally instead of
exposing the inode. I suspect that might actually be the right thing
to do for iomem_inode as well.

