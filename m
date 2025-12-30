Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30440EE4982
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Dec 2025 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+9er3ijy8U4k2E77vytAGlSR7tVQa7zJgRuZNiyBM50=; b=iQ5YVcRWKBt9J4mrccuVflN+Qo
	wkLnmEGZYGWWklq1CA2bTNwziEOsvkRKdPoj0IVz9NBbhEUxJonV2Sik6HI8N1zRpor4NLr0cw7xN
	qbc09tAeQyZSIumFiPILfWtROfM8r9B2zFVwsDtZh2nEtMU6nHYtAkrficbjXBlgBIEkmRfWA69jM
	JXIYFMM4BIWaOj2ElL1IvyTlYtqGBo7Q9Y+3TzEmrI05L2n8u5BeCucqedU8FXJ+hlqjKGNlLcfsH
	sxmt/vUBIl62wquoBrJ816d8FlC+xDvrQbNtpJoXr2adYvZQnKCqIyWOxmi2WGq4ZIW7pefGHgFXG
	6hf4Ac/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaccj-000000053gf-45B3;
	Tue, 30 Dec 2025 16:31:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacce-000000053fl-2Sud
	for linux-nvme@lists.infradead.org;
	Tue, 30 Dec 2025 16:31:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 68FAA43582;
	Tue, 30 Dec 2025 16:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AD5C4CEFB;
	Tue, 30 Dec 2025 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767112258;
	bh=xBkplaWe3jxxylobUpSj/kmtOngI9khErBF92jtJ7Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0B7Q66UP68nuME1SLqJlEaLnd6guein2q2GVriVleGpkIbJi/3FzCgdqLRe6tVut
	 VyfauZPJ/+h5e1eTVwCM/xL5J0XeV8k5MxgaL9GpsN8Yhz2NQJX5a9PKdBPahkCBH1
	 eXafAuIE/q3h5SEidXfVZr6hsNyMjTy//tXFzWbSOMn6HNhegXnkY4az7ZlExVJ6mH
	 tnzEfhmF3bcW5eYVOqm035d/SoEiemt0Sj+iYxPjuWJi7TCpeKlXbmXcJNQNPw0GAQ
	 B62bmAR3eXaxana49jJlMzaoRpsh77TPI2p1rbUwLqhEftidQFxTnHe8P4m8yy3t5L
	 fvcg789xk9OSA==
Date: Tue, 30 Dec 2025 22:00:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <u5morpcx47pgyg7emt6yhhyivevwtbgvp7xme4uf6ssrcvew2n@yznzt7mj4ns3>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_083100_676986_28E38361 
X-CRM114-Status: GOOD (  16.91  )
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

On Fri, Dec 12, 2025 at 05:24:40PM -0500, Frank Li wrote:
> The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> channels, and modifying them requires a read-modify-write sequence.
> Because this operation is not atomic, concurrent calls to
> dw_edma_v0_core_start() can introduce race conditions if two channels
> update these registers simultaneously.
> 
> Add a spinlock to serialize access to these registers and prevent race
> conditions.
> 

dw_edma_v0_core_start() is called by dw_edma_start_transfer() in 3 places, and
protected by 'chan->vc.lock' in 2 places. Only in dw_edma_device_resume(), it is
not protected. Don't you need to protect it instead?

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> +	unsigned long flags;
>  	u32 tmp;
>  
>  	dw_edma_v0_core_write_chunk(chunk);
> @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			}
>  		}
>  		/* Interrupt unmask - done, abort */
> +		raw_spin_lock_irqsave(&dw->lock, flags);
> +
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
>  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
>  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
>  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> +
> +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> +
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

