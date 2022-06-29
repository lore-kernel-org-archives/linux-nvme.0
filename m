Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BC4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=; b=0cbgUs8Nooq8amQOUze5gSoJ+C
	5LzLqR1/54hd3ZgquPntjOmnmnqgdaP7d9nx8NnUECjDC1n6v2xEHnwldILZP42AR3NL73AZx1Fid
	zdtCzggmxrrGIVKDccKUd5Bs32LUW3zx7wc4+ixTkq9jDOFDFSj4gITdt5uRnTNyDA+4xZlKFN+wN
	5NmLdVTxUkCiBBlnIeLjJGaoZkXiS/5BWptR/Slu82YNjmBuuB4lNzfkkYo+ipx8zJYazvR+sbvZQ
	geV/hbvZ8xzjDXPgnIa+EQuCkMNELx/mfzk+Ho5MRMv8bmd5Uvqr/esleItyLikeO3Ils29AHODIw
	vUaoShVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6by8-00DKMB-Cy; Wed, 29 Jun 2022 17:59:16 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6by3-00DKGh-Vk
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 17:59:13 +0000
Received: by mail-qv1-xf35.google.com with SMTP id i17so25900795qvo.13
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jun 2022 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=;
        b=SKmcghAf6nlxb3TYM9q+L2K6WvoAOg3jhiALBKso44zP0sXfB8bfiUedLcgKzgwJgh
         iTJCket4ICkaBkiO0QMT6a7oZweniTqMyqfh5UKIWBSdtteoys0WU0gLpwmQxcuZ4T0C
         B5EZV3F+pSyyuE/TubvDD1bjbB6DXWKJyou3V2eDANW0FMx1qb5IymBGqRBGbaBO/qpz
         ziWT+UQffo2LDKQOaJhYTyVo3/P9yrGTwX9E3INhoqRXiDqc6Jau79+OQONuVBZZne7a
         MzNQ3dTgqHtk/dbWQmfNzsZcoGEiW6sxYQ0kC+3zRe5EegJZ5dxZXRpFz6xNN0CByfx0
         8ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=;
        b=JDXplhS58Shk/E7C+R+/bh4S/cRHgFTKYXWelj9q75HxCXizXDnRpria4uTf66rUin
         O+ZSiRfliJgQT3OtVYhHG1EbMSV54b6QBZxqVaPcjAoUiJxgeyACtLy4Wy3C+rNdlV6/
         tPl1VjDyAopJDsh35JNGB7WF/Ecp8YFTcvZIorRM9HXfymcmrv5UoioLu4GcofYTOAZa
         Gn5XTIHV83ghFbjqY/T4DRnY7CKRGKyHb5EBp3XlGq0aOI1+L0ZMjTNoxjo/putJ29GJ
         uTalbeDjya961oJ/N2ZSBczxsFJs2skERcO6VIv/sjRgqmxGTAjzXfSRC9KK7thUPg4Z
         0/hw==
X-Gm-Message-State: AJIora9UpyIW2Nr9XApIvEny3eytbouPrSpPnILTnyzZtm6IG0JdxCsJ
	JudAA+y+yKIQMMPp3fPkfFdTTm67tcb9XA==
X-Google-Smtp-Source: AGRyM1tbrZ7P9r+hmIBmAW2EDXMkZbkavnNkEyNTe14M5A9CnmgPVypEPOrPgPFspFUz9zUokVYXKQ==
X-Received: by 2002:a05:6214:ac2:b0:46e:7e2a:ada with SMTP id g2-20020a0562140ac200b0046e7e2a0adamr8831887qvi.81.1656525547889;
        Wed, 29 Jun 2022 10:59:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a164d00b006a6a4b43c01sm12832373qko.38.2022.06.29.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:59:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1o6bxy-003bBJ-Q7; Wed, 29 Jun 2022 14:59:06 -0300
Date: Wed, 29 Jun 2022 14:59:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Message-ID: <20220629175906.GU23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_105912_099594_5FEA8308 
X-CRM114-Status: GOOD (  26.19  )
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

On Wed, Jun 29, 2022 at 10:00:09AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 00:48, Christoph Hellwig wrote:
> > On Wed, Jun 15, 2022 at 10:12:32AM -0600, Logan Gunthorpe wrote:
> >> A pseudo mount is used to allocate an inode for each PCI device. The
> >> inode's address_space is used in the file doing the mmap so that all
> >> VMAs are collected and can be unmapped if the PCI device is unbound.
> >> After unmapping, the VMAs are iterated through and their pages are
> >> put so the device can continue to be unbound. An active flag is used
> >> to signal to VMAs not to allocate any further P2P memory once the
> >> removal process starts. The flag is synchronized with concurrent
> >> access with an RCU lock.
> > 
> > Can't we come up with a way of doing this without all the pseudo-fs
> > garbagage?  I really hate all the overhead for that in the next
> > nvme patch as well.
> 
> I assume you still want to be able to unmap the VMAs on unbind and not
> just hang?
> 
> I'll see if I can come up with something to do the a similar thing using
> vm_private data or some such.

I've tried in the past, this is not a good idea. There is no way to
handle failures when a VMA is dup'd and if you rely on private_data
you almost certainly have to alloc here.

Then there is the issue of making the locking work on invalidation
which is crazy ugly.

> I was not a fan of the extra code for this either, but I was given to
> understand that it was the standard way to collect and cleanup VMAs.

Christoph you tried tried to clean it once globally, what happened to
that?

All that is needed here is a way to get a unique inode for the PCI
memory.

Jason

