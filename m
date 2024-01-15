Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14992C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IefIp2t/fh2woePw1t0V08Kx6jHYAq7UuoR9J1vZeXY=; b=UZBSZt76uM4u2mrUqvYRpNdbVw
	XVNQP5cJ5HwU3J5o08lsfUFL9mLEw+auqT8o9W7nx/6yQQdJmLXcPeFCXlhswBiY01+GzKnYT1Tl1
	fHoJhhyeQV4EkWE3oAYsqIuB0luQpdXmeLkaNwu2DdPVy6QWyq8Vd0ySVQsKv8zu1CV/nJKLD2aPs
	1tldxQSaZB2j9MAvU9OUrmSzapMc/Ayl9dhGtvdZf2lEMmZZecE73g+srF9Z2geafojDpfsKb8NvF
	xKrHsgXIxvzKONAekza3yTYeSJ81D4C6/eVRqJE/4mmkEKFSqIzr5S49v/XlxU4wNgH+lBEqdUjUu
	G13wp0GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIp3-008LOC-0a;
	Mon, 15 Jan 2024 08:59:57 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIp0-008LNR-39
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 08:59:56 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c4a4fa736so100888366b.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 00:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309192; x=1705913992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IefIp2t/fh2woePw1t0V08Kx6jHYAq7UuoR9J1vZeXY=;
        b=MJ6Z8ULXH9cTgRBc05V8Taes7PUETQO8qDNDi7Gh7LjBkctVSp+K4kD+IJlVU79c1Y
         Is5SLO2L5TAV5I5IQ3M41aRw5JAE6Sppag5JWNIFjg6UGGGDtaHvm3LpBB2g7+j4Lp9k
         +F+1o8u8nNFsaXeA2OCkznZ7p6wXNmzmqD7x5CYT8i7wVJfW/rQllZ3H7HBBOpHrn6A4
         rR5WhGvlFDmLTNasbwVDtI2e06ssN/92h22OQybN1sk1+4r45ON1qP3iXNFRmzESbliA
         ovu1UFoI3xJx2VE00GIFIZoXnHDzN73BJfWPzeCFOXkQtFkk/B9rWkZjA01UaJAKOAot
         vs4A==
X-Gm-Message-State: AOJu0YwnPvJaToBcn5/qryLvPu6XSf6v3L5w5ndcJcQ3DWCfADNhxTOx
	xgfOQzkdzfup7RCAECJSU6o=
X-Google-Smtp-Source: AGHT+IFSXnYncI3qkwf3Wh4zrafAahqKowPKp4c4GVIZY2A7gu7Jq3nMufFalpthUicDJrbXB2LGfg==
X-Received: by 2002:a17:906:fa92:b0:a28:ab63:db33 with SMTP id lt18-20020a170906fa9200b00a28ab63db33mr5169435ejb.7.1705309192007;
        Mon, 15 Jan 2024 00:59:52 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id cw8-20020a170907160800b00a2cd72af9cesm3768264ejd.146.2024.01.15.00.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 00:59:51 -0800 (PST)
Message-ID: <dcfe1277-bb99-4245-9f28-ae14e8ed8954@grimberg.me>
Date: Mon, 15 Jan 2024 10:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] nvme: introduce pr_work to handle resv event
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
 <20240114092314.63694-4-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240114092314.63694-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_005955_012076_68EF90D0 
X-CRM114-Status: GOOD (  23.43  )
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


> When a reservation event is reported, the corresponding log page is
> already on the target side, and the host side needs to send a get
> log command to clear these log pages.

AENs are already sent to userspace, I don't see why the kernel
should read the log page unless it has something meaningful to
do with it.

> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/core.c | 47 +++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 60f14019f981..a906aea2f4a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4220,6 +4220,47 @@ static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
>   	nvme_reset_ctrl(ctrl);
>   }
>   
> +static void nvme_queue_pr(struct nvme_ctrl *ctrl)
> +{
> +	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
> +		queue_work(nvme_wq, &ctrl->pr_work);
> +}
> +
> +static void nvme_pr_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, pr_work);
> +	struct nvme_pr_log log = { 0 };
> +	int error;
> +
> +	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
> +		return;
> +
> +	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_RESERVATION, 0,
> +			NVME_CSI_NVM, &log, sizeof(log), 0);
> +	if (error) {
> +		dev_warn(ctrl->device,
> +			 "reading reservation log failed: %d\n", error);
> +		return;
> +	}
> +
> +	if (log.nr_avl_pages)
> +		nvme_queue_pr(ctrl);
> +}
> +
> +static void nvme_handle_aen_css(struct nvme_ctrl *ctrl, u32 result)
> +{
> +	u32 aer_css_type = nvme_aer_subtype(result);
> +
> +	switch (aer_css_type) {
> +	case NVME_AEN_RESV_LOG_PAGE_AVALIABLE:
> +		nvme_queue_pr(ctrl);
> +		break;
> +	default:
> +		ctrl->aen_result = result;
> +		dev_warn(ctrl->device, "async event result %08x\n", result);
> +	}
> +}
> +
>   void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   		volatile union nvme_result *res)
>   {
> @@ -4236,6 +4277,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   	case NVME_AER_NOTICE:
>   		requeue = nvme_handle_aen_notice(ctrl, result);
>   		break;
> +	case NVME_AER_CSS:
> +		nvme_handle_aen_css(ctrl, result);
> +		break;
>   	case NVME_AER_ERROR:
>   		/*
>   		 * For a persistent internal error, don't run async_event_work
> @@ -4247,7 +4291,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   		}
>   		fallthrough;
>   	case NVME_AER_SMART:
> -	case NVME_AER_CSS:
>   	case NVME_AER_VS:
>   		ctrl->aen_result = result;
>   		break;
> @@ -4389,6 +4432,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   	nvme_stop_keep_alive(ctrl);
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
> +	flush_work(&ctrl->pr_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
>   	if (ctrl->ops->stop_ctrl)
>   		ctrl->ops->stop_ctrl(ctrl);
> @@ -4494,6 +4538,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->quirks = quirks;
>   	ctrl->numa_node = NUMA_NO_NODE;
>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> +	INIT_WORK(&ctrl->pr_work, nvme_pr_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index e7411dac00f7..6ea4552c4de3 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -334,6 +334,7 @@ struct nvme_ctrl {
>   	struct nvme_effects_log *effects;
>   	struct xarray cels;
>   	struct work_struct scan_work;
> +	struct work_struct pr_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
>   	struct delayed_work failfast_work;

