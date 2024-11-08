Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CCD12D72
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 04:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbYXv3yCM9yQzCKa6ScUYgOxj5i+yJ5Ve18Z6DNxO2Y=; b=e4NfHvZ6l8KHsQ+p/ppd+YClnk
	OEfTKyP/994mejXFXfNr15uDZPkyHmuLWj+Fp2YPdBrCH79mbpcgv25ArpBp+vfF0L2itQyLwz95U
	sYRgpk8pUUsgrc1eCVdv4Xq0e5Ga8JJ2ZOT98S2WaeglDmh5EfmL63VxLnSRThwu20kSS6euuU3D4
	m5gbzayouMxZJVFUg9RorDzR5ItLW5dBjtJE0RcpJ72eEZenx5JG8UYtjJ/D4h5u974vT7qpYKGVO
	MZ71HiZDjooof5jsjbkZ2VkakdnCt2n3IKOiTtEYWR6FoS6nk6UAgdWZa7jsOUVKUkyokbY1ulKXD
	U8wQlicQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAMCO-0000000GKZz-0EKC;
	Mon, 11 Nov 2024 04:38:48 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Qrj-0000000B14Q-4348
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 15:25:41 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7b14077ec5aso311525185a.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731079538; x=1731684338; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbYXv3yCM9yQzCKa6ScUYgOxj5i+yJ5Ve18Z6DNxO2Y=;
        b=KVewtFbN2MQgH29BsB36UGM1cp99k+wszcPtgDToARI5SaA0ajpGgAk/tsRuuQaoIN
         C8ajOTb705K4hbw3GuQXDpqrO2AJcgwbq5UdVkt93+BYjn/wruQOsthe3CXO7PZZmArZ
         kznJf56Q7ZUNsFwSY+WMfg9qghJ+uqHawDinAWheGSRBYbHur7MnxwfE0Bjmb01+VZqj
         Nw6Tdfaf7+8IX0Pz/l8kCXXWx+H5FN37ZLkGJX4d5884e16oJh996OVfUu/OiPwX3WCG
         V3+hjJFPZe8a4V9iGCWdGE2yZAfVf6r6qy6NNe2EdaVkmLbkdBauFNYCHZl9rogbqCec
         1n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079538; x=1731684338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbYXv3yCM9yQzCKa6ScUYgOxj5i+yJ5Ve18Z6DNxO2Y=;
        b=Bvz9mIk7LZBkGOtSz0taQ+HLsX8K01xwiI4eDYNopozB5OWMkcvd/8svXuy51PEyul
         n0WRfdAfrHEzcKNG+epKYdeWrIxHk+tl/rDxYW25gawKOM9YSpPa7MFu8sEflbnNuxoe
         YNp8rFgnr9Yugc1P80FwBTkj0I4eVkCVrdwE/DFxoLlScNaEgPhilgQ4YZ5m2IR43J9+
         BwnotrZaelJcYM0gUpN8Z7iY6mwa8tmPTqEmUxOnZEcbLHWvbafScpnDo28O2/ATHZFs
         SgQLMb7Ryj/fo2xiDzfXGs7zK44BFlzGm+kKVXMD7+8TQU6pPtMgCrcqUIutJBOGASY/
         H+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV65dk1nkVASf1V+wxFMwbqrde3DtFaJtHZXJFlehU7YDZrqcOfO7WLmCYTtlMApfiTuQLoonfxLnNg@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6O1oJTnALDlLD3saZ9bglZrrlvnetHmZbIqlYIZHoOyzr9rq3
	idR2GVAdKv/gpt5IiCTAMLUyUSUT2BfIJO3W11i8Y5tL4tQ9n/G5pYbOWlNbzAk=
X-Google-Smtp-Source: AGHT+IH4eRArrUDZm2rUOb5KR+8EAvAFtyYH0Fr2uIHFPXrPpQnSMiiNxtBbq8LowDrIix/biyMB3w==
X-Received: by 2002:a05:620a:4049:b0:7b1:4cc0:5e32 with SMTP id af79cd13be357-7b3328aeb7dmr490547585a.9.1731079538361;
        Fri, 08 Nov 2024 07:25:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac51659sm170158385a.42.2024.11.08.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:25:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9Qrh-00000002Zza-1RVx;
	Fri, 08 Nov 2024 11:25:37 -0400
Date: Fri, 8 Nov 2024 11:25:37 -0400
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
Message-ID: <20241108152537.GN35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
 <20241105195357.GI35848@ziepe.ca>
 <20241107083256.GA9071@lst.de>
 <20241107132808.GK35848@ziepe.ca>
 <20241107135025.GA14996@lst.de>
 <20241108150226.GM35848@ziepe.ca>
 <20241108150500.GA10102@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108150500.GA10102@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_072540_027705_13CC935B 
X-CRM114-Status: GOOD (  18.47  )
X-Mailman-Approved-At: Sun, 10 Nov 2024 20:38:44 -0800
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

On Fri, Nov 08, 2024 at 04:05:00PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2024 at 11:02:26AM -0400, Jason Gunthorpe wrote:
> > It is fully OK? Can't dma_map_page() trigger swiotlb? It must not do
> > that for P2P. How does it know the difference if it just gets a phys?
> 
> dma_direct_map_page checks for p2p pages in the swiotlb bounce
> path already in the current kernel, and dma_map_sg relies on exactly
> that check to prevent bouncing for p2p.

I'm asking how it will work if you change the struct page argument to
physical, because today dma_direct_map_page() has:

		if (is_pci_p2pdma_page(page))
			return DMA_MAPPING_ERROR;

Which is exactly the sorts of things I'm looking at when when I say to
get rid of struct page.

What I'm thinking about is replacing code like the above with something like:

		if (p2p_provider)
			return DMA_MAPPING_ERROR;

And the caller is the one that would have done is_pci_p2pdma_page()
and either passes p2p_provider=NULL or page->pgmap->p2p_provider.

Anyhow, I hope Leon will attempt this once this is settled and it will
make more sense in patches. I'm just brainstorming how I've been
thinking of it.

Another option would be some 'is_pci_p2pdma_page_phys(phys)', but I
think that is going to be worse performance than managing a
p2p_provider pointer in the mapping call chain explicitly.

Jason

