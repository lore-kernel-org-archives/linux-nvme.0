Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D36FD8770
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5r66x1dBCG1+Up9s69YhaML3E5lVW9KZpAlu66cVKo0=; b=tZU36UPNx8KwhJIE2aP5NuLSqe
	WX/pKhCAjz7lxqSvd8AsUnX9XVSFpk/K3cbn/z9G791Kg8gpj+zP2Dug5U+xA9VrOAxkZloKngx4e
	hKIQCfqLksWfGb56FcmUqCAa9za7xOTGoIDAeF5YMXDUpprsiK9KJY+x5J0bM3b4wQDn9ISkj/I1b
	EHIfbHPo8EwQAe+injXX2GRxbbj499scrEouu8qX0n06WFf97Jgw81H2IimVR79sH8mwyTqoq1GCz
	cfW9cq0/M5WpOCBM7AY6BDPOHvEmdHzeFDoiJxkvHzHhnCwhiP/K15ZWJ/Nt8zjccBUAOCEzK6/mw
	pRZaTzZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VC6-00000006XiM-0wNo;
	Tue, 17 Mar 2026 14:14:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VC3-00000006Xh7-3n2N
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 14:14:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7AD9368BEB; Tue, 17 Mar 2026 15:14:42 +0100 (CET)
Date: Tue, 17 Mar 2026 15:14:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, robin.murphy@arm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
	john.g.garry@oracle.com, ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 2/2] nvme-pci: handle dma_opt_mapping_size()
 returning 0
Message-ID: <20260317141442.GA3539@lst.de>
References: <20260316203956.64515-1-ionut.nechita@windriver.com> <20260316203956.64515-3-ionut.nechita@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316203956.64515-3-ionut.nechita@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_071448_085189_19C621E6 
X-CRM114-Status: GOOD (  12.32  )
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

On Mon, Mar 16, 2026 at 10:39:56PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After the previous commit, dma_opt_mapping_size() returns 0 when no DMA
> backend provides an optimal mapping size hint (e.g. IOMMU in passthrough
> mode with no ops->opt_mapping_size callback).
> 
> The NVMe PCI driver used min_t(u32, NVME_MAX_BYTES >> SECTOR_SHIFT,
> dma_opt_mapping_size() >> 9) to cap max_hw_sectors.  With a 0 return
> value this would set max_hw_sectors to 0, which is invalid.

... which means that if you want to change it, you need to combine
both patches into one to not create a regression.


