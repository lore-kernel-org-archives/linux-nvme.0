Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE94FCD0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UJSS8BA9X0UP2+Wg0w5kBJO3sGzU7n6LMCo+X7jz+lw=; b=x57Pn9UeoMkGHK091RQ+k36guJ
	EfFVZcL5zjN4A4fhpLGT+gPrsIIunR+xl3RVB7CMDM1PRIXhGu88dvPlA+B+LRF03K651oFT2lDmd
	pI1gPrz+54CvaX1ste2zMfhRNNl9hPd1H6ahcg11Q12VDECH90iNHUO2TUp8KFrC+z62dE3reXHEC
	ZjhMDoVaUqZ5bc3eKRbP3qT4vFSjd3RR69MxRd0dVafsA9QYgKDvtaoGNpRlqTYjKKQRG4APyJzWI
	lWUWDNEACPPk3JEMOA75Hozx/JmxrQ/bGpiGLS4mKfUS6oZ0JmYzA84AOw6blNB/v3VYqsZuk44hK
	QgkURbSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2liM-00000007xWP-2qcq;
	Wed, 18 Mar 2026 07:53:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2liJ-00000007xW3-22qm
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 07:53:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68DD068B05; Wed, 18 Mar 2026 08:53:01 +0100 (CET)
Date: Wed, 18 Mar 2026 08:53:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	ahuang12@lenovo.com, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, iommu@lists.linux.dev,
	ionut_n2001@yahoo.com, john.g.garry@oracle.com, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, sagi@grimberg.me, stable@vger.kernel.org,
	sunlightlinux@gmail.com
Subject: Re: [PATCH 1/1] scsi: sas: skip opt_sectors when DMA reports no
 real optimization hint
Message-ID: <20260318075301.GA25589@lst.de>
References: <20260318074314.17372-1-ionut.nechita@windriver.com> <20260318074314.17372-2-ionut.nechita@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318074314.17372-2-ionut.nechita@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_005311_671908_21834BB6 
X-CRM114-Status: GOOD (  14.45  )
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

>  	if (dma_dev->dma_mask) {
> -		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> -				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +		size_t opt = dma_opt_mapping_size(dma_dev);
> +
> +		/*
> +		 * Only set opt_sectors when the DMA layer reports a
> +		 * genuine optimization constraint.  When opt equals
> +		 * dma_max_mapping_size() no backend provided a real
> +		 * hint — the value is just the DMA maximum, which is
> +		 * not useful as an optimal I/O size and can cause
> +		 * mkfs.xfs to compute invalid stripe geometry.
> +		 */
> +		if (opt < dma_max_mapping_size(dma_dev))
> +			shost->opt_sectors = min_t(unsigned int,
> +					shost->max_sectors,
> +					opt >> SECTOR_SHIFT);

This looks reasonable, but please also round down the opt value
to a power of two when you touch this anyway.

And especially with that this logic is complicated enough that it
warrants a little helper that is clearly split out.

