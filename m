Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3823CECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxQOP36bH13DhZdpblozx9dhaLeK49H11GyoyHkKHJE=; b=QFkkt+IVNkEoBXwvgbEvJ7gK5F
	zeV/MZH6bXtHWU6LDYC6Elw0OZzeSin0BhlAVyx96+56Vq2gHBaMlHBmqyXEjkfLJqN9aZz5w3h9X
	E+ngZ8D4VdYT1arPzcCUTZb8YMdU8YzDVsffJ7yeknjT663Ax7Y5Nwc+H0jbGJSLNGV/TZFjvKPst
	4IToLPptISIGwwN6n+qjrbRiNhZZLr0D079VXTMVQOzKaW+pQ1DERg2RlEMWp0n1PTEATa5gd+o9+
	erax8qbT5OgZNxr23ZL47pdBGR3WOA6V2d3JWVFBoy8qFAcaMzQg/vOKLt4X+IM25vh2FhZEbghEP
	98STezaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdqo-002skO-BA; Fri, 23 Sep 2022 08:15:58 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdqj-002sjE-7g
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 08:15:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DC891B82278;
	Fri, 23 Sep 2022 08:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2193DC433D6;
	Fri, 23 Sep 2022 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663920950;
	bh=ITi0Pkie/41exckOOEHb1oAjXkYdzFl60zYe1Z6SOsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v0KIwFqnf0h62gPG0bxhRtPlMQRU+sn46T0CtPVR5NKOnXZsjItRiireczqzCeKag
	 pAvIG3SEtkcD85MT7X2TMXaDlhSnRQcrEOmrMoSMt/EK/FQujn5mkajW6X3k8utzpw
	 anYADRkPfWaRWXGb6PsKo0p6qOHfHnd0hbjq1K+8=
Date: Fri, 23 Sep 2022 10:15:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Message-ID: <Yy1rMn3t33OcFzmB@kroah.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-8-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_011553_446350_1DFFAB6F 
X-CRM114-Status: GOOD (  16.66  )
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

On Thu, Sep 22, 2022 at 10:39:25AM -0600, Logan Gunthorpe wrote:
> Create a sysfs bin attribute called "allocate" under the existing
> "p2pmem" group. The only allowable operation on this file is the mmap()
> call.
> 
> When mmap() is called on this attribute, the kernel allocates a chunk of
> memory from the genalloc and inserts the pages into the VMA. The
> dev_pagemap .page_free callback will indicate when these pages are no
> longer used and they will be put back into the genalloc.
> 
> On device unbind, remove the sysfs file before the memremap_pages are
> cleaned up. This ensures unmap_mapping_range() is called on the files
> inode and no new mappings can be created.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

