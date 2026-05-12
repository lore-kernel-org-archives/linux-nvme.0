Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E58CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AlZpbLfSaUrDMg9zIBxHBDs7klGRu58GhjpCt+/JOuQ=; b=diEpwlfNFvwk1P7nxhOZ0zR89l
	zZIju2pifvbrZjBQTCkVt66LTeLuc3pNzSeAWZ+j6tNuQtmivX1S2l6lpMq3XR2JPLlM0aZRB4aTg
	4V3MqJbdvvh/uRQCDVBk9ZP2n4RAxK7DUc9k7nsMLMQQBqv4SgXn1hons2GH27zylP7Jdrk+dQ9jM
	uNBQ/yj3XELNfZx94OoHCRjBGETCVIGtNXUbgR59cOlN02BxdgGFvHhA235x83aw9SoGmbpB9hwPt
	pj1gkw+YZUqzUcLCgtMM1BfB5AKk8QE0+yNk27wKJHRyDxKVhW+MigyYSygq4ol35nypv/7b2cHCh
	MJSvWUMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnjN-0000000Gx4O-2uHP;
	Tue, 12 May 2026 14:05:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnjM-0000000Gx37-18FT;
	Tue, 12 May 2026 14:05:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9410A62C1E;
	Tue, 12 May 2026 14:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D0C2BCF5;
	Tue, 12 May 2026 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594703;
	bh=BIPChrZ4UpoM72ZAiDAI8HWazP45rR6zIg1tu4Dy7mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8Dz+yxWS9Dm/bT6dOvuuuc2q6WwbWt7taRbZ9XzSnJHfGvP0dAO58m+EUdSUKVji
	 sky0xYgEuhBWzvsr8LRabQsufhrtiKDW0962BhkqyVcI0VW1Raio2h5OO/hQG8CYcw
	 m/updJZpr/GR/9a7F3gLP1OMBpJ0MW3n5K2W1A7jmV5sAP0EICEIjbJjSrCEBu+mc8
	 GtBal0WTjrsxrbPyuwajM0ib3d0ACQeC/NJL3DZnmZDvZnRji8dG0d5cu+g3KIG7pz
	 1qZTeiuE+RSSxPzRT8Asj6QdrfkpKtpZ0Bx2z6OgdG0eAICrcx7WnH1JHgO6DNPAD8
	 hGmE2ALMemKvQ==
Date: Tue, 12 May 2026 19:34:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Message-ID: <35yqgcks3umcplmqq4q5qpbyqmjn2j2utk2tsyz6lbbtkgx7bi@ndbu2timf2ok>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
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

On Wed, May 06, 2026 at 04:44:17PM -0400, Frank Li wrote:
> Pass dma_slave_config to dw_edma_device_transfer() to support atomic
> configuration and descriptor preparation when a non-NULL config is
> provided to device_prep_config_sg().
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> change in v3
> - rewrite dw_edma_device_slave_config() according to Damien's suggestion.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index f7f58b0010e26b529ffb7382d5b166a703587c71..ec6f6b1e482568a27ebe90852d5679672b24a1e9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  	return 0;
>  }
>  
> +static struct dma_slave_config *
> +dw_edma_device_get_config(struct dma_chan *dchan,
> +			  struct dma_slave_config *config)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (config)
> +		return config;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +
> +	return &chan->config;
> +}
> +
>  static int dw_edma_device_pause(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> @@ -385,7 +399,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  }
>  
>  static struct dma_async_tx_descriptor *
> -dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> +dw_edma_device_transfer(struct dw_edma_transfer *xfer,
> +			struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
>  	enum dma_transfer_direction dir = xfer->direction;
> @@ -472,8 +487,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		src_addr = xfer->xfer.il->src_start;
>  		dst_addr = xfer->xfer.il->dst_start;
>  	} else {
> -		src_addr = chan->config.src_addr;
> -		dst_addr = chan->config.dst_addr;
> +		src_addr = config->src_addr;
> +		dst_addr = config->dst_addr;
>  	}
>  
>  	if (dir == DMA_DEV_TO_MEM)
> @@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>  	if (config)
>  		dw_edma_device_config(dchan, config);
>  
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
>  }
>  
>  static struct dma_async_tx_descriptor *
> @@ -614,7 +629,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
>  	xfer.flags = flags;
>  	xfer.type = EDMA_XFER_CYCLIC;
>  
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>  
>  static struct dma_async_tx_descriptor *
> @@ -630,7 +645,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
>  	xfer.flags = flags;
>  	xfer.type = EDMA_XFER_INTERLEAVED;
>  
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>  
>  static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

