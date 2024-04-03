Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C00CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dQNh8zG/kGVlQrsreazIIF46PNGqTELWJrSf5ITeX8=; b=IBuod7cTtqvKqbmXCGMMbZcj8s
	OhWbMjxi8mHunxYmR5p7c40O9PyuRDQrZQxheJpk5a/NF0cWyXhi6pjs4iNiJo/rKBeEC4UXnyQt9
	dsfnC68ahl7uzc0dAtr8J/HyFPrGdCGhxI1AibTSY3QAMMAg+aJlvjtBCExJCE3HluOf0a7iA3WVW
	mSA4xRqSIxFc8lE7BMIERYAC5ZInlyzKyDWkOoTzopOqsrWckhp22DJpHvIDozbf5bFVcl1JROZdG
	cEzijLl/QQRWSO/1DE3wVZaSJdSOPxrgfaJxqkp23a2MyfcNAllvOORxDc05snG/w/VEApwPKtoXi
	wbSJX9uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrr4l-0000000DkTs-1mu8;
	Wed, 03 Apr 2024 03:14:11 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrr4i-0000000DkTJ-07ku
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 03:14:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F07ACCE0A20;
	Wed,  3 Apr 2024 03:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDADC433C7;
	Wed,  3 Apr 2024 03:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712114044;
	bh=+dapKm5Y+YpPPDSc+rhyuAQ/BG4s4lSmnFLEDe5bunw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGh2C3tOEF0aVvDW0S6lTuFbnciTe0K93vXnDNKURILjRIHXfFPTXG4AhykYjkb0K
	 RozcM5ClusbHYX7sOV9doehE14+kiNt8hnopSJcUjLdFqmdjlDvOu9jxsScyB55aG+
	 /bHCfuTy2mMNt7R0MF++uhbEHeHUHJBRKQYwa5r5neOaAEJ2NihCtKNXQ3V+8Tui2g
	 eqqXPCCDQrIpScfUL8WWI5rIm9nIzXBinCXTQEBIm2w/EwU7rWvYsrH5AZ6+mJksPM
	 fEOgn6pGamQCbuwNqPU38kXopTPdQdLY1x1XloRObz6F99Rx0S9DhSn0J0eAg4W9dP
	 QCvio8QtpIKOQ==
Message-ID: <d4261559-66a5-41c6-b308-992b9e61ce85@kernel.org>
Date: Wed, 3 Apr 2024 12:14:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: split nvme_update_zone_info
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20240402144754.751976-1-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240402144754.751976-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_201408_511367_9AB63E3B 
X-CRM114-Status: GOOD (  23.86  )
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

On 4/2/24 23:47, Christoph Hellwig wrote:
> nvme_update_zone_info does (admin queue) I/O to the device and can fail.
> We fail to abort the queue limits update if that happen, but really
> should avoid with the frozen I/O queue as much as possible anyway.
> 
> Split the logic into a helper to query the information that can be
> called on an unfrozen queue and one to apply it to the queue limits.
> 
> Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
> Reported-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - make sure lbaf is actually initialized
> 
>  drivers/nvme/host/core.c | 19 +++++++++++--------
>  drivers/nvme/host/nvme.h | 12 ++++++++++--
>  drivers/nvme/host/zns.c  | 33 ++++++++++++++++++++-------------
>  3 files changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 943d72bdd794ca..3b0498f320e6b9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2076,6 +2076,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	bool vwc = ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT;
>  	struct queue_limits lim;
>  	struct nvme_id_ns_nvm *nvm = NULL;
> +	struct nvme_zone_info zi = {};
>  	struct nvme_id_ns *id;
>  	sector_t capacity;
>  	unsigned lbaf;
> @@ -2091,6 +2092,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  		ret = -ENODEV;
>  		goto out;
>  	}
> +	lbaf = nvme_lbaf_index(id->flbas);
>  
>  	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
>  		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
> @@ -2098,8 +2100,14 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  			goto out;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ns->head->ids.csi == NVME_CSI_ZNS) {
> +		ret = nvme_query_zone_info(ns, lbaf, &zi);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
>  	blk_mq_freeze_queue(ns->disk->queue);
> -	lbaf = nvme_lbaf_index(id->flbas);
>  	ns->head->lba_shift = id->lbaf[lbaf].ds;
>  	ns->head->nuse = le64_to_cpu(id->nuse);
>  	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
> @@ -2112,13 +2120,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  		capacity = 0;
>  	nvme_config_discard(ns, &lim);
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    ns->head->ids.csi == NVME_CSI_ZNS) {
> -		ret = nvme_update_zone_info(ns, lbaf, &lim);
> -		if (ret) {
> -			blk_mq_unfreeze_queue(ns->disk->queue);
> -			goto out;
> -		}
> -	}
> +	    ns->head->ids.csi == NVME_CSI_ZNS)
> +		nvme_update_zone_info(ns, &lim, &zi);
>  	ret = queue_limits_commit_update(ns->disk->queue, &lim);
>  	if (ret) {
>  		blk_mq_unfreeze_queue(ns->disk->queue);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 24193fcb8bd584..d0ed64dc7380e5 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1036,10 +1036,18 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>  }
>  #endif /* CONFIG_NVME_MULTIPATH */
>  
> +struct nvme_zone_info {
> +	u64 zone_size;
> +	unsigned int max_open_zones;
> +	unsigned int max_active_zones;
> +};
> +
>  int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  		unsigned int nr_zones, report_zones_cb cb, void *data);
> -int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
> -		struct queue_limits *lim);
> +int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
> +		struct nvme_zone_info *zi);
> +void nvme_update_zone_info(struct nvme_ns *ns, struct queue_limits *lim,
> +		struct nvme_zone_info *zi);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>  				       struct nvme_command *cmnd,
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 722384bcc765cd..77aa0f440a6d2a 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -35,8 +35,8 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  	return 0;
>  }
>  
> -int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
> -		struct queue_limits *lim)
> +int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
> +		struct nvme_zone_info *zi)
>  {
>  	struct nvme_effects_log *log = ns->head->effects;
>  	struct nvme_command c = { };
> @@ -89,27 +89,34 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf,
>  		goto free_data;
>  	}
>  
> -	ns->head->zsze =
> -		nvme_lba_to_sect(ns->head, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->head->zsze)) {
> +	zi->zone_size = le64_to_cpu(id->lbafe[lbaf].zsze);
> +	if (!is_power_of_2(zi->zone_size)) {
>  		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->head->zsze, ns->head->ns_id);
> +			"invalid zone size: %llu for namespace: %u\n",
> +			zi->zone_size, ns->head->ns_id);
>  		status = -ENODEV;
>  		goto free_data;
>  	}
> +	zi->max_open_zones = le32_to_cpu(id->mor) + 1;
> +	zi->max_active_zones = le32_to_cpu(id->mar) + 1;
>  
> -	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ns->queue);
> -	lim->zoned = 1;
> -	lim->max_open_zones = le32_to_cpu(id->mor) + 1;
> -	lim->max_active_zones = le32_to_cpu(id->mar) + 1;
> -	lim->chunk_sectors = ns->head->zsze;
> -	lim->max_zone_append_sectors = ns->ctrl->max_zone_append;
>  free_data:
>  	kfree(id);
>  	return status;
>  }
>  
> +void nvme_update_zone_info(struct nvme_ns *ns, struct queue_limits *lim,
> +		struct nvme_zone_info *zi)
> +{
> +	lim->zoned = 1;

Nit: "= true" would be better given that this limit is a bool.

> +	lim->max_open_zones = zi->max_open_zones;
> +	lim->max_active_zones = zi->max_active_zones;
> +	lim->max_zone_append_sectors = ns->ctrl->max_zone_append;
> +	lim->chunk_sectors = ns->head->zsze =
> +		nvme_lba_to_sect(ns->head, zi->zone_size);
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ns->queue);
> +}
> +
>  static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  					  unsigned int nr_zones, size_t *buflen)
>  {

-- 
Damien Le Moal
Western Digital Research


