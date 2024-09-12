Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51464EED618
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3DzjyWHe+KYuHiwnIK8txC0+pHIorBSqWuc7NX4qB8=; b=OcjWMbCcuXuoZWXBz0NuIWfM90
	glGxokiYW9Y5mGtqyCS8mhFvYYidbP1djN2YOioOwiSUzUhBZch9kM3yrcCz+iOKnvlbpIF1OeVID
	NL1lrc+J74sI1hQp9DXYh/qC+j6Y3vqmZTVZ/ihw61uzMGk9bQ5DclJWMdNqJvKyXiXvOmhK5I43M
	yJgHUpuIA6D4S0K5SZmrmmhT3rPjTHGZHrqqSL6iU/JKXltiy4Q/U5LGKM3VDqhEngWYNw7M0YJ2a
	fXPIotll+tQPG+pmiK1xyAZjaVgW8rM2VJyOJVjuKkMwxQuviwn65XtnpAGQCtppVPXzfBu1AKjnP
	S1Cax5fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somYG-0000000DgUn-1fSE;
	Thu, 12 Sep 2024 16:20:12 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somYD-0000000DgTo-2dpf
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 16:20:11 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-710ddb52139so550486a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2024 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726158008; x=1726762808; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3DzjyWHe+KYuHiwnIK8txC0+pHIorBSqWuc7NX4qB8=;
        b=Bb1oeMopY1zUIW7X4TMzvh0L6c4LkCwEFpg3RXk9+pyOODcD9KVJTJ0C3RPIMw1vB2
         5xEHzLm2Qu+zOMCzIwkSC1usMBk5dBxRW922cppQAHw+Mr3vQJBe9Vs8FfgRhmGDNJrx
         at36it1gJmF+/h+K+CEPCVtoxXsEOo6Qd2/5LnBFvXqVahD/tyeACriCNnbl6XZOZfnB
         /lCo/jdnoFnGHsOd+3CHvcdA2EN+7yS9jTudYiQy2ZLXZHWYIR2mNiiP+iWim7gzm9xN
         8DDITpusIb70lSGsqYJmRkV1HT4D7PAa5CWdPiUQG/DV/nQQq7FF2wURpVHWz5k8tffG
         J87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158008; x=1726762808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3DzjyWHe+KYuHiwnIK8txC0+pHIorBSqWuc7NX4qB8=;
        b=HAcICHkfCxx8jJ2+s1ACU7NAA/UFQF/Bf3OAZqq7z86Gc+J4D6d4MpkTU6aeRrs7TA
         uQnNQP9OAS1hlxBeVdIRwD07/fTV6Ox2hcIfXmeY4353aa73iakkm2GARljRXNMYUvP/
         bAsLr3knR5xgsN31/7g8HMXGFspiMs4zuYk5w6fpDyY8sLRaeWsbUx6IQK7VYHPHWDCf
         bZgmnUfw8HPWu8XN8+20xwrGcQTUUsIDXDBZAZAftbGF66i3XFrZjvVmQmgTxieF3BtG
         KzPJhX0tPjvAjJvrE7QIR5u0fET89fU0CiCEtbsf9T4ZGFGYaMqADRvG5FYO5iWMMygY
         HG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUClouSXwL0Ck1yVC4Wk5mRv0PmVFoOMsPLOMg63s8ywglpKDylfugHVfpMrOju7UmD04x8S8wUmgS7@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0kgdtWFbg7TQwu3wTOkwC1oaOLAodZYqM6ts3HX32dt6PWQ1m
	QXUPmz62G2yJAbh2mZmGbfqDDi9dchW8grrXqHQQ8WKz0zI81YcR
X-Google-Smtp-Source: AGHT+IGysuELHgg3OfLGsAwGsKNT+nuiEZGuvh0MVUp5JoZbZ2h+iNnwhYBGFOJN8z2/hdrBjyxDjg==
X-Received: by 2002:a05:6830:6606:b0:710:f797:984b with SMTP id 46e09a7af769-711094c9180mr2533120a34.32.1726158007973;
        Thu, 12 Sep 2024 09:20:07 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9dd6f97sm2742836a34.74.2024.09.12.09.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:20:07 -0700 (PDT)
Message-ID: <754401e6-b6a5-4393-ad9b-ffe113e33a72@gmail.com>
Date: Thu, 12 Sep 2024 11:20:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: David Jeffery <djeffery@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
 <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
 <CA+-xHTEMM09PXgWyKX4h48diUxxGnSSrDowh5Gt=Y+EVhHL-_Q@mail.gmail.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <CA+-xHTEMM09PXgWyKX4h48diUxxGnSSrDowh5Gt=Y+EVhHL-_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_092009_702779_EE3E4283 
X-CRM114-Status: GOOD (  36.02  )
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



On 9/12/2024 9:30 AM, David Jeffery wrote:
> On Tue, Sep 10, 2024 at 8:14 PM stuart hayes <stuart.w.hayes@gmail.com> wrote:
>>
> ...
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index b69b82da8837..52d64b419c01 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data, async_cookie_t cookie)
>>    {
>>          struct device *dev = data;
>>
>> +       /*
>> +        * Sanity check to prevent shutdown hang in case a parent or supplier
>> +        * is in devices_kset list in the wrong order
>> +        */
>> +       if (dev->p->shutdown_after > cookie)
>> +               dev->p->shutdown_after = cookie - 1;
>> +
>>          async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
>>
>>          shutdown_one_device(dev);
> 
> While the race window is really small, there is a potential race with
> this fixup. It's possible for the shutdown operation to write a new
> value to shutdown_after in the time between the if check and
> shutdown_after being re-read and used in the
> async_synchronize_cookie_domain call. Such a race would allow a too
> high value to be used.
> 
> Instead, could do something like:
> 
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4833,8 +4833,12 @@ static void shutdown_one_device(struct device *dev)
>   static void shutdown_one_device_async(void *data, async_cookie_t cookie)
>   {
>          struct device *dev = data;
> +       async_cookie_t wait = dev->p->shutdown_after + 1;
> 
> -       async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
> +       if (wait > cookie)
> +               wait = cookie;
> +
> +       async_synchronize_cookie_domain(wait, &sd_domain);
> 
>          shutdown_one_device(dev);
>   }
> 
> This reads the shutdown_after value once and avoids the race window
> where its value being changed on another CPU could still cause a
> potential deadlock.
> 

Good point. Really that sanity check shouldn't be needed at all.  But... maybe it
would be better to just not change the shutdown_after on any device that's
already been scheduled for shutdown... this would work regardless of why the supplier
and consumer devices are in the wrong order on the devices_kset list, and would still
work if supplier/consumer devices don't get reordered for some reason other than
the devlink being sync_state only in the future.  Plus, it's a bit simpler.

How does this look?


diff --git a/drivers/base/base.h b/drivers/base/base.h
index ea18aa70f151..f818a0251bb7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -105,6 +105,8 @@ struct driver_private {
   * @dead - This device is currently either in the process of or has been
   *	removed from the system. Any asynchronous events scheduled for this
   *	device should exit without taking any action.
+ * @shutdown_scheduled - asynchronous shutdown of the device has already
+ * 	been scheduled
   *
   * Nothing outside of the driver core should ever touch these fields.
   */
@@ -120,6 +122,7 @@ struct device_private {
  	async_cookie_t shutdown_after;
  	struct device *device;
  	u8 dead:1;
+	u8 shutdown_scheduled:1;
  };
  #define to_device_private_parent(obj)	\
  	container_of(obj, struct device_private, knode_parent)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837..bd6bc4a3dc15 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4888,6 +4888,8 @@ void device_shutdown(void)
  
  		cookie = async_schedule_domain(shutdown_one_device_async,
  					       dev, &sd_domain);
+		dev->p->shutdown_scheduled = 1;
+
  		/*
  		 * Ensure parent & suppliers wait for this device to shut down
  		 */
@@ -4898,8 +4900,18 @@ void device_shutdown(void)
  
  		idx = device_links_read_lock();
  		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
-			link->supplier->p->shutdown_after = cookie;
+				device_links_read_lock_held()) {
+			/*
+			 * Only update cookie if device shutdown hasn't
+			 * already been scheduled. Some supplier/consumer
+			 * devices (sync_state only) aren't reordered on
+			 * devices_kset list and don't need this, and setting
+			 * this could result in a circular dependency if the
+			 * supplier shutdown has already been scheduled.
+			 */
+			if (!link->supplier->p->shutdown_scheduled)
+				link->supplier->p->shutdown_after = cookie;
+		}
  		device_links_read_unlock(idx);
  		put_device(dev);
  

