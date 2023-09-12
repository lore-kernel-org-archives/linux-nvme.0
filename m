Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4829CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ogiIV815kemF/PQGgBP4BpbSNv5ZquSwDbgPIvodDXY=; b=bi73tXQjBDCgF43DKVH8aF4ZGT
	eG+1+lZd63HcB2CnKX9lRoCq8E+qXm+jWrl+izCLMDRMKjE/8e9RJdOl3/nIt0ILeYVD3WdUjpbs2
	4rs1uvrxGP8sGNRADIEYdrVq3iaOLpFDRajFgIbF5nYODYyhZ+uqXbNq5EImZSFaV6LVp5SWk3dao
	Co3yVJ0S2WBN7cpaFzqMl8L6vksRWmGFNyMHLhOdTOeU20BmO0fa3ysh4QNraZq7XZOduzMLqUm6/
	M2cRw88sRS4+oh8ApBgMi7/QwCL3TqwU8W0bm7PsVfQqFqQsQeGpSYsjZvDY+hHFCgEVRUk0uVyDp
	MbQ83vzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1oU-003F8h-1h;
	Tue, 12 Sep 2023 11:44:14 +0000
Received: from mail-lf1-f43.google.com ([209.85.167.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1oR-003F7O-30
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:44:13 +0000
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500a3c014d8so1547823e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519049; x=1695123849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogiIV815kemF/PQGgBP4BpbSNv5ZquSwDbgPIvodDXY=;
        b=TwOdckX5l2+K2p0asQMi3dWUeU9ll9JJ2RSFFAWyH8lB71ViQBkzeRItK+tw+Rgxyr
         jyodhYGINCFKjsnm09QlQ9h/Y24ZfWPKUpaRcKtIAeuyy1N6LcFcQziezBoPLt4arPdE
         Sij89uvsiefmLOhG7G8mngNl+d6SL/AyC0KYxBwoACvhyNYEJWxxl52VzMxSaq3CPbR0
         TgXen7yhGBWudCw8B1OTa/uT+cDoiGdPmVhu3sYroUa7uqT9RuOHcwLcR9t6eGZRSXqw
         82Ho2Z/G4UfdH9bi5EqcfGIG9ieUp6bLuh9yrx6Ql1MVFVbYUhoJJOOL6zr+U8gpzy63
         2BsA==
X-Gm-Message-State: AOJu0YwNc9u6QfiMjmOZMrPWpVyhzwFEih/6oaInI5a51fxJ+ycNykBy
	V8/CT9mZNxqm6+kIKsVESyyZGgOSLSQ=
X-Google-Smtp-Source: AGHT+IHLN/wS8td+WIqN5mZ9TFUQ96MwEvn4MOWpp2VLm8A7RCMIzDW9lgV8rZkzBIm6wVqfZYrJcA==
X-Received: by 2002:a05:6512:3910:b0:500:8b8d:d567 with SMTP id a16-20020a056512391000b005008b8dd567mr6464493lfu.1.1694519048534;
        Tue, 12 Sep 2023 04:44:08 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906d00500b009ad875d12d7sm901515ejy.210.2023.09.12.04.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:44:00 -0700 (PDT)
Message-ID: <70d9fb1e-07f8-d130-4308-f279c36ddc24@grimberg.me>
Date: Tue, 12 Sep 2023 14:43:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908065717.92207-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230908065717.92207-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_044411_991948_CB5A2E3D 
X-CRM114-Status: GOOD (  18.74  )
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


> It is really annoying to always have to loop through the entire
> /sys/block directory just to find the namespace path links for
> a single namespace in libnvme/nvme-cli.
> So provide links to the namespace paths for efficient lookup.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c      |  3 +++
>   drivers/nvme/host/multipath.c | 10 ++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 37b6fa746662..88933838e067 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3681,6 +3681,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	if (!nvme_ns_head_multipath(ns->head))
>   		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> +	else
> +		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
> +				  ns->disk->disk_name);
>   	del_gendisk(ns->disk);
>   
>   	down_write(&ns->ctrl->namespaces_rwsem);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0a88d7bdc5e3..9dd0be645dad 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -875,6 +875,16 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>   	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>   		ns->head->disk->nr_zones = ns->disk->nr_zones;
>   #endif
> +	if (ns->head->disk) {

Why are the two conditions not identical?

> +		int ret;
> +
> +		ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
> +					&disk_to_dev(ns->disk)->kobj,
> +					ns->disk->disk_name);
> +		if (ret)
> +			dev_warn(ns->ctrl->device,
> +				 "failed to create namespace path link\n");
> +	}
>   }
>   
>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)

What will these links be used for?

