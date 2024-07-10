Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A49C3DA45
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jul 2024 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQu9eN1e2F2Cfdkhv8ZV9riRn7gffplRUvSc+bjovss=; b=TuLYZVPeF1eyNLP3mlB7R4E9cA
	FnSj5zyHQtiEEupAykvOyqfRcGXEHzJHDIqEy2driscqCRbYiy4Y1ULCHAqwssWAg1A3mffuh5nnX
	Ty4SQpLbZxZuwkCBI5J+bGw/x7lmC6QufnBYDM4ag93GSEGMZEKFLCL45XoG9GV64YWLN29Vteqz5
	Q4RNeYsdC1pC/Sz+klG7a9HQlTohBBSMXoy1odDlAqsTJVZESBOojSbOz7NrtJIy6UlPNUmjn/rDW
	WIg1yZocf242rHDgYpKyZDEvxJtqnnsVAczZp2WC2ngFdtrOFSOJqQxApWUSWW6OlveOPfyboqhFE
	MLYJ4RAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRQnT-00000009bhd-1wcE;
	Wed, 10 Jul 2024 06:27:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRQnG-00000009bec-03hM
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jul 2024 06:27:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C935227A87; Wed, 10 Jul 2024 08:27:04 +0200 (CEST)
Date: Wed, 10 Jul 2024 08:27:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240710062704.GA25953@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal> <20240703143530.GA30857@lst.de> <20240703155114.GB95824@unreal> <20240704074855.GA26913@lst.de> <20240708165238.GE14050@ziepe.ca> <20240709061721.GA16180@lst.de> <20240709185315.GM14050@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709185315.GM14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_232710_218741_E2A59FC0 
X-CRM114-Status: GOOD (  27.06  )
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

On Tue, Jul 09, 2024 at 03:53:15PM -0300, Jason Gunthorpe wrote:
> > That whole thing of course opens the question if we want a pure
> > in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
> > way to migrate and allows to share code easily.  We can look into ways
> > to avoiding that more for drivers that care, but most drivers are
> > probably best serve with it to keep the code simple and make the
> > conversion easier.
> 
> My feeling has been that this RFC is the low level interface and we
> can bring our own data structure on top.
>
> It would probably make sense to build a scatterlist v2 on top of this
> that has an in-memory dma_addr_t/len list close to today

Yes, the usage of the dma_vec would be in a higher layer.  But I'd
really like to see it from the beginning.

> . Yes it costs
> a memory allocation, or a larger initial allocation, but many places
> may not really care. Block drivers have always allocated a SGL, for
> instance.

Except for those optimizing for snall transfer of a single segment
(like nvme). 

> My main take away was that we should make the dma_ops interface
> simpler and more general so we can have this choice instead of welding
> a single datastructure through everything.

Yes, I don't think the dma_vec should be the low-level interface.
I think a low-level interface based on physical address is the right
one.  I'll see what I can do to move the single segment map interface
to be physical address based instead of page based so that we can
unify them.


