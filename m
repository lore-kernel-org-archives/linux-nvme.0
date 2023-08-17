Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57374C2FC0E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DV+51nG4XiGuXDD21Bk0S4x/fufuHRaJ2bgQpqeNG1w=; b=DIMLj6XYRu7w5SVDiob0ZXFaMV
	deQUcZ8vUxMdPlrZzFHHstrCbMbNaUum8KJ0Q8ZqioU+7J2cB6k4H8cFd4xw9TPG6XtfDO6oZZxx1
	gEL6WS/mTN2sbK5U3uqJPaFgPoUEN684x5JQ/EEN+BYZR5UXeYv1lRl6wIoana9IT+9EPiaXbGkPq
	2ShbkFQCluRVB51ACJ3kOwKJETIqb/YeVRUb6WjMAzkZarPrSQ9fY3GbE4u+riQc0h5frcKWeKx2a
	BoZF/oNoTEaSWD/OrFdViseK726G6OVCUlXK4OCt5T8R7WGU7vD48UjP7wbf+SjbjyASG2cscnT9/
	ThEEVldw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYRs-005pnp-0b;
	Thu, 17 Aug 2023 08:33:44 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYRp-005pnT-0f
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:33:42 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bcf3c8524so168631166b.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 01:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692261219; x=1692866019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV+51nG4XiGuXDD21Bk0S4x/fufuHRaJ2bgQpqeNG1w=;
        b=bLcPY58bxjQscFvebfu1HCEahv+YNPQ1mAXyXwvlS1m+sR0Q00VjkYCeVs00vFmcsK
         jM+w1Ll2tM0u6XRF+C74jpY3Bm1PyQhgyfFBxPTHO4LqfuojA8IkC/BnymT/K9KxhpeS
         qNRGdjB4TtYdxl8n8nAkclO/v8Rz52qC2g86IfCiHk9KgH++RtykKyEuEIZ0n9tc1yUm
         Zu16EPhdudmu4iUx6IEQHAVyutL0q1S+C8pO6BLji74BzA5X1IGfcJpbqoufIA9+XNoD
         EO51ZB3RIX7AMispzOwL+O0fTRrCtvpLE1ZPqjq6EuP8G24211Ia+Np6+N5syUtuhERD
         kE+w==
X-Gm-Message-State: AOJu0YwPmGcmuT0tHL4/VLWDlXS1I3afjN0xPy8OREiHJEAvdyO+iGdS
	p6IQBqHVcSihhexa2xhDhHI=
X-Google-Smtp-Source: AGHT+IFF7yfv2VJErpteiD85j75Wa6YPduJX5bVBide3GMy3Na5+GURGy3p9cHb8LNFiL8w6UuK/yw==
X-Received: by 2002:a17:906:2204:b0:998:bac1:3bdd with SMTP id s4-20020a170906220400b00998bac13bddmr3203809ejs.2.1692261219032;
        Thu, 17 Aug 2023 01:33:39 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090608cc00b00993004239a4sm9733096eje.215.2023.08.17.01.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:33:38 -0700 (PDT)
Message-ID: <cb468a17-c653-b257-8f5d-bf5981c22de5@grimberg.me>
Date: Thu, 17 Aug 2023 11:33:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v3 13/13] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 James Smart <jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
References: <20230811093614.28005-1-dwagner@suse.de>
 <20230811093614.28005-14-dwagner@suse.de>
 <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
 <lfr3tkzz3sqnsw4y7sqyxc42ptvzkyfqfpeko6gzs42jdgjl2d@u5fbzjksbztd>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <lfr3tkzz3sqnsw4y7sqyxc42ptvzkyfqfpeko6gzs42jdgjl2d@u5fbzjksbztd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_013341_241502_05E438E9 
X-CRM114-Status: GOOD (  17.73  )
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


>> It is very very strange that _setup returns a port
>> which is passed to _cleanup...
> 
> This is the only information the _cleanup helper needs and that is why
> it survived the refactoring so far.

Doesn't change the fact that it is awkward.

>> I think that _cleanup should simply remove all
>> ports, and that setup should not return a port
>> to begin with.
> 
> This assumes that blktests is the single user and can blindly remove
> everything. I would like to play nice here and only cleanup resources
> blktests actually allocates.

I suggest that the test records resources that it is using
and destroy them in the cleanup (IIRC Shinichiro did something
similar with the modules in some other place).

>> If someone needs the actual port number, then it
>> should either not use this _setup helper or
>> query it somehow.
> 
> I try to figure out how to implement such a query helper then.

That would probably be needed when a test wants to cherry-pick
which stuff it is destroying. But on the other hand, in this
case it also doesn't make sense that this test will be using
the default basic setup function. So I don't think it is
very much needed.

