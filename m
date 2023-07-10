Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB876EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 03:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UajrNbaE/zLoH3XX6QcsZ6Fcb6rWO/W1RJyDXg0P7jc=; b=01MphSp/20DmOX+7Js/fzlteXT
	AhID1PQ5VEaMq5kak1Y89TZLnOfPkjc4n1qaN5xSksJqT/pZ1yseMiO1YSsjgy8m1f/zy38WepglJ
	OIi24VYTIWQQP6iSaI7xYnceQtKElYx3NyQ2YZGnhrpUMGCqN3UQo14ASqlYSig5021gax7CoCIAP
	m2YcDoWc2rcT3TmdaaJV1zcz421GPNpt8cCIG5kIC507eTqYprAHqIhegkLI7e7anzi+092Z2Wa6N
	JFvBKuUfiaogiBCtqH8o/TKhjGlFLwPZfcKaaUNEYydIoBla8gpxZm8goJQ+CYnbazA+O9ryidGFm
	vbO68PmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIi2D-00AKum-1q;
	Mon, 10 Jul 2023 03:58:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIi2B-00AKuL-0Q
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 03:58:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 982BB6068C;
	Mon, 10 Jul 2023 03:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1CDC433C7;
	Mon, 10 Jul 2023 03:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688961478;
	bh=lQdyZiTfVnmXKovigAFLm9tCnJJlmsrdXPhNn79RqWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NI6bONp2fCLoG9dfYHbGlIAYtkyK0LoE1GwOJZsSztHeCStzlEUDm4ePtgjyLP37v
	 dFDzZBPIbC0SY38t3h8u3Svr1nM9rzExLAob4HnhcXAup0uQZq4xp0BlJ3trP3+NbB
	 xAd6lPSTf66s7AoGr6Fw5erSvsZeSM+rWPgAZNGnIpg6dLwOPyVH6FpcArdaarbrgT
	 I2pme/Jd+2Z0OYgYrsE3PdSulJ0PqC0tMtueRQButdt2jbuwNS8BxKeTqS3pbtcxgg
	 7kNYS+ZUs6+xnSNBjg17XDKV4Mx3uBf9esm/rAKQQ9zFS+AQViAgj3CUAJt0sXrqJy
	 nZjm83K3cqu2g==
Message-ID: <06da81f9-dbdd-f706-0e26-afcfb89cfe32@kernel.org>
Date: Mon, 10 Jul 2023 12:57:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230707094616.108430-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_205759_244550_47D03263 
X-CRM114-Status: GOOD (  25.90  )
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

On 7/7/23 18:46, Christoph Hellwig wrote:
> ctrl->max_discard_sectors stores a value that is potentially based of
> the DMRSL field in Identify Controller, which is in units of LBAs and
> thus dependent on the Format of a namespace.
> 
> Fix this by moving the calculation of max_discard_sectors entirely
> into nvme_config_discard and replacing the ctrl->max_discard_sectors
> value with a local variable so that the calculation is always

I do not see a local variable replacement... May be you meant direct calls to
blk_queue_max_discard_sectors() ?

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> namespace-specific.
> 
> Fixes: 1a86924e4f46 ("nvme: fix interpretation of DMRSL")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 22 ++++++++++------------
>  drivers/nvme/host/nvme.h |  1 -
>  2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2d6c1f4ad7f5c8..05372bec3b7aff 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1721,20 +1721,21 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	struct request_queue *queue = disk->queue;
>  	u32 size = queue_logical_block_size(queue);
>  
> -	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
> -		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
> +	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
> +			NVME_DSM_MAX_RANGES);
>  
> -	if (ctrl->max_discard_sectors == 0) {
> +	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX)) {
> +		blk_queue_max_discard_sectors(queue,
> +				nvme_lba_to_sect(ns, ctrl->dmrsl));
> +	} else if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
> +		blk_queue_max_discard_sectors(queue, UINT_MAX);
> +	} else {
>  		blk_queue_max_discard_sectors(queue, 0);
>  		return;
>  	}
>  
> -	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
> -			NVME_DSM_MAX_RANGES);
> -
>  	queue->limits.discard_granularity = size;
>  
> -	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
>  	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  
>  	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
> @@ -2870,13 +2871,10 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>  	struct nvme_id_ctrl_nvm *id;
>  	int ret;
>  
> -	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
> -		ctrl->max_discard_sectors = UINT_MAX;
> +	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
>  		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
> -	} else {
> -		ctrl->max_discard_sectors = 0;
> +	else
>  		ctrl->max_discard_segments = 0;
> -	}
>  
>  	/*
>  	 * Even though NVMe spec explicitly states that MDTS is not applicable
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f35647c470afad..d59ed2ba1c37ca 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -296,7 +296,6 @@ struct nvme_ctrl {
>  	u32 max_hw_sectors;
>  	u32 max_segments;
>  	u32 max_integrity_segments;
> -	u32 max_discard_sectors;
>  	u32 max_discard_segments;
>  	u32 max_zeroes_sectors;
>  #ifdef CONFIG_BLK_DEV_ZONED

-- 
Damien Le Moal
Western Digital Research


