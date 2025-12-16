Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081D3D5E146
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CsgXMl+b5fLImo6rOwQPtIyzxVMp1rnzJtYCNyjVFfc=; b=OnfL7WjKhZ9l073HVvxdrP3FoE
	4V1iONSSfQhGZKh3LoXuvNm6Ex2QE1HQ1+RbMOvaONBq5UI/lK2INfg3Ey22p60DVTVyhoSLpMiPH
	Ltmb4smf/setgUe5Yc7LFT+0VW8mmgVIofblK3u7fWx1RHdtBrgjZTITNtCIpfP7qZpHcStAbhJXy
	FpReyIlX+9JGSmvOzNpmSKsfEjtznHO7EvO9Xortn/MNJ34ixoqJJ+cZJ3kDy6a+dj/I1j3RnWAfm
	yJ3HChb1qy33jdALX6Gj3LoQOu2y41gzs94fRVqmY1DeZrIaWEH86dG/rslLXuRJAPEFLghtkW+B7
	W2jbkPwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVUQl-00000005Clc-2RDh;
	Tue, 16 Dec 2025 12:45:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVUQe-00000005ClC-1ivX;
	Tue, 16 Dec 2025 12:45:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5039E6053F;
	Tue, 16 Dec 2025 12:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8388FC4CEF1;
	Tue, 16 Dec 2025 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765889123;
	bh=BB7cuc1NoM/ZjbE9WkcQ3syZOkeMW0I8NGbpaVWvHrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnoL6OaLXuO+HTBjme5kokBg0mnjS5RwOuZ6J05mjCYsgC+8P5QwHuW5NKH2ESn6J
	 G3W5VhnMayk+dn5VjLfT5UFuTX93YBBL9G/2FKYLk/kw3iPFRGcDCSZtUBKzRMSV/a
	 RouZAANdXw1Db478Bn39VjR3zqFC0RYvl5Id7A9t1MT39UIG2Jd87pr3U/+5olFHoC
	 sbo5M9OnE+as1zxfENAdombBcAwZECL0O0bltvRPFc1jAQuExxy57AQ05hCuQs4JP5
	 JLaTsl2h5ZXDDzL+jnGJYuCiJB+YdY2g2Siou/HnXT76l2YwUQRT7WyHzz09vv+OZ4
	 9GDNXf1AYoSfQ==
Date: Tue, 16 Dec 2025 18:15:19 +0530
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
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aUFUX0e_h7RGAecz@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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

On 08-12-25, 12:09, Frank Li wrote:

Spell check on subject please :-)

> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose.
> 
> 	if (dmaengine_slave_config(chan, &sconf)) {
> 		dev_err(dev, "DMA slave config fail\n");
> 		return -EIO;
> 	}
> 
> 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> 
> After new API added
> 
> 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);

Nak, we cant change the API like this.
I agree that you can add a new way to call dmaengine_slave_config() and
dmaengine_prep_slave_single() together.
maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
cant drop it, as absence means something else entire).

I would like to retain the dmaengine_prep_slave_single() as an API for
users to call and invoke. There are users who configure channel once as
well

> 
> Additional, prevous two calls requires additional locking to ensure both
> steps complete atomically.
> 
>     mutex_lock()
>     dmaengine_slave_config()
>     dmaengine_prep_slave_single()
>     mutex_unlock()
> 
> after new API added, mutex lock can be moved. See patch
>      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (8):
>       dmaengine: Add API to combine configuration and preparation (sg and single)
>       PCI: endpoint: pci-epf-test: use new DMA API to simple code
>       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
>       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
>       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
>       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
>       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
>       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> 
>  drivers/crypto/atmel-aes.c                    | 10 ++---
>  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
>  drivers/nvme/target/pci-epf.c                 | 21 +++------
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
>  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
>  6 files changed, 111 insertions(+), 82 deletions(-)
> ---
> base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> change-id: 20251204-dma_prep_config-654170d245a2
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>

-- 
~Vinod

