Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09741C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tk5ycb3N9meE73NCm46CD0AtZuFHAdivFMZfwt24RPU=; b=CCZlnWY4jTB1T5y+FemabNXhC3
	TSrj2UvezLZ2tDpsfl4tx3UY7ScBpGFKbmOsR/4l9gc6dxeKO+voYrdqjqd2Mdkjqw57voOFE8Ejq
	J9hcmERLyZasMg5GZxci3dYdYERWt4BMf4/Xd7KhLoDKlQWXiNzJE+nVXv9Que4itz70eO1cCR0BP
	dMfStpRfupFNI4SHioz0exY8nDSiv8jo2UD9QeKsS+H8nxiHNjnzidPUEShizyT0B3iiCTawjprYa
	jvcNErgiTPmHP1Ob46CFOZePrQoowYblW6Yf/xAssc1GWcZ3o6J49tCq0kDOmzgUTijmgLvWnNBX/
	TcNGI4rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuxgl-00000009mDP-2IIE;
	Wed, 19 Mar 2025 17:58:47 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuxgh-00000009mBO-1BXN
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 17:58:45 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7c24ae82de4so809542385a.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Mar 2025 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742407121; x=1743011921; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk5ycb3N9meE73NCm46CD0AtZuFHAdivFMZfwt24RPU=;
        b=Unal08LB0k4NomyyYmC/KkkQqAzRGfBwbdCSAH3CilmAvPHKVjdaN0UGNHLPsJnE7L
         dvUQZVYvldkiiYB0NfidXeBaQZIn7M3NIBtiDVH5f4JGAeHoyYMRarDs5TUniE7iTq08
         G+TOGX0DMCPKq0U60U4nuON4n/cpcDdJKt0YGZ2MkjWP38QS0XY4pmTMvJw8Gz6GCO2n
         Aa0gMepS4nzLaE73O2YSqZYVUfGGlvyjpaA81W3cl5ScXyNDyTu56gQrw3HJW6ockQkJ
         EseaDWYxj5mZR6CKzi4v/rCdYnvHH+AMzNjjOi9obEgvIW4eXtkWU2n6anB/QjahYVDz
         4bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407121; x=1743011921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk5ycb3N9meE73NCm46CD0AtZuFHAdivFMZfwt24RPU=;
        b=B+qyTiju/Z8Qfh2IiIFlaHtQZ+ElCFk4qgxIKrNlak9Z1c90z568jxsMq7bIzX8gDc
         /UdpD8QBcbsYJbNDv/pA9c2m95seWpuRlK5l4qjwWyxTp5VkcLdT2u0G8n2gtWsTP7Ut
         4X74HbAq/HH96pHhyn/PrUyclUg3jMdCyC3u7ZsiphXw9p8DTWaZrD/WsNqBG4/wtSrn
         M6dk9ECjodOzrtlH2m2J+pm1TeHxKs3BB41a9dih8KzSwOUpFXxiG47mv9IilHagWspE
         nO6T8tmDHem7WE++R1SU6KAnDVZCjdPH3mdOVhzv/ycYLHuIq+URs5bJ5KQpOYSMBkbE
         j68g==
X-Forwarded-Encrypted: i=1; AJvYcCVUcFJ3WQ+O/yFYTxac0fFWK2ECeYSrOsAe72BBfiYfDsVWPh+i08TmsRphmiBbFr0R1eyNQEpFJcXv@lists.infradead.org
X-Gm-Message-State: AOJu0YzGl2ECMPNvOGlcw9PQEoIqb1Mjd0f7iVN2vGqLzqo72kKZyou6
	kDiagUIqV6bLNOUBOTd3ggq5aJCUPbQhmTyIa6i4wI4zFgqvnFjwf2D1Y9/8l0A=
X-Gm-Gg: ASbGncs3XWCYjm7peiXv8i/F0zpYtOWLmt/1aG2MJuhKdBPgGYulI1TTv5r5V/yfLcz
	u4HHbhFWRjTE4783phr4NK9SYu2r5EbciAIxV2vKtp4AKqAVigGo5GLvSBVwHfeqB/b/j4VhqFJ
	DgQXA1P7gJwqamhkG9Jsl7RALQbXoHuDmfr09Q2Ve2oj75FMfrIdcINNCeOGKGZIJ/fiuzDkea7
	bXdbInslToDVqDDWpswzWvyDOy2f7mQU27SEtBeYiwBUtpiuJUjpfhNqBYdmh6zeoso/wwYJHOu
	Lzy+pfLgV6RQgyxdh9auoo73BaaOCvHtLDobtABoHK5ZaVLBNWHPMUGUhtjAYs0i0oMDNmHFZfM
	+zUhX/dpFzkQuCKa3YA==
X-Google-Smtp-Source: AGHT+IH//pIx1EBbRFqDU6QPhXC6odo+Ppd2dshOt/mNgQMR0e3nRHsssO7Vo2UonDgQd/fB3+YCbw==
X-Received: by 2002:a05:620a:3189:b0:7c5:5154:cb2 with SMTP id af79cd13be357-7c5a839688cmr568357985a.15.1742407121681;
        Wed, 19 Mar 2025 10:58:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8a62asm885096585a.96.2025.03.19.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:58:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuxge-00000000Wns-1mXJ;
	Wed, 19 Mar 2025 14:58:40 -0300
Date: Wed, 19 Mar 2025 14:58:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250319175840.GG10600@ziepe.ca>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_105843_322908_81D5478F 
X-CRM114-Status: GOOD (  22.21  )
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

On Fri, Mar 14, 2025 at 11:52:58AM +0100, Marek Szyprowski wrote:

> > The only way to do so is to use dma_map_sg_attrs(), which relies on SG
> > (the one that we want to remove) to map P2P pages.
> 
> That's something I don't get yet. How P2P pages can be used with 
> dma_map_sg_attrs(), but not with dma_map_page_attrs()? Both operate 
> internally on struct page pointer.

It is a bit subtle, I ran in to this when exploring enabling proper
P2P for dma_map_resource() too.

The API signatures are:

dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
		size_t offset, size_t size, enum dma_data_direction dir,
		unsigned long attrs);
void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
		enum dma_data_direction dir, unsigned long attrs);

The thing to notice immediately is that the unmap path does not get
passed a struct page.

So, lets think about the flow when the iommu is turned on. 

For normal struct page memory:

 - dma_map_page_attrs() allocates some IOVA and returns it in the
   dma_addr_t and then maps the struct page to the iommu page table

 - dma_unmap_page_attrs() frees the IOVA from the given dma_addr_t
 
If we think about P2P now:

 - dma_map_page_attrs() can inspect the struct page and determine it
   is P2P. It computes a bus address which is not an IOVA, and does
   not transit through the IOMMU. No IOVA allocation is performed. the
   bus address is returned as the dma_addr_t

 - dma_unmap_page_attrs() ... is impossible. We just get this
   dma_addr_t that doesn't have enough information to tell anymore if
   the address is a P2P bus address or not, so we can't tell if we
   should unmap an iova from the dma_addr_t :\

The sg path fixes this because it introduced a new flag in the
scatterlist, SG_DMA_BUS_ADDRESS, that allows the sg map path to record
the information for the unmap path so it can do the right thing.

Leon's approach fixes this by putting an overarching transaction state
around the DMA operation so that map and unmap operations can look in
the state and determine if this is a P2P or non P2P map and then know
how to unmap.

For some background here, Christoph gave me this idea back at LSF/MM
in Vancouver (two years ago now). At the time I was looking at
replacing scatterlist and giving new DMA API ops to operate on a
"scatterlist v2" structure.

Christoph's vision was to make a performance DMA API path that could
be used to implement any scatterlist-like data structure very
efficiently without having to teach the DMA API about all sorts of 
scatterlist-like things.

Jason

