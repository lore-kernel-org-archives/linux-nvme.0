Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F30EE498B
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Dec 2025 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HPoBjnU2qiGT9CsuNmhjU646sQMtsfbG6pxgtse36c=; b=0VsqQvLn2eTVUxI/UvMUKu3m7b
	HQFWIxT4UIlAOCkP3qHMAde381/DM9ubVc+nYrYlvoqi0eVjg729OArPTvY03g/u0u2Tm6f/YE2SP
	K+S7Cyqq+G3wmL7KmHaBwSuQKkNQIpLNC4UV2OXVzSwUqRgTpB1On6VUhh5AwT2wFZVw7/Ds5WP2c
	/VWRDhtLVZ5aEK1KHJ4FLBIcTAx9zOKYrUPRP6RWSUcVIxRUjZZ0ALh0fF6o6P5mHB8a72tiDyws3
	VM0WmbvJnxKQPnbOPJOmEbE+kJZjmxjG3jCpTGV6tvAzeKolHNCs7mL7lT+/RQdeFwCPi31VXMNfN
	lLqMWnnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vad6K-000000055iL-1inU;
	Tue, 30 Dec 2025 17:01:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vad6H-000000055hw-3eFq
	for linux-nvme@lists.infradead.org;
	Tue, 30 Dec 2025 17:01:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0CCA140734;
	Tue, 30 Dec 2025 17:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325D1C116C6;
	Tue, 30 Dec 2025 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114096;
	bh=3VnALxAJ8sDGakcD3yctJqlVkoErim7xAtZJILR5H+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoO1GjzUeqE3X2GEOY3/uDYes/7Zxk14dxSgVOozzH4No14e2fcAwneozcN7jAJX3
	 ylMysOfStPwrepIt0IZPMyvP9kv9r3fQgRB1audzsvE4+PBBShJBwJcCbJ9WV4y+CE
	 vfUP7Zo2rlDgwRdPF7CPDVxVuZESHJOrO7Oj8451bV0BSzmZ3i91A8H+yTItJ0I3W0
	 kJes6QwItTE0I+eZXOz+nmNVtOfxDlWu7wgpkANQ5JzUUo3N5M34Ne2hpctGiLD78W
	 gWq2yfEKpsVqkE7gBQrEbFW/MoI/FrG2q1pyIdPkRDrflAPCzv0Bm8j2WM/8MFKLPt
	 +Nkdn4ioJtIRA==
Date: Tue, 30 Dec 2025 22:31:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 11/11] dmaengine: dw-edma: Remove struct dw_edma_chunk
Message-ID: <5l2vl7sfnqjylmhve47pyi6tchqkn2n77zskkdisyynfxx3ftp@x55amadqlxph>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-11-fc863d9f5ca3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-edma_ll-v1-11-fc863d9f5ca3@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_090137_972495_2AE42DD4 
X-CRM114-Status: GOOD (  22.10  )
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

On Fri, Dec 12, 2025 at 05:24:50PM -0500, Frank Li wrote:
> The current descriptor layout is:
> 
>   struct dw_edma_desc *desc
>    └─ chunk list
>         └─ burst[]
> 
> Creating a DMA descriptor requires at least two kzalloc() calls because
> each chunk is allocated as a linked-list node. Since the number of bursts
> is already known when the descriptor is created, this linked-list layer is
> unnecessary.
> 
> Move the burst array directly into struct dw_edma_desc and remove the
> struct dw_edma_chunk layer entirely.
> 
> Use start_burst and done_burst to track the current bursts, which current
> are in the DMA link list.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 130 ++++++++++++-------------------------
>  drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
>  2 files changed, 57 insertions(+), 97 deletions(-)
> 

[...]

>  static struct dma_async_tx_descriptor *
> @@ -551,8 +499,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
>  		return;
>  
>  	desc = vd2dw_edma_desc(vd);
> -	if (desc)
> -		residue = desc->alloc_sz - desc->xfer_sz;
> +	residue = desc->alloc_sz;

Now you dereference desc without checking for NULL.

> +
> +	if (desc) {
> +		if (result == DMA_TRANS_NOERROR)
> +			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
> +		else if (desc->done_burst)
> +			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
> +	}
>  
>  	res = &vd->tx_result;
>  	res->result = result;
> @@ -571,7 +525,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  		switch (chan->request) {
>  		case EDMA_REQ_NONE:
>  			desc = vd2dw_edma_desc(vd);
> -			if (!desc->chunks_alloc) {
> +			if (desc->start_burst >= desc->nburst) {
>  				dw_hdma_set_callback_result(vd,
>  							    DMA_TRANS_NOERROR);
>  				list_del(&vd->node);
> @@ -936,7 +890,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  		goto err_irq_free;
>  
>  	/* Turn debugfs on */
> -	dw_edma_core_debugfs_on(dw);
> +	//dw_edma_core_debugfs_on(dw);

debug code?

>  
>  	chip->dw = dw;
>  
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 1930c3bce2bf33fdfbf4e8d99002483a4565faed..ba83c42dee5224dccdf34cec6481e9404a607702 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -46,15 +46,8 @@ struct dw_edma_burst {
>  	u64				sar;
>  	u64				dar;
>  	u32				sz;
> -};
> -
> -struct dw_edma_chunk {
> -	struct list_head		list;
> -	struct dw_edma_chan		*chan;
> -	u8				cb;
> +	/* precalulate summary of previous burst total size */
>  	u32				xfer_sz;
> -	u32                             nburst;
> -	struct dw_edma_burst            burst[] __counted_by(nburst);
>  };
>  
>  struct dw_edma_desc {
> @@ -66,6 +59,12 @@ struct dw_edma_desc {
>  
>  	u32				alloc_sz;
>  	u32				xfer_sz;
> +
> +	u32				done_burst;
> +	u32				start_burst;
> +	u8				cb;
> +	u32				nburst;
> +	struct dw_edma_burst            burst[] __counted_by(nburst);
>  };
>  
>  struct dw_edma_chan {
> @@ -126,7 +125,6 @@ struct dw_edma_core_ops {
>  	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
>  	void (*ch_doorbell)(struct dw_edma_chan *chan);
>  	void (*ch_enable)(struct dw_edma_chan *chan);
> -
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
>  };
> @@ -166,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
>  	return vc2dw_edma_chan(to_virt_chan(dchan));
>  }
>  
> +static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)

No need of inline.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

