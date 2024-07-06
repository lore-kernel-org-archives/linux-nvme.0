Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B0FC2BD09
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jul 2024 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJjvC1mF0q7aqcVpwtDwuOCzqnQ0w4rL5HfWLZFRs+E=; b=19h3TYhDhnP4Par/70JxUpXQVg
	wcNHbhfH2leJneobcGGEe+ib7j4E9OslheSlnMsdHmpkSZt7LqET1PDkMlTikyhm5up3e3/kmsGo+
	yxBAqHbNElWa+1tczQOaVAmBarzfCstr34Ac7LD4Y0sDIEsDHQWksVel/ID48oV3LQPsY2M4tGKlS
	+oM2oFF2pkwm18/zBXBGyKnifd15IMOoKkGAh1Vdui61io3VNHEBJItzbiqvCw0L8AkGTwt1sFVXP
	4cxu2mINPS6J/bKZHHBk9i3UpKJgGHJGCbrImJeVGlk4yhNqm03vQ4gDFxSiUiVPHEGYw8UD0K61d
	mdGWt2Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPzeZ-0000000HSaS-38hI;
	Sat, 06 Jul 2024 07:16:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPybL-0000000HOcI-1qs9
	for linux-nvme@bombadil.infradead.org;
	Sat, 06 Jul 2024 06:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FJjvC1mF0q7aqcVpwtDwuOCzqnQ0w4rL5HfWLZFRs+E=; b=LEz0h5gOMssF3VOfbLwrwOB0HN
	CuHqaH2jDu2ee2V/C6MkKgmOzIR3iZzyaOWA26Yc0StcixRU1eJsSVhCCQU1BPbF/NYZTd/DRMEJZ
	MynFupFcGciw2n4c0FjplhwCAm9CG0MVHTB89xN6zPHg/fj569gv8EJKNAaPPlY3efXpz5K0OkHWE
	ZcklQuQFgftDVich/bkPlBY4yzjajRoF+NXXMClp2RvQC6ey83GJqEps0mjAF9cDFgmRIHW83bCop
	QFvudn53LYv5Xj1kBdz27xQKLPS9WCDhg4HirO71Hum3KQGDwyrzK8P3jgkc1zEfxgyT/HzUUOsPQ
	QSQwIqjQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPyb0-0000000AP99-3ZJ5
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jul 2024 06:08:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FCD868D0E; Sat,  6 Jul 2024 08:08:19 +0200 (CEST)
Date: Sat, 6 Jul 2024 08:08:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [RFC PATCH v1 18/18] nvme-pci: use new dma API
Message-ID: <20240706060818.GA13470@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <47eb0510b0a6aa52d9f5665d75fa7093dd6af53f.1719909395.git.leon@kernel.org> <249ec228-4ffd-4121-bd51-f4a19275fee1@arm.com> <20240704171602.GE95824@unreal> <20240705055806.GA11885@lst.de> <20240705184846.GF95824@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705184846.GF95824@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240706_070845_159190_437CBE34 
X-CRM114-Status: GOOD (  11.37  )
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

On Fri, Jul 05, 2024 at 09:48:46PM +0300, Leon Romanovsky wrote:
> In that case the flow is dma_map_sg()->iommu_dma_map_sg()->dev_use_sg_swiotlb().

Even for that you'll still need to check the first and last entry
for being kmalloc misaligned if we assume that all middle entries are
aligned (which for NVMe they have to, but we're probably better off
figuring out a way to enforce that).


