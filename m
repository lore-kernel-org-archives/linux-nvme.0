Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68964C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHi8dJNqobzD3IwreBYNcWOia+E1Pkt5zMv76aWUsuI=; b=vPFxFfsGllRepBDB0txL0ihxmt
	A0IKbmJglyT3HoDcCnSlNnpvIcmmvSbTfGncF8aY1Od8jW23DQAHKvu1F19iTm9I3OoUDutjd/I4O
	vin7Z2dHVbMqanDkAMHBNeK8sz4i/jHHeBb+t3gIQazEhT2hEhjR2rtbsHblAeAOWb50cMIFJAE2j
	rW9b31VxmoWWTWmyKUuZoWAPpOefVlm3RCt2SJqQv0cLZTaOG2P0rZ0Vp6O/r1OQtnDjteaqmav/G
	aIAq3UppSkGJ+R5pOVeOe1Z+JDB2Ehb7H3yte4H7FqoZl7rUBNydVEgn7gbEF0416lU+ilAv0W/Td
	rbgy/LUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjHKh-00EulX-31;
	Mon, 03 Apr 2023 10:22:39 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjHKc-00EujK-1X
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 10:22:38 +0000
Received: by mail-wr1-f42.google.com with SMTP id v1so28770167wrv.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 03:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHi8dJNqobzD3IwreBYNcWOia+E1Pkt5zMv76aWUsuI=;
        b=3Sk/ohqmvQqTfIQtsCFTK9Csblx5ecwFUQv0+IGo26n/b0LZzNIKLqFo1FT6v9zdfQ
         trnCftPi9PfAf6uOH6lpgm0eTntUaBrQS5mtH7zkTuNxSDRxdu/o7qkQXs9SoyrGU6Jj
         thA+crCOUXk4G4Qad6HED/wmQkyG+V//hejk6wOqsYUYxSzHH0j142BFF+24m6Tg9Zss
         qhI99rQG1zCTyj4ZPWAPw/qZ7hkAAAUK4kGsnqyFjdsTK2qQulrdkhE9vwoMxVjkUYar
         fm2+9xpnCOV+zH2VIK07yN+gKDeQ/CJYCTELkjWnMNCKONJCDA2kI04eqozMPLR5q5p4
         EoyA==
X-Gm-Message-State: AAQBX9eMxtWh886ML2djed48KivOYtO0RTETJDnjHlSZxL9nQHK1FxZe
	T3f9fEaHpiKQnFCudXpp3oHY7fYNJSg=
X-Google-Smtp-Source: AKy350alq5MXcSlaIsuJTqDAX3LNY38qNkwFuvkkF4tQ7KExhGJTR+aHJ2pThUixskEm59jF+9N7mw==
X-Received: by 2002:adf:ee8a:0:b0:2e4:c9ac:c492 with SMTP id b10-20020adfee8a000000b002e4c9acc492mr8149939wro.1.1680517350808;
        Mon, 03 Apr 2023 03:22:30 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w3-20020adfcd03000000b002d45575643esm9338220wrm.43.2023.04.03.03.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:22:30 -0700 (PDT)
Message-ID: <38fbc59a-94cf-9764-e4c4-0fd3c8f3830b@grimberg.me>
Date: Mon, 3 Apr 2023 13:22:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
Content-Language: en-US
To: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de
Cc: kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
References: <ZCoguA3gBUw1CIdd@archlinux>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZCoguA3gBUw1CIdd@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_032234_527488_1E3B0DB5 
X-CRM114-Status: GOOD (  18.07  )
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



On 4/3/23 03:41, Irvin Cote wrote:
> Correcting the de-reference count for
> the controller in the core layer to avoid
> a memory leak.

Is this a regression?

> Also cleaning a bit the teardown logic of nvme_init_ctrl.

This is a good cleanup.

> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>   drivers/nvme/host/core.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8698410aeb84..3d7aca7d0f2a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5137,14 +5137,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>   			PAGE_SIZE);
>   	ctrl->discard_page = alloc_page(GFP_KERNEL);
> -	if (!ctrl->discard_page) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!ctrl->discard_page)
> +		return -ENOMEM;
>   
>   	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
>   	if (ret < 0)
> -		goto out;
> +		goto out_free_page;
>   	ctrl->instance = ret;
>   
>   	device_initialize(&ctrl->ctrl_device);
> @@ -5191,10 +5189,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	nvme_put_ctrl(ctrl);
>   	kfree_const(ctrl->device->kobj.name);
>   out_release_instance:
> +	nvme_put_ctrl(ctrl);
>   	ida_free(&nvme_instance_ida, ctrl->instance);
> -out:
> -	if (ctrl->discard_page)
> -		__free_page(ctrl->discard_page);
> +out_free_page:
> +	__free_page(ctrl->discard_page);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);

