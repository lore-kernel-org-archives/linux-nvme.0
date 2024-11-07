Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10DFD43375
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPucvqyqUcoqOwZjTg+VmWRKh0S4L+FdZJigP4mqlw0=; b=VIAMRwK6j5hYHjkuejbNiKdBhO
	4u9idMWULPL9Itt3HoFcHlaAgRbi1QoYxZ9MeDn/IaaFmPNryBuAupAI3ErV0njBmW3gQc+xDj5Aa
	I57WyljGoncprgor32eGoBhAp3+70n0/7vznP4O7XpRTFlRxI4WG2LqrzF9wG/prOekkejiodBuc6
	pJLPIsjAdAV5GJAlb/KnVCsA4/yYmMhjiegM5zju+yi+thtzA1Vv3cmkmr+Ein9f5zhGEr/oloaGH
	itAhz2eZe90nkAIyQUFWtM1yV8cEaNIpWW+rwPW/EnvmbeAP4AHrkjQQWAdHExqmIgtJEmFN+g3Hx
	kShEkbgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9558-00000007YZu-2axS;
	Thu, 07 Nov 2024 16:10:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t92uA-00000007BGj-2ccG
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 13:50:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A292468C4E; Thu,  7 Nov 2024 14:50:25 +0100 (CET)
Date: Thu, 7 Nov 2024 14:50:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241107135025.GA14996@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <3567312e-5942-4037-93dc-587f25f0778c@arm.com> <20241104095831.GA28751@lst.de> <20241105195357.GI35848@ziepe.ca> <20241107083256.GA9071@lst.de> <20241107132808.GK35848@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107132808.GK35848@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_055034_832251_2F2033DC 
X-CRM114-Status: GOOD (  16.03  )
X-Mailman-Approved-At: Thu, 07 Nov 2024 08:08:32 -0800
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

On Thu, Nov 07, 2024 at 09:28:08AM -0400, Jason Gunthorpe wrote:
> Once we are freed from scatterlist we can explore a design that would
> pass the P2P routing information directly. For instance imagine
> something like:
> 
>    dma_map_p2p(dev, phys, p2p_provider);
> 
> Then dma_map_page(dev, page) could be something like
> 
>    if (is_pci_p2pdma_page(page))
>       dev_map_p2p(dev, page_to_phys(page), page->pgmap->p2p_provider)

One thing that this series does is to move the P2P mapping decisions out
of the low-level dma mapping helpers and into the caller (again) for
the non-sg callers and moves the special switch based bus mapping into
a routine that can be called directly.

Take a look at blk_rq_dma_map_iter_start, which now literally uses
dma_map_page for the no-iommu, no-switch P2P case.  It also is a good
use case for the proposed dma_map_phys.

> GPU driver
> 
> https://lore.kernel.org/dri-devel/20240117221223.18540-7-oak.zeng@intel.com/

Eww, that's horrible.  Converting this to Leon's new hmm helpers
would be really nice (and how that they are useful for more than
mlx5).


