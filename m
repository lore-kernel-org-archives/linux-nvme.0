Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F98CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4w5bQMB5oBiIu07qOaJ3RLjP1kDllrOpKav/m2ew6k=; b=wumbFP0mPNf2rjGDaorT1rguoo
	z9kQGrGR0UWAAISkJYCUlwvOvjoNhXDPMzBzMz3Bgl9SDfDvKyNu6/T1xalSlFAK9uPToE5RF+vwx
	3Y+zVxdMs1RB3pBCo2p7uI8rLAOuWePLefRjf9PG9gTqk3tD/uCpjsOM0qLYlxmezsq7Tw1qdV8j0
	ftZut2DeZ8pjj5k8OF+5DUqm1tjbd8F/gCH165wnIkTBcfyehUaXEKRTJq1OnB+StYbBZzoPGYXlp
	Eh7mTwJPOXbsUoiGPpeMuG++tOmZHFCZSyLJwM3IphhZV4VlWoX13xyebRIr/XovpfqmJXfZECWtE
	He/diXDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJBzE-00000008wZ9-06sY;
	Wed, 12 Nov 2025 14:38:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJBzB-00000008wYI-3HpM
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 14:38:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C790441776;
	Wed, 12 Nov 2025 14:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBA7C4CEF8;
	Wed, 12 Nov 2025 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958290;
	bh=3w+5TRvSRZNdSUCPnulOp1wUZx4xTqD2yLBq2QoKneQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPV1gENlHnzIHESu9BbF88ylyZanjfn8jyXO2haMRr2VQJBg9aoXf423Z9gkqjY1x
	 tubOVbg5LYUdW8AjO2MGOwFGsccdqID34Hc286+wxwQChN4kXumx+23xJNrSXbE9wz
	 EzmvMq5uLrz/2bMF3NUFbvADRocsT6jmsT+DKLAOUaxPLuEKAn/aQgurCazMx/8JL+
	 y+6xKFiyH6H52MjrsD0T1m+4Plcnb7a+qGABlPxs1XvuaZfWFhe1SVFYFLkqC2j65M
	 YgcRZFXP4H4LewlG+B+oZZgaQi4QBeVHqRa0XJ1ed+R1K76a1hC6/rUPMKIeCurBhq
	 sl06EsxKqIH9g==
Date: Wed, 12 Nov 2025 09:38:07 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <aRSbzwpS2AuP92_n@kbusch-mbp>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_063813_860308_A507D0ED 
X-CRM114-Status: GOOD (  14.31  )
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

On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
>  		return;
>  	}
>  
> -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> -					iod->meta_total_len)) {
> +	if (iod->flags & IOD_META_P2P)
> +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> +	if (iod->flags & IOD_META_MMIO) {
> +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> +		attrs |= DMA_ATTR_MMIO;
> +	}

This should be an 'else if' no?

> @@ -760,12 +783,20 @@ static void nvme_unmap_data(struct request *req)
>  		return;
>  	}
>  
> -	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
> +	if (iod->flags & IOD_DATA_P2P)
> +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> +	if (iod->flags & IOD_DATA_MMIO) {
> +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> +		attrs |= DMA_ATTR_MMIO;
> +	}

Same here.

> @@ -1036,6 +1067,17 @@ static blk_status_t nvme_map_data(struct request *req)
>  	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
>  		return iter.status;
>  
> +	switch (iter.p2pdma.map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		iod->flags |= IOD_DATA_P2P;
> +		break;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		iod->flags |= IOD_DATA_MMIO;
> +		break;
> +	default:
> +		return BLK_STS_RESOURCE;
> +	}

Why is it an error if the data isn't a P2PDMA type?

> @@ -1058,6 +1100,17 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
>  						&iod->meta_dma_state, &iter))
>  		return iter.status;
>  
> +	switch (iter.p2pdma.map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		iod->flags |= IOD_META_P2P;
> +		break;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		iod->flags |= IOD_META_MMIO;
> +		break;
> +	default:
> +		return BLK_STS_RESOURCE;
> +	}

Same here.

