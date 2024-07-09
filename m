Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DF7C3DA42
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tz4SKanGT0p7B5kijsG/hyAEtWawoOPO2+O2oyG1KXg=; b=HnjjEhSwZIhvbhgvm9N9mcqAS/
	zUcAR32oyr/bVyvmYq6j93ckHm//uUlAdkBkcM6IacNgcw/sjTO/sx31oRFD8wzdorCFuwRxlv+EA
	7EgwZiZyrhENK0YewaCnBRav6YnVIbrhnfTiO+fBo+aAMGIs6kNj1pLuQwV6x0tYoutPktrjvQW98
	sKWZB2Lo6fH794272rEjnJvp1OJZConDg+8MLxJAupqmaIU0a2Q2S2UcY/IrSzpEcZkBsNh6GvYRn
	3+Lko3C/aL8dfVPqgJOzp2zOSzCygWdTZ+CeuyvuN5n4ngkyDE6yigbVXFEW3l63uY3RiEgT191qD
	r2RYqixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRG7U-00000008Lve-3da0;
	Tue, 09 Jul 2024 19:03:20 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRG7R-00000008Lv5-1anN
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 19:03:18 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6b5f4c7f4fbso24636546d6.2
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jul 2024 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720551796; x=1721156596; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz4SKanGT0p7B5kijsG/hyAEtWawoOPO2+O2oyG1KXg=;
        b=lyu4crvEV1DH953+FlUNUUXzaTV5UccCvhPazUnagMMb/QocnBAnyJANqupSGyQUu5
         oXzU+lVifoUwefyIzY2JD48psqyMATEyeufol/UQ+mSdCBswMdJy3uGnZ1jWUsGpL8aM
         3GbjLvsX5sgOFid7uHlYnQUYZKFCj6cZ5Q4vkU8QkuVnEUvmPSHgkP8su/q6ifpva+HR
         wDhi/WUAoJ1Yzhplx88NX1jr7K7b3vyCeE/jvqEQXrvaM6IfU3hRy0nfnzIgqYfYG0Pl
         mqVoddEwY6GkI2hRS5zi2e2px5Zrar1/u5PpziF/sRkNnsft8PLgd3i4QvD951ENXAy1
         paoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551796; x=1721156596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz4SKanGT0p7B5kijsG/hyAEtWawoOPO2+O2oyG1KXg=;
        b=bjyvUWHEZ5RldpXgayqVC+4XjumQ9OXAyyljdgmaRtClaQIK1cpUTkca3ofUhdBd0K
         OL9DBRMNzg32gVz1zTGWOKUeyA8FZqPITUMNK5C+kSjTmw7EAjKDJbNbn5bLH3bZnXl7
         rJtSx+v1ECH3uuNQ0BpGr+RRcHzpTiFrjyi10H1O2DgxCP7HSGk309T/SCm0yT4PokAP
         EcTElvoTaDR+23p8WAsXVqU0DCRdLgkc6a03mm2t28FONnOTDLFAKjaYGse6r/0J2120
         4Kyg6Hgv5D0YI/mEmZGYgMZBTMcKV7erUomh+Ce6ApzghsudqnfqwbR6jI8ufu40po64
         OGfw==
X-Forwarded-Encrypted: i=1; AJvYcCUeWSxMQHH3rnL0FThFtX6p1nQ4NaNg/3lwbERmWGrRkoKGZ9NixSXNEaZ5lWoJJruYSHXZf637iJ4hG73K+u5QZDV1Cvh+JjQAyeXXzKI=
X-Gm-Message-State: AOJu0Yzsw6L155FZ67xEyaRtoOXWpn2XBcYNBF9H0pcJF4seos1luhFe
	JVVnHB7GoDyDoJ2hsTYo2MC87bzGqEGrEc7KZ8D6AaeO9aie2khh5GqQnh/qCLg=
X-Google-Smtp-Source: AGHT+IFhetxp9iNMwbY2wmkBlgDvT9+MA6GFJVeq9xE0noHusNzmV7TqInccd4H71Z7ysufi1Iri/Q==
X-Received: by 2002:a05:6214:1cc2:b0:6b5:52da:46f2 with SMTP id 6a1803df08f44-6b61bc80504mr38822486d6.6.1720551795800;
        Tue, 09 Jul 2024 12:03:15 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba797c0sm11232896d6.91.2024.07.09.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:03:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRFxj-002sHI-8S;
	Tue, 09 Jul 2024 15:53:15 -0300
Date: Tue, 9 Jul 2024 15:53:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240709185315.GM14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
 <20240708165238.GE14050@ziepe.ca>
 <20240709061721.GA16180@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709061721.GA16180@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_120317_442889_3BC2B213 
X-CRM114-Status: GOOD (  34.94  )
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

On Tue, Jul 09, 2024 at 08:17:21AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 01:52:38PM -0300, Jason Gunthorpe wrote:
> > Ideally we'd have some template code that consolidates these loops to
> > common code with driver provided hooks - there are a few ways to get
> > that efficiently in C.
> > 
> > I think it will be clearer when we get to RDMA and there we have the
> > same SGL/PRP kind of split up and we can see what is sharable.
> 
> I really would not want to build common code for PRPs - this is a concept
> very specific to RDMA and NVMe.  

I think DRM has it too. If you are populating a GPU page table then it
is basically a convoluted PRP. Probably requires different splitting
logic than what RDMA does, but I've never looked.

> OTOH more common code SGLs would be nice.  If you look at e.g. SCSI
> drivers most of them have a simpe loop of mapping the SG table and
> then copying the fields into the hardware SGL.  This would be a very
> common case for a helper.

Yes, I belive this is very common.

> That whole thing of course opens the question if we want a pure
> in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
> way to migrate and allows to share code easily.  We can look into ways
> to avoiding that more for drivers that care, but most drivers are
> probably best serve with it to keep the code simple and make the
> conversion easier.

My feeling has been that this RFC is the low level interface and we
can bring our own data structure on top.

It would probably make sense to build a scatterlist v2 on top of this
that has an in-memory dma_addr_t/len list close to today. Yes it costs
a memory allocation, or a larger initial allocation, but many places
may not really care. Block drivers have always allocated a SGL, for
instance.

Then the verbosity of this API is less important as we may only use it
in a few places.

My main take away was that we should make the dma_ops interface
simpler and more general so we can have this choice instead of welding
a single datastructure through everything.

> > I'm also cooking something that should let us build a way to iommu map
> > a bio_vec very efficiently, which should transform this into a single
> > indirect call into the iommu driver per bio_vec, and a single radix
> > walk/etc.
>
> I assume you mean array of bio_vecs here.  That would indeed nice.
> We'd still potentially need a few calls for block drivers as
> requests can have multiple bios and thus bio_vec arrays, but it would
> still be a nice reduction of calls.

Yes. iommufd has performance needs here, not sure what it will turn
into but bio_vec[] direct to optimized radix manipuilation is
something I'd be keen to see.

Jason

