Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE58C36001
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7w18pLCxgYQdbgr4L7Ilx5M+dDme30Hw40dLx2kJ/Cs=; b=QVTuaHp6DWXOOHnIKG/NIUG2Fn
	Z4h/IynkL6AdbB2wz/GdOSevOHzQVxJf6lcnP7ihUEqNtKyLMtniTtGUVo4bEF/fRAEN4tKgCsdt7
	wtXopfdVjN0UMmmztTv9XzDLMJBM38jEDigIYwoLVATOQ89fu5kx5weQu9HKH22m8LxFoHMylnRoC
	WTxQO47W85AMMWbLiJ9vSbJiwxM/cLKmhIk8fR9+2WI4Rwv7mWCkb5+8mIZmGUyWo9tvOOjDicWAP
	FGeXI8upA6pPsfUkPi/0lTXe4Heo5sjOxcFcJrvfmOYCuLpqu8eL54uNkw8SO0kUF6ihvElwhW/Xm
	BNzH0ZZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvmvf-0000000Gd6R-37zT;
	Sat, 22 Mar 2025 00:41:35 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvmvd-0000000Gd5o-0ThG
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 00:41:34 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-476ac73c76fso28694131cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 17:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742604091; x=1743208891; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7w18pLCxgYQdbgr4L7Ilx5M+dDme30Hw40dLx2kJ/Cs=;
        b=gu6FOLT01F0Xv6K7bZx4tCA+bHtwFuY/FFfvqxL8tKGb7iygVmduPaXsHWKdzHzBZ3
         p2Otk2/aIllfOYjArFTn9BBA6OxGBYvsGfV780SHiZftq0eZIu9fdaYlU4TK+0rFgRzl
         vGs+eZvHb1jK8FVbP+6JsZ1F5MRxKR5gV74prbo/ATXdRAJbOhNSWgYLr8ONaZflJNIt
         0e+sf8QL7c+3ADqZQN0EfI8ACBR4zQSKRpWzD2g1WcSiAv+w9Eui5G25XNX/ETxmoS2c
         b5obpfBqeGgur0Un/5uI75/88o4n+500V/ljhwnD8SBgairkkdb8+BTBfCpqx9s9/YlS
         ckoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742604091; x=1743208891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w18pLCxgYQdbgr4L7Ilx5M+dDme30Hw40dLx2kJ/Cs=;
        b=UXYOemXKLIn1ug2001t701q1V2DfD/6m74LnNm6DZG9mI9JqxSiRhZYhaLTJU1kC/h
         OMB9TIGHrBFl9OzBohlVOQm1uCzA+EiOfLaSvFm5CDGkkuEn2zTvmgOkzndZsjSmP5qK
         sVN3sJCKvrPIUhia4eoDKJRCLedreCy/ew/mbPgiRxnWoshp/bvmE/AOAqsEF6WzdnX1
         HnBszJLWzdPfNCnbUs8ClPvvjunifL65Bo4rKoT+gY2JmL2rZ6mCkOoSlUApXHgQq/dd
         J3sUGo5AiG7wiO0wdBMXnXP5ZgS9gytQ4WYdALCN6pApfNheCx0/W7H/PzIV+WKIcb0X
         C2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV8zbIH6USnyms+mCGqFC4Dags24SAZxpPCE4oNWByZwwsWiUbF/PKynJLhvcS2mwCcSYyQ7Z2yYIU1@lists.infradead.org
X-Gm-Message-State: AOJu0YwPFy47B7FDo9Ah/qPKaUocfFzYptXRPmmPS0YZXInwiJKgxixh
	eEQD1Qesv3acTrfscDSeSeSct1mBIsJPeLKBbg0tC9R02qwHNjMNZf/YQRQnjt4=
X-Gm-Gg: ASbGnctgFxRvfAvAqENLZNt40LbJnqIxVTMJT9UR3bV5GeEP0b942hyGvDCl2tvl488
	CB7xWHJv8W49EQ8iCA68N21rlXXdO2YmymOYyP6vmzO+EA+nOuB+woCOmx2QqJJbSL6lwlQXgEq
	hF3xJYtYRCvTreh1w6r1j6xO4HVmQl0Lqfs3U5Vwv+zFHyWZ9LiyuhS3ygZjs1a/Y25FrujQ5W9
	nBfTsXaPda2l6iV4XBBnmmhbQJ/l+kTjhpmAisxLnmGfkHtHeNSo7xQ15Sw4VZLVHrWXhhddS0H
	PERHvnvDK3gszitL5Y0rDtAbej0Mr2TSBFk2aGjz+pWULtZqecl2bvjjOIAOsnbP2JJmmNe26kA
	mU4BAclsDFNcOHfpUNByDELM=
X-Google-Smtp-Source: AGHT+IF3UkobCdIF7lNWuu9KRAhdJDE5q4DcYOtKKTS+FcoMl1AlUzXXVqHHTKDK0VlDF9Mdifo+AQ==
X-Received: by 2002:a05:622a:480c:b0:476:b7e2:385c with SMTP id d75a77b69052e-4771dd5d0e6mr84261721cf.2.1742604091376;
        Fri, 21 Mar 2025 17:41:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm18121731cf.0.2025.03.21.17.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:41:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvmva-00000001CZm-0pDT;
	Fri, 21 Mar 2025 21:41:30 -0300
Date: Fri, 21 Mar 2025 21:41:30 -0300
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
Message-ID: <20250322004130.GS126678@ziepe.ca>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
 <20250319175840.GG10600@ziepe.ca>
 <1034b694-2b25-4649-a004-19e601061b90@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034b694-2b25-4649-a004-19e601061b90@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_174133_144298_1EBDAB5A 
X-CRM114-Status: GOOD (  16.11  )
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

On Fri, Mar 21, 2025 at 12:52:30AM +0100, Marek Szyprowski wrote:
> > Christoph's vision was to make a performance DMA API path that could
> > be used to implement any scatterlist-like data structure very
> > efficiently without having to teach the DMA API about all sorts of
> > scatterlist-like things.
> 
> Thanks for explaining one more motivation behind this patchset!

Sure, no problem.

To close the loop on the bigger picture here..

When you put the parts together:

 1) dma_map_sg is the only API that is both performant and fully
    functional

 2) scatterlist is a horrible leaky design and badly misued all over
    the place. When Logan added SG_DMA_BUS_ADDRESS it became quite
    clear that any significant changes to scatterlist are infeasible,
    or at least we'd break a huge number of untestable legacy drivers
    in the process.

 3) We really want to do full featured performance DMA *without* a
    struct page. This requires changing scatterlist, inventing a new
    scatterlist v2 and DMA map for it, or this idea here of a flexible
    lower level DMA API entry point.

    Matthew has been talking about struct-pageless for a long time now
    from the block/mm direction using folio & memdesc and this is
    meeting his work from the other end of the stack by starting to
    build a way to do DMA on future struct pageless things. This is 
    going to be huge multi-year project but small parts like this need
    to be solved and agreed to make progress.

 4) In the immediate moment we still have problems in VFIO, RDMA, and
    DRM managing P2P transfers because dma_map_resource/page() don't
    properly work, and we don't have struct pages to use
    dma_map_sg(). Hacks around the DMA API have been in the kernel for
    a long time now, we want to see a properly architected solution.

Jason

