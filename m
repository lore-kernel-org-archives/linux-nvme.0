Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238F5CE79BE
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Sep 2023 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFLGB2qgIpGyxCAHfm2i+PmCGhGU/0Xqf15cnOn5phM=; b=XzI8vyLf0J2ginqcpy9P8t9wTM
	cfdFWjd1I+oNVDZaUCRxHIgzanBXJ4O7kvZKl5ebHHoZdU45PGq1iNlFJD2zA4qcYqIOFOFronWFu
	XE3/nUp78ZgqL0CTKJdh6lm6z9IV8QjUsLGBkyTYmbOWzWGF0+Hruhorakx1FQHLghAwgmOQujzes
	gFAdg9qiQT191A7bgdkLqTelQPebmKWY8VyUlcR4lSdg+c4dUwtw04UDce2LTUfrNNB6gc2GDA+ac
	Nmj8Ui62WSOy5DJow952aaOUbvBlcWduxADub1Fg1aRYhM9KO2+0wURDRaXYsBFaXkw01PuQZ5Vni
	h9w7yUow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiuBZ-002Z4C-0x;
	Wed, 20 Sep 2023 10:11:57 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiuBW-002Z2U-1h
	for linux-nvme@lists.infradead.org;
	Wed, 20 Sep 2023 10:11:56 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40506bfca64so11594705e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Sep 2023 03:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695204711; x=1695809511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFLGB2qgIpGyxCAHfm2i+PmCGhGU/0Xqf15cnOn5phM=;
        b=mh/QgxkMYi9E7vywW6UT/8OwkaCTw6fc3VjE3TTUQYE4699MPX4mb2zHb0ut1tOiZZ
         e183DZDiMK78Ey3wZV2LopZO1hV00eaXfhL/9vY8COHDhLnvqZOg7EZtxP4W0++PUZhE
         NQH/Xyv/sC+3lWZpHhWJs3hBQH96/usFD4IPSQr+vBlx0P40Y+BEfxUdJb4Lrw05F4LC
         AQu4mSDd7ixNeytQeW5777ayn76KqSGqZ7/Rcq1SGrS1Ns833ri3TS1qA4r4gYrX8ico
         VYhFkR8KOkBnmTOS65Nxcg0I+jl/dZC+9w1myiBgiKirNi7r/jyvSYArhz0JWAAzJACF
         cYvg==
X-Gm-Message-State: AOJu0YxwN4YoFAyKNFe5b81kfvolEekRV1gF2bBD28vQ54wtyyz4DfM1
	ePEb+UDQ0PWzSomUUBShZDk=
X-Google-Smtp-Source: AGHT+IE8jps8mSxzh6OP9U5onGqg4xq5lXToTiBZCN6JQ9cBGAViZJwoh/6vwSycDqZnwVxCwrwX9g==
X-Received: by 2002:a05:600c:4706:b0:404:74bf:fb3e with SMTP id v6-20020a05600c470600b0040474bffb3emr2011904wmo.2.1695204710971;
        Wed, 20 Sep 2023 03:11:50 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v9-20020a1cf709000000b00402f7e473b7sm1525727wmh.15.2023.09.20.03.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:11:50 -0700 (PDT)
Message-ID: <b82d4ecd-77f3-a562-ec5c-48b0c8ed06f8@grimberg.me>
Date: Wed, 20 Sep 2023 13:11:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
 <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
 <2537congwxt.fsf@nvidia.com>
 <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
 <253v8c5fdc3.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253v8c5fdc3.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_031154_563753_0D3B7CBB 
X-CRM114-Status: GOOD (  16.16  )
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


>> Can you please explain why? sk_incoming_cpu is updated from the network
>> recv path while you are arguing that the timing matters before you even
>> send the pdu. I don't understand why should that matter.
> 
> Sorry, the original answer was misleading.
> The problem is not about the timing but only about which CPU the code is
> running on.  If we move setup_ddp() earlier as you suggested, it can
> result it running on the wrong CPU.

Please define wrong CPU.

> Calling setup_ddp() in nvme_tcp_setup_cmd_pdu() will not guarantee we
> are on running on the queue->io_cpu.
> It's only during nvme_tcp_queue_request() that we either know we are running on
> queue->io_cpu, or dispatch it to run on queue->io_cpu.

But the sk_incmoing_cpu is updated with the cpu that is reading the
socket, so in fact it should converge to the io_cpu - shouldn't it?

Can you please provide a concrete explanation to the performance
degradation?

> As it is only a performance optimization for the non-likely case, we can
> move it to nvme_tcp_setup_cmd_pdu() as you suggested and re-consider in
> the future if it will be needed.

Would still like to understand this case.

