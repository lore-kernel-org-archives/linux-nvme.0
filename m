Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F73CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/m/NUQP2x/SSlmslUi5G7zfeV2Bzxs0m5z7pyFaYBqQ=; b=ieJnu0t0RLrjtOYv6nuuAAoDw5
	SWwa5nk/STyoazajqtRYMw7RA83CajbayDr4JN3yJ0ljJyFqINO5WdvElsaPyG5b5Npl6ZJWvmMOj
	ncqVPTkwncdEXwR6UobGrIKudI/C8EqgJHNIi9C96ewN4Y16S7C6D7ShaJBRc8Go9AAtS771g2an0
	wc/a8O0jCY+ZHkb4VR2b/CbVAtTdqAlpjrl7Jmn0RZn+M1UU4tx2cUUPJhmtAsBeCDvjx3wDxu+gG
	IRk5O7KiNnzUbjEwPaYLxySl75RaIemDerQoc3dCR8Xb7aXWk4LyH8wNl8FSbBo6TGxCwJs5HcVK+
	e1tZHwAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnkB-0000000GxI4-3tYg;
	Tue, 12 May 2026 14:05:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnk9-0000000GxH9-0xhA;
	Tue, 12 May 2026 14:05:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E603143AAF;
	Tue, 12 May 2026 14:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E89DC2BCF7;
	Tue, 12 May 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594752;
	bh=YycF+BsXmkOHi140SD9bIOo3d5bDA4TH49ncUJknjxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsTWv+Yabh5UIWyhp+vUaLL6nGSFKGZg2bIVVyicNmzP9NDYyN1C+KI3j1Z25Vn31
	 evnVRLXKipTZ5nVsO84Sfz4y6dBTQH9JYo993w9QlvT04WNOadYwToKyg2Qy1+M5hM
	 eHUKeL2xW1PiiuU/s1gFNwpJYlrBN7fpYb+AvX3dGIcbntFITb3Hdb0E6K7AZh88Lc
	 YtlYOW2bGR7CCs9p0vm3s11Vs7gYkX7O57njh7Wbc+gijRiK4H1H8l4U0Fptcngew6
	 7Caeze5M5bfF1KPW/RAcigtB+UEahAZ8Lcdvvx9oU53wAE3XwBeOI8D9vhJ6ogUFde
	 6FiFgfmxDKVSg==
Date: Tue, 12 May 2026 19:35:41 +0530
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Message-ID: <u4elm5jenwxp7r6zrn2ksxo2jqzkyttp2gyxufpvjhxevbtn7l@p7yr6wdbthgb>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-6-85b3d22babff@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-6-85b3d22babff@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_070553_285130_31AC25A4 
X-CRM114-Status: GOOD (  16.74  )
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

On Wed, May 06, 2026 at 04:44:18PM -0400, Frank Li wrote:
> dmaengine_terminate_sync() cancels all pending requests. Calling it for
> every DMA transfer is unnecessary and counterproductive. This function is
> generally intended for cleanup paths such as module removal, device close,
> or unbind operations.
> 
> Remove the redundant calls for success path and keep it only at error path.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> This one also fix stress test failure after remove mutex and use new API
> dmaengine_prep_slave_sg_config().
> ---
>  drivers/nvme/target/pci-epf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 4e9db96ebfecd796244e5dc67c23e1abb1a14974..2afe8f4d0e46104a1b3c98db3905cf33e8c9e011 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
>  		dev_err(dev, "DMA transfer failed\n");
>  		ret = -EIO;
> +		dmaengine_terminate_sync(chan);
>  	}
>  
> -	dmaengine_terminate_sync(chan);
> -
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

