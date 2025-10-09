Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A7CCD184
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LfvP6PnF569utN+QsL2UwRjDFUAvmQW7HPf1dLyCGxo=; b=ZgnOrPF4vnW8U+fPvn1eOktCg8
	LYhLcYM5NkOoaqsmDgV/kn3fIvBhpvP/uAz3sMY6Mzwyc+sEg8ZEsoUFU++/EJL1+UDqPTRHH1QL5
	Mz8l1euQ80qT+THQPTe5oW7EoNtjC5JeSjdS/4MDV06umdSNL5WSd2746HjeLhniM55sjdWsyAHEq
	k9L45Ko/+rM4gTXXlB23l1YKd/y27HwhWQcP1kogOVOB4M3dhiZknTCQVZQZ00c5fEfxvN5ZOYjx8
	9yXlZqQyaRqGyo7dNEakPfdtGGnYmC9WkVMVSHIUgkxLj0K1Nce/ROqel8Sk0TwU4ElzdOw/KQolm
	rOdiRqsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6q20-000000068Vj-3pNB;
	Thu, 09 Oct 2025 12:46:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6q1z-000000068Uo-0qP1
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 12:46:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 799DF437CC;
	Thu,  9 Oct 2025 12:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA20DC4CEE7;
	Thu,  9 Oct 2025 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760013962;
	bh=f5s0vff2wLbx253hF4AOmxvLk3JLuEchs0gj6ZPXFZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW85sL8NWnZolagO6egRLjSu2oYQYpGVF6InyWKPvmPb+aFicAFrzYm40oCZVoB3+
	 3gT3FTzcoBeewOUk9sb5E0nvfm1csRSep9wdSETP6zZD8BG6efmmnKNdzpZxKo+yPh
	 Or7D1V09M4Vnx1+QzaLFr3Kn1uQcVYSKO8Gk9Y43JKN1Ox97GtmNjD7QSyzu3l6YGr
	 eRd4pkCGzUkTLINDkvQE+FkFh8CEPTmEbMITMAsXTSTtupQMSBlaJXebsFGEHs3b4H
	 N+6llY3a0lN9V/t/dn0mjS9+JM84W1k9MdZHAB78aG+P9SazguoZbbp0WwZkzaY2mz
	 t5J8AszmzdGIw==
Date: Thu, 9 Oct 2025 14:45:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] nvmet: pci-epf: fix DMA channel debug print
Message-ID: <aOeuhoM3J-EHFR9b@ryzen>
References: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_054603_252579_026EFD6F 
X-CRM114-Status: GOOD (  15.74  )
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

On Sat, Sep 13, 2025 at 03:53:50PM +0900, Shin'ichiro Kawasaki wrote:
> Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
> print debug information about the DMA channels for RX and TX. However,
> both calls mistakenly are made for the TX channel. Fix it by referreing
> to 'nvme_epf->rx_chan' and 'nvme_epf->tx_chan' and instead of the local
> variable 'chan'.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Refer to nvme_epf->dma_[rt]x_chan and do not move the dev_dbg() call
> 
>  drivers/nvme/target/pci-epf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2e78397a7373..4bfecb0c7ee4 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -320,12 +320,14 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
>  	nvme_epf->dma_enabled = true;
>  
>  	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
> -		dma_chan_name(chan),
> -		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> +		dma_chan_name(nvme_epf->dma_rx_chan),
> +		dma_get_max_seg_size(dmaengine_get_dma_device(nvme_epf->
> +							      dma_rx_chan)));
>  
>  	dev_dbg(dev, "Using DMA TX channel %s, maximum segment size %u B\n",
> -		dma_chan_name(chan),
> -		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> +		dma_chan_name(nvme_epf->dma_tx_chan),
> +		dma_get_max_seg_size(dmaengine_get_dma_device(nvme_epf->
> +							      dma_tx_chan)));
>  
>  	return;
>  
> -- 
> 2.51.0

Gentle ping


Kind regards,
Niklas

