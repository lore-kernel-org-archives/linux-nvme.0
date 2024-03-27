Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1F6CD1284
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MyfMHWP1Z5kFosJnJ/cLT9vrDNlc6F3RpHcMzwkJjx8=; b=2aMjZEarAzog0W0VrQ+yZTEPHL
	/chZ4NOGgjufOlmPV/BS17oBn9Ecr/XIVhvJX7ZeXYzbHiAsW6b5ye7VsvMRD+zBoWfQjQOiMJ1xK
	5yv7gHt2rZNhm+Av6gzIp0zJTpegt/WaXBU6QhoKMd+G9upCtTZikpNQtCGe1BxIrRduOw+bDb7RW
	Ooi4qcg1Bd8WwmTzOOj3p5ONfvrCm9F+jSWGn5dok+SlIK0zFn5QUym8zK/yanWtZArK/1GETfML8
	iT1YsIce4engnH7SKlfsjcmO+XAAvF97xhZ2M4JOOVEDqjD1q474qquBB3jrEnGqojbUdGVn4RD9x
	42YaXDWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprM5-0000000ESK2-2hRl;
	Thu, 28 Mar 2024 15:07:49 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWru-0000000AF5i-26NF
	for linux-nvme@lists.infradead.org;
	Wed, 27 Mar 2024 17:15:20 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so46847b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 Mar 2024 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711559712; x=1712164512; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyfMHWP1Z5kFosJnJ/cLT9vrDNlc6F3RpHcMzwkJjx8=;
        b=hJdOBL4QYVAMn0NxTAFdwy7Co/vfn4yQdbdsG6OxTwtuyyJB4Ncpu+W4gWlcPG/vlz
         kmTtswPM5+fnsBOLysT8UHPcjifYWYllwsm/b31z4+RWD6mWqAhpHUiS717OgvzOF1fK
         Q6bLPhaPBJVf5NaJFT9JGUhyAIEdg6v+pZ+o7x9MHWFhELFvq3HPiWYZdKPgt8ILXc1u
         WyDViDeIbbqFCz+r2CDjJK7sDIU+5l6YnIsZuQPAuTUjSpsnrFL56X3aK/Kb67fwQthZ
         Q8cDopJ93hJKfEkn7Lq9621BIv37ad3704qmODZT09qK1QbX/ThYbDpvBS9vY2gIQXs2
         kasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559712; x=1712164512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyfMHWP1Z5kFosJnJ/cLT9vrDNlc6F3RpHcMzwkJjx8=;
        b=UUtVJNez19iCmHwiIfngGdXqnO3QBe+y+NdlQ/8QXnyu5+LXzh/tDdX6cfKBbB5Czu
         zDGO38lPUx2kxwwRfgjFPV7oEk3P3q90ypLXoYgZwAHacyI/Zg2Z5y3/NGNbYn5wji9h
         QIONDnLmsJC7Tq9A0ep3vfMZ+QFtaXDyrRW17p2CXk6RQJdl8nparpzYjbubUgdgYQNf
         EFkNkIi4GybFx6YBx5fX9Q+SSyBRxRi7e3Olmlndjsor4yh9eiaCj1m4IoA19cEVG2/p
         S1OZHBVNR9m8DNiSA74iigfzGQ8jz5OvcO5NfW91EojQPA7sQ5szzT2wDvOzHnjYQYo9
         PNNg==
X-Forwarded-Encrypted: i=1; AJvYcCVQE3p+bLzFd4IpX8j24Lt2G3RE1hcrz2fimibVk0P5owu3Dd/4gLw/yFmQn6Y3GPsqbWMCVmta0BAAoxmQzSin/Njfn99+RBKt6lHGIvA=
X-Gm-Message-State: AOJu0Ywsg1DqFPZ/0T/ugTU7nlVVQv6h7rrJm3WlUY25pt0Ys85nzsS/
	hd7us3Jf8gr0WNC/1eY+7m5fM7dIKk1Ayg7iwXsQPehxROxpTr+gp7QEi+P6WOQ=
X-Google-Smtp-Source: AGHT+IGQ+Fbz7qR1SW5qNkJYopwwdBYDjEYKQNSO/4NiABanB9dU3kXOL1kwvcUdEQ/e1ORbwkUJTQ==
X-Received: by 2002:a05:6808:64b:b0:3c3:d56d:a5dd with SMTP id z11-20020a056808064b00b003c3d56da5ddmr357972oih.18.1711559712027;
        Wed, 27 Mar 2024 10:15:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kd9-20020a056214400900b00696b117a325sm499925qvb.108.2024.03.27.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:14:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpWr2-005ajV-OE;
	Wed, 27 Mar 2024 14:14:24 -0300
Date: Wed, 27 Mar 2024 14:14:24 -0300
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
Message-ID: <20240327171424.GI8419@ziepe.ca>
References: <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
 <20240319153620.GB66976@ziepe.ca>
 <20240321223910.GA22663@lst.de>
 <20240322184330.GL66976@ziepe.ca>
 <20240324232215.GC20765@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324232215.GC20765@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_101518_567598_3760D5AE 
X-CRM114-Status: GOOD (  37.47  )
X-Mailman-Approved-At: Thu, 28 Mar 2024 08:07:42 -0700
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

On Mon, Mar 25, 2024 at 12:22:15AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 22, 2024 at 03:43:30PM -0300, Jason Gunthorpe wrote:
> > If we are going to make caller provided uniformity a requirement, lets
> > imagine a formal memory type idea to help keep this a little
> > abstracted?
> > 
> >  DMA_MEMORY_TYPE_NORMAL
> >  DMA_MEMORY_TYPE_P2P_NOT_ACS
> >  DMA_MEMORY_TYPE_ENCRYPTED
> >  DMA_MEMORY_TYPE_BOUNCE_BUFFER  // ??
> > 
> > Then maybe the driver flow looks like:
> > 
> > 	if (transaction.memory_type == DMA_MEMORY_TYPE_NORMAL && dma_api_has_iommu(dev)) {
> 
> Add a nice helper to make this somewhat readable, but yes.
> 
> > 	} else if (transaction.memory_type == DMA_MEMORY_TYPE_P2P_NOT_ACS) {
> > 		num_hwsgls = transcation.num_sgls;
> > 		for_each_range(transaction, range) {
> > 			hwsgl[i].addr = dma_api_p2p_not_acs_map(range.start_physical, range.length, p2p_memory_provider);
> > 			hwsgl[i].len = range.size;
> > 		}
> > 	} else {
> > 		/* Must be DMA_MEMORY_TYPE_NORMAL, DMA_MEMORY_TYPE_ENCRYPTED, DMA_MEMORY_TYPE_BOUNCE_BUFFER? */
> > 		num_hwsgls = transcation.num_sgls;
> > 		for_each_range(transaction, range) {
> > 			hwsgl[i].addr = dma_api_map_cpu_page(range.start_page, range.length);
> > 			hwsgl[i].len = range.size;
> > 		}
> >
> 
> And these two are really the same except that we call a different map
> helper underneath.  So I think as far as the driver is concerned
> they should be the same, the DMA API just needs to key off the
> memory tap.

Yeah.. If the caller is going to have compute the memory type of the
range then lets pass it to the helper

dma_api_map_memory_type(transaction.memory_type, range.start_page, range.length);

Then we can just hide all the differences under the API without doing
duplicated work.

Function names need some work ...

> > > > So I take it as a requirement that RDMA MUST make single MR's out of a
> > > > hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
> > > > not a functional replacement for a single MR.
> > > 
> > > But MRs consolidate multiple dma addresses anyway.
> > 
> > I'm not sure I understand this?
> 
> The RDMA MRs take a a list of PFNish address, (or SGLs with the
> enhanced MRs from Mellanox) and give you back a single rkey/lkey.

Yes, that is the desire.
 
> > To go back to my main thesis - I would like a high performance low
> > level DMA API that is capable enough that it could implement
> > scatterlist dma_map_sg() and thus also implement any future
> > scatterlist_v2, bio, hmm_range_fault or any other thing we come up
> > with on top of it. This is broadly what I thought we agreed to at LSF
> > last year.
> 
> I think the biggest underlying problem of the scatterlist based
> DMA implementation for IOMMUs is that it's trying to handle to much,
> that is magic coalescing even if the segments boundaries don't align
> with the IOMMU page size.  If we can get rid of that misfeature I
> think we'd greatly simply the API and implementation.

Yeah, that stuff is not easy at all and takes extra computation to
figure out. I always assumed it was there for block...

Leon & Chaitanya will make a RFC v2 along these lines, lets see how it
goes.

Thanks,
Jason

