Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676CCC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDrEySI/1pWlb/EVtcfzf3j47hSXHdd6oiAatlhFT1c=; b=l37dVZJN0yB5lc7LpVROHPn5Dp
	61gz+efR1t8WvfKkLjsO7ZAlUJEjMgrPD0KsB9x/2WzSLXM2L2U926kgxk90F1sx1QnjmtkYazL8i
	V/stfftRBdNKcxIGCjFBW7aR/p+RXOy3mKccaDPMeO/iR/XtnzSkZC+mdJroavCfvqrJzo4H9alqL
	k/Wwn6i7rGSwkEROouz4Y9Gb26aiy/uL44PpqHLXRYksP/GpCLyeKxshKgP8AeqIMhcFxpL+SX8LW
	Zu9M6sh4OfOlc3jH/JlPos7hI8fUlsDZ6hwhjSD3tv+LAhobvWpQsIqPAXHniZoGkSORQAO7Bp9T8
	oyvwZQxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7uzn-004okU-0w;
	Tue, 28 Nov 2023 10:07:11 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7uzk-004ojn-37
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 10:07:10 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54af65728bcso766704a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 02:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166023; x=1701770823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDrEySI/1pWlb/EVtcfzf3j47hSXHdd6oiAatlhFT1c=;
        b=kK/AVyUKbkqc3euya7/E2Yi5TLL5K82Avkr768g6d3sl8GWAgTO6dKH5EnRIyla/mK
         5MRujZsPVirIAhX2iJmwaddEVWqNmxQwgrSAL9mwRO6Q95+CPc+RNXbv4Fwi0tot8jnS
         GW9/F7v9BcL1LlhslgP8wOgQGU3Ga9kuznGLJCRuwajVeqvMfy2oJNAKOEJFVgO9wRYl
         YbXRO5wZ+VvixWFYW1AvRdRAz6cs6LrwcDXl0ZiCyMWM0m4R8/fDKPlDxGKNC4+T6sUg
         ZhOuzdMPDvZc0goBwTHNdLMSMlebR5W3x35xAbhZyTWOCdRRlAE9pR0Mar6KwtK+m1RF
         T9Rw==
X-Gm-Message-State: AOJu0YwNOGC3p6kmyIXvzxdayiTbxelsi/X6rsGp2OJYKM7UiUuYY4lW
	RA1FYkA8TdG40tHRgUokI2c=
X-Google-Smtp-Source: AGHT+IGhSyFpXGgBeC+cRpX2q+J7NdJHxOrw9GPgE9CCUiMz/ubPGmld7qE6QoPJVugrVsSU7ULNOA==
X-Received: by 2002:a05:6402:1d4b:b0:546:efd8:7f05 with SMTP id dz11-20020a0564021d4b00b00546efd87f05mr11056136edb.1.1701166022633;
        Tue, 28 Nov 2023 02:07:02 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7de8e000000b0053e3d8f1d9fsm6035528edv.67.2023.11.28.02.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:07:01 -0800 (PST)
Message-ID: <e8ae84bf-2cd8-4eea-8523-62de6e493dfc@grimberg.me>
Date: Tue, 28 Nov 2023 12:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
 <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
 <n57gxockmm4iqt53olerr52rgxg3mvgdp4wfshyci2r7dohxfg@22mqtj3ya3g3>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <n57gxockmm4iqt53olerr52rgxg3mvgdp4wfshyci2r7dohxfg@22mqtj3ya3g3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_020709_045916_2B30FB33 
X-CRM114-Status: GOOD (  14.90  )
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


>>>>>> Should this even be an nvme specific attribute? I thought we should have
>>>>>> blk-integrity.c report its 'tuple_size' attribute instead. That should
>>>>>> work as long as we're not dealing with extended metadata at least, but
>>>>>> that's kind of a special format that doesn't have block layer support.
>>>>>
>>>>> Reporting the tuple size is a good idea.  But is that enough for
>>>>> the existing nvme-cli use case?
> 
> 'nvme list' is just listening the block size and the meta size in the
> 'Format' field. So nothing really crazy going on:
> 
>    Usage                      Format
>    -------------------------- ----------------
>    343.33  GB / 512.11  GB    512   B +  0 B
> 
> nvme-cli commands like 'nmve ns-id' etc will always issue a command so
> that is not a concern. It's just the libnvme nvme_scan_topology() call
> which should stop issuing any commands.
> 
> I'll add the missing tuple_size to the integrity sysfs dir in this case.
> 
>>>> nvme-cli currently queries with admin passthrough identify command, so
>>>> adding a new attribute won't break that. I assume Daniel would have it
>>>> fallback to that same command for backward compatibilty if a desired
>>>> sysfs attribute doesn't exist.
> 
> Yes, a fallback will exist. There is no need to break existing users.
> 
> In summary, the only missing entries are
> 
>   - csi
>   - tuple_size
>   - nuse

I agree with the comments made, especially the one made by Christoph
that these values should be added to the nshead.

