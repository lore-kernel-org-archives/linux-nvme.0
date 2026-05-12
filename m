Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5228CCD4F25
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gw/3XWv3lqM4SVo7Ov48bZutctKT/FoPz6Ejl7rchB8=; b=PqnFxC4V54v1K4+u+LR3bt7Eh/
	5GG7RCYB2q5qazUqAxU/agjoYnPPzoXC/ql92VUmdAFnsZ+KlTSLrzhB2qpEyJNJUg5iMM2889W3F
	eIlZMP17zcHtD2FNThLI9AQipDur4m4RbPvR9/UVayfRgnJaNueNu8o9WH/fuu6+wxEvbClz2e0fa
	y50sEekqlT5+DmpvnTakfVN6bO1hTLiIsxRVc+nnBkyaqbK6nEJSByBTOp5jC6AIsazUgZ9lkluTx
	zAm/0RY/WAdL1Ene4jj2OJgnr7S3t1g42Edq/8rnAGkwucPBC0a571fVFwMvEGEe5Jgf8LfJFfJTT
	547ub29g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnkz-0000000GxRX-0mtN;
	Tue, 12 May 2026 14:06:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnky-0000000GxQy-25LB;
	Tue, 12 May 2026 14:06:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 987A8618B3;
	Tue, 12 May 2026 14:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D46C2BCB0;
	Tue, 12 May 2026 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594802;
	bh=sCdTEzy+9QK/GAC04dwJjssIvAEaneP0B0TsanrVNU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDZKGB4K/KBTh0Hm7t50LbJjRocFOeAjXT7hnG3mtf0eR5wpLkBPGFChYay35v5jR
	 ydExe4pHsdItNrltZjn0Zl/A1JOLcD7mSI+mP/isxUIBIurNBAVrRShc6A+D6yxg+3
	 Vtbr4nhW6DufgKxyIA66OT8C+PXB2nXdhPXaPP/y6lvYMkSJajNohSDH5Hmyv9+Cfc
	 1Ce/VN1TCfraCWHNezX4SKDa4bORpvEXKO2RQa2WMBfGWHhu2J4ZnnYF4E6ANe1TpT
	 Q8KxiX7IK7Y9CzE/AnWNzG7Z9bRu1p3tQPtnHltGqqdxEFaFn+FX8MvN7ivhfgkdQE
	 HoCvd9wnsUc3w==
Date: Tue, 12 May 2026 19:36:31 +0530
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
Subject: Re: [PATCH v4 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Message-ID: <xebioeyo4eecaj3sum6scttqqmubpcqutzdcrpjquvtmoaiskm@d2y744phmffd>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
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

On Wed, May 06, 2026 at 04:44:19PM -0400, Frank Li wrote:
> Use the new dmaengine_prep_config_single_safe() API to combine the
> configuration and descriptor preparation into a single call.
> 
> Since dmaengine_prep_config_single_safe() performs the configuration and
> preparation atomically and the mutex can be removed.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2afe8f4d0e46104a1b3c98db3905cf33e8c9e011..04d8f48d6950349ca97d2dbeae4e38e4714ad0d4 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
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
> +	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
> +						 sconf.direction,
> +						 DMA_CTRL_ACK, &sconf);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> -unlock:
> -	mutex_unlock(lock);
> -
>  	return ret;
>  }
>  
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

