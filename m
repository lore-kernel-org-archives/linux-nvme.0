Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2675EC83F35
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMxrmpuCdkav7rNWEg+tHXjOAWkKzAEY7T2CQQo0GbM=; b=Waj2/ssRYpPybe7UgbttVMCqes
	mi6K6flaES/Sv04KLVt4XU3nLWlXz7qaHFp1JdMa2/xVayJpx0L+DahzKrVICcOj9TutUzCBGOC1u
	f0q2+22E1QpznWrJS+lNrv/YWa9tsYSe7aht1uz0MLREHvR4XCroIdqa95rvzsO0v7mP9VKWnhh5p
	rtQqDQwk/MVE+ZEpl8VQHD4mmlcBy4J/0rVuX9x0dssAB9lgQuRkkphmYxsCHgv6JeO0CWNGYRlnv
	bVnmBR8tpqvfHuRav3QVs4XJvA7VW+XWaGB4sRTGOc+yN5zkjL6xp7GN3qVIj6P6QjDzOPoaV8/cG
	BUCaophg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublBg-000000061lm-0odf;
	Tue, 15 Jul 2025 19:19:36 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubjEE-00000005oTz-0u9T
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 17:14:07 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3df2d111fefso49048625ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752599645; x=1753204445; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMxrmpuCdkav7rNWEg+tHXjOAWkKzAEY7T2CQQo0GbM=;
        b=m2wv2cxTjyL6ARYaJ6UNczVItDX4wB0HIyTw1i9oBZUfoZwwNeMxdxIH+79fI/tQbH
         EG1nltTGR0+fXoGXrMAvboHVQJKZsg7gZ4pb5hsrTK8D7ppraZsMq+lUdex5Zuer/vvK
         8U/mQUGQ5gefpz5YghNFtAHVAYEzTWWjmorhpSW5tH4q/IWGjWt9Dfm0aOs97ClnZ+Zu
         YA4m/m8LnSlQJhQzvLJhkbBDigyVA/emfhCldoNtejX3C+dIwopTHza/AzbhuSQir7Gq
         n/kj/Nx0hjrjZCyb0QZkHX54X3wxWH+crZcY1bskjNvzqp/hKEGquf8C/Eucrpgl/Sje
         VYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599645; x=1753204445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMxrmpuCdkav7rNWEg+tHXjOAWkKzAEY7T2CQQo0GbM=;
        b=e5bcRmi77bx/G4NgE9joQQ4QQF30yWf1EsRX9o267joQP6ggq4nGc4/eI3ZwCYKXnB
         UVAJo9Gw8wBRNLHpfkBcFGFa6N9ZHoJ+v8Js0xGGryldPC6qgw6ja8eLThkXt6/QSYQn
         XURchXTwASD1nKszJdvgGD8UdaKIj24JBT2f4WsqwJXwDi27c5qbcaUiHli88ZawPYc6
         Z2bpRVbfy2aheMzfmbSS0X9ciG+PFusAKVYCqAnsGUskGXv1IeWSZo6u4dVZIXFf18Q1
         zbl5SYir+VlsTDYWzLQm9MyRY4vdBKoWKxZwZcbVOahonqQQxdtugqb4hZqpGurgF8pu
         i6iw==
X-Forwarded-Encrypted: i=1; AJvYcCWn/+GR5CLFiSfqBzYCtWYdg+Vkp3ApcLIYF6Oxhfa6xY/7QV/+h9TF/y9MXWzN4s/VZh+RQJ6jPrKM@lists.infradead.org
X-Gm-Message-State: AOJu0Yyfq4LCxVt2jtde0nmoGXunmd7EoC8Eg82umX6v8eAo8rWcFI7k
	8icVy0k2YKzrjWJglgkqsOmEqQlmCZMzHfsVkN5P8AcJf4mVZ/mHxoizf4VsDUVaXzw=
X-Gm-Gg: ASbGncsaz6ThwtIMz8+t5X/5fmyPn4IChSuzBJanUbHV6y69bsXdYEARWEGNUSobt9/
	ThwZd47pQAfNfMRXhNZdvfLOnO4rx4mLetSwYt5ayR+/b8Bm4jJDSHc/uDcUjwZ3CTbFsxVkXBb
	5y6Ahna5LpxbW4Tqfs/Yco4NRg8VCDO/NyyEUBOQIA4B4BrrXOV0y2+nR1GrsBDthxIvIPjzyWT
	NpkjwTmIM584HjCMtCrBiEd3BnrBOoJUWDJuFl8qkplgWFkR9zT9+V+WFXRh9Xbks2bhFcw5yBW
	ihNZTjY74idhU9Ehu6MAZF9XH9/dlvFvGq0fPNb8VP1JjNISOZujX//Ns8MVXICNgDTkRZDbQ+R
	yH/Um1PftggQ9tZaZG9Jt3uFcrsva
X-Google-Smtp-Source: AGHT+IH2n5ItpiLtReE/tNyR8VfN63Qhgl9pICyUl/KKZBnIF8owSdnXaa2nun7yIRDOkb1ctoi+hA==
X-Received: by 2002:a05:6e02:1a21:b0:3df:49b0:9331 with SMTP id e9e14a558f8ab-3e2532781a2mr181059345ab.4.1752599644954;
        Tue, 15 Jul 2025 10:14:04 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569d3d60sm2579258173.103.2025.07.15.10.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 10:14:04 -0700 (PDT)
Message-ID: <7d1b2ab7-0cd8-44b4-bcb5-9bd31ce650e5@kernel.dk>
Date: Tue, 15 Jul 2025 11:14:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "axboe@fb.com" <axboe@fb.com>
Cc: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 Shai Malin <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Gal Shalom <galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gus@collabora.com" <gus@collabora.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Aurelien Aptel <aaptel@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "kuba@kernel.org" <kuba@kernel.org>
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
 <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
 <2e2d61fa-affd-486a-b724-b458d722304c@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2e2d61fa-affd-486a-b724-b458d722304c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_101406_387276_626ADBD9 
X-CRM114-Status: GOOD (  17.16  )
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

On 7/15/25 11:08 AM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 7/15/25 08:06, Jens Axboe wrote:
>> On 7/15/25 7:27 AM, Aurelien Aptel wrote:
>>> From: Ben Ben-Ishay <benishay@nvidia.com>
>>>
>>> When using direct data placement (DDP) the NIC could write the payload
>>> directly into the destination buffer and constructs SKBs such that
>>> they point to this data. To skip copies when SKB data already resides
>>> in the destination buffer we check if (src == dst), and skip the copy
>>> when it's true.
>>>
>>> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
>>> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
>>> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
>>> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
>>> Signed-off-by: Shai Malin <smalin@nvidia.com>
>>> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   lib/iov_iter.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>> index f9193f952f49..47fdb32653a2 100644
>>> --- a/lib/iov_iter.c
>>> +++ b/lib/iov_iter.c
>>> @@ -62,7 +62,14 @@ static __always_inline
>>>   size_t memcpy_to_iter(void *iter_to, size_t progress,
>>>   		      size_t len, void *from, void *priv2)
>>>   {
>>> -	memcpy(iter_to, from + progress, len);
>>> +	/*
>>> +	 * When using direct data placement (DDP) the hardware writes
>>> +	 * data directly to the destination buffer, and constructs
>>> +	 * IOVs such that they point to this data.
>>> +	 * Thus, when the src == dst we skip the memcpy.
>>> +	 */
>>> +	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
>>> +		memcpy(iter_to, from + progress, len);
>>>   	return 0;
>>>   }
>> This seems like entirely the wrong place to apply this logic...
>>
> 
> do you have any specific preference where it needs to be moved ?
> or any other way you would prefer ?

In the caller? First of all, having any kind of odd kconfig check in the
iov iter code makes zero sense. Why would a copy helper need to care at
all about what kind of drivers are enabled in the kernel? It's a gross
hack and layering violation.

-- 
Jens Axboe

