Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14743C2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCNTWVYaP51zgkYgTkFQITxMZCYoN3ocgkKQSV5XmJ4=; b=1GMiKqZl7n0757TyWx3/JCfDOB
	jmSgMrfiaKTRMUoRggSuOB4qatkPK64oSS47l4OJk2C/YL+vv6UkyjQr11jqseQOiHhxiTlfbaxG1
	IBEBsHuMspj7vpV95EXgApkVwkSjU/GHg3Fzang36V4D6HKd5FwyXEo8M5yXAigTaHuDA+aCxjhEE
	/9c+fu5vEdEEJYNc4u7ChYj+YB9p0NDFBm2MhN3tgYsEr5NcuCyMIfAqJi4LHZf5u5SLJRPXhqVkV
	aGqtU7ITcp2tYJ9GDWrdZOOp2YnW3X1YGCssm7GVzw2xj0Yk9luW1m0+tdMf4bBi5W1IVX7Cak6/F
	jFUs0j3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4AP-000000062Mh-2V6E;
	Tue, 09 Jul 2024 06:17:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4AL-000000062LE-36Jz
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 06:17:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52C0568AFE; Tue,  9 Jul 2024 08:17:21 +0200 (CEST)
Date: Tue, 9 Jul 2024 08:17:21 +0200
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
Message-ID: <20240709061721.GA16180@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal> <20240703143530.GA30857@lst.de> <20240703155114.GB95824@unreal> <20240704074855.GA26913@lst.de> <20240708165238.GE14050@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708165238.GE14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_231729_944471_946B5562 
X-CRM114-Status: GOOD (  23.42  )
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

On Mon, Jul 08, 2024 at 01:52:38PM -0300, Jason Gunthorpe wrote:
> Ideally we'd have some template code that consolidates these loops to
> common code with driver provided hooks - there are a few ways to get
> that efficiently in C.
> 
> I think it will be clearer when we get to RDMA and there we have the
> same SGL/PRP kind of split up and we can see what is sharable.

I really would not want to build common code for PRPs - this is a concept
very specific to RDMA and NVMe.  OTOH more common code SGLs would be
nice.  If you look at e.g. SCSI drivers most of them have a simpe loop of
mapping the SG table and then copying the fields into the hardware SGL.
This would be a very common case for a helper.

That whole thing of course opens the question if we want a pure
in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
way to migrate and allows to share code easily.  We can look into ways
to avoiding that more for drivers that care, but most drivers are
probably best serve with it to keep the code simple and make the
conversion easier.

> I'm also cooking something that should let us build a way to iommu map
> a bio_vec very efficiently, which should transform this into a single
> indirect call into the iommu driver per bio_vec, and a single radix
> walk/etc.

I assume you mean array of bio_vecs here.  That would indeed nice.
We'd still potentially need a few calls for block drivers as
requests can have multiple bios and thus bio_vec arrays, but it would
still be a nice reduction of calls.


