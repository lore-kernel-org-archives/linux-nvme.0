Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A48C98321
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jan 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5H9CvLBV9kq/vFlhzTJu+c1ZeGSEoKAauIQ2QKgxvOk=; b=2mVN1eckqGZ469hqc1erTT9XFn
	VEgl/XZ5h7OIilcSHHXxLR+2W9ytgLGTWVqM4KL1/wwVu5ed5tfo0DoFt6WuUNpO0tMnbijnaSoBl
	oCHj4F6BSGmzlnQacSanvAiKGvi71CcXgz4Pe0oTG8Ej2MIhbj00VGc27gX0l1QmX4A8knbdjE9kX
	GbYx5u7Pd+UaCbUOW0i7vhshP+VPP3ofpQIRbdXYz1Bz7FU6Umqk8OwEZMFg/FHZc0+/igNVzEuTY
	jLjM1nrauTM8D5w7gyw/GP95SxlRbfFLX8+It/RWv4g6KIGUlV1HCnDTDtq+G9cnnJUH6FI2vw3IE
	mLDdWJ5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh3zw-0000000FSjt-3d8P;
	Sat, 17 Jan 2026 10:57:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh3zq-0000000FSjL-3TnE;
	Sat, 17 Jan 2026 10:57:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DC1A660127;
	Sat, 17 Jan 2026 10:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD7CC4CEF7;
	Sat, 17 Jan 2026 10:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768647453;
	bh=hNiv/W3QHHIP4X/UDBU+nEtCmGt9Wf1fVOHzvFVeeME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2iAT2H9xieXc+E/UTKamvCsKyuamRllOQz07wrpzr/PFi03FyaK4eix67vMva8qa
	 Bn2N808rm098VDDpvZTC7LgjiODtwl4HQKvRT3/ijbN3qLd20pZfoW0AdaS9XU75Dr
	 PxXMKKiB7b6oWbwSGDpalEE5EnqZcDDklM6V19UXWYu+eqE7/XXXgpiZ2cZIbX7ygJ
	 jYHGXN9RnkohyW7Stm5PItZbX1l/sS+wVBYMXanm3cAFRILY8t+WLiXy5eAjO8V86k
	 QNUmcYX0M83kItZP/zIuTCTT8uDcJMGostfKfUc619iS02/er1Dsuh7NsICE3aAH7j
	 o4A7dzhUg14PA==
Date: Sat, 17 Jan 2026 16:27:15 +0530
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
Subject: Re: [PATCH v3 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Message-ID: <tfqwmj24eu2rf6h4ecvkgom44tgjkaihtgmln7v3zcyy5burcb@sg3q5qafbzgf>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <20260105-dma_prep_config-v3-3-a8480362fd42@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105-dma_prep_config-v3-3-a8480362fd42@nxp.com>
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

On Mon, Jan 05, 2026 at 05:46:53PM -0500, Frank Li wrote:
> Use dmaenigne_prep_config_single() to simplify code.
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> change in v3
> - add Damien Le Moal review tag
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index debd235253c5ba54eb8f06d13261c407ee3768ec..95b046c678da7ca4a0d9616acdd544251dc05aac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -162,12 +162,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		else
>  			sconf.src_addr = dma_remote;
>  
> -		if (dmaengine_slave_config(chan, &sconf)) {
> -			dev_err(dev, "DMA slave config fail\n");
> -			return -EIO;
> -		}
> -		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
> -						 flags);
> +		tx = dmaengine_prep_config_single(chan, dma_local, len,
> +						  dir, flags, &sconf);
>  	} else {
>  		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
>  					       flags);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

