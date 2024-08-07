Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA17AC3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Aug 2024 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WuNDYTrrj/OWq/ui0fLt7dk0dWb6Lg3YGc0EyR1K/jE=; b=BA0wEmrTw/rAT7BsU3va5MvMvf
	Hf4LCFbUJFtKNfikssmrE9wWHTJ73bA8f/Sh8X/VsizAawx/rCUFbyHtiEYghCZe/x9R9vByUv7Sz
	10kZSnCOyD+cij1lBkg3wyyVK1Iioy2qsKv6Etz85eMTzvDhqjoXFCSD1PI/JBon8g97k2TI0Swnl
	h/kRdSQZQnxcjixHk2BeVqWy2+Wfc/robtxujoL6w2u+rbRkMDrdEKN+L0Fo1ghjC7LBGttfcSEeO
	x0ClZjuSSi0weIBvv7g1pa91ORtT0bof+LnvaiXjDq9YxNXwv5NwjNoCe76Ummm9fviFbba7RwZ8W
	Ho9acp7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfZ3-00000004yLR-1ic1;
	Wed, 07 Aug 2024 12:14:49 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfYi-00000004yH4-1RQL
	for linux-nvme@lists.infradead.org;
	Wed, 07 Aug 2024 12:14:29 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36874d7f70bso230250f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Aug 2024 05:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032866; x=1723637666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuNDYTrrj/OWq/ui0fLt7dk0dWb6Lg3YGc0EyR1K/jE=;
        b=CT2TOdyK13hziSN/t6gA+LWbNF2+oBM/OE7Hqvv+eFxjV/K7gvrl369p8xXD2MGWRD
         F7q2BdJNQ0QC39MwH44M2jAg7HrJc7Ih5VlV933kmCuzmeZvaYu8MHFke9kH/QqCj99i
         PyKhvejsZ7WqrWIIImjEuHA2vAnvSFKrYRaD2sucY8K2tPrukKRgOrW8ZN38oC4isizE
         eJu0/W9YIngHqxizLd8+dvHrXvzioaxrjubMHZxhNvIwjbo5mRCESojriHB0Bmenx0ab
         teJgT6dMea7Kc2BOhbW/ryhgxeYUpTG73biM/1lbik3uY2fr+LzQkY/0ktCiXrsh2dqf
         iQJg==
X-Forwarded-Encrypted: i=1; AJvYcCUIaCs72NeuthJDJ+bTh+VlHui6gaFVvmZF7WmiBd82DDWk7DkZ9i4CJBWJlS4T8Ge71bKZK0HwJT7u@lists.infradead.org
X-Gm-Message-State: AOJu0YzKhfaPHEoDcCAQIUJa1x2U/BC8TpCTxrs3Ye4ovdN8VxCWTEdZ
	HZfvl+vSmAeW+DxyKrDpjFWSGdU/QooXbQBS5/po88ZGC6ev/sxjNrEn6w==
X-Google-Smtp-Source: AGHT+IEkpAZ1aPrgVnAONWdVwMrWWyAoPW5jRlXQmSfoka9OUCCOHw7lCjAZNkUIxmsFhevBbh1cVA==
X-Received: by 2002:a05:600c:4515:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-428e6b98524mr79903535e9.4.1723032865103;
        Wed, 07 Aug 2024 05:14:25 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a9d9esm27150045e9.27.2024.08.07.05.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 05:14:24 -0700 (PDT)
Message-ID: <4fca6886-beed-4615-b01f-52499d0f01d2@grimberg.me>
Date: Wed, 7 Aug 2024 15:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3] nvmet: basic RMEDIA support for target
To: Wang Yugui <wangyugui@e16-tech.com>, linux-nvme@lists.infradead.org
References: <20240806004928.27605-1-wangyugui@e16-tech.com>
 <20240806124026.43168-1-wangyugui@e16-tech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240806124026.43168-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240807_051428_418504_6C2B6347 
X-CRM114-Status: GOOD (  23.68  )
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




On 06/08/2024 15:40, Wang Yugui wrote:
> Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
> We add Rotational media(RMEDIA) basic support to nvme target.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
> changelog of PATCH RFC v3
> - restore the process nvmet_req_find_ns() dropped in v2
> changelog of PATCH RFC v2
> - change 'bdev_nonrot(ns->bdev)' to '!bdev_nonrot(ns->bdev)' based on comment.
> - add some support for 'nvme cmdset-ind-id-ns'
>
>   drivers/nvme/target/admin-cmd.c   | 42 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c        |  2 ++
>   drivers/nvme/target/io-cmd-bdev.c |  1 +
>   drivers/nvme/target/nvmet.h       |  1 +
>   4 files changed, 55 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f7e1156ac7ec..20a28102f8a0 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -489,6 +489,54 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
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
> +	/*
> +	 * Our namespace might always be shared.  Not just with other
> +	 * controllers, but also with any other user of the block device.
> +	 */

Non useful comment. especially the other users part...

> +	id->nmic |= NVME_NS_NMIC_SHARED;
> +

unneeded newline.

> +	id->nstat |= NVME_NSTAT_NRDY;
> +
> +	/* return an all zeroed buffer if we can't find an active namespace */
> +	status = nvmet_req_find_ns(req);
> +	if (status) {
> +		status = 0;
> +		goto done;
> +	}

I think this should move up to be first...

> +
> +	if (nvmet_ns_revalidate(req->ns)) {
> +		mutex_lock(&req->ns->subsys->lock);
> +		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
> +		mutex_unlock(&req->ns->subsys->lock);
> +	}

This should move down to be last.

> +
> +	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
> +
> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +
> +	if (req->ns->rotational)
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
> @@ -706,6 +745,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
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
> +	ns->rotational = !bdev_nonrot(ns->bdev);
>   	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
>   		nvmet_bdev_ns_enable_integrity(ns);
>   
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 190f55e6d753..86eeeadf3787 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -62,6 +62,7 @@ struct nvmet_ns {
>   	struct block_device	*bdev;
>   	struct file		*file;
>   	bool			readonly;
> +	bool			rotational;
>   	u32			nsid;
>   	u32			blksize_shift;
>   	loff_t			size;


