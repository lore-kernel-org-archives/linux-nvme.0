Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC78D767CA
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iW5hVe2JF3gz/xWLZB424JNcuML60TPdp8X+9fmlaiA=; b=qO0x9poWSvgf3RqsNI2vVf0B4b
	vDSxPqjSaUQXxd8ZzXM5vHm0ytHLg6DJxGPSbPgC5BUYTYAzCPJcQdFGzBhneVJSPOE5EA/39yWzK
	zhSGkDzsIbSCbWVoi6YLAuPzYlROzrhn7ASsN9Dom7Fs7UZtzsrvz+EzBxIQxO0K0v2hXhBc1JrMx
	qYjIbTfqJ8P1M+twKQyQIul7RVv4NJ+oS6sP4QYozi4JiisbDtETF1C0ChCe58N/z98P2b/QFGCF2
	oCqHrCUsLfSlLnTIQpAWDv2ayz5VPyg09lVSdRMvG+RujIMWU6rW8ny3Qu3BBKjyY3+DsxIg1DCiE
	nwLESTUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXok-0000000A5KZ-1l9h;
	Fri, 19 Dec 2025 10:34:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXoh-0000000A5JB-2Vzj;
	Fri, 19 Dec 2025 10:34:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A4B0160008;
	Fri, 19 Dec 2025 10:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAC7C4CEF1;
	Fri, 19 Dec 2025 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140474;
	bh=SPRUl0fwxx8jiqVDCFYqIIeOa8rw0a17M2C60HwfJOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jbQCkDi+SiwTKv020NgWvoxwzYzEONj66gaT7jH/WIt5dueq62sRmSRfSnXKy0ppP
	 wbtfJwnEOYIX+xm1UbPrmqqmZt8XYIKN47DWOjBzEu+Ki6WTVL+2KYoHfZ29Q2dD5v
	 cv6VAul5T6Jq/mIAKGQtU/MLmEyZBJFt9lPu1mNOq6mGbbu3EgFkxg5mT9AC95tab1
	 87nogYLfOfLZ/p3idrWg/DvSk515LSmGKHT7e53LnLk25R3dVzMs/J6R45XxDY7DnZ
	 eBxx7NiPTRNJiWFJf1k/UcMw2erdX3pIbb7Z6NuBc3HCIzg1fRxMHBimADkO9B2g8r
	 kT5+FXcefUX1w==
Message-ID: <bb3a60d6-8503-4990-bdf7-7e14b13bddff@kernel.org>
Date: Fri, 19 Dec 2025 19:34:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-2-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-2-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/19/25 00:56, Frank Li wrote:
> Use dmaenigne_prep_config_single() to simplify code.
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

