Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D46EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTZZyWSh5B06JRMOZ2wOYOUO2V2w0QiKG05HA/MJRFw=; b=lrCiuo2cBoHkgKZDKhPUHqJ85g
	AW3YHwRkkfOe6fM2N1IYaFlOdCOijt/+lRPVBDrFhdAhSqpN7uBjDEI9Iw3ptpC5irJlKevr8VeoC
	QKq6PrsokhHkC43su0nKmDEiAHL41NpgQy+Ot6nV0rYEFAXKrtn5zU9dtH0Jz6wpghbj2qxV7kTG9
	EdNnAv2zlRkgKaTo2EQKsHRYEGPVgoHJGqedpQ9t8CCpK9d7ayEyx7Ee4n66bt4JuIigvsNklkiVY
	0v0RvBjZcEbNo4qo1LWPmsHrqgi0YKRYGj9yvog87rF0d9KrV/VauXOQ9+FQLIlyVupYJX6Q8POfB
	KVww3tQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJEX4-00F9uw-0V;
	Tue, 11 Jul 2023 14:40:02 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJEWz-00F9ti-2a
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 14:40:00 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-313f5f5c6c3so1506809f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 07:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086395; x=1691678395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTZZyWSh5B06JRMOZ2wOYOUO2V2w0QiKG05HA/MJRFw=;
        b=CG3OP4bRo2RrLPEqZutfU/ByQTdjHN5twBKK0lFP90HpgkiPZvZSHEn52OZyaUyrlp
         yDZa5wjSlpdIt4P5kv97YaYgqMPyFRN9A53V34B0Z2QNfLvncfK/CVho9cU/PK0oMGuf
         U4UZMVJWH1Qs0Ky7vDtYe6cuumH6KktxMrbXiFpTkU1867ynPdRskyhUvB7Pu8NdGJtx
         mtlUctzXUwfoXZFipbfB/subfuyTijuGMM8SQDRhdQyFWAnid+nIcIVreSbZZj38IOc4
         Xbks1lA1k+Ey490Meh9vG8vi3pG4LJSCOx5MpjhEzBYGYjLN5VspWiT76KpquQc7jgZG
         1EgA==
X-Gm-Message-State: ABy/qLZuypSEEIJfz88H14cQCI7EBjYbNRZC+nEWp2l7Q92Mn49thTEQ
	lZ1fwHtdhVcEHy5cj7t4pbY=
X-Google-Smtp-Source: APBJJlGgdl8aDs0Ugo2WnDF7rxcBgbTYzXT7t367gYQci8IYgQGthLUOCpXloU8NyYb+4GuXvz5/lw==
X-Received: by 2002:a5d:4c85:0:b0:314:1d7f:9e9 with SMTP id z5-20020a5d4c85000000b003141d7f09e9mr15798184wrs.0.1689086394648;
        Tue, 11 Jul 2023 07:39:54 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d4a86000000b0030e5bd253aasm2413031wrq.39.2023.07.11.07.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:39:54 -0700 (PDT)
Message-ID: <9e91ba36-0a4f-4613-e45c-7919205d8704@grimberg.me>
Date: Tue, 11 Jul 2023 17:39:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Pankaj Raghav <p.raghav@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 "Clemens S." <cspringsguth@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>,
 Hannes Reinecke <hare@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>, =?UTF-8?B?67CV7KeE7ZmY?=
 <jh.i.park@samsung.com>, Linus Torvalds <torvalds@linux-foundation.org>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
 <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
 <2023071135-opt-choosing-51dd@gregkh>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2023071135-opt-choosing-51dd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_073957_855460_95074D13 
X-CRM114-Status: GOOD (  19.71  )
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


>>>> Well, that "They keep pumping out more and more devices with the same
>>>> breakage" and the "new device" comment from Pankaj below bear the
>>>> question: should we stop trying to play "whack a mole" with all those
>>>> quirk entries and handle devices with duplicate ids just like Windows does?
>>>
>>> As far as I can tell Windows completely ignores the IDs.  Which, looking
>>> back, I'd love to be able to do as well, but they are already used
>>> by udev for the /dev/disk/by-id/ links.   Those are usually not used
>>> on desktop systems, as they use the file system labels and UUIDs, but
>>> that doesn't work for non-file system uses.
>>>
>>> And all this has been working really well with the good old enterprise
>>> SSDs, it's just that the cheap consumer devices keep fucking it up.
>>>
>>> If we'd take it away now we'd break existing users, which puts us between
>>> a rock and a hard place.
>>
>> Maybe the compromise would be to add a modparam that tells the driver
>> to ignore it altogether (like allow_bogus_identifiers) that would
>> default to false. Then people can just workaround the problem instead
>> of having the back-and-fourth with the vendor?
>>
> 
> Module parameters do not work on a per-device basis, sorry.  This isn't
> the 1990's anymore, please do not attempt to add new ones :)

Don't get me wrong, I don't like adding this. But the source of this
is that there are simply too many breakages of non-compliant consumer
drives out there that maybe a compromise would be "globally relax
compliance check in this specific area" as a workaround.

Right now each time this issue is seen in the wild, the only
resolution is either the vendor fixing it, or the driver adds
a quirk, which is positive and exactly what we want. But more
and more users complain, and there is no immediate workaround.

