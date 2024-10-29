Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7500D3E2D0
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ey/h1UWH4PsNFprB/VIDBkwWQ4/GYp79V4On9mrOAm4=; b=rt+raVnKvNDJnUHOUCvB1TjBBZ
	6A1cp2HpFwR3SotTcNvrqucjeHPw+Yz+L8cT46oAO1G9yRFBqA2EwnDBuVdI1Jnn4Z0+CJDdUKCq7
	IlTihTTo7vcm6v0SfMvgyPV1ik4M590X2vF6GGqrs91WGhCRFyLnkqVTRFrNgZmwxchi6kkmMRT74
	5c9t45B2vU7CJuzGWrGJ4AYLJLLDqrO1FYwzJIy++1jatCz9KaQArPkKcsvOf7SyqFX0Fzp0dfVqg
	UcptlSPQ3xi3IpmnqExwffci+COuwYHAeyr2MSTP4nz+Gebvtzu+/H1YJHZ0fBuOuyEkAc6N7j1Sb
	+Awfuxcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gyu-0000000DZZC-0CQp;
	Tue, 29 Oct 2024 07:49:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gw2-0000000DZ4E-0rms
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 07:46:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1051227A88; Tue, 29 Oct 2024 08:46:31 +0100 (CET)
Date: Tue, 29 Oct 2024 08:46:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
Message-ID: <20241029074631.GD22316@lst.de>
References: <cover.1730037276.git.leon@kernel.org> <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org> <25c32551-32e2-4a44-b0ae-30ad08e06799@linux.intel.com> <20241028063740.GD1615717@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028063740.GD1615717@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_004638_406901_BFD1D98A 
X-CRM114-Status: GOOD (  14.54  )
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

On Mon, Oct 28, 2024 at 08:37:40AM +0200, Leon Romanovsky wrote:
> In this specific case, the physical address is used to calculate
> IOVA offset, see "size_t iova_off = iova_offset(iovad, phys);" line,
> which is needed for NVMe PCI/block layer, as they can have first
> address to be unaligned and IOVA allocation will need an offset to
> properly calculate size.

And that is also very explicitly spelled out in the kerneldoc comments,
including the note that the physical address is optional if the
transfer is granule aligned (actually it says PAGE_SIZE which should
be fixed).

Any suggestions to further improve it are welcome of course.


