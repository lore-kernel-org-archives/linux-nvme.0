Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66AFD36121
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+fX00798BJ3ATWBHAwavTUTImd2ssZMf/WzAfMHnat0=; b=kzeZBqFbdG9Ss3xma8S9t4n3oo
	bZfV8zSzYG9pwdL1jDk+2Dczh4FZWETQ2WZMy4zPdHPoE5UheORwXUudhtkPSZaaeHL8ob2AIG8rR
	j9qvxqFe8wdiePcJcWOJwQ5JLw2l3yaD01RF3x/Xyh2d5/pj9UsQgpTE+bHr74P+wf+slEFqVcJvk
	lVVkwNaKMb4QQSg8GeqW6b3ZgBWux/Fqyf4iIUPpyJuxu/ysvelDEdEu/sIije/8yb6yZplUfluxm
	TbDbpUQtB4W5ksXhf/ekNsA+eaF4iKyZbbz7QOWKTZtFzAsYheU+ENZdvxMPkOWJvZzLiBkLGT9M5
	ZcZyygiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Pco-00000000c06-3yzF;
	Tue, 05 Nov 2024 19:54:02 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Pcm-00000000bzR-1e1K
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 19:54:01 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so1619726d6.0
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730836439; x=1731441239; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fX00798BJ3ATWBHAwavTUTImd2ssZMf/WzAfMHnat0=;
        b=EN57jCHkyYS9fmK5MHlWIzMykp3RzRs/63ebnoja1y2ye0PhwwKCC7gJ6J7dLHP/z9
         A8BP7/IuA4Yjbat5dqp6iONDfcYR7zStYtOpvFPofvoy2wHb8OzzbPvCxVau395cbkBQ
         f6DhVprQSmthrYC6JFTDyBuzr7976X5w5UU/NNj/PFGiKwiCKE/QfXuJ56/Cfo73fnLs
         9YsQIsuM/5gijZlac/eZ2KYc5iLv/mdtOoRpctca8Ai9a1Qb5juSk5DmZ6AcrS7HQMJB
         bgw9I+ceSepvOfOnyNW810OwcalBQuzo8wk/xkWot46YNp8G7RW0Kn2hi64DRt8SonsG
         iFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836439; x=1731441239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fX00798BJ3ATWBHAwavTUTImd2ssZMf/WzAfMHnat0=;
        b=atGKKra0oz1BY4J/BWEye/Yoop1eCAZ7X8KTKmB9E2uK03KIqAdWLvUoK2SYjpCZ/x
         OJT3zIciWHqfwjWz1e8ZcWhQjjYb5IYTkvlT+PQBT3byta/UHAcupwkb1IapFqEl0piz
         3eOeybI/a8Yub56vPVj308LrCzC1kZyOQ5vn6nnyA6ML57fXa3BqvCUatgwMIR3M7i8F
         cBoa2j6FnMnNF6Qu+HMfiHfL8L83fhU9hmntKpgjPNgBGPBHhzWPmwdKtlXilzjvTvth
         dAZU4+H5YCa6xC1JaLlTPGckEpy/U1IPfwq9oMB+dlEYbS1eEFFcb7sY13xdOsLDU/Xz
         eIMw==
X-Forwarded-Encrypted: i=1; AJvYcCVhCzLFCKMAeLbSCfEY4m2we+lfwpm+qK3ya7txRFR16RNxiLDEQZmVHfgD9SFUUL3xncYT6k2hH9to@lists.infradead.org
X-Gm-Message-State: AOJu0YxxatuRc3DsElijEsqZvVXOKxZbEQY3xKDRCcleE97K9hjpJ8JS
	WP87PtpGmLt7n4ZgMuBVCIasqRw9QdCPaBM5Lue59pV/Y8xVBYQEfH0i/1J5geY=
X-Google-Smtp-Source: AGHT+IEaav3D7n+muLVYjXAvVqOfQiyB3KvOcn2o5SW6dcKTwKh96GbO3Tfnssa4/aNZfrPdV+MQVQ==
X-Received: by 2002:ad4:4eeb:0:b0:6cb:ed27:145c with SMTP id 6a1803df08f44-6d35b9510a3mr302739006d6.19.1730836438787;
        Tue, 05 Nov 2024 11:53:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a62asm63870536d6.80.2024.11.05.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:53:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t8Pcj-000000023mq-1vDZ;
	Tue, 05 Nov 2024 15:53:57 -0400
Date: Tue, 5 Nov 2024 15:53:57 -0400
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241105195357.GI35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104095831.GA28751@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_115400_478329_32295B66 
X-CRM114-Status: GOOD (  50.06  )
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

On Mon, Nov 04, 2024 at 10:58:31AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 31, 2024 at 09:17:45PM +0000, Robin Murphy wrote:
> > The hilarious amount of work that iommu_dma_map_sg() does is pretty much 
> > entirely for the benefit of v4l2 and dma-buf importers who *depend* on 
> > being able to linearise a scatterlist in DMA address space. TBH I doubt 
> > there are many actual scatter-gather-capable devices with significant 
> > enough limitations to meaningfully benefit from DMA segment combining these 
> > days - I've often thought that by now it might be a good idea to turn that 
> > behaviour off by default and add an attribute for callers to explicitly 
> > request it.
> 
> Even when devices are not limited they often perform significantly better
> when IOVA space is not completely fragmented.  While the dma_map_sg code
> is a bit gross due to the fact that it has to deal with unaligned segments,
> the coalescing itself often is a big win.

RDMA is like this too, Almost all the MR HW gets big wins if the
entire scatter list is IOVA contiguous. One of the future steps I'd
like to see on top of this is to fine tune the IOVA allocation backing
MRs to exactly match the HW needs. Having proper alignment and
contiguity can be huge reduction in device overhead, like a 100MB MR
may need to store 200K of mapping information on-device, but with a
properly aligned IOVA this can be reduced to only 16 bytes.

Avoiding a double translation tax when the iommu HW is enabled is
potentially significant. We have some RDMA workloads with VMs where
the NIC is holding ~1GB of memory just for translations, but the iommu
is active as the S2. ie we are paying a double tax on translation.

It could be a very interesting trade off to reduce the NIC side to
nothing and rely on the CPU IOMMU with nested translation instead.

> Note that dma_map_sg also has two other very useful features:  batching
> of the iotlb flushing, and support for P2P, which to be efficient also
> requires batching the lookups.

This is the main point, and I think, is the uniqueness Leon is talking
about. We don't get those properties through any other API and this
one series preserves them.

In fact I would say that is the entire point of this series: preserve
everything special about dma_map_sg() compared to dma_map_page() but
don't require a scatterlist.

> >> Several approaches have been explored to expand the DMA API with additional
> >> scatterlist-like structures (BIO, rlist), instead split up the DMA API
> >> to allow callers to bring their own data structure.
> >
> > And this line of reasoning is still "2 + 2 = Thursday" - what is to say 
> > those two notions in any way related? We literally already have one generic 
> > DMA operation which doesn't operate on struct page, yet needed nothing 
> > "split up" to be possible.
> 
> Yeah, I don't really get the struct page argument.  In fact if we look
> at the nitty-gritty details of dma_map_page it doesn't really need a
> page at all. 

Today, if you want to map a P2P address you must have a struct page,
because page->pgmap is the only source of information on the P2P
topology.

So the logic is, to get P2P without struct page we need a way to have
all the features of dma_map_sg() but without a mandatory scatterlist
because we cannot remove struct page from scatterlist.

This series gets to the first step - no scatterlist. There will need
to be another series to provide an alternative to page->pgmap to get
the P2P information. Then we really won't have struct page dependence
in the DMA API.

I actually once looked at how to enhance dma_map_resource() to support
P2P and it was not very nice, the unmap side became quite complex. I
think this is a more elgant solution than what I was sketching.

> >>      for the device. Instead of allocating a scatter list entry per allocated
> >>      page it can just allocate an array of 'struct page *', saving a large
> >>      amount of memory.
> >
> > VFIO already assumes a coherent device with (realistically) an IOMMU which 
> > it explicitly manages - why is it even pretending to need a generic DMA 
> > API?
> 
> AFAIK that does isn't really vfio as we know it but the control device
> for live migration.  But Leon or Jason might fill in more.

Yes, this is the control side of the VFIO live migration driver that
needs rather a lot of memory to store the migration blob. There is
definitely an iommu, and the VF function is definitely translating,
but it doesn't mean the PF function is using dma-iommu.c, it is often
in iommu passthrough/identity and using DMA direct.

It was done as an alternative example on how to use the API. Again
there are more improvements possible there, the driver does not take
advantage of contiguity or alignment when programming the HW.

> Because we only need to preallocate the tiny constant sized dma_iova_state
> as part of the request instead of an additional scatterlist that requires
> sizeof(struct page *) + sizeof(dma_addr_t) + 3 * sizeof(unsigned int)
> per segment, including a memory allocation per I/O for that.

Right, eliminating scatterlist entirely on fast paths is a big
point. I recall Chuck was keen on the same thing for NFSoRDMA as well.

> At least for the block code we have a nice little core wrapper that is
> very easy to use, and provides a great reduction of memory use and
> allocations.  The HMM use case I'll let others talk about.

I saw the Intel XE team make a complicated integration with the DMA
API that wasn't so good. They were looking at an earlier version of
this and I think the feedback was positive. It should make a big
difference, but we will need to see what they come up and possibly
tweak things.

Jason

