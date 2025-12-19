Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B26D767CB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjayKuqVLWDIo7A3OJvcFGeeRhpR+qJsPK3CDegnWjk=; b=uIDNOv099v07qPEJAN2oAdV34O
	5hUJH+JgzofhI15S1vbbvSVS8FLq/EwefVKSh7ui2MqM9LRFtzQHqvvjSnx8UY99oYuyXgaMa817o
	x6uN9jvwz/m7dkd+2xGZP0Ux1cNTNWLiawS1cmxvNBt8/iWCkuvPlzSa5a4rGJchkp/1XhCZmEhzx
	56zP3gQ7DaCy7+c6PdRbFFxegbeQC5z4I1To5KJJ9BgaW0DlIT4aZHXe49XryL6ierNh+1ZnC8RlM
	5Tj4Ofi2fvvsi29iObJbXnYYYwcqXXLfv2yX0/rsXtvBEECP+dhM4rYnIrgUn5A9KPVMijKQLhniy
	cu2gnJDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXsE-0000000A7o6-2iaR;
	Fri, 19 Dec 2025 10:38:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXsC-0000000A7mC-3hFZ;
	Fri, 19 Dec 2025 10:38:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C7E260008;
	Fri, 19 Dec 2025 10:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF531C116B1;
	Fri, 19 Dec 2025 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140691;
	bh=TKxHdYDWPMHS6PrRcH0CtD5eVxCTGhtjbjlyqik0m/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E1fDJI5JmYCCrnC3Xi03l3Q/ACQw/BfazpJ2GrSaVBNYE1cxHPCne/bMKl6nRjQCE
	 BjlcE+Zj/3/p6G6izv1O0fbpSDHB+WUyZMHxi4uvr6UvZpzPY38mnUbffSAzWsUNg4
	 6RJ4OTerbo7WCvZUwsncP7NuxFyc2gLAsEU4+fcGHjlwfsfQ4ggN1T7nIRn5DALMmT
	 cn2KCeJ6y3NJGbqjngYwSwDKIpouXL9u/OavqvqM8/f2gGeQAA14yPlCN3rY0lsrAu
	 GyPDm5PMwLDio+dRAalT1cEMVpLQSMHIVN6sUW4pxp79UT3/hzW+Xj7xpE+9ygtjA8
	 mIWWZ/t+CRV5g==
Message-ID: <bff84f52-a23c-4a76-977b-9deb2306b154@kernel.org>
Date: Fri, 19 Dec 2025 19:38:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-4-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-4-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/19/25 00:56, Frank Li wrote:
> Pass dma_slave_config to dw_edma_device_transfer() to support atomic
> configuration and descriptor preparation when a non-NULL config is
> provided to device_prep_config_sg().
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index e005b7bdaee156a3f4573b4734f50e3e47553dd2..1863254bf61eb892cb0cf8934e53b40d32027dfa 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -230,6 +230,15 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  	return 0;
>  }
>  
> +static struct dma_slave_config *
> +dw_edma_device_get_config(struct dma_chan *dchan,
> +			  struct dma_slave_config *config)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	return config ? config : &chan->config;
> +}

I would rewrite this as:

static struct dma_slave_config *
dw_edma_device_get_config(struct dma_chan *dchan,
			  struct dma_slave_config *config)
{
	struct dw_edma_chan *chan;

	if (config)
		return config;

	chan = dchan2dw_edma_chan(dchan);

	return &chan->config;
}

That avoids the call to dchan2dw_edma_chan() if config is specified.

-- 
Damien Le Moal
Western Digital Research

