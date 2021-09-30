Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 07:55:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530B761452
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 07:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 530B761452
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McxfxYK/2fFJMY9oNxa/DQxvVvpHVLQV9Tv1qAd1l0E=; b=EM9kFHkd0PdKx+1yVjRf7eXh+8
	O14k+uAPk/WzZBgXdXOQhSepzL0JfstnZIEE60ZNzKKZuk6sgP9Q2PGO6rzkwhs6ryt79rOPnb45h
	wQrkKLQA9fJ21GhFS2BGW6Ua7L0zLULB45+bFMKp1rAAAkrhrHI1NPFVzChjF9cC4UoVvKaLMlxew
	aeLzcgaaefPJ2ZradiYdO0OX7kqVGzz6rfW/RGexFWdxuY0y73CKrMytyE6uMSWBHlqAMMk84PN/n
	jRaQCRKi3YSCDi7F2PbVK39lzMhto1s/fw1UB8fXRDmAGoESsullaFVyQ2tB1VR2py7k1mu/Tq89E
	G58cA+Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVqua-00DH7j-SB; Thu, 30 Sep 2021 07:55:24 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVquX-00DH5U-2C
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 07:55:22 +0000
Received: by mail-wr1-f54.google.com with SMTP id d21so8466956wra.12
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 00:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LhOnlTmikjgmVXOi3QJfXvc0q6nt8e51p5u7+xTUvtg=;
 b=MvhbIItoRk84ce1dXYsL1BVBWzWUdKM796p7DwzIQ8pG54uXfY0szyV/hbktjEPUto
 dhjhZ+veO6VymI68q4+OG72yyyDv4i6Tht8sV16gwqLSdJcn3810A8bqNTCeh87wEKTn
 11YRb7ppQlCNp+na1UNMtrVB+t62SVSUnIuN0Wn/GAludXgQfbGnimFZD6tE+T3IBF0b
 wRHUJiOdV4uFyyTtmaLwhX1+dHNyuadw0Yov1CVj1BLwCWWJBRb+x+4JWiF3ZLdsKJa7
 ZUQF0BEpiFUjDE5UIF0NPWrpW0PgfTa00pAIedvlBmF9gMRDIvfsq8oFdcHnanyjSeNc
 2ywA==
X-Gm-Message-State: AOAM532sn18jXs2nySkaBD+v0Xxo9zFq3NXUGVJY+QG5t2MD0Z/yWTxc
 xH91YbGA6B1/J90b++NKwMb8xakfCjQ=
X-Google-Smtp-Source: ABdhPJw8i+MSJcFLad4BagAdxCsoGzPNGs83Dqne0gOsDC2yhSK0YXr4xuCVG7AxekcEJoXTDFXFdA==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr4605446wrd.252.1632988518163; 
 Thu, 30 Sep 2021 00:55:18 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m5sm2482104wms.41.2021.09.30.00.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 00:55:17 -0700 (PDT)
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Yi Zhang <yi.zhang@redhat.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
Date: Thu, 30 Sep 2021 10:55:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_005521_168991_6D9B1F10 
X-CRM114-Status: GOOD (  14.85  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hello
>>>
>>> Below kmemleak was triggered with blktests nvme-tcp on latest
>>> 5.15.0-rc3, pls check it.
>>>
>>
>> Please share the test number and the frequency to reproduce this...
>>
> 
> Hi
> I'm running the full blktests nvme-tcp[1] and it's 100% reproduced.
> 
> [1]
> # nvme_trtype=tcp ./check nvme/

Yi, this does not happen with nvme_trtype=rdma? It looks like
we don't get to call cdev_device_del and del_gendisk, which means
we may have a referencing problem...

I'm wandering if this is a regression we can bisect to?

> 
>>> unreferenced object 0xffff8882bc8d6668 (size 8):
>>>     comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
>>>     hex dump (first 8 bytes):
>>>       6e 67 31 6e 31 00 7b 7c                          ng1n1.{|
>>>     backtrace:
>>>       [<0000000046e1c456>] __kmalloc_track_caller+0x129/0x260
>>>       [<00000000a8f7a3a1>] kvasprintf+0xa7/0x120
>>>       [<0000000076a54cc5>] kobject_set_name_vargs+0x41/0x110
>>>       [<00000000a569a16a>] dev_set_name+0x9b/0xd0
>>>       [<00000000f793cc3d>] nvme_mpath_set_live+0x322/0x430 [nvme_core]
>>>       [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
>>>       [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
>>>       [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
>>>       [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
>>>       [<000000007be5c512>] process_one_work+0x9a8/0x16b0
>>>       [<000000002ae51314>] worker_thread+0x87/0xbf0
>>>       [<0000000034c41079>] kthread+0x371/0x440
>>>       [<0000000020c3a70f>] ret_from_fork+0x22/0x30
>>> unreferenced object 0xffff8882d1509800 (size 512):
>>>     comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
>>>     hex dump (first 32 bytes):
>>>       00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>>>       ff ff ff ff ff ff ff ff c0 b6 b7 97 ff ff ff ff  ................
>>>     backtrace:
>>>       [<00000000d6c8d6f1>] kmem_cache_alloc_trace+0x10b/0x220
>>>       [<00000000e6493d28>] device_add+0xe08/0x1d10
>>>       [<00000000aa40e6ce>] cdev_device_add+0xf1/0x150
>>>       [<00000000142436f1>] nvme_cdev_add+0xf8/0x160 [nvme_core]
>>>       [<00000000d948ccab>] nvme_mpath_set_live+0x347/0x430 [nvme_core]
>>>       [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
>>>       [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
>>>       [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
>>>       [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
>>>       [<000000007be5c512>] process_one_work+0x9a8/0x16b0
>>>       [<000000002ae51314>] worker_thread+0x87/0xbf0
>>>       [<0000000034c41079>] kthread+0x371/0x440
>>>       [<0000000020c3a70f>] ret_from_fork+0x22/0x30
>>>
>>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
> 
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
