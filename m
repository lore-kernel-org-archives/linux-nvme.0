Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83558C4707B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aco3Kkg0Ib10Lwt2Vgnw32qC01Jnjfh1mzqhbA+Cq/w=; b=HX35XlHik718HNzZ+hu6l6s9hr
	xvmRQMXzoENeIeQOXC4Rw+P0mYQmb6AycHQXsOw954ygX1niVgHwCi0NmgdmZmF/6xzAI1XilZ0/Y
	xJNR54d7zgtU98mq7kAJiibqqsXhQhcZedvYTK/vNLoK16PNJYyxqhMSxdKbTASg2QN78Q2kJZ1Wv
	DJ0XrqzswKLwFfIsiIcB5nKvM0SVSOfpIiCMXLbAvvRlGWFi5nOchgeQUl1LPpSdyMaQxJH03Zo7y
	zj0HJoOol+x21oXRlDtGw5XfH+gPU1c6U7G7YQgAKjIGalqsGgzBBdcYKNtcihsWPV1qer9LGq4v8
	XUhgDvOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPNxF-009DRy-1T;
	Mon, 15 Jan 2024 14:28:45 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPNxD-009DRR-0Z
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 14:28:44 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e544fac26so6525115e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 06:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328919; x=1705933719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aco3Kkg0Ib10Lwt2Vgnw32qC01Jnjfh1mzqhbA+Cq/w=;
        b=q6fDau0HkWBgQmFwvel9DInLCI64+NUaB7udm3ExPr0qo8TnBxezwstUV3vw5Wnwxz
         +3MY7a6Q5s3JRp0AmJZ15kMqz6js6QZc6m3ca8RCtDr6ul1OoVCbhOaWppf+xIJepxul
         JqFKpfAEH533xKbqkteFGM91TSdklnMCtWdlm2TdcayJh0wdk7vqFpv83YPxfAPWj52r
         WIKdxocypKfP5ssRhBvJILj2JZM/IQb7prWkx6H5UdmBRMGdSNRvA8YVErxi3gkCvDM+
         rkOcyQgVa8xczR8T1A2YfnazyjrAaAIQBKEuunhZzlXWZL+VMj+7T8mSNqsQ5pAe6amz
         SKsA==
X-Gm-Message-State: AOJu0Yzgoo6xrpG2xv+I8GDXdZRFim2x1n6CvzRkZu3i+jJVRXt3u6oI
	49b6si3JjjVaK20RQWZam2Q=
X-Google-Smtp-Source: AGHT+IHsTflHtPmnDijXLksbP1D28W0VE4z2lN5fb8CPOMCDEuuyMmbZF8st1JSq8dLrq+kh/nJTVA==
X-Received: by 2002:a05:600c:3b0e:b0:40e:4912:1df3 with SMTP id m14-20020a05600c3b0e00b0040e49121df3mr6712237wms.3.1705328918603;
        Mon, 15 Jan 2024 06:28:38 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm16146855wmb.7.2024.01.15.06.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:28:38 -0800 (PST)
Message-ID: <df8864fe-655a-4890-a19c-7fb69513aeb5@grimberg.me>
Date: Mon, 15 Jan 2024 16:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Content-Language: en-US
To: =?UTF-8?Q?Sa=C3=BAl_Valdelvira?= <saul@saulv.es>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240113213012.30898-1-saul@saulv.es>
 <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
 <lnfpduryv5nwibiejqxnvohr4pcismnkyzkowqvit3gkpdgt3d@ojcvlonaolzu>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <lnfpduryv5nwibiejqxnvohr4pcismnkyzkowqvit3gkpdgt3d@ojcvlonaolzu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_062843_217705_E4554BDA 
X-CRM114-Status: GOOD (  17.63  )
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


>> Is this specific to a certain fw version? otherwise this should perhaps
>> live in the device ids table in pci.c ?
> 
> I'm not sure. I'm trying to check if there's a newer firmware version
> for this drive, but the manufacturer's page [1] says "Firmware updates
> are automatically handled by the Western Digital SSD Dashboard app and
> apply to Windows exclusive systems", so I don't know if I'll be able to
> update the firmware to check that.
> 
> About pci.c, I also tried adding an entry there like this:
>      { PCI_DEVICE(0x15b7,0x5003),
>                .driver_data = NVME_QUIRK_NO_DEEPEST_PS },
> 
> However, it didn't fix the problem. The only way I've managed it to work is
> by adding the entry to the core_quirks table in core.c

Strange. Not sure why it wouldn't work unless the vendor/device numbers
are off...

> 
> [1] https://support-es.wd.com/app/answers/detailweb/a_id/47188/~/p%C3%A1gina-de-soporte-e-informaci%C3%B3n-de-western-digital-pc-sn520-nvme-ssd

