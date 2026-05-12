Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A551CD4F24
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDp+7TD2W513jjYY+Q6olEWbeSyiZgmTKvMRXJIHyn8=; b=iHqNFwYWnyxp2bSSnu+LLRM4RF
	z+I5V+kzbgQ2DgkRZQt7f9xKZrKogXARUGB8njq0CW9YwBhYB7McUg68GU6fHRgdxtQ+ywH76WbZH
	7NenNc2gGVDSz14em6cETg7qAg7lPX8zCdOjbqQswDlj4kBXcU8kacCxM0CtB+GnoYiafy95vKir8
	Y3ErorUOa5HtFJMwFH3MZlFntNMYEW4surN9jMnnZ1an3W3edVw2ub3LrRMASouggjpH5AuYVXb8/
	OtrrutaK+VxpPVIoRTvDX/AuefF0PatkXBgMhlKfAjWL78rgWV9AG5BSXmgqiekqpckhVlf9Hs5gQ
	q+F+ttFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnfU-0000000GvzR-0Fuz;
	Tue, 12 May 2026 14:01:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnfR-0000000Gvz5-45Pr;
	Tue, 12 May 2026 14:01:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 54A5C62C19;
	Tue, 12 May 2026 14:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9917AC2BCB0;
	Tue, 12 May 2026 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594461;
	bh=73KY+PJnQz0DVDO55WQRtqfL9KC8eXib5SBHC0nL4q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsrKNSBjdZ8JvOL/tIch5tetu7d3acvdP5ngcZ/dXyTCzoko34LlvoSPIZ9/qZlTh
	 egHfZkdRrTx0Uo21xIA5NrREt/v2pxE1tzGFKPJIfrK6gqDKzfGJ3R8bLpd6+VzY4G
	 gMNIe8FwHDcazuujib9FDMzNaCbiMrLeWcOVu3JN/Iwn4/zsD+wa3OsS8Yus8UGDMM
	 sSS8ohJOJOuDov8UFLtFUZUhUFBKXasF5J2Omz892ggz40wNHyHEIDI+ZLVcbpmo3L
	 IZAxFO9v/6onKxqq9P2tadE/BIjvjeMkudjmW/IkUThvGD/EhwRAkXAfDPmPOkfdLY
	 w5/HoxASJrzgA==
Date: Tue, 12 May 2026 19:30:37 +0530
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
Subject: Re: [PATCH v4 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <77s7y2zu5y2jtauczrqvdtedrhqsmtcnkic2zgm77xopcyazxm@xubtnmcppcni>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-1-85b3d22babff@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-1-85b3d22babff@nxp.com>
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

On Wed, May 06, 2026 at 04:44:13PM -0400, Frank Li wrote:
> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose and
> requires additional locking to ensure both steps complete atomically.
> 
> Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> and callback device_prep_config_sg() that combines configuration and
> preparation into a single operation. If the configuration argument is
> passed as NULL, fall back to the existing implementation.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

My only concern is that since these APIs are defined as 'inline' functions,
adding more code will end up increasing the kernel Image size.

- Mani

> ---
> change in v4
> - drop context in device_prep_config_sg()
> 
> change in v3
> - remove Deprecated for callback device_prep_slave_sg().
> - Move condition check before sg init.
> - split function at return type.
> - move safe version to next patch
> 
> change in v2
> - add () for function
> - use short name device_prep_sg(), remove "slave" and "config". the 'slave'
> is reduntant. after remove slave, the function name is difference existed
> one, so remove _config suffix.
> ---
>  Documentation/driver-api/dmaengine/client.rst |  9 ++++
>  include/linux/dmaengine.h                     | 63 +++++++++++++++++++++++----
>  2 files changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index d491e385d61a98b8a804cd823caf254a2dc62cf4..5ee5d4a3596dd986b02f1bce3078ca6c4c1fb45a 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -80,6 +80,10 @@ The details of these operations are:
>  
>    - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
>  
> +  - config_sg: Similar with slave_sg, just pass down dma_slave_config
> +    struct to avoid calling dmaengine_slave_config() every time adjusting the
> +    burst length or the FIFO address is needed.
> +
>    - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
>      peripheral. Similar to slave_sg, but uses an array of dma_vec
>      structures instead of a scatterlist.
> @@ -106,6 +110,11 @@ The details of these operations are:
>  		unsigned int sg_len, enum dma_data_direction direction,
>  		unsigned long flags);
>  
> +     struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction dir,
> +		unsigned long flags, struct dma_slave_config *config);
> +
>       struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
>  		struct dma_chan *chan, const struct dma_vec *vecs,
>  		size_t nents, enum dma_data_direction direction,
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b3d251c9734e95e1b75cf6763d4d2c3a1c6a9910..defa377d2ef54d94e6337cdfa7826a091295535e 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -835,6 +835,7 @@ struct dma_filter {
>   *	where the address and size of each segment is located in one entry of
>   *	the dma_vec array.
>   * @device_prep_slave_sg: prepares a slave dma operation
> + * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
>   * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
>   *	The function takes a buffer of size buf_len. The callback function will
>   *	be called after period_len bytes have been transferred.
> @@ -934,6 +935,10 @@ struct dma_device {
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
>  		unsigned long flags, void *context);
> +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, struct dma_slave_config *config);
>  	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
>  		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  		size_t period_len, enum dma_transfer_direction direction,
> @@ -974,22 +979,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
>  	       (direction == DMA_DEV_TO_DEV);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
> -	struct dma_chan *chan, dma_addr_t buf, size_t len,
> -	enum dma_transfer_direction dir, unsigned long flags)
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
> +			     enum dma_transfer_direction dir,
> +			     unsigned long flags,
> +			     struct dma_slave_config *config)
>  {
>  	struct scatterlist sg;
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
>  	sg_init_table(&sg, 1);
>  	sg_dma_address(&sg) = buf;
>  	sg_dma_len(&sg) = len;
>  
> -	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
> +	if (chan->device->device_prep_config_sg)
> +		return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
> +							   flags, config);
> +
> +	if (config)
> +		if (dmaengine_slave_config(chan, config))
> +			return NULL;
> +
> +	if (!chan->device->device_prep_slave_sg)
>  		return NULL;
>  
>  	return chan->device->device_prep_slave_sg(chan, &sg, 1,
>  						  dir, flags, NULL);
>  }
>  
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
> +			    enum dma_transfer_direction dir,
> +			    unsigned long flags)
> +{
> +	return dmaengine_prep_config_single(chan, buf, len, dir, flags, NULL);
> +}
> +
>  /**
>   * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
>   * @chan: The channel to be used for this descriptor
> @@ -1010,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
>  							    dir, flags);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> -	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
> -	enum dma_transfer_direction dir, unsigned long flags)
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +			 unsigned int sg_len, enum dma_transfer_direction dir,
> +			 unsigned long flags, struct dma_slave_config *config)
>  {
> -	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (chan->device->device_prep_config_sg)
> +		return chan->device->device_prep_config_sg(chan, sgl, sg_len,
> +				dir, flags, config);
> +
> +	if (config)
> +		if (dmaengine_slave_config(chan, config))
> +			return NULL;
> +
> +	if (!chan->device->device_prep_slave_sg)
>  		return NULL;
>  
>  	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
>  						  dir, flags, NULL);
>  }
>  
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +			unsigned int sg_len, enum dma_transfer_direction dir,
> +			unsigned long flags)
> +{
> +	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
> +}
> +
>  #ifdef CONFIG_RAPIDIO_DMA_ENGINE
>  struct rio_dma_ext;
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

