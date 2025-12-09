Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC03D3B7EA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 06:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2wZTv7GFhioyjeubDeO1pmwhT/HGt94G5uuFTU+0Oc=; b=lV8vHJlBpLMa+0LyMNqSvm0kHd
	3iyHWIm/sf7ciQ5BuHApsTphRj274HCBf+8maS68lHMZgzpgusvwaohDuIgYrrb0HpwtU/PWCchFh
	wJ6Ny6msMdU42muWLc4lvdWHZw6R6hGy8TKte8gHmYmVkFFcL9ErMXAvHEV+BG72kx/2iwZWULgXr
	daTEQbYcH/ZNGwpeQ/6vaMDXx78WW1iQpWUF5ao47J4fZdUbl0/NRmKqN6c9wunkhyt5H8QpC6BYV
	XRyDwQRvSl+O0oKW52hlkBo235OH9yq2qDSU0ALmB7w0Rl5hmgt7PxIVgQR1xax17Py6dLL5stWeH
	xUxabx4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSrMo-0000000Dted-1P9z;
	Tue, 09 Dec 2025 06:38:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSrMl-0000000DtdP-0N4O;
	Tue, 09 Dec 2025 06:38:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1062568AFE; Tue,  9 Dec 2025 07:38:09 +0100 (CET)
Date: Tue, 9 Dec 2025 07:38:09 +0100
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
Subject: Re: [PATCH 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <20251209063809.GA27728@lst.de>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com> <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_223831_296570_B910CFC3 
X-CRM114-Status: GOOD (  14.91  )
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

On Mon, Dec 08, 2025 at 12:09:40PM -0500, Frank Li wrote:
> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose and
> requires additional locking to ensure both steps complete atomically.
> 
> Add a new API and callback device_prep_slave_sg_config that combines
> configuration and preparation into a single operation. If the configuration
> argument is passed as NULL, fall back to the existing implementation.

Maybe this would be a good time to start retiring the "slave" naming
and come up with shorter names as a win-win situation?


