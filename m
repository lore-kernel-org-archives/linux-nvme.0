Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA9BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Za2u9xiMwHQI7hLYUiv/WFtqJCOw820fM5EFEI9bWS0=; b=fbsogDttDSmOnQse0lHvmN7gZK
	UAZbD4goREib06GoSiM0xsKcJzyUS2d/Tf0aWUX15N89z9g3myB+ntkf2Qmr8WaBoSBHdq1Z0lKsp
	nuQxD3CATbPtA1VXS7xjkaDwrV4ebZrhaz/si4hOdcax3MGfzKguEhMSk5cB26erOYE7kFwqtqBwi
	aIFKO3U9kpTQ9llkitJt1cDzosXiT6E3ynH8OF1mdZCpNHBz482j1qLmxBx0Q9NtGodeAjerXDUYi
	NwsIM893xxCQNlP+6B2LMDtGA9xzBDh83Nrx300tnRMlVYfUBfKmkD5xbJqqgXzfOAEeZ+zuu/FDO
	B2fukIcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4lJ-00GsdT-BD; Wed, 19 Oct 2022 08:49:17 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4lF-00GsWE-Ci
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:49:14 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1326637be6eso19797558fac.13
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Za2u9xiMwHQI7hLYUiv/WFtqJCOw820fM5EFEI9bWS0=;
        b=IY0XWTQEiEAzGedkEG9VyQgKTKBfJptCxDSdUxAZwPoGD8VHjHc+gIE4LT8t6qrlFP
         PbqIzPvpHVvwe6doBHH/TqYzOTkEKJDg33FtRNYvXJ5xAUAqBkAV/CRKkweh5j9Kr7co
         ZRHJda9m+qDZts9JC6lj7vn5w8HG5hna7HmuybkgSAO+Q5k+7fogF3TxVdSHz/BNQluv
         DVsXLkE5ZGUQOpLz9g789LGIDxkHnB1c+aDNd84oqlHazHHPotjLSVQAcfdu1prJmCOJ
         tKp5qN8AE+cSNXsef4myHEfC99U42bL9XojbRiAapxDTm+6klBoAFO/Wcpc6isn35cKl
         863Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za2u9xiMwHQI7hLYUiv/WFtqJCOw820fM5EFEI9bWS0=;
        b=d5DTg2tIDDfTu7lRk69jbtLokCpruTtSXe+Hudt38DAh5XSph8ynqN+SxiA8h8dhH8
         RJ0WQKUShntblWR+clDFU2LI7X6+Wc/4fSCUxL7GWIK8HhxxbAtqtPn8EcfM4bnQac/M
         tFAl3WZQkkSOMmOLCCVV1PHCzSgWhoJ9JHaWeRvqgLsZ4bAykcPSeVyqHilOLEdluYyn
         21Avbm9op7Cb/U/Dcg537gwlvFcCsyXJCbuSnkPHeCCy5g4RAc/bb9r4Lr4qH4kLiPkC
         g2s6lRm2NeZ0L0Yv+h5f/7t+go0A9PIsiHzmFWn9am18tvPJstlSOPKOD0uv8zkgWBHo
         Jt/w==
X-Gm-Message-State: ACrzQf3HnI1J27kM+ckPzB3m5I++lI7/zn3tU3rpUPl1/gVJEwSZ0WZC
	UUeUnh0Xs8afJ4nglwg7EvY=
X-Google-Smtp-Source: AMsMyM4Q1gYSw9qX27XYyRpuP4nYAlWK3w5M94hEMIxMoOve8J72z481o0nmEv6QFYSna4wsn8Qvag==
X-Received: by 2002:a05:6870:b512:b0:132:98fc:5b79 with SMTP id v18-20020a056870b51200b0013298fc5b79mr19771693oap.11.1666169352194;
        Wed, 19 Oct 2022 01:49:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a4a8244000000b004805c328971sm6184661oog.42.2022.10.19.01.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:49:11 -0700 (PDT)
Message-ID: <dc74a729-5f45-ffc8-96ef-dc86d43b0545@roeck-us.net>
Date: Wed, 19 Oct 2022 01:49:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme-hwmon: consistently ignore errors from
 nvme_hwmon_init
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
 fancer.lancer@gmail.com
Cc: linux-nvme@lists.infradead.org
References: <20221019083744.993792-1-hch@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221019083744.993792-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_014913_563294_F4814A89 
X-CRM114-Status: GOOD (  22.40  )
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

On 10/19/22 01:37, Christoph Hellwig wrote:
> An NVMe controller works perfectly fine even when the hwmon
> initialization fails.  Stop returning errors that do not come from a
> controller reset from nvme_hwmon_init to handle this case consistently.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
>   - switch to ignoring the errors in the caller.
> 
>   drivers/nvme/host/core.c  |  6 +++++-
>   drivers/nvme/host/hwmon.c | 13 ++++++++-----
>   2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cbe7854d4883..dc42206005855 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3262,8 +3262,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>   		return ret;
>   
>   	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> +		/*
> +		 * Do not return errors unless we are in a controller reset,
> +		 * the controller works perfectly fine without hwmon.
> +		 */
>   		ret = nvme_hwmon_init(ctrl);
> -		if (ret < 0)
> +		if (ret == -EINTR)
>   			return ret;
>   	}
>   
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d7129201..23918bb7bdca2 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   
>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
> -		return 0;
> +		return -ENOMEM;
>   
>   	data->ctrl = ctrl;
>   	mutex_init(&data->read_lock);
> @@ -238,8 +238,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   	err = nvme_hwmon_get_smart_log(data);
>   	if (err) {
>   		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> -		kfree(data);
> -		return err;
> +		goto err_free_data;
>   	}
>   
>   	hwmon = hwmon_device_register_with_info(dev, "nvme",
> @@ -247,11 +246,15 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   						NULL);
>   	if (IS_ERR(hwmon)) {
>   		dev_warn(dev, "Failed to instantiate hwmon device\n");
> -		kfree(data);
> -		return PTR_ERR(hwmon);
> +		err = PTR_ERR(hwmon);
> +		goto err_free_data;
>   	}
>   	ctrl->hwmon_device = hwmon;
>   	return 0;
> +
> +err_free_data:
> +	kfree(data);
> +	return err;
>   }
>   
>   void nvme_hwmon_exit(struct nvme_ctrl *ctrl)


