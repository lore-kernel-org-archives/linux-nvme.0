Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793BBC04A95
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZDDjfylRAJRRzhmnDobf1BWErlBOVo9fkQS3AeMsoA=; b=nMeIkyqOdiskBVSYsJWsXaMe3o
	Xjj160+Vkl0ccYITdjLYZ4pDMHnZvadz5HaE2MsAzyosMxyND1XXFfvzPPGGyZuFJK6i0ZHYdPaPi
	ip1HFF+ovWzm0cCZ1tii0kWBjQ1ZamL7eJhC6ivtUvh+VG9qShUNvJg/ZilfU5Afo+9EnUpiGRAMG
	1sITTDwbf7vTeBz+It/bGYWLkp3locVdgZpVXzGKkLXrxeSjWBpU691FRV6BBULx40y1CNFVOBPwu
	htVQWe+MHQEHWZdlgoQ5oJYhLclz+sFvdpfrZ/8n6eKWwmGXjQHE1wsQ1KsUr9In5sFAQaDxYWeTj
	OwA9+W+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odoko-001nBt-NA; Thu, 29 Sep 2022 08:18:46 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odokl-001nA2-Sw
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 08:18:45 +0000
Received: by mail-wr1-f53.google.com with SMTP id bk15so908283wrb.13
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 01:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3ZDDjfylRAJRRzhmnDobf1BWErlBOVo9fkQS3AeMsoA=;
        b=oMsBe89YQj27Nvv6X3/Jyrpgbz3RezDqbJCXNkBQR/DPLQcfEiqjt2ktkGRWHjNRhW
         ej2dKuhwqPH68X1pcVgbVwNI3b2j0JXh0t81EpFSpyiO2ljWEkyuAsxqMDjp5nFZkIZR
         o2MehvTgLXzmIZiujOD77h/SgQLM8NA+i9THwParfB7DACOPDtqVIwRmP7LHchmVvpsu
         sKxHble2+xt3z5ZkpBvkBpViKxVZAxT+Co5cxCF8YxAnAZk9cRKQxxdsAEXxZYOWDRg7
         vIEtDA5ZTyezWOWFtox8Zs7gKberYeMtyph5Z0MZUuJ7Tiqwg7dDWG5Z45RpDULY0ykT
         DMcg==
X-Gm-Message-State: ACrzQf1PWJus++33wy3XbUK4+i+gbqG5apCzSRo+XnlSfGf8GJQLF1RE
	LfmRa+jkzPLW3wKhhQz0x1w2EnK2/Dk=
X-Google-Smtp-Source: AMsMyM4BjIM5wEAjAHZ1MD2TkX4u8HZyGfPUcYjCymKZq2gdXzYoYVnoXl5nYFeSl0986CyCtLVqpw==
X-Received: by 2002:a5d:46c7:0:b0:22c:c9e5:4e4e with SMTP id g7-20020a5d46c7000000b0022cc9e54e4emr1289370wrs.37.1664439519217;
        Thu, 29 Sep 2022 01:18:39 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b003a5f4fccd4asm3908685wmb.35.2022.09.29.01.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:18:38 -0700 (PDT)
Message-ID: <33c9d202-550f-1cd7-3ff4-11559110d672@grimberg.me>
Date: Thu, 29 Sep 2022 11:18:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: Support user mode processing of ZNS Zone Changed
 AEN
Content-Language: en-US
To: clay.mayers@kioxia.com, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20220929001629.2024067-1-clay.mayers@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220929001629.2024067-1-clay.mayers@kioxia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_011843_959191_EF0A7DD6 
X-CRM114-Status: GOOD (  24.99  )
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


> The ZNS Zone-Descriptor-Changes AEN is of type notify and uses CQE.DW1
> to convey the namespace of the log page to read. Unhandled notify AENs
> now generate an NVME_AEN uevent and include the value of CQE.DW1 as a
> new property when non-zero.

But you always send it...

> 
> All unhandled notify events are include to avoid command set specific
> code in the aen handling.  This support is planned to be used by both
> zone based applications and another unreleased device with an alternate
> command set.

This needs to be split into two patches.

> 
> Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
> ---
>   drivers/nvme/host/core.c | 19 +++++++++++--------
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 66446f1e06cf..fa865b8da1d3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4615,17 +4615,20 @@ static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
>   
>   static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>   {
> -	char *envp[2] = { NULL, NULL };
> +	char *envp[3] = { NULL, NULL, NULL };
>   	u32 aen_result = ctrl->aen_result;
> +	u32 aen_data = ctrl->aen_data;
>   
>   	ctrl->aen_result = 0;
> +	ctrl->aen_data = 0;
>   	if (!aen_result)
>   		return;
>   
>   	envp[0] = kasprintf(GFP_KERNEL, "NVME_AEN=%#08x", aen_result);
> -	if (!envp[0])
> -		return;
> -	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +	envp[1] = kasprintf(GFP_KERNEL, "NVME_AEN_DATA=%#08x", aen_data);
> +	if (envp[0] && envp[1])
> +		kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +	kfree(envp[1]);
>   	kfree(envp[0]);
>   }
>   
> @@ -4748,11 +4751,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   		queue_work(nvme_wq, &ctrl->ana_work);
>   		break;
>   #endif
> -	case NVME_AER_NOTICE_DISC_CHANGED:
> +	default:
>   		ctrl->aen_result = result;
>   		break;
> -	default:
> -		dev_warn(ctrl->device, "async event result %08x\n", result);

I'd keep the log... and also don't know if we want to pass any unknown
possible spam to userspace... not sure that being blindly forward
compatible is the right choice here.

>   	}
>   	return requeue;
>   }
> @@ -4799,8 +4800,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   		break;
>   	}
>   
> -	if (requeue)
> +	if (requeue) {
> +		ctrl->aen_data = le64_to_cpu(res->u64) >> 32;

Please use a helper for that.
aen_data is not a great name... maybe use a union for that for the
specific aen subtype?

Maybe it'd be better that zoned namespace aen is handled explicitly
and passes a AEN_NSID env veriable to the uevent.

>   		queue_work(nvme_wq, &ctrl->async_event_work);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1bdf714dcd9e..a1bab447dc65 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -299,6 +299,7 @@ struct nvme_ctrl {
>   	u16 cctemp;
>   	u32 oaes;
>   	u32 aen_result;
> +	u32 aen_data;
>   	u32 ctratt;
>   	unsigned int shutdown_timeout;
>   	unsigned int kato;

