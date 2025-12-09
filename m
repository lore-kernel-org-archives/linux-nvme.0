Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE1D1CDC6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqC5eagO0a/ErvLUj0Z+O4RNeXdiJk16/3f/TtABkxA=; b=advGEFPrgiGTq8kZ7kQ00Faun4
	ukafwnbJ3L5NNXWFRw1WOVMIFkZdJ8tTtyaeVneJaEOs7rIa7UpAAWHge6H9Tl+2gb4++i85p4OLi
	3YOfuhqzJ1Y/DHyhesD+1fXdldm5TXN2k80bOneyhuoJPowR/oOl9G+y0BdCoyw70eU2HO92NVz/E
	9Y0G3REqUR0rUC6cfE2KnVyDGZ1ocgIrhSwQFEpKecyi76cBsO0zBV2esnzQgOcMpuEabP5OH6qRv
	ZRo1SrCbniIVM+tL7G8PQKA4aVlkO/RbgkoFuLdh5rM/KABCZV3K0h4lx65U5i438X4bLSFy9iQfx
	PZJ4MorQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSrNG-0000000DtjY-48Xe;
	Tue, 09 Dec 2025 06:39:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSrND-0000000DtiM-2NEk;
	Tue, 09 Dec 2025 06:39:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54A7C68AFE; Tue,  9 Dec 2025 07:38:56 +0100 (CET)
Date: Tue, 9 Dec 2025 07:38:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
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
Subject: Re: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <20251209063855.GB27728@lst.de>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com> <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_223859_782280_95727F17 
X-CRM114-Status: UNSURE (   8.21  )
X-CRM114-Notice: Please train this message.
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

> +	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
> +						  sconf.direction,
> +						  DMA_CTRL_ACK,
> +						  &sconf);


If you stick to tab-indents this becomes a lot more readable:

	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
			sconf.direction, DMA_CTRL_ACK, &sconf);

