Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938DFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1B6KU4RqQ75A+QkPts2j5YhHfWA4F26bHFXjCNuj/8=; b=leDokzIwl5tbYw2EEpfPvSrHD5
	XIF+ISCF/Sb1gadCYAz9lLpO6fBSt0mn08CWJLKLVkbhi6Hc9LhN45cw/KLG8AEXURZNlAMVbdhss
	lTO7cI703Q0/7URmygOcEzzMyWzJ4EiQQARY9uXSrbmyHHCceLvad0o6Fp08UhQkFLXs07x1IL6+A
	lcXe+M7IwTFWcRpoZara0rscUaKyZZTaDv5uY/6NZbwQ1e19rSnulIeqEu7jvRNUsJR3xmvIa2hqz
	7rua7FFkxB9htG9S7crXNnuEK5McAldixtE5hZ9HBlXHqqPj4T7ZnEMjsPw687Mcsy17KgnLFmX5O
	D/sl0RDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8dL8-00Fntb-Fn; Tue, 05 Jul 2022 07:51:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8dL5-00FnqK-OB
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 07:51:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CBB668AA6; Tue,  5 Jul 2022 09:51:08 +0200 (CEST)
Date: Tue, 5 Jul 2022 09:51:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220705075108.GB17451@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de> <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com> <20220629175906.GU23621@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629175906.GU23621@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_005120_005979_DB4BE2D5 
X-CRM114-Status: GOOD (  24.53  )
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

On Wed, Jun 29, 2022 at 02:59:06PM -0300, Jason Gunthorpe wrote:
> I've tried in the past, this is not a good idea. There is no way to
> handle failures when a VMA is dup'd and if you rely on private_data
> you almost certainly have to alloc here.
> 
> Then there is the issue of making the locking work on invalidation
> which is crazy ugly.
> 
> > I was not a fan of the extra code for this either, but I was given to
> > understand that it was the standard way to collect and cleanup VMAs.
> 
> Christoph you tried tried to clean it once globally, what happened to
> that?

Al pointed out that there are various places that rely on having a
separate file system.  I might be able to go back to it and see
if we could at least do it for some users.

But what also really matters here:  I don't want every user that
wants to be able to mmap a character device to do all this work.
The layering is simply wrong, it needs some character device
based helpers, not be open code everywhere.

In fact I'm not even sure this should be a character device, it seems
to fit it way better with the PCI sysfs hierchacy, just like how we
map MMIO resources, which these are anyway.  And once it is on sysfs
we do have a uniqueue inode and need none of the pseudofs stuff, and
don't need all the glue code in nvme either.

