Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79809C54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7H3WfkclcieHpBg89GTkZxaS3r7II1qq9xezXi0hVM=; b=w7KmXvrBgPzEga+KRgfHheXxlt
	ZYBX8DZDEcf7/SThnIdwSapLosyzWHzpRM+tgKFxCNwLPrKgGLuL1qeskQLxUwkx7dkAeZdhoQpR5
	QDUmIrSldxe+ov3yrCgsX4Im7M5i7LNN6yaaI22nEs3I8BdHn7fdrqWzf5GG2hRoUwu/eHGkGAL3G
	FPLr68hBteGfk0E8oHETHUTuts/O5wv1yjGRdC3cs5YBzdXKeMXfQo4aI3kfPWJw3QpwtgGRlfQUw
	KpoPfFOfpPxH4PxC9BDKMrxBmkPHupVBQ9wZ5wJMT22BheekNDoJWFLYpb3cZVLQoPkBzcFACzowS
	2FSqltaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnDOk-00000002EY8-0iS7;
	Thu, 21 Mar 2024 08:03:38 +0000
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmdfS-0000000DgwD-2BIC
	for linux-nvme@lists.infradead.org;
	Tue, 19 Mar 2024 17:54:32 +0000
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-22963f0e12cso941548fac.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Mar 2024 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710870867; x=1711475667; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7H3WfkclcieHpBg89GTkZxaS3r7II1qq9xezXi0hVM=;
        b=XUBrduBGd9GSngFM9F7fsT+su1F35usnQnNWKreq/0TBEWCDclJ0KHwEry7pdU04d5
         YH87bg2rf+3bSP9orKhMEbP2dyTGIGgKAFJheLzONuPYCWw+a84sHS5jzEnu5AhkU73s
         sLOMYmMekw2+mmOJ+2n+l2mkHz90Wegsxp9PTeQ0vHKe5YHMPdQza7X3h/PV68o/dhe1
         oHSFCaqjvkYlxzOanjMLJLRX3TEzYS9t4FSYq3KMjwm2XRLu8P2kw5oHDqMtQOHBCzT1
         sq0GM5oHGsyeRFn6mA1ke2P5TxSpO03mhajLpqYOZNaOovC1xMT1xKezAvji0BlA81Ct
         s+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870867; x=1711475667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7H3WfkclcieHpBg89GTkZxaS3r7II1qq9xezXi0hVM=;
        b=lFmw7FKBClDopMjw3JCtYuTrAAjmMHE+Zz7j057LKEPqgwVOdiGG2zM2a5AHFO2xh3
         y/Nc6czIJ6m08JDLuFd8AJqoJIaDz10wpdwiN3u0yxhoO/o1xuzak3EvqCbIjQ9/tOhi
         BNKaAccAHJ3yZuIHMc+Pw0PX2cAJeUoUvRj7yHqoFJuN6gMmO3WXXj0Jtvk4AKBnjomk
         8fbvPpVa/o0FX7S9qd6OdWIFJ6hS4Qe/70VJDTdEu6cNZKkm8+9ZmSGfVG+QbhyW816L
         mT0jYrscuypq3LBUIGPDpzEWHZrwWREOxkmkHqgruNYZoFpV2ipOIYnqYDOtMjss7NXx
         cGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX96mF4KuzNqnSkp0mjJ+5T5kkB98O2KeHUCuZhlXuDzYMcU5mX8Zgh0zcsIshmBMrB/xc1CtqvNuz0FQPa08uvlSJD/7pBti/maP/aNsk=
X-Gm-Message-State: AOJu0YxbtS6u9ffunBWZBE04M/veLsbo7V1Vxp9vQ0KyB17CqSB+UIqu
	c7eHetITe2IkbEtSN8XZABMrH+LX2UFx38MOfNdl/7A/VQHDa5mr/1pPnbAWzx8=
X-Google-Smtp-Source: AGHT+IFEKHu8FJxVRb4YxsELWM46dNSxNuN3njm0tBeD+R+fEyp1j8c0yaDa2gTZMCaYT5fxKBzgBQ==
X-Received: by 2002:a05:6870:d20e:b0:222:99cb:2215 with SMTP id g14-20020a056870d20e00b0022299cb2215mr3580439oac.28.1710870867581;
        Tue, 19 Mar 2024 10:54:27 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b00477716fcbb8sm2429986jab.40.2024.03.19.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmbVk-001elO-4L;
	Tue, 19 Mar 2024 12:36:20 -0300
Date: Tue, 19 Mar 2024 12:36:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240319153620.GB66976@ziepe.ca>
References: <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309161418.GA27113@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_105430_595524_70E21117 
X-CRM114-Status: GOOD (  39.83  )
X-Mailman-Approved-At: Thu, 21 Mar 2024 01:03:35 -0700
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

On Sat, Mar 09, 2024 at 05:14:18PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 04:23:42PM -0400, Jason Gunthorpe wrote:
> > > The DMA API callers really need to know what is P2P or not for
> > > various reasons.  And they should generally have that information
> > > available, either from pin_user_pages that needs to special case
> > > it or from the in-kernel I/O submitter that build it from P2P and
> > > normal memory.
> > 
> > I think that is a BIO thing. RDMA just calls with FOLL_PCI_P2PDMA and
> > shoves the resulting page list into in a scattertable. It never checks
> > if any returned page is P2P - it has no reason to care. dma_map_sg()
> > does all the work.
> 
> Right now it does, but that's not really a good interface.  If we have
> a pin_user_pages variant that only pins until the next relevant P2P
> boundary and tells you about we can significantly simplify the overall
> interface.

Sorry for the delay, I was away..

I kind of understand your thinking on the DMA side, but I don't see
how this is good for users of the API beyond BIO.

How will this make RDMA better? We have one MR, the MR has pages, the
HW doesn't care about the SW distinction of p2p, swiotlb, direct,
encrypted, iommu, etc. It needs to create one HW page list for
whatever user VA range was given.

Or worse, whatever thing is inside a DMABUF from a DRM
driver. DMABUF's can have a (dynamic!) mixture of P2P and regular
AFAIK based on the GPU's migration behavior.

Or triple worse, ODP can dynamically change on a page by page basis
the type depending on what hmm_range_fault() returns.

So I take it as a requirement that RDMA MUST make single MR's out of a
hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
not a functional replacement for a single MR.

Go back to the start of what are we trying to do here:
 1) Make a DMA API that can support hmm_range_fault() users in a
    sensible and performant way
 2) Make a DMA API that can support RDMA MR's backed by DMABUF's, and
    user VA's without restriction
 3) Allow to remove scatterlist from BIO paths
 4) Provide a DMABUF API that is not scatterlist that can feed into
    the new DMA API - again supporting DMABUF's hodgepodge of types.

I'd like to do all of these things. I know 3 is your highest priority,
but it is my lowest :)

So, if the new API can only do uniformity I immediately loose #1 -
hmm_range_fault() can't guarentee anything, so it looses the IOVA
optimization that Leon's patches illustrate.

For uniformity #2 probably needs multiple DMA API "transactions". This
is doable, but it is less performant than one "transaction".

#3 is perfectly happy because BIO already creates uniformity

#4 is like #2, there is not guarenteed uniformity inside DMABUF so
every DMABUF importer needs to take some complexity to deal with
it. There are many DMABUF importers so this feels like a poor API
abstraction if we force everyone there to take on complexity.

So I'm just not seeing why this would be better. I think Leon's series
shows the cost of non-uniformity support is actually pretty
small. Still, we could do better, if the caller can optionally
indicate it knows it has uniformity then that can be optimized futher.

I'd like to find something that works well for all of the above, and I
think abstracting non-uniformity at the API level is important for the
above reasons.

Can we tweak what Leon has done to keep the hmm_range_fault support
and non-uniformity for RDMA but add a uniformity optimized flow for
BIO?

Jason

