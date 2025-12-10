Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D53D3B9AB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=5yMsgRQi6UiaSbA4vIty8SPZBWLU7FgAy5T/+tZKTOI=; b=EUk9AVtfkHyAuz
	dt3KxzAS4zxdL6G2GCjZd/3BdQFxX+LMvhvdrYqvbE6uEjkZfhLj3ref2GN24m/4OwlOlngSsg3OS
	+SEqYhI7bs830rW+DGqH4k9kLk2rk2xQ5F8ULqWAnwlxk4tCtkIlgrp0mt5ktiX+LsdRjoWNAN0RV
	Rl5BNXIUCvLj23gU/c5PujuiOU7BmcgKmHE6+eM2O+2/P4uPWsJwOYAFJ9L8GC52rJi4lTIBBgr4B
	dLWWUkkYQLUTV2Ky7QUF5xvpMu8WphPNl8hjomPJhXAwLyETBNBa4HEcE9ba6d5ODF4lo14A+IxDe
	dZtFbYjMpYLt8+ftXC3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTT5G-0000000FwzY-1oRP;
	Wed, 10 Dec 2025 22:54:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTT5F-0000000Fwz7-2597;
	Wed, 10 Dec 2025 22:54:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AF63A6011E;
	Wed, 10 Dec 2025 22:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48847C4CEF1;
	Wed, 10 Dec 2025 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407296;
	bh=8JOdnH8KktNBpZMvUsGFkBLybLSALb0U05AElB0cFO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BslJAJRjXviWwZqQk04+V3QQDrmDTUkC45Jv3BiKvpuSlqZ/PhPXfINN6TNP1FBgm
	 /O8W07PM1aA6dZ2tX/6MvQXI/QBbWxqhNWgL4PBWD+DEeKoZg2UlCQMAzGBqzRZsLc
	 6nktTVq8q2rOs+0zYDkmjN1NGbit7v1Ctr91smzqnKXl+30sGnTbooG+BRUK2cxrJv
	 Z2oxKn9y4kj1teNsPoUAIUq4GrQmvyGQ7rkWAZTZEorZTUi4MKzP4I11qOceqBXOwY
	 KG3c613LwXnUwUAQa2vxWvCSHJRR54w1+jqJnIRhD3GUy/iWVwj9WZi/MQtdjXBNrT
	 +q85oSr3ibLdA==
Date: Wed, 10 Dec 2025 16:54:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <20251210225455.GA3544539@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
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

On Mon, Dec 08, 2025 at 12:09:45PM -0500, Frank Li wrote:
> Use the new dmaengine_prep_slave_single_config() API to combine the
> configuration and descriptor preparation into a single call.
> 
> Since dmaengine_prep_slave_single_config() performs the configuration
> and preparation atomically, the mutex can be removed.

> @@ -386,22 +386,16 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(lock);
> -
>  	dma_dev = dmaengine_get_dma_device(chan);
>  	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
>  	ret = dma_mapping_error(dma_dev, dma_addr);
>  	if (ret)
> -		goto unlock;
> -
> -	ret = dmaengine_slave_config(chan, &sconf);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto unmap;
> -	}
> +		return ret;
>  
> -	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> -					   sconf.direction, DMA_CTRL_ACK);
> +	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
> +						  sconf.direction,
> +						  DMA_CTRL_ACK,
> +						  &sconf);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -423,9 +417,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> -unlock:
> -	mutex_unlock(lock);
> -

I don't know the dmaengine code, but it's not obvious to me what makes
dmaengine_prep_slave_single_config() itself atomic, since it doesn't
contain any locking.

Bjorn

