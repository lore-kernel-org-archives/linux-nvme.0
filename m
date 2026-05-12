Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB032CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlCkyynv9A3owqO3IQsLFXB9VjhnvszC1FYDWJErtQQ=; b=fr6q4/iWrwDSBUdn0bwQkMYv1I
	RNTttcYrzxV8OII/yxPds/t8CqfYUAk9G11rfZKnwglGNY0BykaaPJu63wFiJZSxDiPgyiJWdK4FZ
	03hlyJsyVy5rsPP2PKVo/OQ6Kx2o7w1ttmYBqeFgnMnwJLtc/DUxt90l02G7ISGVHzJjEAIto+vio
	4EqTecRzRc/Blo4ss5NVBveB7hhr2pLWT0POZiC2nsYdYP+k/IxjB1EV913JtjPVUtBT8yQ4Pr0hi
	4f19XOnK25Tg084PSY1yv2P0TlrNzriN8RncRy7WOAgJibuOkhlWlbpwuBvrfVIF852oLr5ZENeyo
	1QZu14cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnhu-0000000GwX4-36Ag;
	Tue, 12 May 2026 14:03:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnho-0000000GwVS-1Abk;
	Tue, 12 May 2026 14:03:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 54EE642B86;
	Tue, 12 May 2026 14:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F40C2BCF6;
	Tue, 12 May 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594606;
	bh=GjrbKqt7UhV0Fd7/x9yogisk1zMvp87XUhU2BO+jtOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX7jChaUGVKoBPZH/623LQEbqKANOyAyzsgX07zPjtXQUkJ9Hrc4sSMclR6oEhB9l
	 BBi153bMAkA/PjdEBfqppW9jl3rlG2FMvTmLqXZIylLYVnKt7xCBn12YQoWliOEqJo
	 e0aEXfKBLYqE3/bkb0iWwjKLOA1JDOY4uY0vRBpvmjjwK+tkbdmWxugDX0f9gvKg2T
	 prICu0IymXygx5olXk6vqboutJujjEscqoPhn7ZXhCQ4/fMwE/bbxB988pVIu+XmOA
	 q8sNTePhE4v4/589EAltLChYFbtotfWdqcBPpeeEN75hY2o51JK4Ajue4m2UmZK2sc
	 rub6PZ9aElcyA==
Date: Tue, 12 May 2026 19:33:15 +0530
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
Subject: Re: [PATCH v4 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Message-ID: <zaf2zeguq7oyrygv5fdokuo4w3btbcoysi2wmtyzremmdov3xe@reo3hnu7wpgi>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_070328_729791_7B59D43F 
X-CRM114-Status: GOOD (  25.95  )
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

On Wed, May 06, 2026 at 04:44:14PM -0400, Frank Li wrote:
> Introduce dmaengine_prep_config_single_safe() and
> dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
> combine slave configuration and transfer preparation.
> 
> Drivers may implement the new device_prep_config_sg() callback to perform
> both steps atomically. If the callback is not provided, the helpers fall
> back to calling dmaengine_slave_config() followed by
> dmaengine_prep_slave_sg() under per-channel mutex protection.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> chagne in v4
> - use spinlock() to protect config() and prep()
> 
> change in v3
> - new patch
> ---
>  drivers/dma/dmaengine.c   |  2 ++
>  include/linux/dmaengine.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 405bd2fbb4a3b94fd0bf44526f656f6a19feaad0..ba29e60160c1a0148793bb299849bccfebb6d32b 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1099,6 +1099,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	chan->dev->device.parent = device->dev;
>  	chan->dev->chan = chan;
>  	chan->dev->dev_id = device->dev_id;
> +	spin_lock_init(&chan->lock);
> +
>  	if (!name)
>  		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
>  	else
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index defa377d2ef54d94e6337cdfa7826a091295535e..23728f3d60804e49cd4cbbd3a513c4936eed5836 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -322,6 +322,8 @@ struct dma_router {
>   * @slave: ptr to the device using this channel
>   * @cookie: last cookie value returned to client
>   * @completed_cookie: last completed cookie for this channel
> + * @lock: protect between config and prepare transfer when driver have not
> + *	  implemented callback device_prep_config_sg().
>   * @chan_id: channel ID for sysfs
>   * @dev: class device for sysfs
>   * @name: backlink name for sysfs
> @@ -341,6 +343,12 @@ struct dma_chan {
>  	dma_cookie_t cookie;
>  	dma_cookie_t completed_cookie;
>  
> +	/*
> +	 * protect between config and prepare transfer because *_prep() may be
> +	 * called from complete callback, which is in GFP_NOSLEEP context.
> +	 */
> +	spinlock_t lock; /* protect between config and prepare transfer since */

Why two comments?

> +
>  	/* sysfs */
>  	int chan_id;
>  	struct dma_chan_dev *dev;
> @@ -1068,6 +1076,56 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
>  }
>  
> +/*
> + * dmaengine_prep_config_single(sg)_safe() is re-entrant version.
> + *
> + * The unsafe variant (without the _safe suffix) falls back to calling
> + * dmaengine_slave_config() and dmaengine_prep_slave_sg() separately.
> + * In this case, additional locking may be required, depending on the
> + * DMA consumer's usage.
> + *
> + * If dmaengine driver have not implemented call back device_prep_config_sg()
> + * safe version use per-channel spinlock to protect call dmaengine_slave_config()
> + * and dmaengine_prep_slave_sg().
> + */

Use proper kernel-doc comments please...

> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
> +			      unsigned int sg_len,
> +			      enum dma_transfer_direction dir,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
> +{
> +	struct dma_async_tx_descriptor *tx;
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_lock(&chan->lock);
> +
> +	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_unlock(&chan->lock);
> +
> +	return tx;
> +}
> +

Missing kernel-doc.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

