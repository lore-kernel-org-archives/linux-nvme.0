Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F536C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zI9S4WsJO+B3yWxo6LFa+TIs/4eBcMQ4GYanyGUlvgY=; b=JfeBRTXE0H+ar6n615djb8WaD9
	/EngSE9EYRGyNiXT1ZpINBS4aLsW9sCHOWOgADrOE3gkT5luwXBdcYRyAS65hrtAvlVuGgzhMGtKA
	whws2QDRy5d1pFU8OQfGkc7O3zy1bSYqKPiryWqZjq5tpbb2e/sgLWxqMBqnU9R5rinXC87ztrA97
	/LbmrKrEAAH7W56ZDFwxeVJiJfPUmabzXBGN27aVpBwxbeaTkOHBtgB8qmbt3NbUgPYzXkxrG+jYP
	0JoKBYnkISjVZl6I6EXLhkYNKJEdXAiSMssgbUgGZUFzDRoo8O99Yzje28Z9UtlwTvc6LUPF2NtV2
	6cIqqv5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGJ4-00000005Q7Z-3aES;
	Thu, 07 Mar 2024 16:09:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhu0L-00000000yYP-2jaC
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 16:20:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1908468CFE; Wed,  6 Mar 2024 17:20:23 +0100 (CET)
Date: Wed, 6 Mar 2024 17:20:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
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
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240306162022.GB28427@lst.de>
References: <cover.1709635535.git.leon@kernel.org> <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com> <20240305122935.GB36868@unreal> <20240306144416.GB19711@lst.de> <20240306154328.GM9225@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306154328.GM9225@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_082030_017849_1B682335 
X-CRM114-Status: GOOD (  27.62  )
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

On Wed, Mar 06, 2024 at 11:43:28AM -0400, Jason Gunthorpe wrote:
> I don't think they are so fundamentally different, at least in our
> past conversations I never came out with the idea we should burden the
> driver with two different flows based on what kind of alignment the
> transfer happens to have.

Then we talked past each other..

> At least the RDMA drivers could productively use just a page aligned
> interface. But I didn't think this would make BIO users happy so never
> even thought about it..

page aligned is generally the right thing for the block layer.  NVMe
for example already requires that anyway due to PRPs.

> > The total transfer size should just be passed in by the callers and
> > be known, and there should be no offset.
> 
> The API needs the caller to figure out the total number of IOVA pages
> it needs, rounding up the CPU ranges to full aligned pages. That
> becomes the IOVA allocation.

Yes, it's a basic align up to the granularity asuming we don't bother
with non-aligned transfers.

> 
> > So if we want to efficiently be able to handle these cases we need
> > two APIs in the driver and a good framework to switch between them.
> 
> But, what does the non-page-aligned version look like? Doesn't it
> still look basically like this?

I'd just rather have the non-aligned case for those who really need
it be the loop over map single region that is needed for the direct
mapping anyway.

> 
> And what is the actual difference if the input is aligned? The caller
> can assume it doesn't need to provide a per-range dma_addr_t during
> unmap.

A per-range dma_addr_t doesn't really make sense for the aligned and
coalesced case.

> It still can't assume the HW programming will be linear due to the P2P
> !ACS support.
> 
> And it still has to call an API per-cpu range to actually program the
> IOMMU.
> 
> So are they really so different to want different APIs? That strikes
> me as a big driver cost.

To not have to store a dma_address range per CPU range that doesn't
actually get used at all.

