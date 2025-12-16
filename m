Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0593CD609D2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQUOiFH+u9sWT2JoTRvbAKhp31r6m+G18FztOamuUes=; b=Rt9ByO/XWxnYIelPEsh7uJhNjs
	4l7Son9G2VzPQMIO0R2zXSRxhOfU3BuOrZ29RuI59XT6lafAuROPphGdwJ3aKde5Cv3wT9jA4Vr6F
	pp0uugBob3Y9oxKA27uiP9yusbT56tL9YHg5LtAu76OMVMfcCbyaNnrp+RJT6AeIMIrSeE8J2AUhn
	q4UXnUZTujr/JfLI+CY8R/AJapH8pwkIwPFNUEeFfrw/LDhjrogZU2BbJAOJaY553Pf/BwN6IJuKu
	l1PZQ6FLMqEWOc7J9ThyWtyvO+r3t/U1Q2L7ByA+RsATq8bcaFPFdq06fZAtxa2h6wjSsaM7aQ+ec
	ZvKTOezg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVYgY-00000005bJ4-2fJ0;
	Tue, 16 Dec 2025 17:18:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVYgU-00000005bIR-3oAw;
	Tue, 16 Dec 2025 17:18:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E5E7F6017B;
	Tue, 16 Dec 2025 17:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3909C113D0;
	Tue, 16 Dec 2025 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765905481;
	bh=cppGG9PT+JpiVSfKeuzy9K48JaGezXDa3T4Yw7/QjLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9Z0adoYBmlbmaIqmD79zYatnS+Nt9uvNPpMDj8zX/H9mOuYbV48DmY7Rh8YVw9qd
	 kPaz6lUutNxyvoq7ZvVMPOvsgYTAzuBlktLuvQ5j5I6V5g7piqDfxgXGt8ewBWaV99
	 KVhZfzc6hJz1AFyIDWQlGEPMQlWZ23GklILkeYlwlpyezVASDJn8Y3tC+h9+7ViXMV
	 F6TWaAZvDP6hyZlZdErrsnkbI/f8almng8GM1fBYyZOmchVnX0pKgBMiqUi4HiCeSf
	 uiFFuy6zg2Y5TNiUPlnOgcsviidlVs2UFXR0qo2C805X9YA13sjqyc7PDY5fLzXDrQ
	 dyBmhKeBtDjFQ==
Date: Tue, 16 Dec 2025 22:47:57 +0530
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
Message-ID: <aUGURVuW33WSTuyI@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
 <aUF-C8iUCs-dYXGm@vaman>
 <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
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

On 16-12-25, 10:55, Frank Li wrote:
> On Tue, Dec 16, 2025 at 09:13:07PM +0530, Vinod Koul wrote:
> > On 16-12-25, 10:10, Frank Li wrote:
> > > On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> > > > On 08-12-25, 12:09, Frank Li wrote:
> > > >
> > > > Spell check on subject please :-)
> > > >
> > > > > Previously, configuration and preparation required two separate calls. This
> > > > > works well when configuration is done only once during initialization.
> > > > >
> > > > > However, in cases where the burst length or source/destination address must
> > > > > be adjusted for each transfer, calling two functions is verbose.
> > > > >
> > > > > 	if (dmaengine_slave_config(chan, &sconf)) {
> > > > > 		dev_err(dev, "DMA slave config fail\n");
> > > > > 		return -EIO;
> > > > > 	}
> > > > >
> > > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > > > >
> > > > > After new API added
> > > > >
> > > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
> > > >
> > > > Nak, we cant change the API like this.
> > >
> > > Sorry, it is typo here. in patch
> > > 	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);
> > >
> > > > I agree that you can add a new way to call dmaengine_slave_config() and
> > > > dmaengine_prep_slave_single() together.
> > > > maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> > > > cant drop it, as absence means something else entire).
> > >
> > > how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
> > > to align recent added "dmaengine_prep_peripheral_dma_vec()"
> >
> > It doesnt imply config has been done, how does it differ from usual
> > prep_ calls. I see confusions can be caused!
> 
> dmaengine_prep_peripheral_single(.., &sconf) and
> dmaengine_prep_peripheral_sg(..., &sconf).
> 
> The above two funcitions have pass down &sconf.
> 
> The usual prep_ call have not sconf argument, which need depend on previous
> config.
> 
> further, If passdown NULL for config, it means use previuos config.

I know it is bit longer but somehow I would feel better for the API to
imply config as well please

> 
> >
> > > I think "peripheral" also is reduntant. dmaengine_prep_single() and
> > > dmaengine_prep_sg() should be enough because
> >
> > Then you are missing the basic premises of dmaengine that we have memcpy
> > ops and peripheral dma ops (aka slave) Absence of peripheral always
> > implies that it is memcpy
> 
> Okay, it is not big deal. is dmaengine_prep_dma_cyclic() exception? which
> have not "peripheral" or "slave", but it is not for memcpy.

Cyclic by definition implies a cyclic dma over a peripheral

-- 
~Vinod

