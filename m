Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DAAC369D9
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 12:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JBNjeFWNj+l9ru6mCK7IYz7qgtgjTXYNZBHsQZntGsQ=; b=a/bd7A0Akgy5XAmvtKb8qaPSpc
	biLio9HEChDWvJy3Q7CMnA8RNM+ibOXFN9M6/1fYM243M74/qQJegwADR8QlxSajSjr7BYV54+6x/
	LlrqU+MmrUIqXuUoo2EDhTzgESpfEpHIRSMIH1BU8oDzRhzrboye5TMHmulaH2KS8qcxMJpWDdjRs
	V9lWUyecafAL3j5dlmkfN2MMAsLhFHwZ1DW2msceqDoeyLk6JbjbW7YMeSKP3u5KyzhpYqNeuPb5k
	bXdtYO0pUe8vUmD6IS843mgDJgke1XhLDz1LQOBIwDppKKT57nzOcd7Kng4wUCPm0pZ9Ag1IBKivv
	r8PsUheA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vSC-0000000DzPw-1nAQ;
	Thu, 24 Apr 2025 12:13:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7sE9-0000000DOcJ-0cDv
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 08:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JBNjeFWNj+l9ru6mCK7IYz7qgtgjTXYNZBHsQZntGsQ=; b=MBsGIQLWnmLyK1NT3kI1016fXB
	DVqdnqqiX/03FB2a4VaEqcmjH8++K+v9aV2Es3I+kqzVcpRK7+lYWbGawpKa1J3LduraGQXQ1V5gu
	X7zLaIH1Q8QnrFziRG36d0AxpUv12EXaNhR6Ybq5gUmA5sKldfyCrvy2DaBSASHO09lbFT+R9u5xF
	+1BxLsMyr0UB9p09iT6nEx80r7fmdV3Bkz54jWOxI0d2+OXPHep19oU1cZJM8nA7qfm542rg4GvFi
	QWEv6s4jUxFlwMkXDnUGu647zqu+/0ezzE31u3Ns9Qug9eV5W+78eKsQO9l5fqRNXKrJgkGzNvM1k
	ePGzfHeA==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7sE5-0000000Bdii-48CU
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 08:46:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AF4F04A162;
	Thu, 24 Apr 2025 08:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4A0C4CEED;
	Thu, 24 Apr 2025 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745484392;
	bh=ki3q6dIyPVLY9OlwYT9gx2mvHOve0ih8UQqOIXQy4sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSR+lBTuzs9lAfUp6ETUwd/e83HDQBPN+bi2x6d+WcXRuXqISLxR1KnZmPcANDNPl
	 XcusVwWrcgl5ZwxaQMTClZZp6wv04VyBadsXr0ChBep2yGTn0yT6aRBkv0qe3YHnsu
	 Xbfy/GOWPkZiF5ouAX9EAiGXmE23jYsBtArkcpCT8edU46pm2SHyttUmmiowtlF9le
	 jBdsLZ0dV8tCc+abgC1OkQo4yqWtl296bgiFLL3P131EcMwOFukXU6T1YRIKWY0DCS
	 vfhRiecYS5EGzJ47VScGPAGcWrDrAIXqhECCrbNzQ/i5dx+Y8dYPFcg8gKvkI2s3k1
	 MO9hwaOX8jurQ==
Date: Thu, 24 Apr 2025 11:46:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250424084626.GQ48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
 <20250423233335.GW1213339@ziepe.ca>
 <20250424080744.GP48485@unreal>
 <20250424081101.GA22989@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424081101.GA22989@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_094634_385862_706F1EC2 
X-CRM114-Status: GOOD (  15.64  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 04:18:00 -0700
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

On Thu, Apr 24, 2025 at 10:11:01AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 11:07:44AM +0300, Leon Romanovsky wrote:
> > > I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> > > DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.
> > 
> > Thanks for the fix.
> 
> Maybe we can use the chance to make the scheme less fragile?  i.e.
> put flags in the high bits and derive the first valid bit from the
> pfn order?
> 

It can be done too. This is what I got:

   38 enum hmm_pfn_flags {
   39         /* Output fields and flags */
   40         HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
   41         HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
   42         HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
   43         /*
   44          * Sticky flags, carried from input to output,
   45          * don't forget to update HMM_PFN_INOUT_FLAGS
   46          */
   47         HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 4),
   48         HMM_PFN_P2PDMA     = 1UL << (BITS_PER_LONG - 5),
   49         HMM_PFN_P2PDMA_BUS = 1UL << (BITS_PER_LONG - 6),
   50
   51         HMM_PFN_ORDER_SHIFT = (BITS_PER_LONG - 11),
   52
   53         /* Input flags */
   54         HMM_PFN_REQ_FAULT = HMM_PFN_VALID,
   55         HMM_PFN_REQ_WRITE = HMM_PFN_WRITE,
   56
   57         HMM_PFN_FLAGS = ~((1UL << HMM_PFN_ORDER_SHIFT) - 1),
   58 };

So now, we just need to move HMM_PFN_ORDER_SHIFT if we add new flags
and HMM_PFN_FLAGS will be updated automatically.

Thanks

