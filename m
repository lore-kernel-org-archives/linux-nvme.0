Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B92E68960
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zxxDLg2if/+U13TgxLiwEWEZYEmxIoG3404sioeF7p8=; b=Q9JkXd9HYfhukQ8PywbYguFIcO
	PDzqFWMKt6cNBEWYOWRZVCy/ufrFs9mIw7PA8VAplLSfzCWL4we0WtUGNbaBjYKHiD41I+fV5Atx+
	xmmCqdnZlcNQzLsGQon82/OGxlN8+dUhZbBJQwVXu6VSQ+/rZlRRxZoAEnRwXawcJ/diU43pYaxFG
	pBTMmxK/JtEadRl6NV5yU9ZjJuGe3+G2qksa5priouBBZGiqaDyccP8vY3GmauSvm3WfiJC7RgqHl
	g4skOv9Z2CgAjpuZSEdBOY/Axs7S869HTu+jLLEGnnSKrT11fHqQFbx5uVbmeGglJFfKgNWqJe7Bx
	9Q7evCGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RMo-000000033yG-2p7i;
	Thu, 31 Oct 2024 09:21:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RMl-000000033xl-3vIe
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 09:21:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0872F68B05; Thu, 31 Oct 2024 10:21:14 +0100 (CET)
Date: Thu, 31 Oct 2024 10:21:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241031092113.GA1791@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk> <20241031083450.GA30625@lst.de> <20241031090530.GC7473@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031090530.GC7473@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_022120_135689_084AAB6D 
X-CRM114-Status: GOOD (  17.14  )
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

On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
> This series is a subset of the series you tested and doesn't include the
> block layer changes which most likely were the cause of the performance
> regression.
> 
> This is why I separated the block layer changes from the rest of the series
> and marked them as RFC.
> 
> The current patch set is viable for HMM and VFIO. Can you please retest
> only this series and leave the block layer changes for later till Christoph
> finds the answer for the performance regression?

As the subset doesn't touch block code or code called by block I don't
think we need Jens to benchmark it, unless he really wants to.


