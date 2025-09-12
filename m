Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DC9CAC582
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNqTa9UacBtb4KorFaALXmo4mpJrWqBfML92eL6vUBQ=; b=RWveKIc2MK3oZK6Whi+r1yzaIZ
	f+zcv6HSNoLZZEMAfiWtM2UP90+zHS1QspeOXzb/RpXfG5DNUKpaY8ZriXBc/SSaaG/v3jdJYfts+
	HNCc+UdfMhnydqFtRDmwueCz3ogdVAjItTTt3AJud6JkmmMRVa+ZMoRUpyOqjKniiY0pbIt6Pjr1S
	kwOMlEQqVCO6xXq65q7iyxFxSj4fWrwuOO3VTo7RNiED7TIrSt1w+eEXDJeqqF40VLd+Tc1IxBa0g
	zGtwklG3pBnmRdIZvKwV2IHHkunSiqnQzhTuD9U4VpWbPKBvXw0TBqr4vf84Lfh1dk5i1S0lP5wgb
	mSk6n45A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux2fg-000000099kj-3CtN;
	Fri, 12 Sep 2025 12:14:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux2fe-000000099hj-16Il
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 12:14:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AFF943985;
	Fri, 12 Sep 2025 12:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B4FC4CEF1;
	Fri, 12 Sep 2025 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679267;
	bh=qwJUsdABBJlLfNFSilyP3+lcwy6qMRIubeaxoYK1ElU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t84tSmTCqWOR8P7LMlHE7yhGVWnZQYveztNbf/vqK2ygSzXaLA3cfl3a1I2FP9Twx
	 TCKFzRfxLTXTtYFL5tldShPkndFkOQf0OGFNzH+yPLBXFDGrXBYmqPOdOEEuLdovkF
	 rdu/aCwzep7QFOrMs/qKxYYfiKmj90HISc99DKAACWcO5r0HI3C9ZsTZWLrZ0GqHRk
	 F0TrPG+Gum4FPgNXc2J2WlsmME4TDxvPyAiCHMJp6/SbODU4hkpzf8+Xhwp29797oq
	 SRhsxHBGec7aXwZBTEZgt0p1+9N9xRSYnHOhM1iUNmtqAyMKr4mk/PTX+hGfWQF9U+
	 fjJQD4OKtnB9w==
Message-ID: <f7ee6332-60e9-4a1d-b1f1-296066ccdf55@kernel.org>
Date: Fri, 12 Sep 2025 21:14:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: fix DMA channel debug print
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Niklas Cassel <cassel@kernel.org>
References: <20250912111703.676993-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250912111703.676993-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_051430_320780_AD0B7C67 
X-CRM114-Status: GOOD (  15.41  )
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

On 9/12/25 20:17, Shin'ichiro Kawasaki wrote:
> Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
> print debug information about the DMA channels for RX and TX. However,
> both calls mistakenly are made for the TX channel. Fix it so that one
> call prints the RX channel as intended.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/nvme/target/pci-epf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2e78397a7373..cee3ae6f5be7 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -310,6 +310,10 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
>  
>  	nvme_epf->dma_rx_chan = chan;
>  
> +	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
> +		dma_chan_name(chan),
> +		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> +

It would be better to keep this message after "nvme_epf->dma_enabled = true" so
that it is not misleading. So I think you need to have 2 channel variables (e.g.
rxchan and txchan).

>  	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
>  	chan = dma_request_channel(mask, nvmet_pci_epf_dma_filter, &filter);
>  	if (!chan)
> @@ -319,10 +323,6 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
>  
>  	nvme_epf->dma_enabled = true;
>  
> -	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
> -		dma_chan_name(chan),
> -		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> -
>  	dev_dbg(dev, "Using DMA TX channel %s, maximum segment size %u B\n",
>  		dma_chan_name(chan),
>  		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));


-- 
Damien Le Moal
Western Digital Research

