Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B71EFCD9A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QZNnrKZleJxX1z1TzknkDHHZ6NkSyKVLLXuqB64ZhbQ=; b=Zc5J61Xtwv8d/vKImHY7WcPXPw
	75t3X9gQm0t4uCbZVUJzfCw54A7Bsj9uv6zBCnYk6cjRM/j+jGdyekA+MCtWz+C+QFJYMa4v9Tvyw
	6tx7LuCHbIICWi1QnDi1d1JO5qrnvDWR0b+K5dZ+kR+hCKC3qcZ6XHAnrFaLlUeTpq7sZuzKSvhD0
	WKwX7VkweeWrifSYrCUN5IlqRD8BnDyi3jmq6YlDqrkFtcTrFBK4cMYdOPRQuC2eMJRTrMcnpF3D5
	anF6NfvtcTZcDaUUS8Pl81im6Ddj8WliwE/YK0qHEfcD1QEDHS25Nf01l8OJ2HzQHLiRN607wjfhZ
	E2CoIYsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzYQ6-000000078P9-1VuR;
	Mon, 09 Mar 2026 11:05:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzYQ4-000000078Nx-2GOs;
	Mon, 09 Mar 2026 11:05:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A0C66013E;
	Mon,  9 Mar 2026 11:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6435C4CEF7;
	Mon,  9 Mar 2026 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773054303;
	bh=wEz8Ozl7d1i2Iil0NevpMKFEd8sHrDQan1sUFVnc2jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXIOX4YTIHM87gvY4gOrptvS37DMMvPE1iDdRiW0VDS+X9LpNC1KxxZ+qWSOOkWU7
	 RgJsIjAvzv8p4ooQtA0D45b1dlQGZ1MbUN6T1Un2cjJ17JMUYFmaaZKOItIdYGCPrt
	 J9FNMn0WlSxn0w0D2zzhpSD1dtXG025bcG/J+IFLBht9EIn4w/xj78dt6UMkUkN2J6
	 VDJrjG7fwuJ3btdrXogdNq2lZTs0OWIPPd0pJYZoSjkPCoJt/m6Qv/fOHBZVVGcF6j
	 asZXADR3ahoAmxn6AxQAisPLrDwvDvCNJF8n4E4Xy8SVMnhD/s4QjANpLPnp2TBhvv
	 xjkSaeQDoyosw==
Date: Mon, 9 Mar 2026 12:04:59 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <aa6pW-zpxnrZnfPn@vaman>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
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

On 18-12-25, 10:56, Frank Li wrote:
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
> Add a new API dmaengine_prep_config_single_safe() and
> dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> implement callback device_prep_config_sg().

Okay to add API

> +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, struct dma_slave_config *config,
> +		void *context);

Do we want to have drivers implement one more callback. It does not make
sense to me. Why not handle this in framework and have it call the
respective lower level APIs.

Drivers should implement simple apis and collectively the functionality
can come from the framework.

Would you consider revising as such. Bonus all existing drivers can
start using this API, no change required for drivers in that case


-- 
~Vinod

