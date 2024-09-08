Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB12E6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cR3VYMMURPSiFaFZKJGG3Rc11X1L8jXkvDrs4A4koFc=; b=bsav8k3ojO1n7nK4tLqJJndJdq
	UPAahRTyRAbudcveFwyZFZ73r81ucoen/YtBVmizaJY8DhE1Ljh+wcIgJrwucPsA7AWMIdcfehmzH
	2TZ0we6NYlXmkwqxMiqZNn9yab1KOcV3i0TBR+HWTqkMX87i+zsF5ntxSw80V5TG9r0vjJauHVMEv
	TRAFfR54pEYVvxz2GjRkQxeX3jm1UU6eH32s6p7N3aTD44fu8EN+AMFQ2up7/J8I4p7d34U/pcDCF
	guDORoNtViufV32OXN9z8MJGavshfrDOA+gRipNTjThtdqs/1d2R4gh6j878ryZ1rkT3mOjWF9hAX
	CPT0KnIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snJ9g-0000000GyMZ-3z74;
	Sun, 08 Sep 2024 14:44:44 +0000
Received: from msa-212.smtpout.orange.fr ([193.252.23.212] helo=msa.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snJ9c-0000000GyM0-2xtM
	for linux-nvme@lists.infradead.org;
	Sun, 08 Sep 2024 14:44:43 +0000
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nJ9TsuXviS3tRnJ9Vs50vb; Sun, 08 Sep 2024 16:44:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725806676;
	bh=cR3VYMMURPSiFaFZKJGG3Rc11X1L8jXkvDrs4A4koFc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=XX5MdYW7WdDxfdC3dFTrteO3FizHnAtoGRFEC8UtBkPuwoYh823fAktnsbXLtkawH
	 rRRssBhWkNn9oQ+GCD9ctUpDAaVcTLtRA4KsbrtYqPVmEiyXqX2KOZPq5OG4wQMdPn
	 Nl97sO5SPcaIqgZ8kpwSnsRosE/x70oCLSHwtBG25KaxZUpQeEDnb/8/l7d6zLR/DW
	 8wVfslDmw4qu/IsNLPOSqTG9nL354GGtMgzScsEH/qobdmxZRfcSckTVxEsw1NHLSU
	 vRPkdkaY/Cd6N+bcJUc5fJljycP+U++UCgKiC47Is5Unv6PnAeioB3yHqhFgbF/q+d
	 ZdGFiAeJvhlHg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Sep 2024 16:44:36 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8debbb55-449d-4f8d-a6dd-3ba15836aacf@wanadoo.fr>
Date: Sun, 8 Sep 2024 16:44:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
X-Mozilla-News-Host: news://news.gmane.io
Content-Language: en-US, fr-FR
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_074441_315879_DE1892FC 
X-CRM114-Status: GOOD (  27.05  )
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

Le 22/08/2024 à 22:28, Stuart Hayes a écrit :
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---

...

> +/**
> + * shutdown_one_device_async
> + * @data: the pointer to the struct device to be shutdown
> + * @cookie: not used
> + *
> + * Shuts down one device, after waiting for shutdown_after to complete.
> + * shutdown_after should be set to the cookie of the last child or consumer
> + * of this device to be shutdown (if any), or to the cookie of the previous
> + * device to be shut down for devices that don't enable asynchronous shutdown.
> + */
> +static void shutdown_one_device_async(void *data, async_cookie_t cookie)
> +{
> +	struct device *dev = data;
> +
> +	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
> +
> +	shutdown_one_device(dev);
> +}
> +
>   /**
>    * device_shutdown - call ->shutdown() on each device to shutdown.
>    */
>   void device_shutdown(void)
>   {
>   	struct device *dev, *parent;
> +	async_cookie_t cookie = 0;
> +	struct device_link *link;
> +	int idx;
>   
>   	wait_for_device_probe();
>   	device_block_probing();
> @@ -4852,11 +4878,37 @@ void device_shutdown(void)
>   		list_del_init(&dev->kobj.entry);
>   		spin_unlock(&devices_kset->list_lock);
>   
> -		shutdown_one_device(dev);
> +
> +		/*
> +		 * Set cookie for devices that will be shut down synchronously
> +		 */
> +		if (!dev->driver || !dev->driver->async_shutdown_enable)
> +			dev->p->shutdown_after = cookie;
> +
> +		get_device(dev);
> +		get_device(parent);
> +
> +		cookie = async_schedule_domain(shutdown_one_device_async,
> +					       dev, &sd_domain);
> +		/*
> +		 * Ensure parent & suppliers wait for this device to shut down
> +		 */
> +		if (parent) {
> +			parent->p->shutdown_after = cookie;
> +			put_device(parent);

Would it make sense to have this put_device() out of the if block?

IIUC, the behavior would be exactly the same, but it is more intuitive 
to have a put_device(parent) called for each get_device(parent) call.

Another way to keep symmetry is to have:
	if (parent)
		get_device(parent);
above.

> +		}
> +
> +		idx = device_links_read_lock();
> +		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +				device_links_read_lock_held())
> +			link->supplier->p->shutdown_after = cookie;
> +		device_links_read_unlock(idx);
> +		put_device(dev);
>   
>   		spin_lock(&devices_kset->list_lock);
>   	}
>   	spin_unlock(&devices_kset->list_lock);
> +	async_synchronize_full_domain(&sd_domain);
>   }
>   
>   /*
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 1fc8b68786de..2b6127faaa25 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -56,6 +56,7 @@ enum probe_type {
>    * @mod_name:	Used for built-in modules.
>    * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>    * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> + * @async_shutdown_enable: Enables devices to be shutdown asynchronously.
>    * @of_match_table: The open firmware table.
>    * @acpi_match_table: The ACPI match table.
>    * @probe:	Called to query the existence of a specific device,
> @@ -102,6 +103,7 @@ struct device_driver {
>   
>   	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
>   	enum probe_type probe_type;
> +	bool async_shutdown_enable;

Maybe keep these 2 bools together to potentially avoid hole?

Just my 2c.

CJ

>   
>   	const struct of_device_id	*of_match_table;
>   	const struct acpi_device_id	*acpi_match_table;


