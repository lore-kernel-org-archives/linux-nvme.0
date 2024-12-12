Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AFEE77182
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+V4ulW501CFBe21acqtUchKrgLK8usvF5c/zK5VBIhc=; b=XT28PhMUFhprSolPG7l6FxTjtS
	C042K7uLhXR2I0UOa/MM7FmAmCBaWMC1oqI+UnoDLvnDiQT4cwxxa5i026KnY3nGMhZbfRrgDAB1V
	AOvYLlzKws5/dkytMq/N0LlXnRyZFO8YVZcLTsyPgF6kCo5vJ876qpdA7jPta4uMtxV3GwXuhtCuU
	3vNm3K50+S8DK3vdIekDW1DSKiJ5p2S4OXURqEtC/7y6TCyaziKpPWGgU95d1uPlJWTlZLGj8iSHr
	DlAITnK6AudmJgQCF+L8eXED8yWwi+pIiUz6H+a5ntHk7bwkxPBbKu9hL/qmmiZdRqT7UpTO7ue66
	qy+dxx5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLezw-0000000HOMT-3z4T;
	Thu, 12 Dec 2024 08:56:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLem1-0000000HLNx-3e3W
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 08:42:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B516068D1C; Thu, 12 Dec 2024 09:42:07 +0100 (CET)
Date: Thu, 12 Dec 2024 09:42:06 +0100
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
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 06/18] dma: Provide an interface to allow allocate
 IOVA
Message-ID: <20241212084206.GC9376@lst.de>
References: <cover.1733398913.git.leon@kernel.org> <e562e9a5c5107fae2345150e550e9e850dbe3c0c.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e562e9a5c5107fae2345150e550e9e850dbe3c0c.1733398913.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_004218_040293_26BC390D 
X-CRM114-Status: GOOD (  13.38  )
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

s/dma/dma-mapping/ in the subject.

> function call per API call used in datapath as well as a lot of boilerplate

Please trim commit messages to 73 characters so that they still look good
in git show output.

> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
> +		phys_addr_t phys, size_t size)
> +{
> +	memset(state, 0, sizeof(*state));
> +	if (!use_dma_iommu(dev))
> +		return false;
> +	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
> +	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
> +		return false;
> +	return iommu_dma_iova_alloc(dev, state, phys, size);
> +}

Now that dma_iova_try_alloc is the only caller of iommu_dma_iova_alloc,
maybe merge the two?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

