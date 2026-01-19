Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2236CCF2D2
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jan 2026 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NXcdWG287LzF08jF155k+OwAYqGcwl1txjLdu6FJhII=; b=cTwkwRGo2B4KDOv5eUNd0jpluS
	Kx7rQwgTtLaMVOyx26RWe3O3ytQc3vpgdXoaklwrRrupkrKD7OkGnpGXgUUH24jZy36zI8QJFxwPd
	6Ag6ByiJp9eniVROuSzyOi4hvkz5AOEZMM8EYQ8/55cjHJEKjAFRvagGcLU0j3Q3nzX7/MQ8iaeyC
	HKsJK2DIL52jwECpEPp0ziZGOdg0VPHlib0afQUO7Yib4vjYsOfysnIMbETJIUlXBJJMDuVCMNqpt
	hnP2c7JdikVNk7nbDslgemv5+7fxKBkR8tB9CQibd5YRSs1199XND91M0LptcYz2DBagDcoyUmACG
	1QCsR7sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhlXd-00000001dSh-3GhD;
	Mon, 19 Jan 2026 09:27:21 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhlXb-00000001dS8-0OmJ;
	Mon, 19 Jan 2026 09:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1768814838; x=1800350838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FnDqYCqY4eMQu1KfJO2diG09+hGAQVkPBUCJXUeIZ0A=;
  b=mkG5skaIOQjYosZQq4bgzYL0Rt0GVK3ebTWZCHg5B+cflS6ijPVqOBXZ
   grB8oWmyGLUPvo8R+1rycaZkA8m5pD4lCBdxw1jaUpVCLFdWxv2EAAlA4
   TA9wYvP36+exx/UHAgevKKMEZad7wSTuHo8Bu2RnFXcx5W+wdx4kEYUf2
   2dII6Zq5Ge3hgTL4VW2nYm/Q4feTSjPKuGJUHULMH6CHuGZFkCd6AWrqw
   FUuSi3LR7ren20az831WLjBeJQMiaj8D7dZVRpsQMGXAHrW/t8vdlkXRe
   6Irsup9Et0uoksqGMOptvS0Nh867qAgkAYC/QHKDn3yX569ujtAB+mfVj
   Q==;
X-CSE-ConnectionGUID: i0zijf1nTfiJcIl2a1rGow==
X-CSE-MsgGUID: 5Vc33klYRPeu5OUwKZF+zg==
X-IronPort-AV: E=Sophos;i="6.21,237,1763449200"; 
   d="scan'208";a="219379894"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2026 02:27:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 19 Jan 2026 02:26:44 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 19 Jan 2026 02:26:40 -0700
Message-ID: <bc019bd8-34d3-420e-8519-09700437fb01@microchip.com>
Date: Mon, 19 Jan 2026 10:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] crypto: atmel: Use dmaengine_prep_config_single()
 API
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<imx@lists.linux.dev>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <20260105-dma_prep_config-v3-9-a8480362fd42@nxp.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20260105-dma_prep_config-v3-9-a8480362fd42@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_012719_427968_581B9AF6 
X-CRM114-Status: GOOD (  14.66  )
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

On 05/01/2026 at 23:46, Frank Li wrote:
> Using new API dmaengine_prep_config_single() to simple code.
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/crypto/atmel-aes.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index 3a2684208dda9ee45d71b4bc2958be293a4fb6fe..e300672ffd7185b0f5bf356c2376681537047def 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
>          struct dma_slave_config config;
>          dma_async_tx_callback callback;
>          struct atmel_aes_dma *dma;
> -       int err;
> 
>          memset(&config, 0, sizeof(config));
>          config.src_addr_width = addr_width;
> @@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
>                  return -EINVAL;
>          }
> 
> -       err = dmaengine_slave_config(dma->chan, &config);
> -       if (err)
> -               return err;
> -
> -       desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
> -                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +       desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
> +                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
> +                                       &config);
>          if (!desc)
>                  return -ENOMEM;
> 
> 
> --
> 2.34.1
> 


