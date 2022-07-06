Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAFBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7HTFOsPYHoY2+jtInKvQNIromPx7OWzOgUegE3v3Nk=; b=11riu3rLaImB7EVuUyDbTYXTFN
	IF48/OE6GF5Dkxlt546Xd0DD5rlcEPMI4fNX6oTywwpsC1Qb2F6dlQ5GgchEoyizkmRamXlqqaHHl
	rmaz1snxo4eIe2LfTK7j5t/VHh5yXCU4eLp1kbwk53AtJEwr/tSy3MuSTH0SP4FCdY3M81hwh4va/
	P9al/mgEILjAaLEIu3H1R8ZpPMbAhEsIl2oGP1bWjxg23qB4tr2g4JzEbDyBlCcgrbvjLSBkqLjxo
	/UkgH0PcotnU6zL7FIO3IwTjEZ1ZVSu9PTD8B84m1cE9SurIzpmo3grsIMf/ydnP9el7QVOGosr4n
	dqnM6HBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ysu-006qRf-9u; Wed, 06 Jul 2022 06:51:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ysp-006qOi-3R
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 06:51:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79E0F67373; Wed,  6 Jul 2022 08:51:27 +0200 (CEST)
Date: Wed, 6 Jul 2022 08:51:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20220706065127.GA27132@lst.de>
References: <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de> <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com> <20220705164315.GB14484@lst.de> <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com> <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com> <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com> <YsR4CNDgtt4JWonv@kroah.com> <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_235135_333221_6F6A4AA8 
X-CRM114-Status: GOOD (  17.12  )
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

On Tue, Jul 05, 2022 at 12:16:45PM -0600, Logan Gunthorpe wrote:
> The current version does it through a char device, but that requires
> creating a simple_fs and anon_inode for teardown on driver removal, plus
> a bunch of hooks through the driver that exposes it (NVMe, in this case)
> to set this all up.
> 
> Christoph is suggesting a sysfs interface which could potentially avoid
> the anon_inode and all of the extra hooks. It has some significant
> benefits and maybe some small downsides, but I wouldn't describe it as
> horrid.

Yeah, I don't think is is horrible, it fits in with the resource files
for the BARs, and solves a lot of problems.  Greg, can you explain
what would be so bad about it?

