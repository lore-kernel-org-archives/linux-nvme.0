Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D4CD5BA4
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMysT48ee3tLKAEa46f61lSngBAw19LG9Xn+jm2jKTM=; b=rfauszLHjR7GfMYea2sR0y48g9
	OOjsE3Pl9JOX+5a94J4gp2zA1I5+aT54bfmhROG7xEcyabkBlCx9gm0/8B7ejCqtLL/X3auD2+c1B
	Vdbl55+jz+NAy/DZqi40Nlx5gWB5Q7KEVrqQdJh8e5dmwv/4ck1X6VWbg0oeUilWPLNQt4RAC3JHx
	mKALcwv/S9FkCG7m4X0Z5E8YrTXizivKX+3NH+k+BGbY1FUtPVka3BTtbdFFVR23mvhUGwERitkbq
	zhMGKcy2izXm15IVVAHa5CnbHYuXIfAn2/UHREEWKioPWinEj+ozFiu+myDIXx8qoI/XDhXQxtZOe
	7yMek4iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPygh-000000077as-1N2v;
	Thu, 21 May 2026 08:23:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPygb-000000077Ww-09nJ
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 08:23:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6411568BFE; Thu, 21 May 2026 10:23:18 +0200 (CEST)
Date: Thu, 21 May 2026 10:23:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/2] nvme-pci: fix dma mapping leak on data setup
 error
Message-ID: <20260521082318.GB10917@lst.de>
References: <20260520174953.2989852-1-kbusch@meta.com> <20260520174953.2989852-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520174953.2989852-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_012321_218031_9A62432C 
X-CRM114-Status: GOOD (  12.88  )
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

On Wed, May 20, 2026 at 10:49:53AM -0700, Keith Busch wrote:
> +static void nvme_unmap_iter(struct request *req, struct blk_dma_iter *iter,
> +			    struct dma_iova_state *state)
> +{
> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +	struct device *dev = nvmeq->dev->dev;
> +
> +	if (!blk_rq_dma_unmap(req, dev, state, iter->len, iter->p2pdma.map)) {
> +		unsigned int attrs = 0;
> +
> +		if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> +			attrs |= DMA_ATTR_MMIO;
> +
> +		dma_unmap_phys(dev, iter->addr, iter->len, rq_dma_dir(req),
> +			       attrs);
> +	}

At some point this might be worth lifting to the block layer, but we
can defer that until needed.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


