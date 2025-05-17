Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B916C2D0CD
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iuq1lFTfb3Gfo6aRAMHfOuP3kLHaPc7FmeGzvBNgalE=; b=K+YHq/9L10Ko9FLKQ+ErRaQy2a
	uwK6aN/EZr9QFRrFR8RbGgxt1+x03IlEQDgCT1KDT2CpVjIK660pVm8HHLwrZXBKgT3DvVjSypyHv
	JPNLi/jKvwePaXWLKcuqEvcd0rPDTtFyklABwCmbO8+RR/UKe/o5tJ7rHkahJBc9ipMODw5KgAcZD
	ic60Xl1FcEa2QPUzgDlXoxejr4N+W95JsqE9OfWMwhregErPup8DW4RSPFibWfl0i8mmKDweETve2
	AsHalB0X6bczc5c3k4665yDOxMT2qWQ3duJSAu6OWW1DeGpkXjRnCwxMqyW9A3QWatmNHhgZhROaq
	DtrclT8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGEML-00000005Vcq-36NW;
	Sat, 17 May 2025 10:01:37 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGEMJ-00000005VcR-2JkB
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 10:01:36 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so22551335e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 17 May 2025 03:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747476094; x=1748080894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuq1lFTfb3Gfo6aRAMHfOuP3kLHaPc7FmeGzvBNgalE=;
        b=FWQhpCEJCedQckTsPNKdjfll1GhdmG1qzt4zCkSfes2++qP4CwXFYYpHRHqGcHbzUv
         GGoT1XGjPSnkZCpvGb0K1h5ecf9rVjB8XefP6ywldlhpi4Kmyu3v2ZBLQdEXQyFbwat5
         ZiV+rtv+wTamgAxPQ61eO1qk3acDCv6OujVUDDuwGj2BKsnxIskljqPDOnKWLGHXn3dt
         ifwyEaY/G2RIYRWxIs7vgUEEWNRF1okhilKR+X3usjiTv01/kNoD8HHhxF6i7Wdt0YGS
         wuaXXhsGvPjszSqs9BVIfthaTiWhKh+tg1z/klNk5wLxH2C6EIxWn3ljqAdJ/pso9rnt
         2iEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuhz5KqLGXDYNLuzznwOkbHfNEFDvzneI9MTiELFP47Mvg8H+sKXWJiOyWgNpH0kP8sTD2+UB4MPqO@lists.infradead.org
X-Gm-Message-State: AOJu0YyQumKETLdhuIiNKWnZsu+Huw0HdUlbUWFKMvZzQp+BD8W6cqe2
	fJJ6uzHdZHYHVctL2j3EjpsbJtEtFFvRWD8sBAYeh9mAG7iVJuRe9f0i
X-Gm-Gg: ASbGncsNqrM3gCr/dQZnp36AU7nuEFEyh5XlUkVtNxnRkUrn0Z82bDo6sbYsEvrOcOV
	UNOi0EHRMXalNFJ3dN7XtwlPr3a4OMHSpfQFDKQlerUdrYSAOSdLRZHTrUeElJZmF2M75Ytdq79
	U68KNUZLGR31Jv4ahEh1VAxnTKdBMCu2yKQYS0JTMjPtwZCRLia0t2KnSGzp0ainnnqQ3NFGpeH
	8VwjSpX9EKbVUWg0uXwmZI5Iv910Pn+iLFeUmoKIUL3CrjqJWDcHdHOKfYSLIO4h2gnxyCBQt3V
	ka8DSqOU1u8SSc3eTsARoBcqjDZR8KTN8CObg8EShdm56BnAjxVKsRtxSWRRJEmT5+23FTGDRd8
	vSTmeDfWk
X-Google-Smtp-Source: AGHT+IEy+CVkZtsV1lA7kXrIwK2DCO8Z+Xr6Gt9jcd0Q8pjp6YWePRA5ocgc0a6tLIqUhq37UVMIJA==
X-Received: by 2002:a05:600c:548d:b0:442:f44f:678 with SMTP id 5b1f17b1804b1-442ff03c63emr61195775e9.31.1747476093516;
        Sat, 17 May 2025 03:01:33 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-443003ab9e2sm48881765e9.7.2025.05.17.03.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 03:01:33 -0700 (PDT)
Message-ID: <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
Date: Sat, 17 May 2025 13:01:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@suse.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
 <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
 <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_030135_601867_5216D545 
X-CRM114-Status: GOOD (  17.20  )
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



On 14/05/2025 9:35, Hannes Reinecke wrote:
> On 5/13/25 21:24, Kamaljit Singh wrote:
>> Hi Sagi, Hannes,
>>
>> On 09/11/2025 02:11, Sagi Grimberg wrote:
>>>> IO timeouts are still occurring with Writes. The only Read that timed
>>>> out was most likely due to the path error. It takes ~4.5 hours to 
>>>> fail.
>>>>
>>>> However, this test does not fail if either ECN is off or if digests
>>>> are not enabled. These passing combinations were run for 16+ hours
>>>> without any issues. Both ECN and Header+Data Digests need to be turned
>>>> on for it to fail.
>>>>
>>>> Do you have a failing test as well? If so, is it quicker to cause the
>>>> failure? Would you mind sharing any details?
>>>>
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] block nvme1n3: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 
>>>> opcode 0x2 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 
>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>      [2025-05-07 19:57:13.295] block nvme1n1: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] block nvme1n1: no usable path - 
>>>> requeuing I/O
>>>>      [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 
>>>> seconds...
>>>>
>>>> In the current build I had these patches on top of the "nvme-6.16" 
>>>> branch:
>>>>      41b2c90a51bd nvme-tcp: sanitize request list handling
>>>>      9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets
>>>
>>> Kamaljit, with the prior version of the patchset (the proposal with the
>>> wake_sender flag) did this not reproduce regardless of ECN?
>>   With the last patchset, when ECN=off, we did not see any IO timeouts
>> even with a weekend long test. This was true for both cases, i.e. with
>> Inband Auth and with SecureConcat.
>>
>> With ECN=on & HD+DD=on IO timeout still persists for both Inband Auth &
>> SC. I’m currently debugging a possible target side issue with ECN. I’ll
>> let you know once I have some resolution.
>>
>> I don't have any clear indications of the original kernel issue to be 
>> able to
>> differentiate against the current target-side issue. So, if you want 
>> to go
>> ahead and merge those two patchsets that may be fine for now.
>>
> Thanks a lot for your confirmation.
> We continue to have issues with high load or oversubscribed fabrics.
> But this patchset is addressing the problem of I/O timeouts during
> _connect_, which I would argue is a different story.

We still need to hunt these down. I'm still puzzled why adding the 
WAKE_SENDER
flag was able to make this issue disappear? I'll have another look at 
this patch.

For now, I think we can go with this patchset, and then incrementally 
fix the remains.

