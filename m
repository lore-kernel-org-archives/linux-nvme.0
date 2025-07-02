Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F6BC8303D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxYpymCKJ5C/mBaUO0RNrafUJYwf9CTXITh3Zt7Lm84=; b=mh9a0G39lEhjnVThakQSP+rNG6
	YM5YGolqN5QTne6fOXOEhizOGhK4fapo4xrKRpcJ0eaoF8NgpblFCd7l+BRpRZVJCqn4+z/gJrzny
	qvyhBUGprwCfmPd0WqMB6682TfZfzJzwQ6KSxzSlZTlvQd3OIpyPbnLc4KiPg+SwAudngmcLsh5Rv
	pOrYf+mFOKeZUmYZUUr8sEwBySfnswSr70oZbw/ru9+5VMf4eKIk+2wbHrmRlgwYDbjXSdoY7Y95V
	PArq3elDg2YONS717fIc0iHDYqQsTADdr/J75t4YhaAYwTSRcDnQkIgBt7fuynwOrZV6xOegWYt0u
	cqpvBFGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWmxY-0000000722h-1jlw;
	Wed, 02 Jul 2025 02:12:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWmwk-000000071va-27NM
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 02:11:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BAA3E43679;
	Wed,  2 Jul 2025 02:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752FAC4CEEB;
	Wed,  2 Jul 2025 02:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751422297;
	bh=ZxpM08Bm9vTyHYsL4UkOghyZQdZk96l4oAe+fmDSvVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HvlZUjcare6+dM2Ep+4iNdig/DyZTKDhF+0jHyBdJKZNiHvt/uh/+tltl61kRoIot
	 3dfQ0z2ivrdAhWt7Z9h7sAcRrTmrRUEjeqHveCiAHOVC6ERbCy/+0/6SGcNO3hWC4g
	 Auy4FVam0fTXHejp+0AehKz5OXJwFVnz9YCydgzZ3et70SdyVrNm1ZUv8TJh/y1J1w
	 ygVv8uhnHbuwlK5y66T61yV4NUhQ6BWkOYBnwPCCM8veUIW9n+5mD/wAVYWSgp2gVP
	 aoJ78wjRQrSwpWnffXHS1eISxlnnVxgl5ttxWmWncG7sjMLZF/vUEUvh6whqlipnkG
	 nvZuBoSUFc/zg==
Message-ID: <22f8ec86-2d50-4237-9313-79bfc93c8e3d@kernel.org>
Date: Wed, 2 Jul 2025 11:11:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme: add capability to connect to an admin
 controller
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-2-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250702005830.889217-2-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_191138_569566_76F181EF 
X-CRM114-Status: GOOD (  20.23  )
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

On 7/2/25 09:58, Kamaljit Singh wrote:
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> 
> Add capability to connect to an administrative controller by
> preventing ioq creation for admin-controllers.
> 
> * Add helper nvme_admin_ctrl() to check for an administrative controller
> * Add helper nvme_override_prohibited_io_queues() to override
>   queue_count in nvme_ctrl
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>  drivers/nvme/host/core.c | 21 +++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/rdma.c |  2 ++
>  drivers/nvme/host/tcp.c  |  2 ++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e533d791955d..a1155fb8d5be 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3149,6 +3149,22 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
>  	return ctrl->opts && ctrl->opts->discovery_nqn;
>  }
>  
> +static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	return (ctrl->cntrltype == NVME_CTRL_ADMIN);

No need for the parenthesis.

> +}
> +
> +/*
> + * An admin controller has one admin queue, but no I/O queues.
> + * Override queue_count so it only creates an admin queue.
> + */
> +void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	if (nvme_admin_ctrl(ctrl))
> +		ctrl->queue_count = 1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);

Why not have this done in nvme_init_subsystem() ? That would avoid needing to
call this in all fabrics drivers.

> +
>  static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>  		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  {
> @@ -3215,6 +3231,11 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  		kfree(subsys);
>  		return -EINVAL;
>  	}
> +	if (nvme_admin_ctrl(ctrl))
> +		dev_info(ctrl->device,
> +			"Subsystem %s is an administrative controller",
> +			subsys->subnqn);

We do not print an equivalent message for other subsystem controller types. So
drop this.

> +
>  	nvme_mpath_default_iopolicy(subsys);
>  
>  	subsys->dev.class = &nvme_subsys_class;


-- 
Damien Le Moal
Western Digital Research

