Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EDDC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eiFPBn1tbYiWnXsgsAeerc+9XoO81Qyg9ewXiIEgCIk=; b=jLguYrDHJq77NDUw88sJl4Hv1i
	D+MWkvYINURVlD9mJYVk+cgozV9k7mheVllm1F9YdNWH6IiDjcvSKzzy7oQu4S0omy0G4BNEftt9I
	wRws+1KTT1P3iGWLO9UIByPWLjBLJst4CFhZKSpoMU530XeWHGKVnqIDhLySbU/oBgtaziv+nIetN
	C6c4yGhHCmozmqLy6pW1sL5C0vz995LDVwXGVCLST87Ge853m2pXsfTL+yeacxhJ/kYKszqqyRI/Y
	u46jkSnLJ/kknPzgHnT5h24iYahkgq1LX0ImgzgT0iR20U3MGnuNLd9Q3H6D/DIvw8YvKeHsYnM59
	G3nGEP1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjbyo-0000000Bs5Q-3OX0;
	Tue, 14 Jul 2026 12:11:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjbyn-0000000Bs4w-2B1c;
	Tue, 14 Jul 2026 12:11:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 125DB405B1;
	Tue, 14 Jul 2026 12:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401061F000E9;
	Tue, 14 Jul 2026 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784031077;
	bh=eiFPBn1tbYiWnXsgsAeerc+9XoO81Qyg9ewXiIEgCIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSJLzUZ1u4So/jNeJG3gQdyMRyt76jnISJCj95cssU5cPktGnVw0pZzi0wUI1BV8h
	 ZH1RYmG6WUXAld29tnNWXxcdZI1ND3WLQr3l3iA0OkCL1qTj8WsLgIDWkes6dg+wju
	 uAJu9/IMZPwkyuSXvXUfuidGWD7Y0nKFNuH5PGEbnAUzp72tNR7hSN4hJObGu7H0XK
	 yHdJXNL9PoReWtbdiXpN++LWC6GSlYCO3L23cFqTTy3Sy85XKZSpWcBd0SyJAdx3o6
	 Ub6SXF6/hO5yJ5rtgQZjJkXAOLO7fPJ0JeVw+CFhwTpcluT1yG76US3bCqvBL5IQZD
	 Y1syx3MaHkDoQ==
Date: Tue, 14 Jul 2026 17:41:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank.Li@oss.nxp.com, Manivannan Sadhasivam <mani@kernel.org>,
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
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Message-ID: <alYnYY0DHl3qi5T6@vaman>
References: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
 <20260709195203.GA874193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709195203.GA874193@bhelgaas>
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

On 09-07-26, 14:52, Bjorn Helgaas wrote:
> On Thu, May 21, 2026 at 11:32:49AM -0400, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> > 
> > Use dmaenigne_prep_config_single() to simplify code.
> 
> s/dmaenigne/dmaengine/ both in subject and commit log.

Yeah I had fixed while applying

-- 
~Vinod

