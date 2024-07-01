Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB97C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iq7LaOoJ929Ne7IIqCNeS+dBDfJFsJTnNAQTkDtHOm0=; b=pnYH75E42Ile/nV7u8WbFKIHxQ
	Ofj0FShichPcjaGsev4M8ETEosUtqTIxrd3ITc6g39/DyflFe2S11gUkfWYI1hCdzlQnAcDmnvLS4
	zw8LYwHI9gvxPG+RLoc+F5FQVnZwj5CZi8CsbhCLR3yKJ9A3urJd1q/Ex0Uf2qnlCCtsqNFp5p3YF
	VVQSfJ5WDxa81ZnbS8f74gy+EqkUojSrmEwfz1Cf/QUu1uc4tdrfI9YREMl/aGsTnwauPciGwJ+7g
	hWNPR9VPrEQLH+Gt3mReNJ+qCuEmI0cN8JC3r+lDcMAHXXEhJYYEcolPH8ZNfYgi6+CGYKhklh3gp
	ii9e8kVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOLHf-00000004NRM-2UDU;
	Mon, 01 Jul 2024 17:57:47 +0000
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOLHc-00000004NQm-427U
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 17:57:46 +0000
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5c21df2d0a6so1678916eaf.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719856664; x=1720461464; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iq7LaOoJ929Ne7IIqCNeS+dBDfJFsJTnNAQTkDtHOm0=;
        b=miL223pVW2TgBFUZRXTmuEzvG5BsAlj86jnJfX732u+Tl5jAMKSIPO6A5WgGNkP/Kf
         mcD77QBMUkXN4fIeoO6aO9Y5s/aMtPAVJVlf5A8kg0ygbnLvArW0x0XKtelkdwaTwoca
         jZfUvb1G7/kMc+/hA4DuP+EUEb/Szrdl//6+OgmjRfFMLSO+paSe+NpSkEqYlEa/hB7n
         Em7gh3Ispp38OKcIJPXzlq6yxs+gP2NPAkf4/Rm2f9oVShmPHC8L7AerAWtwO2V6BSJX
         Ayq/5orsXkvD/w3wpRvGP/uheYINr81SKK9HAOeF2V1lijc0G6/gmyklIyR9kevWWpD8
         z/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856664; x=1720461464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq7LaOoJ929Ne7IIqCNeS+dBDfJFsJTnNAQTkDtHOm0=;
        b=Peo1+pv68PIzBwPcK56+ttqQcPDXKG3Kn/0jdWUNkK1wMxnJwcHGaYAPTTcdVc9elz
         iOFBckt8hQlFAa/9Y6dwS1HH/E09QT0E1jcedvsgcQzXZapICmBf31xZ8VJWRifbcqFU
         g9UxB35baQaeyCgl9+FGVOtotz1p+4XS7pNffczWVyrvdo6tjExYlJ45ikCBOa6YHHo5
         53SmlRxnoQU0HPAPg2VYx8jgxeA3VMXz2FMr8o29R6LWviSyU4Ln2cQxZ/xXcZg4EBZW
         eADeFz0b+hSEuAWhIRZl/9jZUyZOVEWXgTwrJ2mUQaHwl1eDbczAQpNypOP2/0MHD96B
         1Bmw==
X-Forwarded-Encrypted: i=1; AJvYcCVEg1rsq8NlDuK1YbEALPxzIv+9obDrHN19HhQnzzj4GfhOyRqV7YdO9D1mwLbIv92MJI7zStotBK9BLHwkJ0OIElbQRKb69WIPmlQdGK0=
X-Gm-Message-State: AOJu0YzFLjakOdPxk4PX2Sa1xlAucaKe1XII0AznualdfLNJ+GifY4Sa
	sjPIVJq3Us0FOgBs1Pwu73ku6D8pZEcDNuxlPOZ0b/3+aOcT4MDO
X-Google-Smtp-Source: AGHT+IHcImss3ZKjRkkmMrd9b9X4rGySjxBpsw1cPL0M4Fg4bC3ZEpvE4Id7GDKSHjFtpuRmhhUy+g==
X-Received: by 2002:a05:6870:9626:b0:258:42c8:7f69 with SMTP id 586e51a60fabf-25db33f81f1mr5718323fac.23.1719856663587;
        Mon, 01 Jul 2024 10:57:43 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e1f278fsm1829479fac.24.2024.07.01.10.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 10:57:43 -0700 (PDT)
Message-ID: <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
Date: Mon, 1 Jul 2024 12:57:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
 <20240626194650.3837-4-stuart.w.hayes@gmail.com>
 <20240627055515.GC15415@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240627055515.GC15415@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_105745_037524_C2A25DF7 
X-CRM114-Status: GOOD (  22.82  )
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



On 6/27/2024 12:55 AM, Christoph Hellwig wrote:
> On Wed, Jun 26, 2024 at 02:46:49PM -0500, Stuart Hayes wrote:
>> Add code to allow asynchronous shutdown of devices, ensuring that each
>> device is shut down before its parents & suppliers.
>>
>> Add async_shutdown_enable to struct device_driver, and expose it via sysfs.
>> This can be used to view or change driver opt-in to asynchronous shutdown.
>> Only devices with drivers that have async_shutdown_enable enabled will be
>> shut down asynchronously.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
> 
> We discussed this before, but there is no summary of it and I of course
> forgot the conclusion:
> 
>   - why don't we do this by default?

It is done by default in this version, for devices whose drivers opt-in.

In the previous discussion, you mentioned that you thought "safe" was the
only sensible option (where "safe" was driver opt-in to async shutdown)...
that is the default (and only) option with this version.  Greg K-H also
requested opt-in as well, and suggested that "on" (driver opt-out) could
be removed.

>   - why is it safe to user enable it?

I guess it isn't necessarily safe, if there are any drivers that can't
handle their devices shutting down asynchronously. I thought it would be
nice to be able to enable driver opt-in from user space for testing, before
changing the default setting for the driver.

> 
>> + * @shutdown_after - used during device shutdown to ensure correct shutdown ordering.
> 
> Overly long line.
> 
>> +static ssize_t async_shutdown_enable_store(struct device_driver *drv, const char *buf,
> 
> .. and here.
> 
I can correct these lines. I thought that an 80 character line length limit
was no longer required, and saw another line a few lines above these that was
even longer... and the checkpatch script didn't flag it either.

