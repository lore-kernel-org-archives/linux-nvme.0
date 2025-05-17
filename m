Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84E3C2D0CD
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5eT/eZ4Kkrbmk5WeQ92868S/qIPb8eStkSNpU7D8qc=; b=dgnVTpKEXGGE3VM5FiDNEdzTtS
	b+8yUff6/MEVc/QdutYb6FcqUonSTqS6QSJ2UfVKLKkYqQEWhuAzLV2adQLiFVRnScj4f/J/UD2PP
	sj6r/OauvbsdM7FPYN0inRD1WkTZaoQOQYeSSN63tF9RNhzJ1IDy0w2oUbqbbPl3kdUEGvrtrY89q
	syZGHer/vM5ISz8n98gwautSexY86dHM2NjBtT+hHdt3PdDOj9PGtS1LBoZz8Bx3zJHP0Bab9R6OY
	PGdGfdTQjcaWwaDV/pAu50D38iAunaUTzRuS9z8rzrwngNsW41ut3Db1rKEXgBhmYRvUIV4KjuXCo
	vIDy3Erw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGEWk-00000005XEx-3d0Q;
	Sat, 17 May 2025 10:12:22 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGEWi-00000005XET-1yWF
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 10:12:21 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so15596855e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 17 May 2025 03:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747476739; x=1748081539;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5eT/eZ4Kkrbmk5WeQ92868S/qIPb8eStkSNpU7D8qc=;
        b=H2/urpflm3JJufbiQyfc5BXd/BTaeG6T7DFqb2mFlzmelzlBWur/hoo/6z+eVJKSGV
         s7AFx5xEFRzz0ZUiBZltYnxne+XIz3u2FFNOG2lftBeIVg4BrColUm/QZjkTtZMOb50M
         Mh1RuknduztN+1g6kbI6q5jC7uqvAK5ENTbiPRfjvkJXEGTLOshRpYqNBo1tRY1kvamf
         7wCmzWJEX8r8LZV3PMGRXhpk0hyaP/5cLNTXpA6GDwwLnkJCH2SOeqW758ugWy0graUl
         mSvmHTTQWO27sKm36xvWhC4/qZ4Ov/v7UpQx6yB3u6b2J9AOtPv3+A7JEi1JWFtkVYg0
         9IwA==
X-Forwarded-Encrypted: i=1; AJvYcCVggYjHGY1TiaqaqjxxVmuuZfQEOktgHY9898j8DCoRw57WGDa4qilLqiZ6T3NHggW3EdNFim6uGY/r@lists.infradead.org
X-Gm-Message-State: AOJu0YwddwD3IsKC5gwfIEz4mb5kQ1utDbnVdhTmLClzjFvY8ZqtO8JF
	vqYoqHiCQuvl4fFRVVMPxkVRK4mpHBBtb6iGLzU4vj1kAYXmakIl4U+u
X-Gm-Gg: ASbGncvdRB4HTlJgs1vJ9+wfPoK/+y/UEc4UWj1LH2LgIsJQjpGRM1tX2a4FXOK0nMX
	6mo9zxycCwg8xGusJjLV86+M11mKcuRVhRFaEGkjZg5GUl5p8FAAu6rbvAFQIF0SN9PRrBmNmDE
	Zzaxv07vgkPTyH7WLx1jYQUL0v3BkBPhmeqlAbTTUCXqt5AJJTkWmDqeCK9gVvN2DQdnE84/jz0
	vFHJXDB/5plMv1W9fFcF4nXjrMDZ1/8laK1zomZqTmrQ3jaE/hhhONj+3i5XUtkAK/yu5wyYgb5
	eOGprgAQi5LSidKQG3FEGDsfFZ2udWoEpSlOOL2qmON/ItBhbMkW+p5Sf99tEpq79CZjo8H47ep
	PRCCMtrT9
X-Google-Smtp-Source: AGHT+IEP+hmpHhyWT7wemJ7GtXdSA4l/PtG9nnlqp9op3w1M3WupO7oDI7Q/r86D5LhMuGOYbut6uA==
X-Received: by 2002:a05:600c:1d96:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-442fd60ce7dmr76512045e9.2.1747476738470;
        Sat, 17 May 2025 03:12:18 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3380539sm142842995e9.16.2025.05.17.03.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 03:12:18 -0700 (PDT)
Message-ID: <ede69310-a640-489c-8922-24dd62cf6ea1@grimberg.me>
Date: Sat, 17 May 2025 13:12:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
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
 <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
Content-Language: en-US
In-Reply-To: <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_031220_512294_7843EE4E 
X-CRM114-Status: GOOD (  22.51  )
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



On 17/05/2025 13:01, Sagi Grimberg wrote:
>
>
> On 14/05/2025 9:35, Hannes Reinecke wrote:
>> On 5/13/25 21:24, Kamaljit Singh wrote:
>>> Hi Sagi, Hannes,
>>>
>>> On 09/11/2025 02:11, Sagi Grimberg wrote:
>>>>> IO timeouts are still occurring with Writes. The only Read that timed
>>>>> out was most likely due to the path error. It takes ~4.5 hours to 
>>>>> fail.
>>>>>
>>>>> However, this test does not fail if either ECN is off or if digests
>>>>> are not enabled. These passing combinations were run for 16+ hours
>>>>> without any issues. Both ECN and Header+Data Digests need to be 
>>>>> turned
>>>>> on for it to fail.
>>>>>
>>>>> Do you have a failing test as well? If so, is it quicker to cause the
>>>>> failure? Would you mind sharing any details?
>>>>>
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 
>>>>> 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] block nvme1n3: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 
>>>>> opcode 0x2 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 
>>>>> 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 
>>>>> 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 
>>>>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 
>>>>> 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 
>>>>> 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>>>      [2025-05-07 19:57:13.295] block nvme1n1: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] block nvme1n1: no usable path - 
>>>>> requeuing I/O
>>>>>      [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 
>>>>> seconds...
>>>>>
>>>>> In the current build I had these patches on top of the "nvme-6.16" 
>>>>> branch:
>>>>>      41b2c90a51bd nvme-tcp: sanitize request list handling
>>>>>      9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets
>>>>
>>>> Kamaljit, with the prior version of the patchset (the proposal with 
>>>> the
>>>> wake_sender flag) did this not reproduce regardless of ECN?
>>>   With the last patchset, when ECN=off, we did not see any IO timeouts
>>> even with a weekend long test. This was true for both cases, i.e. with
>>> Inband Auth and with SecureConcat.
>>>
>>> With ECN=on & HD+DD=on IO timeout still persists for both Inband Auth &
>>> SC. I’m currently debugging a possible target side issue with ECN. I’ll
>>> let you know once I have some resolution.
>>>
>>> I don't have any clear indications of the original kernel issue to 
>>> be able to
>>> differentiate against the current target-side issue. So, if you want 
>>> to go
>>> ahead and merge those two patchsets that may be fine for now.
>>>
>> Thanks a lot for your confirmation.
>> We continue to have issues with high load or oversubscribed fabrics.
>> But this patchset is addressing the problem of I/O timeouts during
>> _connect_, which I would argue is a different story.
>
> We still need to hunt these down. I'm still puzzled why adding the 
> WAKE_SENDER
> flag was able to make this issue disappear? I'll have another look at 
> this patch.
>
> For now, I think we can go with this patchset, and then incrementally 
> fix the remains.

Kamaljit, can you check the following patch on top of the patchset from 
Hannes that
gets a reproduction?

--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 835e29014841..2f5f2fcfb078 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1075,7 +1075,7 @@ static void nvme_tcp_write_space(struct sock *sk)

         read_lock_bh(&sk->sk_callback_lock);
         queue = sk->sk_user_data;
-       if (likely(queue && sk_stream_is_writeable(sk))) {
+      if (likely(queue)) {
                 clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
                 queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
         }
--

This think this may be preventing the scheduling of io_work. But now 
that io_work is
also ceasing based on sk_stream_is_writeable, we should probably still 
schedule it.

