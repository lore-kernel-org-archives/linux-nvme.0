Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38FFD68B3D
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kre1M17FzdrVfaaiZ6LgesrPos9zd3u1UPS3fIa+Xs=; b=HBgbLkDb5K3buVs3k1/wjuhGQM
	WOtEY4WS5VLYKvnb9OJEUrXR4vjT+WolaaAvilKW3jm6S2z8PgeDNU05ux1r7jhglE5vCLh6jnYVk
	FjVR9PcCowYbA0NeIf8CjNfnTAs6lVV75OrKmWILlAxFmJGPJIT+uVVBTWwoyCM6bkpNAMBblc55S
	zUT53vSfRkz/WE+eZ3/m1idQk4rnasNlpWGZ3wVqz/AlBop/yMKZa/E5A69BzKnAMAfnkXGNkd5uX
	eutmKHcBO1YcZUVqPsJ0JVheM8mySzLJq+6BPhW0MjWvYrmne1ZeQwPu1BjJGQAzlrYimUAfrQaxg
	CtCqm/jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBdF9-00000000FR1-1Hab;
	Thu, 14 Nov 2024 17:02:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBdF6-00000000FPx-2qvH
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 17:02:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51BBB68C7B; Thu, 14 Nov 2024 18:02:47 +0100 (CET)
Date: Thu, 14 Nov 2024 18:02:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, ill Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 00/17] Provide a new two step DMA mapping API
Message-ID: <20241114170247.GA5813@lst.de>
References: <cover.1731244445.git.leon@kernel.org> <20241112072040.GG71181@unreal> <20241114133011.GA606631@unreal> <20241114163622.GA3121@lst.de> <20241114164823.GB606631@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114164823.GB606631@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_090252_876466_D4E41D63 
X-CRM114-Status: GOOD (  21.59  )
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

On Thu, Nov 14, 2024 at 06:48:23PM +0200, Leon Romanovsky wrote:
> It is fine, but as a bare minimum, I would expect some sort of response,
> so I won't sit and wait for unknown date when this API will be acknowledged/NACKed.
> 
> I would like to start to work on next step, e.g removing SG from RDMA,
> and I need to know if this foundation is stable to do so.
> 
> > 
> > No changs to dma-iommu.c are going to get merged without an explicit
> > ACK from Robin, and while there is no 100% for the core dma-mapping
> > code I will also not merge anything that hasn't been resolved with
> > my most trusted reviewer first, not even code I wrote myself.
> 
> And do you know what is not resolved here? I don't.
> All technical questions/issues were handled.

Let's just wait a little bit, we're all overworked can't instantly
context switch.


