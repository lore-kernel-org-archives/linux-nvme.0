Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93CC3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJaqmGlj5TkkwWqEb+gsxUJwhTuXKSuSwVaCsIihbaE=; b=b8O5C7w3MV60lKjog7T9cACVbm
	5nskrUkE6sJd6TwpwuSO+Q4lo4ga5yzb/5pj9BVKrjGsiEIkKPLxyiH8WSLk16iiT8DABGA4FkLSt
	gUG2nWhUXqbZqSIP9OUGyMuLTWxW+AIaBryGnLMNc5YJQKyMS4JJbDL6uYsc9snqn3T/wX/EFzwIA
	wKD+g7AeQvAdW+tHXLu4oP2GW6u3D+rugsMlqOV2s4tg/y3JrYi/eEE6Z3EpZtQVy7sktiCDDgcyK
	wL5g3Cyk2szpoMvtazl+ylUHvBG2Cc7NB9xPVaeM0fAjzWaXT3VAJsHZ7tPO20ZbasaCqZwCeYQWw
	z6FBtJ6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFIv-00000000tpc-0vzZ;
	Tue, 06 Aug 2024 08:12:25 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFIY-00000000tjo-0iij
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 08:12:04 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427d71e746aso85855e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Aug 2024 01:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722931920; x=1723536720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJaqmGlj5TkkwWqEb+gsxUJwhTuXKSuSwVaCsIihbaE=;
        b=qYjYxsMVDB3363urGzXBLVGuIhK9f7KLjngwrc46ujFXLQDkcnEfIL3s5mKxxzIRJt
         8f3AwarZeD2ELOVCD2crz6XglK2l5Jup5wGRgs9IHaXglwbuGh05ElqW0WRu2i1euVBv
         idm6R5hYa1dLrGxHjID9w2WV5Kei+X3i+yvVGDDJgx7e1Q74JDk962Cai+C2UjLJVM8q
         gGN6LN9MyhXy6YfOh4/94Udpp4dTJZuVmYS0HRYqtz+s8Ru4/wTdEyRg56pvfJasdW/4
         pNnEnaaTOjHd82NLsohbiDP5JKx4spQ6GRuaZhh/NNENpzUCPb3SjsQBWH9sT1QsVkHd
         jJig==
X-Forwarded-Encrypted: i=1; AJvYcCUPXirxQlSYUUJfmLOHcQBPC80YWGNn4zkq7O+FrxqJizqGJX9do6B49TGS0BqP39ZlypEZp17L9ZBk@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6jajbiviOCfGeUdOCYvNtvKECi8kmuTsyZiXAIGIEVyLtMLTp
	yPtkiCr2SYUprIOAkfPmzEBbz/bg5oWYS6OSQ0+BDoAJyVj6UuCU8f2nsQ==
X-Google-Smtp-Source: AGHT+IGzfYE3pRTpvWAJGqKR9N43Pgm2j9KCbSVPG4Zm4sqAhoDFHsnrXuiAkWXJb7v8kbT6Gv2n4g==
X-Received: by 2002:a05:600c:19d3:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-428e6ba92e9mr63444705e9.6.1722931919384;
        Tue, 06 Aug 2024 01:11:59 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e4073f7bsm190529595e9.18.2024.08.06.01.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:11:58 -0700 (PDT)
Message-ID: <6ec0d9af-1972-4181-bd12-218f0e566cd1@grimberg.me>
Date: Tue, 6 Aug 2024 11:11:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvmet: basic RMEDIA support for target
To: Wang Yugui <wangyugui@e16-tech.com>, linux-nvme@lists.infradead.org
References: <20240806004823.27417-1-wangyugui@e16-tech.com>
 <20240806004928.27605-1-wangyugui@e16-tech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240806004928.27605-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_011202_253991_84E82C6D 
X-CRM114-Status: GOOD (  19.83  )
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




On 06/08/2024 3:49, Wang Yugui wrote:
> Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
> We add Rotational media(RMEDIA) basic support to nvme target.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>   drivers/nvme/target/admin-cmd.c   | 50 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c        |  2 ++
>   drivers/nvme/target/io-cmd-bdev.c |  1 +
>   drivers/nvme/target/nvmet.h       |  1 +
>   4 files changed, 54 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f7e1156ac7ec..20a28102f8a0 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -489,6 +489,53 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +static void nvmet_execute_identify_indep(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_cs_indep  *id;
> +	u16 status;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	/* return an all zeroed buffer if we can't find an active namespace */
> +	status = nvmet_req_find_ns(req);
> +	if (status) {
> +		status = 0;
> +		goto done;
> +	}
> +
> +	if (nvmet_ns_revalidate(req->ns)) {
> +		mutex_lock(&req->ns->subsys->lock);
> +		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
> +		mutex_unlock(&req->ns->subsys->lock);
> +	}
> +
> +	/*
> +	 * Our namespace might always be shared.  Not just with other
> +	 * controllers, but also with any other user of the block device.
> +	 */
> +	id->nmic = NVME_NS_NMIC_SHARED;
> +	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
> +
> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +
> +	id->nstat |= NVME_NSTAT_NRDY;
> +
> +	if(req->ns->rotational)
> +		id->nsfeat |= NVME_INDEP_NS_FEAT_RMEDIA;
> +
> +done:
> +	if (!status)
> +		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_identify_ns(struct nvmet_req *req)
>   {
>   	struct nvme_id_ns *id;
> @@ -706,6 +724,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   			break;
>   		}
>   		break;
> +	case NVME_ID_CNS_NS_CS_INDEP:
> +		nvmet_execute_identify_indep(req);
> +		return;
>   	case NVME_ID_CNS_CS_CTRL:
>   		switch (req->cmd->identify.csi) {
>   		case NVME_CSI_NVM:
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index ed2424f8a396..2790fedb593b 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1254,6 +1254,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>   	else
>   		ctrl->cap |= ctrl->port->max_queue_size - 1;
>   
> +	ctrl->cap |= NVME_CAP_CRMS_CRIMS;
> +
>   	if (nvmet_is_passthru_subsys(ctrl->subsys))
>   		nvmet_passthrough_override_cap(ctrl);
>   }
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 0bda83d0fc3e..d15ad1a864bc 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -104,6 +104,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>   
>   	ns->pi_type = 0;
>   	ns->metadata_size = 0;
> +	ns->rotational = bdev_nonrot(ns->bdev);

Shouldn't this be !bdev_nonrot(ns->bdev) ?

