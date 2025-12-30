Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8937EE498B
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Dec 2025 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDN9aAsp2T3VIcG8w3tHm7UISOaL7e+OTL6xRiwmjDc=; b=COof00TT+6nS7VWnscyZsjxg++
	fOPbAeDG2abw8e1AC7b473sIcCqnkURw4ch3yDT0/Q3Z+XAJZOWaqRLhdysTnSA+7WblzAuked8ts
	DYkjsMOPdq9TvwkdrwyWUlRpsrts6Vg03I/Q/PEemzUaZmIfnTONYEx3CogPhiE7pA/ru3mnBu759
	AB89DtaDGbx4AfutFynxM2PILCd39cnzkXf8PmIPx956LUfRj17JhFZJqcb5rFIu05Jnjkg+qdJzO
	iHo8JxdCgDljdF+DsKyJWYLJyEVxcIXe/FVeG33TdWvz0YTkWrnok4WT0CeAuzobIJhaEi3R6BWXy
	fXLX2dug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacls-0000000548c-2Cv6;
	Tue, 30 Dec 2025 16:40:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaclm-0000000548B-3DC8
	for linux-nvme@lists.infradead.org;
	Tue, 30 Dec 2025 16:40:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 550154165A;
	Tue, 30 Dec 2025 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904ABC4CEFB;
	Tue, 30 Dec 2025 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767112824;
	bh=pXu1dGg3HAHzpe2BeHtRhRxDDAPPwz+O+fOZU5/mlek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcYUBfUcTd/PNGCZMa3EK/N/rG+xwj7WnWVLb2cqf566uM+EJkk8iygVXp8LnaiPn
	 oPHzs2p+vOlXF5NSq3JlrkXg5DdHHfie/GzA0AE2THzwJD8/IaovEPbLtFW6vU2V53
	 HZNQEakIHIIDPHKcRYn0eiwwRbWMTVHaVqQhWn2BozkAjbAUDIQ9rXA0NtHvgSpwwB
	 edbXTk6kvCrThuEg8CffVVEmtbpALeNd8UyR/N7MkfSpuWPKn+Fk44iNWYiSZCaJ6b
	 lQH8yIsAyi9JQcP4yZ75UYXC+jwrWhU69DcaI7PwTzdxVPqBZeuq0kxWlqQ9cfFiJJ
	 GU0z++4eeG28w==
Date: Tue, 30 Dec 2025 22:10:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 08/11] dmaengine: dw-edma: Add new callback to fill link
 list entry
Message-ID: <coijbx3ubd5o5kf6tmqoxeecymat55lvcjkdoda5x6nyaluytu@bk3hfybsbap2>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-8-fc863d9f5ca3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-edma_ll-v1-8-fc863d9f5ca3@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_084026_864434_DEEDF5A4 
X-CRM114-Status: GOOD (  22.37  )
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

On Fri, Dec 12, 2025 at 05:24:47PM -0500, Frank Li wrote:
> Introduce a new callback to fill a link list entry, preparing for the
> future replacement of dw_(edma|hdma)_v0_core_start().
> 

You are introducing 4 new callbacks for different purposes.

> Filling link entries will become more complex, and both the EDMA and HDMA
> paths would otherwise need to duplicate the same logic. Add a fill-entry
> callback so that common code can be moved into dw-edma-core.c and shared
> cleanly.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.h    | 31 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index e074a6375f8a6853c212e65d2d54cb3e614b1483..2b5defae133c360f142394f9fab35c4748a893da 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -125,6 +125,12 @@ struct dw_edma_core_ops {
>  	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  				  dw_edma_handler_t done, dw_edma_handler_t abort);
>  	void (*start)(struct dw_edma_chunk *chunk, bool first);
> +	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
> +			u32 idx, bool cb, bool irq);
> +	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
> +	void (*ch_doorbell)(struct dw_edma_chan *chan);
> +	void (*ch_enable)(struct dw_edma_chan *chan);
> +
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
>  };
> @@ -201,6 +207,31 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
>  	chan->dw->core->ch_config(chan);
>  }
>  
> +static inline void

No inline please.

- Mani

> +dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
> +		     u32 idx, bool cb, bool irq)
> +{
> +	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
> +}
> +
> +static inline void
> +dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
> +{
> +	chan->dw->core->ll_link(chan, idx, cb, addr);
> +}
> +
> +static inline
> +void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
> +{
> +	chan->dw->core->ch_doorbell(chan);
> +}
> +
> +static inline
> +void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
> +{
> +	chan->dw->core->ch_enable(chan);
> +}
> +
>  static inline
>  void dw_edma_core_debugfs_on(struct dw_edma *dw)
>  {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index cd99bb34452d19eb9fd04b237609545ab1092eaa..59ee219f1abddd48806dec953ce96afdc87ffdab 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
>  	}
>  }
>  
> +static void
> +dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
> +			u32 idx, bool cb, bool irq)
> +{
> +	u32 control = 0;
> +
> +	if (cb)
> +		control |= DW_EDMA_V0_CB;
> +
> +	if (irq) {
> +		control |= DW_EDMA_V0_LIE;
> +
> +		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			control |= DW_EDMA_V0_RIE;
> +	}
> +
> +	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
> +				 burst->dar);
> +}
> +
> +static void
> +dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
> +{
> +	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
> +
> +	if (!cb)
> +		control |= DW_EDMA_V0_CB;
> +
> +	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
> +}
> +
> +static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	dw_edma_v0_sync_ll_data(chan);
> +
> +	/* Doorbell */
> +	SET_RW_32(dw, chan->dir, doorbell,
> +		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> +}
> +
>  /* eDMA debugfs callbacks */
>  static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
> @@ -521,6 +563,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.ch_status = dw_edma_v0_core_ch_status,
>  	.handle_int = dw_edma_v0_core_handle_int,
>  	.start = dw_edma_v0_core_start,
> +	.ll_data = dw_edma_v0_core_ll_data,
> +	.ll_link = dw_edma_v0_core_ll_link,
> +	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
> +	.ch_enable = dw_edma_v0_core_ch_enable,
>  	.ch_config = dw_edma_v0_core_ch_config,
>  	.debugfs_on = dw_edma_v0_core_debugfs_on,
>  };
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 953868ef424250c1b696b9e61b72ba9a9c7c38c9..94350bb2bdcd6e29d8a42380160a5bd77caf4680 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -287,6 +287,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
>  }
>  
> +static void
> +dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
> +			u32 idx, bool cb, bool irq)
> +{
> +	u32 control = 0;
> +
> +	if (cb)
> +		control |= DW_HDMA_V0_CB;
> +
> +	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
> +				 burst->dar);
> +}
> +
> +static void
> +dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
> +{
> +	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> +
> +	if (!cb)
> +		control |= DW_HDMA_V0_CB;
> +
> +	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
> +}
> +
> +static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	dw_hdma_v0_sync_ll_data(chan);
> +
> +	/* Doorbell */
> +	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> +}
> +
>  /* HDMA debugfs callbacks */
>  static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
> @@ -299,6 +333,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.ch_status = dw_hdma_v0_core_ch_status,
>  	.handle_int = dw_hdma_v0_core_handle_int,
>  	.start = dw_hdma_v0_core_start,
> +	.ll_data = dw_hdma_v0_core_ll_data,
> +	.ll_link = dw_hdma_v0_core_ll_link,
> +	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
> +	.ch_enable = dw_hdma_v0_core_ch_enable,
>  	.ch_config = dw_hdma_v0_core_ch_config,
>  	.debugfs_on = dw_hdma_v0_core_debugfs_on,
>  };
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

