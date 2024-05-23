Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783F7C25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbVYzX2xhQbqadrfoasV4OzWTKZKnKq+Oeef8jBG8Ho=; b=yo+IbZBlJrlbI7i9+jvi9uirY/
	It4peYUNTUJRe/TiPU1u0iHSfDt+5QArgdSEljclD49y9imlaJwf5555OR6eTNhPTlDds61HHNxe2
	V3MTJ9pR5MYsPI4bIgzLfRYSCS7zPISpTRhjGgln01EO6sIL9030C/gx/fs9U52YkxKpCxThBz/bS
	gl3DRCzmFkZ/1OddnANDD+VBamf6uAaZDwe6U3W4d9uRA0/p91WyqkmS0myvyvAq2ExF+e33rjPWy
	7iQ/bSvej3TFml/f6j42P8BocmdXAIoqAeyWOTg7P0yKR9IzOWLIoLZ94RilqFLnluRnzw3ESmXzh
	dxRMx0vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA7oR-00000006E7U-3C1k;
	Thu, 23 May 2024 12:44:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA7oP-00000006E65-0eAm
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 12:44:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF22D68D07; Thu, 23 May 2024 14:44:45 +0200 (CEST)
Date: Thu, 23 May 2024 14:44:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Damien LeMoal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fixup zns namespace initialisation
Message-ID: <20240523124445.GA20879@lst.de>
References: <20240523115810.133470-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523115810.133470-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_054449_365859_9146E0CB 
X-CRM114-Status: GOOD (  16.74  )
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

On Thu, May 23, 2024 at 01:58:10PM +0200, Hannes Reinecke wrote:
> nvme_set_chunk_sectors() needs to know whether it's a zoned namespace
> or not, but the information is only set in a later call.

Where "needs to know" means the blk_queue_is_zoned check to warn if
an I/O boundary is set for a zoned namespaces? 

> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1952,6 +1952,12 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
>  	lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;
>  	lim->max_segment_size = UINT_MAX;
>  	lim->dma_alignment = 3;
> +	lim->chunk_sectors = 0;
> +	lim->zoned = false;
> +	lim->max_open_zones = 0;
> +	lim->max_active_zones = 0;
> +	lim->zone_write_granularity = 0;
> +	lim->max_zone_append_sectors = 0;

I can't see why we'd need or want this part.

>  static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
> @@ -2115,13 +2121,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	lim = queue_limits_start_update(ns->disk->queue);
>  	nvme_set_ctrl_limits(ns->ctrl, &lim);
>  	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ns->head->ids.csi == NVME_CSI_ZNS)
> +		nvme_update_zone_info(ns, &lim, &zi);
>  	nvme_set_chunk_sectors(ns, id, &lim);
>  	if (!nvme_update_disk_info(ns, id, &lim))
>  		capacity = 0;
>  	nvme_config_discard(ns, &lim);
> -	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    ns->head->ids.csi == NVME_CSI_ZNS)
> -		nvme_update_zone_info(ns, &lim, &zi);

This part looks fine, but you probably also want to replace the
blk_queue_is_zoned() check with one for lim->zoned for this to
actually work..


