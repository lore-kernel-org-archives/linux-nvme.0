Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2611C54E41
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Mar 2024 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LwAnb64EwkeKmrTREui8emTN6ZYCNogBTHISie/yQU0=; b=BeU83Y0wJ37yrMsSWRSRJBrCyT
	qjIASQh8ZMCNJT64rZD1qOZCPKIOEBySCvhAOxrIhXxBRKR/cObc2Ezjz0UfMayJS6zY4AuKc8nWA
	NPEEZuzjxo7+/Has5Fwd0+f+Hxv7j6o84Uy1ZDkPmrVZSjp6UbPJoxrL2iuo/3FLVBw8UdLpCyIGj
	u+3DDJQu2EJzI006hnCfxoyVxRwpwoNqnQfnuL66AVDs0sd7DfsmpetMgB7bWyJ9oL4PkQk1Y0RNo
	dQohgTcdYPWWB8hSPJNX7rF4kLDIorWGophdpWdn7+UTFyK0BjGpDOz0mHaMCpYIHLhN9gdwOdtLI
	TGXh03XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riz8X-0000000DhNo-15M1;
	Sat, 09 Mar 2024 16:01:25 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rigkr-0000000BD69-3xI5
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 20:23:48 +0000
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-59fb0b5b47eso1040027eaf.3
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709929424; x=1710534224; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwAnb64EwkeKmrTREui8emTN6ZYCNogBTHISie/yQU0=;
        b=gRNVsWGpVAgg/gzvi35YI6zreOaXSo/RPzteWeDYUew/LjgSrEZeuYMBZVpJXXScPZ
         hI1h4M9/Hr5EKBBy5xufdE+dL8XgIJtnYHwqy1g1rA3lgg0aGhhmCwtgTcxMWjJSUsj/
         vZHWJ4d6mEWgJSCoMlp/8S14Y47v7XvrUcd0S4fPOfHebLDlhde5ikSJ8zpix6GQoS8u
         aBRuWbDWpu1HTctx+qmjHCHjfHSeJJumquvjlUA4VdzaOE+83QKn/8l589a3DmI65rDY
         Nwgv0lcC+2TuU2cS+aITy176Myb4n9RHL4HXTsdeW9BX22ca+4kbM5fjO8qPXs/AJId5
         wOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709929424; x=1710534224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwAnb64EwkeKmrTREui8emTN6ZYCNogBTHISie/yQU0=;
        b=c9PXOVUxN+BroJhbvCtWqkcVNgL+6nWaSOJDFzU+kbi/ZymixrjcWRwQ8ZZba+TckW
         m5v42rUOxGexPGJHxesiKYa3on5mYP0ObolmgfRu5QtbxKQ/SBwotAJPSp6X/Xcn2yK3
         Da5Y2h0FhX2tcoMWR/y3XqK2SOq+hvMqANxcbgpIw/Ot/Je7TzzIxRExkXybE9Ch2U8i
         0+O6nc+0GCtGKhD9uKWfbrh7hkIFsjrThJcGrhAMGVUN3pUZgVY52g2xiekqUxyKLYf2
         PWfr66LHtCcodlHkGnUZe8k/ZfGnzhD0WRMWbT1lMurdMoLU4VzlwQNrYRg70FlMEedP
         SaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgsV1iC00ORMPsE9rhJEckT3L/FswFKUhvgp3jsZ8NylFuS6yfWG8Ew/9dgD/AezSpLA13aEQpUZYS5G+fQGjBGALVjhFQBo77pKfaf4o=
X-Gm-Message-State: AOJu0YyJSYbbnEHTph1dvTwyI3vnxS1JtZ/0efBmZcEkRKhiQvjwRi0b
	U8yaAZ06PLs+PdJAxO1EJySqWkcAzkl152KyB/R91RHB1maTX/fBHvO+Y2jdh7M=
X-Google-Smtp-Source: AGHT+IF/qfykmuaRb5uNoRhqiqioiMWJKv2ds3n4ZiUYzIpQ3ydAyGQZJUUw4tTE2mYtsW4uV3seEQ==
X-Received: by 2002:a4a:311e:0:b0:5a1:c4b6:bb76 with SMTP id k30-20020a4a311e000000b005a1c4b6bb76mr357202ooa.5.1709929424080;
        Fri, 08 Mar 2024 12:23:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830130e00b006e513edb0e3sm18031otq.17.2024.03.08.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:23:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigko-007vqd-D8;
	Fri, 08 Mar 2024 16:23:42 -0400
Date: Fri, 8 Mar 2024 16:23:42 -0400
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
Message-ID: <20240308202342.GZ9225@ziepe.ca>
References: <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
 <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308164920.GA17991@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_122346_167080_F79BEBA9 
X-CRM114-Status: GOOD (  48.62  )
X-Mailman-Approved-At: Sat, 09 Mar 2024 08:01:22 -0800
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

On Fri, Mar 08, 2024 at 05:49:20PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 07, 2024 at 05:01:16PM -0400, Jason Gunthorpe wrote:
> > > 
> > > It's just kinda hard to do.  For aligned IOMMU mapping you'd only
> > > have one dma_addr_t mappings (or maybe a few if P2P regions are
> > > involved), so this probably doesn't matter.  For direct mappings
> > > you'd have a few, but maybe the better answer is to use THP
> > > more aggressively and reduce the number of segments.
> > 
> > Right, those things have all been done. 100GB of huge pages is still
> > using a fair amount of memory for storing dma_addr_t's.
> > 
> > It is hard to do perfectly, but I think it is not so bad if we focus
> > on the direct only case and simple systems that can exclude swiotlb
> > early on.
> 
> Even with direct mappings only we still need to take care of
> cache synchronization.

Yes, we still have to unmap, but the unmap for cache synchronization
doesn't need the dma_addr_t to flush the CPU cache.

> > > If all flows includes multiple non-coalesced regions that just makes
> > > things very complicated, and that's exactly what I'd want to avoid.
> > 
> > I don't see how to avoid it unless we say RDMA shouldn't use this API,
> > which is kind of the whole point from my perspective..
> 
> The DMA API callers really need to know what is P2P or not for
> various reasons.  And they should generally have that information
> available, either from pin_user_pages that needs to special case
> it or from the in-kernel I/O submitter that build it from P2P and
> normal memory.

I think that is a BIO thing. RDMA just calls with FOLL_PCI_P2PDMA and
shoves the resulting page list into in a scattertable. It never checks
if any returned page is P2P - it has no reason to care. dma_map_sg()
does all the work.

That is the kind of abstraction I am coming to this problem with.

You are looking at BIO where you already needed to split things up for
other reasons, but I think that is a uniquely block thing that will
not be shared in other subsystems.

> > If you don't preserve that then we are calling, 4k at a time, a
> > dma_map_page() which is not anywhere close to the same outcome as what
> > dma_map_sg did. I may not get contiguous IOVA, I may not get 3 SGLs,
> > and we call into the IOVA allocator a huge number of times.
> 
> Again, your callers must know what is a P2P region and what is not.

I don't see this at all. We don't do this today in RDMA. There is no
"P2P region".

> > > That's why I really just want 2 cases.  If the caller guarantees the
> > > range is coalescable and there is an IOMMU use the iommu-API like
> > > API, else just iter over map_single/page.
> > 
> > But how does the caller even know if it is coalescable? Other than the
> > trivial case of a single CPU range, that is a complicated detail based
> > on what pages are inside the range combined with the capability of the
> > device doing DMA. I don't see a simple way for the caller to figure
> > this out. You need to sweep every page and collect some information on
> > it. The above is to abstract that detail.
> 
> dma_get_merge_boundary already provides this information in terms
> of the device capabilities.  And given that the callers knows what
> is P2P and what is not we have all the information that is needed.

Encrypted memory too.

RDMA also doesn't call dma_get_merge_boundary(). It doesn't keep track
of P2P regions. It doesn't break out encrypted memory. It has no
purpose to do any of those things.

You fundamentally cannot subdivide a memory registration.

So we could artificially introduce the concept of limited coalescing
into RDMA, dmabuf and others just to drive this new API - but really
that feels much much worse than just making the DMA API still able to
do IOMMU coalescing in more cases.

Even if we did that, it will still be less efficient than today where
we just call dma_map_sg() on the jumble of pages.

Jason

