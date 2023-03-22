Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F724C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbxHciLG2pypN9Bl2bjTVAU52GvCboKUaOJHGsOIGts=; b=N2LSjZno1WK4qECpEwutnpizde
	QhWkhZgHkts9XXOFB7mBqicVUUrLekL4LS04l39Y7WFHnK70c2rKO300WMEZ17hlU3aGatcm+aekg
	o13YyRVSQQjRxTJxG7j3AeCvGygQOEptGpYMpgiZF7mkpPo573HWIsYN3vQByYrBsOfTZtNa9MqXv
	8yFeoJE6JeVJekEygIiH/Lj/h36e0i2yxTTs9dJQQkzHS0X5ct0VpWwA5dWnxOxAc5tZjcTQZEhtI
	3KgFTMp5a8qZrUBXSm4noUWv1zCrwk7xKRNJ32NK5A0+LGOVKmoHaXvJK2IMgqAGL5k0Nc3ghPhQv
	ME9OwpCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pese4-00EyY3-1k;
	Wed, 22 Mar 2023 07:12:28 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pese1-00EyWt-26
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 07:12:27 +0000
Received: by mail-wm1-f49.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so5619597wmq.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 00:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbxHciLG2pypN9Bl2bjTVAU52GvCboKUaOJHGsOIGts=;
        b=LuK4fjg44kUP2irIPdeB5yy6q8Ja8pvXOKzbaVinT3KPq3BzKI6YjIWKogfNZxf2CK
         Z0JC/DNkCqxyOgNuibwAUpQTcedYyHkY9gcoQkGrWFxaVP50eP0bU4ZzUgBVqLwoqezr
         c177T3qv9N3Rusr5DDNSt/dFS5HsE6Dwyz8/VzoEFXWyS+M2VT5PXT7/53SekUl5GuR+
         ltxwcdPYnEgnMH57Mdqg/Z/kr2IfmNzDWp9h5epMn1/jwyzcQLvxyY1LQdN7Bu1RRzOP
         9GGnq41oswj4IHYV11jv8XTn4S2quZbH2jDIFA85n2YVra4NDrri1tgUatxn44NYu8Js
         2ZRg==
X-Gm-Message-State: AO0yUKWefqCE/JR7eLwU3pkNJtvOrmpB5BSoqtcMf4L45LuK7fBje5fm
	4BZlB2yhORsr8+2QRO8XMGQ=
X-Google-Smtp-Source: AK7set/xVFyitMqda4JG/F7Z0xoit+LJ1ikInj55ZuaxNfbI68pTdU7MxR5BPW/3soMGBns5GFGg6A==
X-Received: by 2002:a05:600c:4515:b0:3ed:2eb5:c2e6 with SMTP id t21-20020a05600c451500b003ed2eb5c2e6mr5384776wmo.2.1679469141061;
        Wed, 22 Mar 2023 00:12:21 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003ede6540190sm9659662wmq.0.2023.03.22.00.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:12:20 -0700 (PDT)
Message-ID: <4ec55800-fe57-11f5-d282-a7e4c58f14ce@grimberg.me>
Date: Wed, 22 Mar 2023 09:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0V4dGVybmFsXSBSZTogW1BBVENIXSBudm1lOiBm?=
 =?UTF-8?Q?ix_heap-use-after-free_and_oops_in_bio=5fendio_for_nvme_multipath?=
To: Lei Lei2 Yin <yinlei2@lenovo.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
 <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me>
 <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_001225_712928_A73751CF 
X-CRM114-Status: GOOD (  15.45  )
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


> 	No, I have not verified this issue with a system larger than 5.10.y(such as 5.15.y and 6.0 or furthor), because some function we need like cgroup in upper version kernel has changed too much, we can't use these upper version kernel.

Well, this would be the starting point.

> 	In addition , uptreams have change bi_disk's modify to bio_set_dev(bio, ns->disk->part0), and as you said there is no bi_disk in struct bio anymore. So that is too involving because of code dependencies,  i want to do is what you said, to send an alternative surgical fix.

The correct course of action would be to identify and narrow down the
fix for this upstream, and then backport it back to stable kernel 5.10.y

> 	(I will confirm upstream for this problem in the near future, if it have same problem, i will submit this fix.)

Great.

> 	I'm not sure what evidence is needed to prove this problem and patch. The following is child bio and parent bio struct when heap-use-after-free occur catched by crash(I turn on kasan and panic_on_warn).
> 
> 	Please help me confirm if this is enough, thanks.

It is clear that there is a bug in 5.10.y, what we are discussing is:
1. Is this problem relevant to upstream kernel?
2. If yes, we can debate the correct fix, as your initial patch is not
    If not, then the upstream fix for this needs to be identified and
    backported.

Having stable kernels drift away from the original code-base is a bad
idea.

