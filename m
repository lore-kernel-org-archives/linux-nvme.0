Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1E606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aG/LKbsd;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BsG6NVeK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=; b=aG/LKbsd9BA3uYe60KXua24NbA
	5s9t7OmkzjOc6C2SMhJF0vQ6T8WUchcX3XqzJffz9pWfZAqegiqPmASeDrr+maWr4wCSGCadIDUdk
	W2uvSX1G5jgbSF3Tf6GqYKXL3jSVhYQ6t2DFZtxHdplPnEDc6b2AlWdvqX3N2t6NNA136HIVFmqkq
	Y7gTJNk/FTHMUXPB6KO9e+WpADnIFZaFc3bhas8lh1h5scGU2O0EzwX2Om3lqzRWxWN1wIB9clkil
	/PPPnaqU7y52TLlP7HgW7bOMuL6ZcMtdb6Xvm1FuUvpkALg1vZfvEDopzdXuUC3Z2mXgSz3GEJxaO
	a5hdHaXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWQq6-0000000C3vG-07V5;
	Thu, 26 Nov 2026 04:12:06 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWIKi-0000000B5ej-31CH
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 19:07:10 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-94961bfe1a0so400013385a.3
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795633627; x=1796238427; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
        b=BsG6NVeKsMHLxxatDb7JGQeQO5V76jOa/ckGDceI4O3oEMAzyVYon2FpYP9Ma+C6ZH
         FKmuq4eqBOGixvHVCeL3Fgw88l6L6AZbKo3lhDL8D4DpFKPSXGsMPCR/XuNZHrDN4zNa
         7Nr+2KJRZMvfXZkuHPLQM7bHg0Gesgb6h02sGzO8ppy3XWS9+x+norryy9Ia8kbB6UpX
         In+yW0IB/b1RQywn8wfGT1MfV9ydLy0iKymjqQqmfFR0dAAu2HhL61lD277k4qRFVVYh
         A5CEzVSIp/+HtLIeg7YyV/7KmPbcU7Ys6T3Dz/vvga/mVzC/EDBHB7KMQhtEiw8zITgz
         8zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633627; x=1796238427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
        b=MWtJ0CvvKeLIiIE0VT2DVHe1wAeNZx7nkFu863v1P++yhKB4R/VNBcafvY0BpSUyJS
         SWA45m5bzQO2VL9wGOetFt56+7nhDP+6hxotLcrqrBtsVf/lbrkUhVCCbNVewXOp5erF
         bBOEyZifLbmh6RARnTodZ+T715WRwYj+PzEp19+PcTyRxbqZWdrlhBDoaRd4wdtFSRrg
         EGiXLmaki5bwLr3fvHNoVDfvQrQGEjM7xPAwRDPadUNSXLdI5SSBySRf7UEdXxVLSrvS
         06sayfHIDergnpXuJRH2UA3kn/GDu3KicnbTEHGFiK6I35XgzexZV5hU37vT7kbs7YDn
         Idvg==
X-Forwarded-Encrypted: i=1; AL+hErG8p/EPDyZ79RB5bUzjWb4XMYxyvA5hHfZf2StojQyScFl91l+Dm7p2RVp1sCiUrnGpoCo+XaINkTub@lists.infradead.org
X-Gm-Message-State: APuU4Z+2R2GpaI8w5h1+/BlM2BVD+FctB3cQRh5S+IAjMjJNTuJrjqup
	e107toqwPPmKfcrjDPaqsOwaxIU4RARw8p8xyzRO+F4lpHrIjdQizYVXIIZZla8g04c=
X-Gm-Gg: AZFdTZfWDiQ1VSTRLwQVetqPKl2tOoCy0XUj6563J1T+goM46tcOx/7BVXqdvJtedaa
	kJ7VOtJMET6paUvAHy7OGxBLepWUbFNFyNnA3nX6VcYOxCpoR0uGuFGiJQmq6jcXTK1bNOyAoFM
	KUc8jB/u7/NOBO+F81mwX+EBiN2YIrXxqruhUTg2o2tBsEHG9lIHArMvKrEqDvFAtVkKxp5E3/U
	CsqaE7BaBG7FLp35vRpzVrbUyUU+sKXPnWS6MXVqmPG7Ibl3GybNG+87ZzEeTjI76ccC+OSfT0X
	mDPGfxqcAdp4/G9zhrwjQ6DTrEmd2rn0Rq+SFMQQyRDfGG4sjRXYk8AglUvQme0gU8JxusuOdiy
	1mT0SHvxpVxDGwObuBY4acKpmOEmwftkjJRtusu1AGGN/m+af03sUliW9e1PvOe/bSmyY18A4Fm
	AdBmCa5rtpSanG/59ZHt+vfb9NOrFBmdAjoazZs4BF8Gd/5Y+U32P+ZB5MrfaJ2mxsNQT/ELwqR
	c9ye4rZARsMIJhSVASHEOtY+frTQoCE60zYi0P0GYdKnZmlOX6jhplRiHPMBw9S7QRhaqy7WdiB
	brjK3/0=
X-Received: by 2002:a05:620a:4543:b0:949:65fe:b727 with SMTP id af79cd13be357-949ba9b99a7mr3433826285a.26.1795633626929;
        Wed, 25 Nov 2026 11:07:06 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a017cfb46sm339501085a.28.2026.11.25.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:07:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWIKf-00000002HLZ-3ZQi;
	Wed, 25 Nov 2026 15:07:05 -0400
Date: Wed, 25 Nov 2026 15:07:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
	treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261125190705.GN246011@ziepe.ca>
References: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_110708_815769_B83E7C63 
X-CRM114-Status: GOOD (  32.90  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 25 Nov 2026 20:12:00 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 07:17:51PM +0100, Christian König wrote:
> On 11/25/26 16:55, Jason Gunthorpe wrote:
> > On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> >> The low level API which talks for example to the IOMMU driver for
> >> creating the information how to access the buffer is simply not the
> >> task at hand for that framework. The stuff we already handle is more
> >> than complicated enough.
> > 
> > No matter what name you give it we need something in the middle that
> > can see the phys_addr_t and the iommu_domain..
> 
> No, absolutely not. That should be given to the exporter so that the
> exporter can call the DMA API to create the DMA addresses for the
> importer.

I think I've said it many times, and I thought you agreed: NAK to
giving GPU exporter drivers an iommu domain.

> The idea here is that the importer give all the information to the
> exporter so that the exporter can do the mapping on behalves of the
> importer.

No GPU driver must touch these internal details, they must only use
standard abstracted APIs that prevent them from abusing things.

My fear of DRM drivers abusing the DMA process is equal and possibly
greater than your fear of phys_addr_t :P

We are not giving DRM a nightmare API to continue to shoot us in the
foot with.

> > The primary issue here is the exporter *direct* call to the DMA API!
> 
> Why?

Because we need things to be mapped in ways the DMA API will never
support.

DMA API will never support something like dma_buf_iommu_map(). I have
no idea at all how you expect to build this if exporters are directly
calling DMA API. It is not possible.

> > We cannot disconnect this from the DMA API, ie to use an iommu domain
> > or ualink, if exporting drivers are hardwiring calls into it.
> 
> Well the plan is to not disconnect it at all. The exporting drivers
> just says to the underlying API here is my buffer please map that
> for this importer and that result is then given back to the importer
> through the DMA API again.

DMA API will only do basic PCI DMA mappings into dma_addr_t.

It will never handle iommu_domain, it will never handle ualink/etc.

Give us a plan for those if you don't like any of these ideas.

> > Fundamentally the need is for the driver to get the phys_addr list,
> > exactly like today, and then pass it to an op which formats that into
> > the right data structure for the importer. Be it dma_addr[],
> > iommu_domain, or some ualink_addr[] - or whatever.
> 
> No, the phys_addr type should only ever been seen by the DMA API and
> not by DMA-buf.

Again, I don't care how you label things or what "library" they live
in, I can't tell if we are nitpicking names or what.

But there needs to be some kind of abstraction that takes in
phys_addr_t and makes sgt, dma_addr_t, or iommu_domain depending on
what the importer needs.

Exporters must not open code that.

Obviously DMABUF is involved here *somehow* since it is the only thing
that knows an importer even exists.

Would you be happy if we made a 'dma mapping for dmabuf' library that
did all of this and DMABUF just passes its type opaquely and drivers
just call its tightly abstracted functions?

That is the component Alistair is proposing, he just prefixed it with
dmabuf_* as the namespace because, lets be honest, only dmabuf needs
this weird looking thing.

Jason

