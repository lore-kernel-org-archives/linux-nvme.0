Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCEAD767CB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZUv6PVQX03BQcCMuDJZjgSOx0iTY7jH1mAWIXCBM/4=; b=hbCNnvThJy2xiDlgbjxDduMa2h
	6alBXqiNurtXEY3iqc0NVp2IY6xCEo6uSAdvwxhG4CsQ0qUtf9+A6OmUam3Xc7OLS9USlp528zOQC
	bPtEmtiQBCkCfyx+GRNtLG4PhZyes6MOA6FCJTbnvagy2pG4ztBLqmfwci2z2VMA/Djv4S63oCyiU
	pKX196n9W8PMowSoaBqhKLus2QH1bujDsIvfx+KRIXokSa7YmEvJZwXqWZ6RANgqCHd1Grb8YQzY7
	gdO+GlYSSpH3lDY6fqEc8UzGyTJ+qjlERWf+SIh3DSswpgI5jOg/79/AgeyHzP1fPxYurPw23kggD
	dgwIJERg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXsy-0000000A8DZ-1bjV;
	Fri, 19 Dec 2025 10:39:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXsx-0000000A8CE-0kMZ;
	Fri, 19 Dec 2025 10:38:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8AC6960052;
	Fri, 19 Dec 2025 10:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A87C4CEF1;
	Fri, 19 Dec 2025 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140738;
	bh=JojbryuXzuZwBViUbKuSYpD99u7Ev05B8Sqdbjq3JeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RTyqXLh+pnMEDRL7QCn4ZVL5I48+KSFBkbfWLELWPIeGp5NlOGtMixn93HSyIUib1
	 VsXEFv6pp43x4ac+Ik1lR16wRZoTgERZyNybDBDrEdsksBKON8ZwHK+UjmvsqQ25Up
	 NicNvwtPw0uXTVVnF0tvXLWxU5N3EIikmt2XlOs9WCGgKeBy8C+XM1a4f21WmaW1HL
	 kzCa3N6gEjcuqriwV5jf2V1IrftSL6eodz2qshTNJlzsNkvBQ5/UsbP/PLEv2/8tA7
	 EOzMcZBtd8f5GjqLWa87NigJQdEnNa79jA6TIcgqP3qKIinOEECXzZvvyhNjrmtPrq
	 cgX4J/3C22GhA==
Message-ID: <8d4ae6b3-096a-4e12-8fa8-abaad2e953ad@kernel.org>
Date: Fri, 19 Dec 2025 19:38:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
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
 <20251218-dma_prep_config-v2-5-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-5-c07079836128@nxp.com>
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
> dmaengine_terminate_sync() cancels all pending requests. Calling it for
> every DMA transfer is unnecessary and counterproductive. This function is
> generally intended for cleanup paths such as module removal, device close,
> or unbind operations.
> 
> Remove the redundant calls for success path and keep it only at error path.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

