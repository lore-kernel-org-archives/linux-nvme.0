Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0B5C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljH3s5YOjg/OLS2jlsovQcEEWLkSn+PbbEeauwoOdEE=; b=xaHKMTp+jArymwLpyBWNY847x+
	JOJJt+uO92Vaa8SC4v/89ztyiSoZC9bdiqlvquYiAjUTDobzJFjUFgWp38kQIqMRxE177zvyMzHVS
	ffySOlY1tgMmD9LnjFxi1j/C82WzjsHgDW8sQr7MqB4Ci/nR8uP/kk6KrdGlGQEqxwGcKkOqTRL1w
	/nH9qpSgnCXAGrHGuCqHvY6CbjkV6C53b8Eulv15d2eY6AMEzeDx+La6RD1TH77r8X7vhGGpV8Ogk
	s3M9U2IPXu2Af1g7jQ3ZUwiCW5VSZY0kosOIVOTpN5xXGeHMVqsoKCvgyrw1JTJnFsitespAhwFgr
	zZozf15A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPln-00EvYM-1z;
	Wed, 13 Dec 2023 13:59:27 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPlk-00EvWY-2W
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:59:26 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c362efc2dso8406045e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475962; x=1703080762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljH3s5YOjg/OLS2jlsovQcEEWLkSn+PbbEeauwoOdEE=;
        b=BoIvocDjUgxVt7v8DyWSUzGZulB8YYn3bKL0uSaczJ7MldNVyujAMnoIwMjQIm2mcU
         srTHqXnYDXCKO8E80R3oabDv1AKy1/Y0+kKNbjf9GgaZTWumdCw1bZTEMfwzHa7HpzPL
         YcnWj8R6Jus4LKuE9yTlefeFZYuRk5EvqZqji0DjZaObnbIAGNvTA3zL6xTaMG2Da6AQ
         wURbcSyl1qq1xawofiqoko4lbBO8eRLapX+1L5ky3H+6A7BBFOVrPKZoNfdCfxNh/JY1
         YL+EinqF8HufBTTkP2XZNu533PTQKUDOaCx06pGcfWCMDReH8JRWQPmrHLG3Fw6dGRX8
         ihuw==
X-Gm-Message-State: AOJu0YyKv5gn/5KMGxUrRiHt6keLiUD8Q3Gj+LyuDUCKPOpxib+8VfE+
	kmR5gq5h8brrEi0YzyTQpak=
X-Google-Smtp-Source: AGHT+IEtrQFcx806RD1P5HerfeK8JeAD5ouXOJzN7NkiQ0Ip73gGqgtLxGdjkZBSrHiofTAaE/CFLw==
X-Received: by 2002:a05:600c:35d6:b0:405:358c:ba75 with SMTP id r22-20020a05600c35d600b00405358cba75mr9849624wmq.0.1702475961730;
        Wed, 13 Dec 2023 05:59:21 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040b2c195523sm22766090wmo.31.2023.12.13.05.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:59:21 -0800 (PST)
Message-ID: <d05302bc-6228-4798-979d-91904c794c13@grimberg.me>
Date: Wed, 13 Dec 2023 15:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20231212180938.397403-1-jallison@ciq.com>
 <20231212180938.397403-2-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231212180938.397403-2-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_055924_825943_3A9DABFD 
X-CRM114-Status: GOOD (  27.01  )
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

> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility.
> 
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> ---
>   drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
>   include/linux/device/bus.h | 10 ++++++++++
>   2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67ba592afc77..d9745822fb50 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>   void device_shutdown(void)
>   {
>   	struct device *dev, *parent;
> +	LIST_HEAD(async_shutdown_list);
>   
>   	wait_for_device_probe();
>   	device_block_probing();
> @@ -4769,7 +4770,14 @@ void device_shutdown(void)
>   				dev_info(dev, "shutdown_pre\n");
>   			dev->class->shutdown_pre(dev);
>   		}
> -		if (dev->bus && dev->bus->shutdown) {
> +
> +		if (dev->bus && dev->bus->shutdown_pre) {

I'm assuming that there is no shutdown_pre without a shutdown_post
paired with it, so I think the code should verify that.

> +			if (initcall_debug)
> +				dev_info(dev, "shutdown_pre\n");
> +			dev->bus->shutdown_pre(dev);
> +			list_add(&dev->kobj.entry,
> +				&async_shutdown_list);
> +		} else if (dev->bus && dev->bus->shutdown) {
>   			if (initcall_debug)
>   				dev_info(dev, "shutdown\n");
>   			dev->bus->shutdown(dev);
> @@ -4789,6 +4797,35 @@ void device_shutdown(void)
>   		spin_lock(&devices_kset->list_lock);
>   	}
>   	spin_unlock(&devices_kset->list_lock);
> +
> +	/*
> +	 * Second pass spin for only devices, that have configured
> +	 * Asynchronous shutdown.
> +	 */
> +	while (!list_empty(&async_shutdown_list)) {
> +		dev = list_entry(async_shutdown_list.next, struct device,
> +				kobj.entry);
> +		parent = get_device(dev->parent);
> +		get_device(dev);
> +		/*
> +		 * Make sure the device is off the  list
> +		 */
> +		list_del_init(&dev->kobj.entry);
> +		if (parent)
> +			device_lock(parent);
> +		device_lock(dev);
> +		if (dev->bus && dev->bus->shutdown_post) {
> +			if (initcall_debug)
> +				dev_info(dev,
> +				"shutdown_post called\n");
> +			dev->bus->shutdown_post(dev);
> +		}
> +		device_unlock(dev);
> +		if (parent)
> +			device_unlock(parent);
> +		put_device(dev);
> +		put_device(parent);
> +	}
>   }
>   
>   /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index ae10c4322754..cbcb001f6336 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,6 +48,14 @@ struct fwnode_handle;
>    *		will never get called until they do.
>    * @remove:	Called when a device removed from this bus.
>    * @shutdown:	Called at shut-down time to quiesce the device.
> + * @shutdown_pre:	Called at the shutdown-time to start the shutdown
> + *			process on the device. This entry point will be called
> + *			only when the bus driver has indicated it would like
> + *			to participate in asynchronous shutdown completion.
> + * @shutdown_post:	Called at shutdown-time  to complete the shutdown
> + *			process of the device. This entry point will be called
> + *			only when the bus drive has indicated it would like to
> + *			participate in the asynchronous shutdown completion.
>    *
>    * @online:	Called to put the device back online (after offlining it).
>    * @offline:	Called to put the device offline for hot-removal. May fail.
> @@ -90,6 +98,8 @@ struct bus_type {
>   	void (*sync_state)(struct device *dev);
>   	void (*remove)(struct device *dev);
>   	void (*shutdown)(struct device *dev);
> +	void (*shutdown_pre)(struct device *dev);
> +	void (*shutdown_post)(struct device *dev);
>   
>   	int (*online)(struct device *dev);
>   	int (*offline)(struct device *dev);

