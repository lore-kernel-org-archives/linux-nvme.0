Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4A7CCD184
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rqvog1QhV2JU0YdXdX3NM2zkBdnN0KBpmWvzTfASv70=; b=EwelhaXAIeoSNgj78BYgOFzAlh
	ScqRqxWCq+Zkt2jff4R8WDej6py/QVYr5Lt/udsuIPRQJsMF3DKlx6Byv14l7F5hDgeXl089ImN64
	H26k6AgGBpfxF8vbD1MbQM2va6TmzUjzRnXxmfA5uvk6073dfJkxy06uUEPiVzUa5/5FE2BMaYFVo
	KZ89rwSA7vL7Gk4nOmwBGUAufPznPnOs33nUR3K4LW4bi29cldE9UPt1cYoQsOHtuUPwy88NEd3aJ
	P/ssjTfg1nsPWSNz6uKbZn51a89DKRBDkXs2i4JkaoGfuvpkqypg/We1t/nIvGl+sE/qyzMQ48pS7
	N4pcn5bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6q2v-000000068eQ-1JqU;
	Thu, 09 Oct 2025 12:47:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6q2t-000000068du-0yMa
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 12:47:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B5DED46015;
	Thu,  9 Oct 2025 12:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B24DC4CEE7;
	Thu,  9 Oct 2025 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014018;
	bh=4jXmqHuqD7VrpSNjnW3wyubD0AMbmelliRUoP8W2ZHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bB95S1NXNYtZEXb62RcfqfOk5oUa8MXshB6eOozHhC1NLvG/w9X5edO+nQ9J8OI4Y
	 zTR17jTAr7lRieWK3eTc0zJeJvW8e2Y9Ao2tP9MvZehsNZ9qesjr/5LuNsEsKa46oT
	 n3mHTnEFGGiHJI+Ayna9FM5tZXt95NkTGVVH3b7Kvc2GgH7XTvjWOk4+CsTcLn6fhO
	 Zg2YzV65eXCHfLG1Mcb0BROdOaxOAC0KjoMmWkW2UiTzIu9DyzqErEE+ZV/qCBoiKa
	 lWBA8X8iGniy/UtJZHma68gMoR8CY3Zvbe5rZiiqSghTesL0gN3xH876Jab9r3b3Ip
	 /ifETLlPyZuxg==
Date: Thu, 9 Oct 2025 14:46:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init
 callback
Message-ID: <aOeuvipwGfwvQG_C@ryzen>
References: <20250909112121.682086-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909112121.682086-2-cassel@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_054659_287895_70C328CF 
X-CRM114-Status: GOOD (  21.69  )
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

On Tue, Sep 09, 2025 at 01:21:22PM +0200, Niklas Cassel wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> For DMA initialization to work across all EPC drivers, the DMA
> initialization has to be done in the .init() callback.
> 
> This is because not all EPC drivers will have a refclock (which is often
> needed to access registers of a DMA controller embedded in a PCIe
> controller) at the time the .bind() callback is called.
> 
> However, all EPC drivers are guaranteed to have a refclock by the time
> the .init() callback is called.
> 
> Thus, move the DMA initialization to the .init() callback.
> 
> This change was already done for other EPF drivers in
> commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
> initialization to EPC init callback").
> 
> Cc: stable@vger.kernel.org
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2e78397a7373a..9c5b0f78ce8df 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -2325,6 +2325,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
>  		return ret;
>  	}
>  
> +	nvmet_pci_epf_init_dma(nvme_epf);
> +
>  	/* Set device ID, class, etc. */
>  	epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
>  	epf->header->subsys_vendor_id = ctrl->tctrl->subsys->subsys_vendor_id;
> @@ -2422,8 +2424,6 @@ static int nvmet_pci_epf_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	nvmet_pci_epf_init_dma(nvme_epf);
> -
>  	return 0;
>  }
>  
> -- 
> 2.51.0
> 
> 

Gentle ping


Kind regards,
Niklas

