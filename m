Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5228ACD4F54
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=opPhjbjQEeWL5KlTSvnzXJVotSy/MVUMCHX6ZdnxBtU=; b=lunLwZ/xLr6tylfMYrqhwgiIA0
	fEwJ2Vn/fFoA0YDxSg2f2IZgtSlQo6sL0FZc2MWPNLNVsXNNSt2Ub9aIWytRFfsgl5ocnDlUXbaoH
	XttKwekV+v9SZ6ePNV7VN60xeCTwF/3lJXbOXqUeqB0cOLSjtGxjJ+35UfZsIXhbgjNyQi9Grf1RB
	Rt2bxxtxX3qJYuwHCA2lb5eRagJIq6J5QiZilZ/XkMsNCF99GQtKn7kCEWq8rb3zB+70wHYq0bl/Z
	++CViQrBDT0nE2/+4D04Jzl+otIrVYc/x+KXgeft8cFdfe/Z0of8QmbPmEpljMNOtD263EnE8I6za
	98nbmE1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPT04-00000002y7y-3Tdv;
	Tue, 19 May 2026 22:33:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPSzz-00000002y2D-3nwx
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 22:33:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ACA4060232;
	Tue, 19 May 2026 22:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A08E1F00893;
	Tue, 19 May 2026 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229993;
	bh=opPhjbjQEeWL5KlTSvnzXJVotSy/MVUMCHX6ZdnxBtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sq3DsqF5RpFkImx7gupb5z7wM0oAdHW1KDHKTDlTIoHPFvBMVViKzOWjPEwHAAzOe
	 WNE/CzL5Or17DNQDxhKUPVcinwrHJlyjTrXfxMudJRYdiegOelg3u1qpkEdbj9+7gj
	 WQPgxUNuR/WNjSbm48A5xC98qQ/KJpHs3K5g5ppcFpeLSnOLCmXS/6kqDZS63V/f56
	 xadmdtFA8UrFm7k7uxHt5ASLC81kJr24bFAK+5ZssGfHWcXhjlhg11VS63b+D8l5rk
	 avxJ3e/ATHxrYPKza8G6iMStgVI0/ZMtvJMLssAS+XJUUxXFQPnQdTwNYSdhOiR5xT
	 b9m5ML6DFMp5g==
Date: Tue, 19 May 2026 16:33:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH] nvme-pci: fix dma mapping leak on data setup error
Message-ID: <agzlJ5pRyofyeVh8@kbusch-mbp>
References: <20260519200614.755159-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519200614.755159-1-kbusch@meta.com>
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

On Tue, May 19, 2026 at 01:06:14PM -0700, Keith Busch wrote:
> -	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter))
> +	if (!nvme_pci_prp_save_mapping(req, nvmeq->dev->dev, iter)) {
> +		dma_unmap_phys(nvmeq->dev->dev, iter->addr, iter->len,
> +			       rq_dma_dir(req),
> +			       iod->flags & IOD_DATA_MMIO ? DMA_ATTR_MMIO : 0);
>  		return iter->status;
> +	}
>  
>  	/*
>  	 * PRP1 always points to the start of the DMA transfers.
> @@ -1112,6 +1116,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  	dev_err_once(nvmeq->dev->dev,
>  		"Incorrectly formed request for payload:%d nents:%d\n",
>  		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
> +	nvme_unmap_data(req);
>  	return BLK_STS_IOERR;
>  }
>  
> @@ -1155,8 +1160,13 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
>  
>  	sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
>  			&sgl_dma);
> -	if (!sg_list)
> +	if (!sg_list) {
> +		dma_unmap_phys(nvmeq->dev->dev, iter->addr, iter->len,
> +			       rq_dma_dir(req),
> +			       iod->flags & IOD_DATA_MMIO ? DMA_ATTR_MMIO : 0);
>  		return BLK_STS_RESOURCE;
> +	}

Oh, these need to check dma_need_unmap() first. I'll send a v2.

