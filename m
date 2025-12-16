Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F50D609B2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNZ29PXPWaJHxUEAABq5WyvNSfOGiRAU7qqEK1X4BWI=; b=UcHFDXRBX1H74B7ucASGBAoRGy
	00X9fYU2szkn3Rgg7kOTK2OX59UsY1X4+vmYa/CPHWoJrvXfudGwXRIVkpDAR651JJGAynGxGHIq7
	3wTm3VryFrc4wF3qLdl6aur7q+PiM0bRJ54QeYiKKnzfTjmh3KeDAL8rb9YXpvw9weMkyzp5v7qFS
	6B8gTZmplvEIUDDQy3dkHuAVgPkpndw7S93G2mBJa7wCLDrQ/Ql2TeaqTqNzjxGqR8v32+J6LdZ3K
	pYlOCURXciTnwAAL+aBXBVEIIiWFNXLRDTmF6MC2y4L4Fpx80BwPv4kZxiCXgWPGhdRDy94zCKmZy
	bv+7qPWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVXCk-00000005T1b-27Aq;
	Tue, 16 Dec 2025 15:43:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVXCi-00000005T1A-2A01;
	Tue, 16 Dec 2025 15:43:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 97AF36017B;
	Tue, 16 Dec 2025 15:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8A9C4CEF1;
	Tue, 16 Dec 2025 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765899791;
	bh=ZJTJypfLe1H/1AUEwksCTkMoXxELG4u7pdR81YdX+EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avTeetSCg2f1iVCLtIL2eMD8lxo6IXEVPcYP29oezKOpSlnYbzQvySLzpryda+R1A
	 ew6Qmjryuhzff4o2BNqhJbYikZ/FxB9nsZ+SVx/fEVe4+Vk8KAAXNTxXKgB1dOxfC6
	 74+SKOUxUYH7bvsWWQn3Q5qwYcHK43xEPD2CbWjHDldkEanlq21fmXVgnU0XBWMqbv
	 BNwMTA5V4T1ZdwdXE45rLHOcG/cKJ0JLceGyQuUmh04zLBAqknv3qYM1zyCFIEZrg6
	 xNyoNgN2Bk8xHpe+jauDCs8GKdRJcRNBlYtSaJq0IBEmiVa1MMIQaZqoQDY1frH7eC
	 nyyoTKRn0yS8A==
Date: Tue, 16 Dec 2025 21:13:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Message-ID: <aUF-C8iUCs-dYXGm@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
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

On 16-12-25, 10:10, Frank Li wrote:
> On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> > On 08-12-25, 12:09, Frank Li wrote:
> >
> > Spell check on subject please :-)
> >
> > > Previously, configuration and preparation required two separate calls. This
> > > works well when configuration is done only once during initialization.
> > >
> > > However, in cases where the burst length or source/destination address must
> > > be adjusted for each transfer, calling two functions is verbose.
> > >
> > > 	if (dmaengine_slave_config(chan, &sconf)) {
> > > 		dev_err(dev, "DMA slave config fail\n");
> > > 		return -EIO;
> > > 	}
> > >
> > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > >
> > > After new API added
> > >
> > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
> >
> > Nak, we cant change the API like this.
> 
> Sorry, it is typo here. in patch
> 	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);
> 
> > I agree that you can add a new way to call dmaengine_slave_config() and
> > dmaengine_prep_slave_single() together.
> > maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> > cant drop it, as absence means something else entire).
> 
> how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
> to align recent added "dmaengine_prep_peripheral_dma_vec()"

It doesnt imply config has been done, how does it differ from usual
prep_ calls. I see confusions can be caused!

> I think "peripheral" also is reduntant. dmaengine_prep_single() and
> dmaengine_prep_sg() should be enough because

Then you are missing the basic premises of dmaengine that we have memcpy
ops and peripheral dma ops (aka slave) Absence of peripheral always
implies that it is memcpy

> - dmaengine_prep_dma_cyclic() is actually work with prepiperial FIFO
> - some prepierial FIFO work like memory, by use shared memory method, like
> PCIe map windows.
> - argument: config and dir already passdown information to indicate if it
> is device preiperial. So needn't indicate at function name.
> - maybe later extend to support mem to mem by config becuase adjust burst
> size for difference alignment or difference bus fabric port to optimaze
> performance.
> 
> Frank
> 
> >
> > I would like to retain the dmaengine_prep_slave_single() as an API for
> > users to call and invoke. There are users who configure channel once as
> > well
> >
> > >
> > > Additional, prevous two calls requires additional locking to ensure both
> > > steps complete atomically.
> > >
> > >     mutex_lock()
> > >     dmaengine_slave_config()
> > >     dmaengine_prep_slave_single()
> > >     mutex_unlock()
> > >
> > > after new API added, mutex lock can be moved. See patch
> > >      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Frank Li (8):
> > >       dmaengine: Add API to combine configuration and preparation (sg and single)
> > >       PCI: endpoint: pci-epf-test: use new DMA API to simple code
> > >       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
> > >       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
> > >       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
> > >       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> > >       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
> > >       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> > >
> > >  drivers/crypto/atmel-aes.c                    | 10 ++---
> > >  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
> > >  drivers/nvme/target/pci-epf.c                 | 21 +++------
> > >  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
> > >  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
> > >  6 files changed, 111 insertions(+), 82 deletions(-)
> > > ---
> > > base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> > > change-id: 20251204-dma_prep_config-654170d245a2
> > >
> > > Best regards,
> > > --
> > > Frank Li <Frank.Li@nxp.com>
> >
> > --
> > ~Vinod

-- 
~Vinod

