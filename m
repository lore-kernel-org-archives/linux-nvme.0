Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7B5D64072
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Dec 2025 05:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cz7yv0qeK8S8YidREsR6zzef9V83y6rGPe4XUS6V/1g=; b=KkbvWeUEJxUoDDqLpWUxCSjXUB
	SZ5WgoGToCJtFEXnX0Vo+fvBQCGh6BAizQ7hNZ2rFpI35NscKuBp9F8V91x/eBuCZLMYFFFns8WJl
	Q0nXNN1WnUfI/HbsdTzdQXidYIAURb/SjAfHnWm7m425PzSaQZ8oQGlQvbGp3+ftY1wGaML1S8LEB
	zMgJU8vmAG5aNuP/yEx7V/QIwRv5omu8DYCWplZgazkblW8W/3uMzNt3OEoVEa8Z4R8YYRcI/1de7
	F22wLz4FPQ3fXjWaGZa8/tkyGE0HFh3DiZFs+dCSfsxkuPIYrIOIFN9DPX71f1CEdkyr9yToeKMDj
	DNh9V5lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVjo3-00000006BIK-10yw;
	Wed, 17 Dec 2025 05:10:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVjo1-00000006BI4-3IwL;
	Wed, 17 Dec 2025 05:10:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 561536011F;
	Wed, 17 Dec 2025 05:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DCC19421;
	Wed, 17 Dec 2025 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765948231;
	bh=bLaK2gFWACWyalrEyaiMmZm2YYU4Bq1urmASnlDm6Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcJmWWfK33MwnybWoQwekHilGr5zCy1560YIq82bx13SaA1+NQhhGq6QhzHPOtbEe
	 g76xucoHWrhcqeg8jb5VE05l6kNRJqy8dzrHM71a0cQhnkMbxx8WNSdtD/xq6p5DJh
	 bLHZ6CrHbnrrdiA/lniK+9rvYDMqboXAwilsS0aU54t6HtaaMkb9cupJ0QxHomVxV2
	 yEKUZaMdsykL/s2wdfPiua3AQCBlcTtdYyxETlm+DBvrPfzz8JejKbsd8W5e+SNrmX
	 GIQpG0as5/ipXXQUCNwIQXZKMAJ3whyWGdWsrBeHqTqlltwGj8NOqaddzfTt/pb5xg
	 F3WTKkjID57OQ==
Date: Wed, 17 Dec 2025 10:40:28 +0530
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
Message-ID: <aUI7RJvQUx3m2IRf@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
 <aUF-C8iUCs-dYXGm@vaman>
 <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
 <aUGURVuW33WSTuyI@vaman>
 <aUGWtarjFNNy2KyZ@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGWtarjFNNy2KyZ@lizhi-Precision-Tower-5810>
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

On 16-12-25, 12:28, Frank Li wrote:
> On Tue, Dec 16, 2025 at 10:47:57PM +0530, Vinod Koul wrote:
> > On 16-12-25, 10:55, Frank Li wrote:
> > > The usual prep_ call have not sconf argument, which need depend on previous
> > > config.
> > >
> > > further, If passdown NULL for config, it means use previuos config.
> >
> > I know it is bit longer but somehow I would feel better for the API to
> > imply config as well please
> 
> I can use you suggested dmaengine_prep_config_perip_single().
> 
> But how about use dmaengine_prep_config_single(), which little bit shorter
> and use "config" to imply it is for periperal? (similar to cyclic case?)

Yes that is a good idea. config does imply peripheral cases. Please make
sure API documentation marks that clearly

BR
-- 
~Vinod

