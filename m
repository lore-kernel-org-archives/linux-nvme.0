Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F0E77180
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ot48Ik4V4v5EQENxhTEcEi66UwS0ekYW2KvZvqQWfBA=; b=OAsCega285TL+LxUIezIsMRyHd
	ksLEQI6+u0VLtM3SvcVGnwILD+3KPasbJKdiC9UgUqs6/dm19BlgP3DVSUAKrs/EenPuypY2i73Za
	XGYChGSV3Z9dIpWi2JhOyj1yfxsyQuyWxtWph/ritlm5z5i2xlcVpGnf1r8iziIaNDHd0nETLQDlN
	iL/uTJmSiUFuSDThRsaN3FU5GG/jJcUeyZ17Nc1vI1B9SPI0ISzEDBD5y1H8Pny+c3OVY/4ZZvj7o
	WRqG833ZviRwt1bRm4n5UJ+YnA9IZDeebdA5VQSMr44xp558B0HfLbF0nqXdgFvOQI7R3rBzWupMR
	Xy0anp8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLezv-0000000HOLi-35OR;
	Thu, 12 Dec 2024 08:56:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLedL-0000000HJdC-1v2d
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 08:33:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FDD768D0E; Thu, 12 Dec 2024 09:33:12 +0100 (CET)
Date: Thu, 12 Dec 2024 09:33:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 04/18] iommu: add kernel-doc for iommu_unmap and
 iommu_unmap_fast
Message-ID: <20241212083312.GA9376@lst.de>
References: <cover.1733398913.git.leon@kernel.org> <da4827fda833e69dbe487ef404a9333c51d8ed2e.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4827fda833e69dbe487ef404a9333c51d8ed2e.1733398913.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_003319_628608_08DB01EF 
X-CRM114-Status: GOOD (  14.76  )
X-Mailman-Approved-At: Thu, 12 Dec 2024 00:56:29 -0800
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

On Thu, Dec 05, 2024 at 03:21:03PM +0200, Leon Romanovsky wrote:
> +/**
> + * iommu_unmap_fast() - Remove mappings from a range of IOVA without IOTLB sync
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @size: Length of the range starting from @iova
> + * @iotlb_gather: range information for a pending IOTLB flush
> + *
> + * iommu_unmap_fast() will remove a translation created by iommu_map(). It cannot

Please avoid the overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

