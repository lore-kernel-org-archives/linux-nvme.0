Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3451C98318
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jan 2026 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f5K99/trExvpAf7KoxmDVfjMJhpr+FPqIPC+4L/MFc8=; b=hEOfwpk5GnCdTtxZtpGBp864oQ
	yhwntjS3jjJptJba0hETFI9WCb4KgYzv4k3z94G7B1y2AccOfGdwlzxOZ8FlRP3Ncc0/bOZDPNH5m
	T8MsUrves39nnYBXjzFwYjARzxjQ1yIRlXksWhE0JkeZoxSbqtho2N/E8WeFllwIO+z9bU8HwU4OP
	aXryAA5N4KsgU5bP3qF6g7xgg5XSyO6RgQ/5yCERHhPQJxkTVkj9/uvzGHhq4S2yAQOKS9gV2wDJH
	9Vcth7PfguftYyQNbiPxCOZ+viuI3MSiNTZbCVi/p6sTGLE3/txKRi943fsQCraL1ueM4ZyvDIwnT
	0xayFfBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh45Z-0000000FT2g-43IV;
	Sat, 17 Jan 2026 11:03:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh45W-0000000FT2C-2u4Z;
	Sat, 17 Jan 2026 11:03:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 269D8437A3;
	Sat, 17 Jan 2026 11:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B213C4CEF7;
	Sat, 17 Jan 2026 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768647805;
	bh=O+duQ4JNA7Nott7rAhBuH0I1nT89hCgeyNw0mpwEzjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CM7IEuumCuUr8tQUn1mAa4brRyWwMxEit3KmPILt6x24ftoLF98QlqWD5qfVxIR/r
	 cHrq2Uu+a46tPnQs+qKfKkWpXfb6Ql5sciUqUPASd9K/XM9CjkaJbepmQ9U6aj2jIr
	 3Y5AWv6plm78hBx7NmUyVSJxTyeVEaXn4B3/5ULcT3j7Sq7NJZ1kWtl/wa2qEJxquW
	 v1ewSD7+Ee05NqQg9++H3A74uX4sMuDnVIz/YxWP2mwF0WpwaNp/ERXIuCjIxCZXxs
	 qnSpVTY5KwIKiflyZiodClza/H/dMqzzFXeNASuTK8FT8lDjhXcWAUDADrTV20u8DS
	 wXdSRp5nOVZFg==
Date: Sat, 17 Jan 2026 16:33:09 +0530
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
Subject: Re: [PATCH v3 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single()
 to simplify code
Message-ID: <lsvjhgxkpk3drbu4nvika5rj7yvc3dqvu6fhibj4nlsuq7fulx@odbkesxm377n>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <20260105-dma_prep_config-v3-8-a8480362fd42@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105-dma_prep_config-v3-8-a8480362fd42@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260117_030326_775522_2763DC4E 
X-CRM114-Status: GOOD (  15.75  )
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

On Mon, Jan 05, 2026 at 05:46:58PM -0500, Frank Li wrote:
> Use dmaengine_prep_config_single() to simplify
> pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Keep mutex lock because sync with other function.
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
>  1 file changed, 16 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 6643a88c7a0ce38161bc6253c09d29f1c36ba394..0bf51fd467395182161555f83aa78f3839e36773 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_DEV_TO_MEM;
>  	config.src_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_FROM_DEVICE);
>  	ret = dma_mapping_error(dma_dev, dst_addr);
> @@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> +					    DMA_DEV_TO_MEM,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -399,12 +394,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_MEM_TO_DEV;
>  	config.dst_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_TO_DEVICE);
>  	ret = dma_mapping_error(dma_dev, src_addr);
> @@ -413,9 +402,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> -					   DMA_MEM_TO_DEV,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
> +					    DMA_MEM_TO_DEV,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -502,12 +492,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_DEV_TO_MEM;
>  	config.src_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_FROM_DEVICE);
>  	ret = dma_mapping_error(dma_dev, dst_addr);
> @@ -516,9 +500,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> +					    DMA_DEV_TO_MEM,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -581,12 +566,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_MEM_TO_DEV;
>  	config.dst_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_TO_DEVICE);
>  	ret = dma_mapping_error(dma_dev, src_addr);
> @@ -595,9 +574,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> -					   DMA_MEM_TO_DEV,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
> +					    DMA_MEM_TO_DEV,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

