Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2BD10F36
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 05:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G2y1TaKaV2g4XFVY3gJwH3zViZ7RCzLm1QmvK0MsuyE=; b=lX7Cu2omaoVf62NImHtGh73g2/
	If5AGY7ybSKdDzPlVfGI3Ho5GXZNNSKijMs+I8b1bY24diwK9VGNKovbgX23qh2oEWG22bS9N4HiU
	HLPihEfckaGNykgkRKqoPYIIBXV62oNpgZpD1LZ/0NyGn+4W4oCQV/9TUMvyZtoyO3Ge6cmej1Kz5
	kO6CZ0y+SiS7/mv7GDwus9995Nc8njz7ldmAMQUd2BFVBCGgdNkfdAk3nYiKj0udHz/V0notER+AS
	beuR2z1h3ziGBJ9lxEWB9fkU4Z2rGPwK17cgF4AkLNo+uQudYdj5n9In3pts+t5j/jrGRBbyp6r+e
	vRhajwiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCtvD-00000008Lwm-1Nrp;
	Mon, 18 Nov 2024 05:03:35 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIJ3-00000007kVB-2QYV
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 18:41:45 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7b15467f383so526884785a.3
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731523291; x=1732128091; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2y1TaKaV2g4XFVY3gJwH3zViZ7RCzLm1QmvK0MsuyE=;
        b=cD0lWE01a0KW5u5waK/yaQy/nAjq0eURebvSTl4lK0KYHpI/pUUtiKVwuGiYTrXRia
         2LcfWBH02XIqJ7gq9MzgRCgvL8l+RBdMIxai8VDMXDE4K9G/r1YsKYOvYUtc5DdRCMrN
         7ZpGJIXvrnNXLI2VUpk1/sP2HVcn4KQcnwuGlep6HGGGIiy2P6D9A/3DaqjV3j5LWa8h
         yW1RHmHlnWrFN5hkvlyIvfo3lFSBwwDM0Co6+pg0ipZT/4Av3Ak8z/QWpji2cN9qBEWu
         UogWufCS+KICt890VfnTLehywxULAGyf0NMg6XliwTpzTYxDqFx7rY4bAfgdeuY8/n7l
         AA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523291; x=1732128091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2y1TaKaV2g4XFVY3gJwH3zViZ7RCzLm1QmvK0MsuyE=;
        b=n1Inp/jXh/Y7zJQx2jzvdRPMGpCPpLqnLYmwewhKQbEurPLB66+QE9LmYUEJrhjyCt
         CP7ufcKpFCefnMT7bgnu19g/iWtsphzC86FG88Tz1Io3C9bDrKcboTI4LWDiPtq9fgS9
         L7D4eiGLhy3U3pNCF4TdboiYXwB4l+g98fUqngQsdMSz8QCL2O2B7fTJJ05afwa4ajo6
         +N5OAlHdQUBljQx2U0jbiTOuXv4BkaUN9yvV3vPnTlCc1KZaKYy+r+56DqbRvQUK6SsC
         2NC3/leFwiIP4yjH3MfGRP1G6LIQFKOatFBujF2XuvqBxFM+tdYH9JsWxDMYVuDNTlyW
         NOsg==
X-Forwarded-Encrypted: i=1; AJvYcCVSnY77Ud1STGwOqGGihv/p93lvzailkDKSufN8ktTk9nLhUCDaZOVdr7uOO1H+jOmyrUi/KBsGiO61@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1gpQKqn0oO72AUrFNzH5fw/xCIBiOYJIHvF0mjK623qBZ0eAo
	dNmPoJlZALj7h1NaVD7cZ+PFT60/8aBo2z48hdNStuLUZ6ZwbLEsW3t38Ti1+uY=
X-Google-Smtp-Source: AGHT+IGHlQ3B6cgvg7LHp9B0an1V9l7W1otIHEU9XZtLf2twbE4ctDauWQrxx5wsqcBmnHpCgDTZBw==
X-Received: by 2002:a05:620a:4150:b0:7a2:1db:e286 with SMTP id af79cd13be357-7b35293bd6emr455709785a.52.1731523291038;
        Wed, 13 Nov 2024 10:41:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb0496sm718091885a.89.2024.11.13.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:41:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tBIIz-000000011lJ-0zht;
	Wed, 13 Nov 2024 14:41:29 -0400
Date: Wed, 13 Nov 2024 14:41:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241113184129.GA173265@ziepe.ca>
References: <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
 <20241108150226.GM35848@ziepe.ca>
 <20241108150500.GA10102@lst.de>
 <20241108152537.GN35848@ziepe.ca>
 <20241108152956.GA12130@lst.de>
 <20241108153846.GO35848@ziepe.ca>
 <20241112060108.GA10056@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112060108.GA10056@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_104134_018739_CB2436B1 
X-CRM114-Status: GOOD (  22.87  )
X-Mailman-Approved-At: Sun, 17 Nov 2024 21:03:30 -0800
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

On Tue, Nov 12, 2024 at 07:01:08AM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 11:38:46AM -0400, Jason Gunthorpe wrote:
> > > > What I'm thinking about is replacing code like the above with something like:
> > > > 
> > > > 		if (p2p_provider)
> > > > 			return DMA_MAPPING_ERROR;
> > > > 
> > > > And the caller is the one that would have done is_pci_p2pdma_page()
> > > > and either passes p2p_provider=NULL or page->pgmap->p2p_provider.
> > > 
> > > And where do you get that one from?
> > 
> > Which one?
> 
> The p2p_provider thing (whatever that will actually be).

p2p_provider would be splitting out the information in
pci_p2pdma_pagemap to it's own type:

struct pci_p2pdma_pagemap {
	struct pci_dev *provider;
	u64 bus_offset;

That is the essential information to compute PCI_P2PDMA_MAP_*.

For example when blk_rq_dma_map_iter_start() calls pci_p2pdma_state(),
it has this information from page->pgmap. It would still have the
information via the pgmap when we split it out of the
pci_p2pdma_pagemap.

Since everything doing a dma map has to do the pci_p2pdma_state() to
compute PCI_P2PDMA_MAP_* every dma mapping operation has already got
the provider. Since everything is uniform within a mapping operation
the provider is constant for the whole map.

For future non-struct page cases the provider comes along with the
address list from whatever created the address list in the first
place.

Looking at dmabuf for example, I expect dmabuf to provide a new data
structure which is a list of lists:

 [[provider GPU: [mmio_addr1,mmio_addr2,mmio_addr3],
  [provider NULL: [cpu_addr1, cpu_addr2, ...],
   ..
 ]

And each uniform group would be dma map'd on its own using the
embedded provider instead of page->pgmap.

Jason

