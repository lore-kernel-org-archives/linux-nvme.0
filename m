Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF35CC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpyRbZ0RdQZQRjC0Rn2UI7ybSBSrjRoc3WCER4LofKQ=; b=xEZnMv9FmaXwuEQ0iVgRmr5dSB
	JL4ADRFnwxptHKvayA1VWAgxD9aypqAdfUw74Ni5aKyE51yz35Uc/WHU6Q+uGp/bZheTz+DTFiCgf
	kFN40zUqsCDbAhXeQMMHd0T8V+3Bv1dLLkd+D7D1i0lOhYDxox9gjzyXmS6y8uA+lrEreLDI9c175
	ygk932DXdbnExGpGrfCyl31ASO3DRnTSaXMMtSE83Jn2+t/Aa9AS+mORDQL36pIR86BKLdvvlHBQd
	J95tiQnjx48YZVx3rqfEh7bVeui8y/1mN8phvqSyIEa2RMNuE8JDV6peZZvRGOFAx2z98wlU/7Ha7
	KNwfRmhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGJ6-00000005Q8c-164L;
	Thu, 07 Mar 2024 16:09:20 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhvK7-00000001GnD-3Gfr
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 17:45:08 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6869233d472so36813566d6.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709747098; x=1710351898; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpyRbZ0RdQZQRjC0Rn2UI7ybSBSrjRoc3WCER4LofKQ=;
        b=SWztfsTFZ/1Mak+TnxIvGlXfaUvXxQw44SYdRYSmRxGhSyvViZGk+iCsLlBXyzSaM3
         ShmCPWdG5oaKiWuoHOuGv+hbC7/hov10F6teOjVjRP2er/RVfwu42k55XLuACRqivH1Y
         Tij/1xdEH7lnDmkegxkYw3IJF4Yg5x6cZlhyYp5MZ1C1dXpXKPZeiOS3Ubm81/aXAXfk
         WkybdfZ2V+ChAFNig7aik9mrPTvTtWxn2dhHz1khvPGCeH/XCSSm2HtsX7YJfr947dYs
         y1Etu18yalLNPzROoWmHZEK9EPr97F/oemy1mInDDZoc2EGK3+RCx0GGfZV7tjKjwF1+
         IdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709747098; x=1710351898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpyRbZ0RdQZQRjC0Rn2UI7ybSBSrjRoc3WCER4LofKQ=;
        b=C/jGiMC/+PRlLKmYPiZ46jNizD+xo9U0+7tSzQCo/ZIaYGQ2LUw4uYddjXUJOM8/KA
         UWuglrQkNtqfdTbyQXoM0/g6btP8GpYalfYjAlcFOBQykvbbKZoZXzFyLiUqZOucgQLq
         ZGCHyIdxQGyCAP/wGddx4XqKw2b6CGQSnWcOsZLV1ZZxPLgW15xNWSCYV33wK/u82YDd
         /t+xWChO5sN8kjhRrZ17xQVxmk9xIU41cOhU9swyhD1kRQCDJmL2QNkKmHtzdMLGRGXu
         /078ddmNuxv1Mz0t1B5lerTHABENTRTmhDfzk0EtcCElEF+lPrSiZzZT529q+vpDJoba
         TzEA==
X-Forwarded-Encrypted: i=1; AJvYcCUlNzzzYUSFIvwB/HhpuJ4THV8cfgVwxVmtzXvLU/pJ9OQHlk2jhHA0v46MQibnUqC7HuYnUQoCsz7mGh3ZgUUuiRWr6vlDaLO0NnQQGh4=
X-Gm-Message-State: AOJu0YyZ2uQ5yRSUduHailj4AQwg8OkOj6WDW7PjOXi6BS5PNoERrSsV
	N9OQSD0tZrcs5awXyBJh3Vt6F5k3WGSslDeH8fpCSSkyuntsWWhf8H7agCjE6L0=
X-Google-Smtp-Source: AGHT+IFPBkf7L5QuuJTJ8Xv6bEQYd424i8376Z5+WOarEDc8ZpU3tKfW4UZ0uYoM0R8xl79r0aNmBg==
X-Received: by 2002:a05:6214:11b1:b0:690:64e6:33d5 with SMTP id u17-20020a05621411b100b0069064e633d5mr5599360qvv.54.1709747097870;
        Wed, 06 Mar 2024 09:44:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ol17-20020a0562143d1100b006904e2c9e36sm7228573qvb.116.2024.03.06.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 09:44:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhvK4-001uSz-88;
	Wed, 06 Mar 2024 13:44:56 -0400
Date: Wed, 6 Mar 2024 13:44:56 -0400
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
Message-ID: <20240306174456.GO9225@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
 <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
 <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306162022.GB28427@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_094500_042506_63EDB825 
X-CRM114-Status: GOOD (  29.06  )
X-Mailman-Approved-At: Thu, 07 Mar 2024 08:09:15 -0800
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

On Wed, Mar 06, 2024 at 05:20:22PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 06, 2024 at 11:43:28AM -0400, Jason Gunthorpe wrote:
> > I don't think they are so fundamentally different, at least in our
> > past conversations I never came out with the idea we should burden the
> > driver with two different flows based on what kind of alignment the
> > transfer happens to have.
> 
> Then we talked past each other..

Well, we never talked to such detail

> > > So if we want to efficiently be able to handle these cases we need
> > > two APIs in the driver and a good framework to switch between them.
> > 
> > But, what does the non-page-aligned version look like? Doesn't it
> > still look basically like this?
> 
> I'd just rather have the non-aligned case for those who really need
> it be the loop over map single region that is needed for the direct
> mapping anyway.

There is a list of interesting cases this has to cover:

 1. Direct map. No dma_addr_t at unmap, multiple HW SGLs
 2. IOMMU aligned map, no P2P. Only IOVA range at unmap, single HW SGLs
 3. IOMMU aligned map, P2P. Only IOVA range at unmap, multiple HW SGLs
 4. swiotlb single range. Only IOVA range at unmap, single HW SGL
 5. swiotlb multi-range. All dma_addr_t's at unmap, multiple HW SGLs.
 6. Unaligned IOMMU. Only IOVA range at unmap, multiple HW SGLs

I think we agree that 1 and 2 should be optimized highly as they are
the common case. That mainly means no dma_addr_t storage in either

5 is the slowest and has the most overhead.

4 is basically the same as 2 from the driver's viewpoint

3 is quite similar to 1, but it has the IOVA range at unmap.

6 doesn't have to be optimal, from the driver perspective it can be
like 5

That is three basic driver flows 1/3, 2/4 and 5/6

So are you thinking something more like a driver flow of:

  .. extent IO and get # aligned pages and know if there is P2P ..
  dma_init_io(state, num_pages, p2p_flag)
  if (dma_io_single_range(state)) {
       // #2, #4
       for each io()
	    dma_link_aligned_pages(state, io range)
       hw_sgl = (state->iova, state->len)
  } else {
       // #1, #3, #5, #6
       hw_sgls = alloc_hw_sgls(num_ios)
       if (dma_io_needs_dma_addr_unmap(state))
	   dma_addr_storage = alloc_num_ios(); // #5 only
       for each io()
	    hw_sgl[i] = dma_map_single(state, io range)
	    if (dma_addr_storage)
	       dma_addr_storage[i] = hw_sgl[i]; // #5 only
  }

?

This is not quite what you said, we split the driver flow based on
needing 1 HW SGL vs need many HW SGL.

> > So are they really so different to want different APIs? That strikes
> > me as a big driver cost.
> 
> To not have to store a dma_address range per CPU range that doesn't
> actually get used at all.

Right, that is a nice optimization we should reach for.

Jason

