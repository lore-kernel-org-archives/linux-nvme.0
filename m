Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6A9C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMSnzzQbUF9EKnMeK5bfcAYGorPWABNSY7naaLj6+sU=; b=q0yz+phl1nuSkFYoPoFPBnJ66g
	xkSRadLUWve+E1le+miMHugoU9a8bQpkSmSEljEYvVwRrXE+JFjKuinAJuLDw03UdmQoAZrOUT2mD
	qF1Kba+O8N8P31HDeTgV1/uH4kJR/H6di9UG89p3oJqqn4NnmX8cdZ3ypfB/s2s3EglnXGCyJntYr
	TZKIIx9XoeMYm+068gb21hZFp1jEz5T74Ew8rVyX4VeZBJtpulZrXKS8lgYPCjzgAGaWXwv2EdAIc
	ELKcefIeUmkrsladRBXTMCi2dqBsOEXJ6A3/Fb1VbT9TOg/Lyoa5PE1Agjwj0dtELJSX/DnNw+mWc
	JqTMfnJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNWE-00E5xE-1F;
	Thu, 04 Jan 2024 13:12:18 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNWB-00E5vf-3A
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 13:12:17 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d377bd169so285005e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 05:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373934; x=1704978734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMSnzzQbUF9EKnMeK5bfcAYGorPWABNSY7naaLj6+sU=;
        b=dal3U/+6pCuaM6M05U7Xz6k5xINaq9dnpkyeMDYdHejyFbUnktIM8GO0keS660hqVe
         57vq11XEuHNhBvgYd8jwvRUj9K9Zq8OcrzEorEyo8Vi2bfVy3z52hplb5cEpWR7fh0QE
         AvsUCX5LzapAT6uHJYVLNibGCS3nYjpNXZuUlxf7MBZoHb32IZBA6p2f8z44O5SZWEyV
         zItM9/PgzQ7tqIq5WBVgmqTKGMfnbMJWK0iGKTSpm/xuNf4fdeuby3S5OpyhwWthgq2b
         ZGgy595DuztE63A6PhaU17NjiNGev87UtnjVPVdMsAxkpws+aOlYcXewk6TvT3299ONl
         PlpA==
X-Gm-Message-State: AOJu0Yyn0pc8iXrYw8eWdBiSAhkLH1kHI48Oyjsa9/F7G5c9AKRzZVoP
	Xsn9vSVEbqPpV+UZE+/JwCU=
X-Google-Smtp-Source: AGHT+IHqLPUWZN7bQn8cqdnLnkUmZwlBZLDFndeEm6iOoyxaCRMoPkeVP0kkl/FzCCLdQIYrBUx1MQ==
X-Received: by 2002:a05:600c:3b97:b0:40d:5b7b:15d5 with SMTP id n23-20020a05600c3b9700b0040d5b7b15d5mr777431wms.4.1704373933746;
        Thu, 04 Jan 2024 05:12:13 -0800 (PST)
Received: from [10.100.102.14] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040d8d11bf63sm5638610wmo.41.2024.01.04.05.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:12:13 -0800 (PST)
Message-ID: <7c797813-40fb-49c6-baf0-2029e9177939@grimberg.me>
Date: Thu, 4 Jan 2024 15:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-2-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240103210405.3593499-2-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_051216_019097_1F3DC9A3 
X-CRM114-Status: GOOD (  24.53  )
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



On 1/3/24 23:04, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with an additional entry point
> to enable devices to implement two-pass shutdown. The existing
> synchronous interface to shutdown is called, and if a shutdown_wait
> method is defined the device is moved to an alternate list.
> 
> Once the shutdown method is called for all devices, the
> shutdown_wait method is then called synchronously for
> all devices on the alternate list.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> ---
>   drivers/base/core.c        | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/device/bus.h |  6 +++++-
>   2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67ba592afc77..e1f4c54de3e1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>   void device_shutdown(void)
>   {
>   	struct device *dev, *parent;
> +	LIST_HEAD(shutdown_wait_list);
>   
>   	wait_for_device_probe();
>   	device_block_probing();
> @@ -4769,10 +4770,17 @@ void device_shutdown(void)
>   				dev_info(dev, "shutdown_pre\n");
>   			dev->class->shutdown_pre(dev);
>   		}
> +
>   		if (dev->bus && dev->bus->shutdown) {
>   			if (initcall_debug)
>   				dev_info(dev, "shutdown\n");
>   			dev->bus->shutdown(dev);
> +			/*
> +			 * Only put the device on the shutdown_wait_list
> +			 * if a shutdown_wait() method is also defined.
> +			 */
> +			if (dev->bus->shutdown_wait)
> +				list_add(&dev->kobj.entry, &shutdown_wait_list);
>   		} else if (dev->driver && dev->driver->shutdown) {
>   			if (initcall_debug)
>   				dev_info(dev, "shutdown\n");
> @@ -4789,6 +4797,35 @@ void device_shutdown(void)
>   		spin_lock(&devices_kset->list_lock);
>   	}
>   	spin_unlock(&devices_kset->list_lock);
> +
> +	/*
> +	 * Second pass only for devices that have configured
> +	 * a shutdown_wait() method.
> +	 */
> +	while (!list_empty(&shutdown_wait_list)) {
> +		dev = list_entry(shutdown_wait_list.next, struct device,
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
> +		if (dev->bus && dev->bus->shutdown_wait) {

How can dev->bus or dev->bus->shutdown_wait be null at this
point?

