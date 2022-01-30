Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2610C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JEFyGFoPbyzgZYfMDsqURU1Oe+Tlg90Vu2Zk5zw5r1c=; b=dPUrUZiQZGNW/iPybhUNvpnXLQ
	D+GBorCR32BtY6uioefmNj68bxD3918FnqG/MBOsaeLYA3bbnONbQnjVI7AaMa89dOmuoZjgECuRC
	JgzOik+NhBQYGblfkWPXPtV5VLcSjdjFm97XViR6x9Jg04CPTY/wKqCc4Mol8x9j5iWk/bysFboOb
	bO1bMMiilj0It9cshROhf0oliIAX0DYiaDfz1thN8W7aySthD89t6USHa0BeyGvQEQRCXQFL2SAcD
	zMO0EmBHbgarOJGVqjLlPdViYlTynMLBSs7bsZSwPYpN5HqIoGokZz/JNSplaXH+MCNaRnSw4IUlD
	l1fVRmjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE5ql-006Agg-3h; Sun, 30 Jan 2022 08:46:19 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE5qY-006AgE-VB
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 08:46:08 +0000
Received: by mail-wr1-f48.google.com with SMTP id h21so19458458wrb.8
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 00:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JEFyGFoPbyzgZYfMDsqURU1Oe+Tlg90Vu2Zk5zw5r1c=;
 b=JRCTmfrBzmXDGd5BOJExlqO6BArbq9tWikZMamTGokpOeMc1ZAyXuEe96hQmKzoRpG
 yrFZE9HRWCYqhJHht9ebUNazdVY//Ghr8Bx7rgy09KF2Pi5NJVAeWBn9gUaFleOyNlFL
 84WnelPgbRoDO/CW6u6xKg3TBrxgOQMDimF2T+un934vVPNqZXjnT2jOHbXVSz9JPow3
 7xeQa6OssYfcPfpQhrMz3MC1MWb+JrGPbZ3agNg1AjyqI5mDL4LPtE64XBXpjgrGcdh6
 Nfb8Xk7SuptzwrcGWX4VEnkYXLpmQ+P5XUBPUAnoL08qblKE3OND9sP/B3YMaPKg76+t
 qouQ==
X-Gm-Message-State: AOAM5313BcwFBInPJAOM1UAPoMlvkzjFyVWlBJauv3E0tDatiEaSd/o7
 wa3kjpo1KJ0LUCGISI72Qp5ENioN9xw=
X-Google-Smtp-Source: ABdhPJwd5sxvDuNKDrEaAEg6XxT++S6f3j1/1K6g974T6TbGN3GfSI88VHno14t28l1qQTmjGKfayg==
X-Received: by 2002:a05:6000:2a6:: with SMTP id
 l6mr13754749wry.601.1643532364706; 
 Sun, 30 Jan 2022 00:46:04 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a1sm9045246wrf.42.2022.01.30.00.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 00:46:04 -0800 (PST)
Message-ID: <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
Date: Sun, 30 Jan 2022 10:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_004607_031484_2C5286F2 
X-CRM114-Status: GOOD (  12.71  )
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


> [ .. ]
>>>> It would be nice to have different events because if we use the 
>>>> "change"
>>>> uevent for both "log pages have changed" and "connection has been
>>>> restored", then the user-space app will have to send both an "explicit
>>>> registration" and a "get log page" whenever it receives a "change" 
>>>> uevent.
>>>> It won’t be able to tell what that "change" uevent is for.
>>>>
>>>
>>> Au contraire.
>>> Change events come with a full payload detailing out what the event 
>>> is about.
>>> In the case of a 'log page changed' uevent the event points to the 
>>> controller
>>> device, and payload is a string 'NVME_AEN=<aen number>'.
>>> In the case of the 'path reinstated' uevent the event points to the 
>>> block
>>> device.
>>
>> There is no *block device*. It's a connection to a Discover Controller.
>>
> Ah. Correct. Guess we'll have to add an uevent here.

Yes, thgere is no bdev for discovery controllers. We may add a uevent
for userspace to consume as soon as the transport reconnects or when
a controller (re)starts.

Don't see any point for the disconnect part as this is async and will
not have any ordering with the actual disconnect. userspace will need
to do it before it disconnects the discovery controller.

