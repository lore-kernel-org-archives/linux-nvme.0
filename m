Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0697DFD7076
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7wMiWIcb4v2/zjsfaBcDUQVwJDxu+opHLl2JH6njsY=; b=5GYzuXWvyFVbQwnjnB1T2+NZnk
	v3SeEPnsbsgvXByTU+yWtKWz6USQVU/lLSPzisghsrIkCclwdZjrANJI1dhDoDuzpfoHUCk0cacFj
	kUfd7NXtkSSlFFzcu3ZWXhaZctWGxZF6U9XXvp4Gv6+iKTzJhOEPtu/LrsZXxzCcm8tas9qmy40W9
	J/rNDeKO7iyGfwIkxLZkbncP4oZOpll8wGv/WEFlQv+LvMPmt6bP1hh7/xzV+MAp13KN9JGUSmbB5
	DAEdsJKCywF2FHCb8vdvow+69RqkaymadzTQKWfxegOjCunM8ZF405Fb/laMfkDXbJ1vx/Y4VHECW
	4fg8nP4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Ro4-0000000639b-31r8;
	Tue, 17 Mar 2026 10:37:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Ro2-0000000638Z-1Gvs;
	Tue, 17 Mar 2026 10:37:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9CBFE43B43;
	Tue, 17 Mar 2026 10:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BA2C2BC9E;
	Tue, 17 Mar 2026 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773743865;
	bh=bVEWdLxO6ioCtZnPQrdXen+JMCFn/KT/7+euMbV69tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOUr0clKofRpKlPQbpoGfbgW9oToJQusdYtrjFwC+xX+oDNSZytwUiA4CRIDQXhMT
	 xdfBatwQU3l+u8MhtrvnIpgsESwkSLOQjt3qB/Xc59eOYZt41K7Yt5IQ6r+3wsvTNk
	 RYvRm7XfIZmvxULvrr+bHWanoNOdZIoHkimQjH7QoO1I5DRxl+ZJOSbOWf2CfvfYxw
	 o4Mt2aeShixX/CrnBsDtw+1tkhO2TN36FEwVR+VGjLGHhhYcVsFwy4vZ2PfCApJoEK
	 k1zTCdZbe2/7yoHhavk0gUqPVYdHLfuZGEAMSXZvoUuG9ZVbrIy4t6izS5WAXy2E+p
	 LE2sQDdblsyOg==
Date: Tue, 17 Mar 2026 16:07:41 +0530
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
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <abku9bXxkZWUwOhE@vaman>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
 <aa6pW-zpxnrZnfPn@vaman>
 <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_033746_382696_DBBB32EB 
X-CRM114-Status: GOOD (  28.31  )
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

On 09-03-26, 10:42, Frank Li wrote:
> On Mon, Mar 09, 2026 at 12:04:59PM +0100, Vinod Koul wrote:
> > On 18-12-25, 10:56, Frank Li wrote:
> > > Previously, configuration and preparation required two separate calls. This
> > > works well when configuration is done only once during initialization.
> > >
> > > However, in cases where the burst length or source/destination address must
> > > be adjusted for each transfer, calling two functions is verbose and
> > > requires additional locking to ensure both steps complete atomically.
> > >
> > > Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> > > and callback device_prep_config_sg() that combines configuration and
> > > preparation into a single operation. If the configuration argument is
> > > passed as NULL, fall back to the existing implementation.
> > >
> > > Add a new API dmaengine_prep_config_single_safe() and
> > > dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> > > implement callback device_prep_config_sg().
> >
> > Okay to add API
> >
> > > +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> > > +		struct dma_chan *chan, struct scatterlist *sgl,
> > > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > > +		unsigned long flags, struct dma_slave_config *config,
> > > +		void *context);
> >
> > Do we want to have drivers implement one more callback. It does not make
> > sense to me. Why not handle this in framework and have it call the
> > respective lower level APIs.
> 
> To avoid use addtional lock! suppose each API is re-entriable.
> 
> thread 1:  call dmaengine_prep_config_sg_safe()
> thread 2:  call dmaengine_prep_config_sg_safe()
> 
> If DMA engine driver implement device_prep_config_sg, thread 1 and thread 2
> can run parallel.
> 
> If driver have not implement this callback, it have to use mutex make sure
> config and prep atomic.
> 
> https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> show finial opitimziation result, which depend on this. If can't call
> prep() function parallel, which will kill performace.

Which seems to be 10% in your case.

> > Drivers should implement simple apis and collectively the functionality
> > can come from the framework.
> >
> > Would you consider revising as such. Bonus all existing drivers can
> > start using this API, no change required for drivers in that case'
> 
> Not that simple, some devices just call config at probe, especial fix
> FIFO address and burst length.
> 
> Call config and prep only need for the case, which need adjust src/dst
> address, burst length or other parameter for each transfer.

Correct. In the cases where config is done once they can invoke with
NULL config. I would like the middle layer to handle complexities and
drivers should be simpler

> 
> Frank
> 
> >
> >
> > --
> > ~Vinod

-- 
~Vinod

