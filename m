Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965E8D58060
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FG8n4tPKSGrUjaE+/uG4vf/iDOyIXHTfv7aHzUhLPI=; b=1/CuQ43Yi7IuqUolCKDRk3yc7U
	A2RCCubHxpMoG6lwiapyAAfFKc56Ny0BcdKR64a5/0AVufG16x57brkJU3FELdrQPzEh9hG7y6zF4
	iY/fFwYWbjrLuEHAOv3zx/xBAEti2aPp1NxCu4FdGj3qzxcMn0YJ0FLYr7+zsrk5khAXQ5pNcdU6k
	MDiTHdTbd4mXcvXUHdpToyDpesaUKVY30kUOzIyBVZCbX3bDwyllV5JyPCLAUNHrKCVPCYuEZP/u7
	37nl1lod66xw1sKaPvaxAGFcbRABZyRKsKIr6sj1rEE3rxpYgc6dAfkh0ZJcG2q+d2h06RrTL9ZpC
	dEUaO/Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWqy-00000007qCA-3xcI;
	Mon, 25 Nov 2024 11:02:04 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWqw-00000007qAs-0fmp
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 11:02:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B391EA4157A;
	Mon, 25 Nov 2024 11:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A394AC4CECE;
	Mon, 25 Nov 2024 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732532520;
	bh=CP3zKWwbrslisE/UbWI1G3xhio1GOyNDf3EQtEW9i0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEgjRShrCLRpFY9hOj2srl0D/Jz353RVz93aun0r7PdnqHBRuDAimkumEss5nwiJU
	 1qFx/oGTtOmRtE4FJlS3pcbe8toQds8KePvjNprSVP2UFWnR4twt3E8YrPLc0qR5xb
	 5MHCM0iB+rPFCW9t9W9bEu0F3LwObYti3kBNGgJNYDfBU+AloYVuq+qaBq6qgnzSf5
	 z7hCFWxglFAU0iy/v9aGIgB4PtFVIqR8D9M/LmuniceIVDp2unUjngTPZwDtSKOr8H
	 beL7uOCloKR5KxjsYSGP4TjQI5D4DT48xWvnS0u934OhljTg2EHmQNRcVEao5bY3S/
	 paFrpzJ0uydQA==
Date: Mon, 25 Nov 2024 12:01:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <Z0RZAKgUA7jS1U_m@ryzen>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_030202_327519_59D633D4 
X-CRM114-Status: GOOD (  31.24  )
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

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> We initially put in a quick fix of limiting the queue depth to 1
> as experimentation showed that it fixed data corruption on 64GB
> steamdecks.
> 
> After further experimentation, it appears that the corruption
> is fixed by aligning the small dma pool segments to 512 bytes.
> Testing via desync image verification shows that it now passes
> thousands of verification loops, where previously
> it never managed above 7.
> 
> Currently it is not known why this fixes the corruption.
> Perhaps it is doing something nasty like using an mmc page
> as a cache for the prp lists (mmc min. page size is 512 bytes)
> and not invalidating properly, so that the dma pool change to
> treats segment list as a stack ends up giving a previous
> segment in the same cached page.
> 
> This fixes the previous queue depth limitation as it fixes
> the corruption without incurring a 37% tested performance
> degredation.
> 
> Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/nvme/host/nvme.h | 5 +++++
>  drivers/nvme/host/pci.c  | 6 +++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 093cb423f536..61bba5513de0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -173,6 +173,11 @@ enum nvme_quirks {
>  	 * MSI (but not MSI-X) interrupts are broken and never fire.
>  	 */
>  	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
> +
> +	/*
> +	 * Align dma pool segment size to 512 bytes
> +	 */
> +	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4b9fda0b1d9a..6fcd3bb413c4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2700,8 +2700,8 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
>  		return -ENOMEM;
>  
>  	/* Optimisation for I/Os between 4k and 128k */
> -	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
> -						256, 256, 0);
> +	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,256,
> +				       dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512 ? 512 : 256, 0);
>  	if (!dev->prp_small_pool) {
>  		dma_pool_destroy(dev->prp_page_pool);
>  		return -ENOMEM;
> @@ -3449,7 +3449,7 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
> -		.driver_data = NVME_QUIRK_QDEPTH_ONE },
> +		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
>  	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_BOGUS_NID, },
> -- 
> 2.45.2
> 
> 

+CC: Gwendal

Since he sent out a patch to revert the original QD=1 quirk,
claiming that the quirk wasn't needed when using the same
NVMe to eMMC bridge with another eMMC device.

If the quirk is really per eMMC device (from reading about this
problem, it sure sounds like a controller issue...), but if this
problem is really eMMC device related, then probably the quirk
should be applied only for certain eMMC devices instead.


Kind regards,
Niklas

