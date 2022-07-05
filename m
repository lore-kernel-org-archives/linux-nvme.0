Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E857AC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7NxEUOhBA/vpCLtgBoaHFhHtEAgPzmWy1pdQgH0j92E=; b=R2vReAGYrQ3JbskHMd8wQ0himE
	ibpq+b5Nh4JjFD4BS1C11qQ7SX9wAFZjst5Y6INFUe3zhF2Dmr7s0ZvBADWxgVCTzceqr9TK8pH1N
	9aDn1oWTqRnkFpuAbaoHJsN0JruubVcH62NR01QinSUqc5Nhm+J2j/5Qyrdgv4gzb3ABTAOg/9jGG
	dvLmhPnAkXU+rKDQ+tdpkr40H6kyFihn72dlZpzv07pN/h1hbWgTXdVwN7YG8iGJIMOmZBnzSuq1E
	WSZNNbo0QeJMgnegI6bWNZb4e0Ocy1GPY7kpSsiVXa5xVzT3I5QLZ6AKXbc6XHGw47mvXtqcysZRA
	KzWfbGaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8le0-001Xtr-6s; Tue, 05 Jul 2022 16:43:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8ldw-001XqG-Gp
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 16:43:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31F3168AA6; Tue,  5 Jul 2022 18:43:15 +0200 (CEST)
Date: Tue, 5 Jul 2022 18:43:15 +0200
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
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705164315.GB14484@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de> <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com> <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de> <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de> <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_094320_744762_9F88AABD 
X-CRM114-Status: GOOD (  14.58  )
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

On Tue, Jul 05, 2022 at 10:41:52AM -0600, Logan Gunthorpe wrote:
> Using sysfs means we don't need all the messy callbacks from the nvme
> driver, which is a plus. But I'm not sure how we'd get or unmap the
> mapping of a sysfs file or avoid the anonymous inode. Seems with the
> existing PCI resources, it uses an bin_attribute->f_mapping() callback
> to pass back the iomem_get_mapping() mapping on file open.
> revoke_iomem() is then used to nuke the VMAs. I don't think we can use
> the same infrastructure here as that would add a dependency on
> CONFIG_IO_STRICT_DEVMEM; which would be odd. And I'm not sure whether
> there is a better way.

Why can't we do the revoke on the actual sysfs inode?

