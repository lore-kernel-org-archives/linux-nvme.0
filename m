Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55847C98321
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jan 2026 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4pcnz3lctmFczRJJMAFshsMy/gHswYLO7hT0cfwF2No=; b=YSKNRoyN11hufdc39udVQfuMCv
	vETiMLzYPSStW4bgCiTL6augBQacW4aQz1Cw6tl4yUGx8OqCxyGpckp59a3PgiZQ25gQsDXcwZRDQ
	tEM2Covr4NpgMmv7YW5uS81adl4kTUFyv2v8uAQSDvRpJZ6ilDSBrTnTV1ZKJEXo6bJOaQhxTvM03
	XOgM4tSUxeUNZpPll7duPGOKMwxHjcpRZdkUO635dB2UEe9HErvpjTeSSILBm5Io2KqEe2ltRzXtF
	h8hVMHOWQK6HXlKYE5h+UVB8IF4C/VFHtH1D8nwN3FsslTEuOR+QtMN6DCFhDQ5ElbdC5uMm9BvIs
	SO4e5EeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh480-0000000FTPq-1nXy;
	Sat, 17 Jan 2026 11:06:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh47z-0000000FTPO-0Ubh;
	Sat, 17 Jan 2026 11:05:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B0F760127;
	Sat, 17 Jan 2026 11:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A15C4CEF7;
	Sat, 17 Jan 2026 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768647957;
	bh=6d45T7HhrZc5jUsPEswloktiujk+9zSyGqQrcH8upas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I86gXbHeAPG5z+dNCmXJ4LzPzpH1PCM9BMOypcZ2cxCY/yMSDbRsNkPlf5LbxMsxm
	 y7L2XvpK1gqFYoOXMQaqCWoEggzXM6r98tqKl/C9yGzOItSVhO80a/C01Pzec+8grg
	 L/sa/1/sozRCc7xvT0+dX12N0V1lojo7vJ4wp95WbsxJTIgmr/2IGQTFOBmTDxEsUA
	 dW+u/3Jga8l8y8JLdh41y+M+YNFkwtEo/qwxRPUcsDYo7U9l4H4IrDImfHPxpl04bC
	 /PpApDyKyiJI8iYLzTbgdwC037qC/cJNyNRl7j+4iocl7R2M3UNfcYYWFa9ciYQPGg
	 9D+mCvRF6/HUw==
Date: Sat, 17 Jan 2026 16:35:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aWTwrOOXX3AR8Ght@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWTwrOOXX3AR8Ght@ryzen>
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

On Mon, Jan 12, 2026 at 02:01:32PM +0100, Niklas Cassel wrote:
> Frank,
> 
> Thanks a lot for your work on this series!
> 
> On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
> >  Documentation/driver-api/dmaengine/client.rst |   9 ++
> >  drivers/crypto/atmel-aes.c                    |  10 +--
> >  drivers/dma/dmaengine.c                       |   3 +
> >  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
> >  drivers/nvme/target/pci-epf.c                 |  21 ++---
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
> >  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
> >  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
> >  8 files changed, 177 insertions(+), 84 deletions(-)
> 
> Is the plan to merge this series via the dmaengine tree?
> 

It makes sense to take it through dmaengine tree given that the changes in PCI
and other drivers are straightforward.

> If so, we might need an Ack from Mani on the pci-epf-mhi.c and
> pci-epf-test.c patch.
> 

Just did.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

