Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2A0C3ABC5
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26EOXr2vJWW6t3hHaNAR2D9XFOZG9IBsNflnUTByjK8=; b=QzLj2o+5Bm+6ewLDjnTtNVaDim
	+xpo93ibRglwQDwoA82FU8EAym/2R0ppiJuMUL1IhY93ws5APuw1Ie2NdY74SZ6DrEHfbUnjtMUND
	x6+22VQQLsgn56X+LUqQ6xwUBkdLekCrJ8WEqtQYkHhRrwbOL05kJZA49ZorR6X3gHYK22kdkh14s
	zfgs7nHnRPUrR5k0I5jAb173xv8aYkP1em5F1QHw5b/fujLCTN71eFLd/8QXmce5+A5Iutgk/dpCg
	VkzzZNDRd6PU7ByGuuuDbibYD9TmdcdlmIrlLeGPSkEKWb7phaYmd6N22ZMf5fhOkRcGn0BygcVLj
	zrdzIA4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE2iY-00000006zNM-3bds;
	Sun, 11 May 2025 09:11:30 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE2iV-00000006zN0-1ifP
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 09:11:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so37952735e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 11 May 2025 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746954685; x=1747559485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26EOXr2vJWW6t3hHaNAR2D9XFOZG9IBsNflnUTByjK8=;
        b=dJs3V9dFI7pz5FuAMowQc2QFrowwW8XZLfMuWgtSvk5wvUrP5cZLwJyDdgojAfjq75
         PfC1AhJC1O8a513pbDWGfm7Ljquuy7Z2jdDHkUtcd42ds9UD0zJGr0rAiCIIgoeNOG/U
         8ciUz/9MgyEM7PMr3IhSvXXO2Kfb9f26XkvnL/SCA6/DHkfliaCZ5UP42Qx+kpU/8ogL
         /LPTh35eYWlqugpvWuHkS6F79omfvnN1ug2RrWqTwUCNMZ/dLVVTgztUfAXrzHqLdYeQ
         Xm3JxRnsGXwUg27IZRcIFTOs8rDOhfplMHIfTMAhzgAAXVp9We3iWSlTKLfSasyWebp2
         aqGA==
X-Forwarded-Encrypted: i=1; AJvYcCVVWZ5C6WrHQLFOaIErkd5B0fgzDXMtVK8j7lEqXGZiR/TqsAGCaSY4YZ5H6BKKADIi6kqdwfqVRan+@lists.infradead.org
X-Gm-Message-State: AOJu0YzK7CEDZKiSuLOs61iSCac6+1qE5OH9TsCC5/033I//L0mX0Jpj
	+hjvsyVOHWJ1Ydy6xz3MIH2k1WezUhs3lq7EKPYCnPNZRtz3nHnY
X-Gm-Gg: ASbGnctAoT9mw5PgKu8fokIHQ0V0QnfRgfFlUG6TkJ3zg4Ze3DYbSl8SxLN4VEi/zal
	mDHITn9gtIqV2TWs9GC6zp8j+gla9ACYln+1lY+AMiEnH4LhtdoCZmPZCvV4g1p9ZqzntPKm+1I
	WqRoQpnbSj19O//38rSnTEdlqaVWPpnDbuyAnuLsiO9QwWKFjztSif5QK8B25o4HJ6Rg5N695c9
	STgWNwcsjX0KVnXcVjx9gc22FqMPQwMz6trkLlg3e5xBywWDAhOu4slhva8pGiG/udCVpYC3V97
	y6et8qRRlIpXKII8fo7W9aguo4jBVHLxYLKhWR+OPGaWC0OPgEnRIyke8REWKNBwmi8TamVq4nt
	NUDKUKctaInyhVsBdbT4txlpNlUU=
X-Google-Smtp-Source: AGHT+IEwmHjOmUIJPSSg80MNRTRVohsIOggiFdrIc7ZFiIW//jfPsF7XZY5bQvnmnDW2B7h0c76jLQ==
X-Received: by 2002:a05:600c:4e8f:b0:43d:98e7:38dc with SMTP id 5b1f17b1804b1-442d6cf318fmr69461565e9.5.1746954684890;
        Sun, 11 May 2025 02:11:24 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdcbsm87742175e9.40.2025.05.11.02.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 May 2025 02:11:24 -0700 (PDT)
Message-ID: <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
Date: Sun, 11 May 2025 12:11:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_021127_451765_D35D9231 
X-CRM114-Status: GOOD (  16.60  )
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



On 09/05/2025 0:23, Kamaljit Singh wrote:
> Hi Hannes, Sagi,
>
> On 5/7/25 15:26, Kamaljit Singh wrote:
>>> Can you please retest with the patchset '[PATCHv5 0/2] nvme-tcp: fixup
>>> I/O stall on congested sockets' _only_ ?
>>> (on top of nvme-6.16 latest, of course).
>>> I think I _should_ have included all the suggestions floating here,
>>> but we need to have confirmation.
>> I've built the kernel against the latest of nvme-6.16 branch along with
>> these patches. Its with test now. Will let you know when we get some
>> results back.
>>
>> 0. [PATCHv5 0/2] nvme-tcp: fixup I/O stall on congested sockets - Apr 29, 01:18
>>      Hannes Reinecke (2):
>>        nvme-tcp: sanitize request list handling
>>        nvme-tcp: fix I/O stalls on congested sockets
>>
>> 1. [PATCH 1/2] nvme-tcp: sanitize request list handling - Apr 29, 02:31
>> 2. [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets - Apr 29, 01:18
> IO timeouts are still occurring with Writes. The only Read that timed
> out was most likely due to the path error. It takes ~4.5 hours to fail.
>
> However, this test does not fail if either ECN is off or if digests
> are not enabled. These passing combinations were run for 16+ hours
> without any issues. Both ECN and Header+Data Digests need to be turned
> on for it to fail.
>
> Do you have a failing test as well? If so, is it quicker to cause the
> failure? Would you mind sharing any details?
>
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] block nvme1n3: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 opcode 0x2 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 seconds...
>
> In the current build I had these patches on top of the "nvme-6.16" branch:
>    41b2c90a51bd nvme-tcp: sanitize request list handling
>    9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets

Kamaljit, with the prior version of the patchset (the proposal with the 
wake_sender flag)
did this not reproduce regardless of ECN?

