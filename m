Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E9C3ABC5
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=USjyp70sym57jdvumSSLXgStsd36CEyXK+UQEirUqxc=; b=0KzAWL74puMcAN/knjC7A1i/vO
	rrAkAY0KJ5iMXSvUvK6bzbLpN1u726l34qoQJEUaEBuXPHg8zjD2V67Yo7kVaLKSVI6/NyefleJM7
	7g198CESTTZpP4pyApDA0H0EFwsluEhLnjHA2lzMtQyTuHzJECFCLD3ZnpWwLYjog2Q4wmIGNvk39
	lsFscAaQZ9g/H4AxUtNMHXH74zAEhPHFwOprrRjfxUZB89By5KVFGVDyg+1yOTJY7D1i5W9KL4bs6
	+bNSYhMLjF2G+gGEzmMVObMlqYEdx5YxbfWnZtCzcpK52BzsD1TwH5WoXln74JJWIyA1bQPda2Mdl
	nmdtsPdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE2jJ-00000006zT9-0c88;
	Sun, 11 May 2025 09:12:17 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE2jG-00000006zSZ-2z7n
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 09:12:15 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso1896524f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 11 May 2025 02:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746954733; x=1747559533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USjyp70sym57jdvumSSLXgStsd36CEyXK+UQEirUqxc=;
        b=QHwYjY4OrvY28um7Yia66E7HoJPT+wiwGJAqtCku3bDvGvWc1EPE0tjOHx0pnYoL3J
         VDv8xAyOoDFzNdBqvWK4YkEXxXkeHMIwGalbO1x52O25o6q+X3v1Kc8DTsH+knYfp0FZ
         R1BaxTvMmD5ohaJNZWofuUEyYQZ3UYupIKOrETJgJY5QJBSaz2R3nqXKCWqFqnS6Ehtd
         p3lCi+C/13kVX3ekijF0QtYtXKEIe+zIJqwIzp+TjSS1fJvhUafaobt/VdZuvuqVt9D9
         pQH5o3Ir2T/whwDWjQfiJmuwXyonnolC8K3kxm6PN8MTAE7EmjBiadAU54kmsMfwpgSF
         rhHA==
X-Forwarded-Encrypted: i=1; AJvYcCUT+7zLQEtvB7JfpqnNvejqBAVm0bx+QwfEt63dm00CoC6DeIouDkuqem6EVeSZIdPucoh3jBOZM8Xx@lists.infradead.org
X-Gm-Message-State: AOJu0YyXqTSfmgmguCgYVwUxkPlnGLCr8gCCMs+pf6z8IBPRsts0VCEB
	lVWVINv+tnU0Onr6D2DmbBENZlg8i0tGKtq//6Uxke7Bdyjyck7B
X-Gm-Gg: ASbGncs9Y1WSenTire+Sg87lfipLN8FDDT9mW/aYVm54pPEFF/oI+krtZhukkaGftpq
	5H3SOLByj978J5Tec7EkEbGahbomKXQtvCPBZJqU4ZGZ/E2h3x1Mun3LL/WOD5ujrKTHKRFA+S6
	eY8bq1AWHEtCN5uA76Qc9rwWUmcT73bl+8MDyuOz2vATB+UtkXQvOGhBKxuNNwHGE6JRjeoWl1w
	KPW7ee77E0MxwnaZmDB2RNP4HKKf7rOUz9vTEwuyKO0DWQpNiUssdqL5UVcQJyEpneJq9JCtNQu
	kSSmJxQdVAS1KKJbGEA/vfUHMdOkml2HVpzfCw7AipkfNlKl5MQbK3eHDWgGlRx5ROKcMyq4wM6
	McapA4sAQ17rz4BRA
X-Google-Smtp-Source: AGHT+IGVSIPhC102bjdtEiIX+mvCjtI+ez7K4MTRVf3zvgrF1XIcw/b04IFBlAypqc1ThlG4+3k2xA==
X-Received: by 2002:a05:6000:186f:b0:3a0:b334:6aab with SMTP id ffacd0b85a97d-3a0b990782emr10589400f8f.12.1746954732851;
        Sun, 11 May 2025 02:12:12 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d780ffb7sm48145965e9.1.2025.05.11.02.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 May 2025 02:12:12 -0700 (PDT)
Message-ID: <fd87da00-ce84-475e-b60b-7a36c1268cb5@grimberg.me>
Date: Sun, 11 May 2025 12:12:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@suse.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
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
 <698775ee-3502-4f45-98bb-81ca495226ec@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <698775ee-3502-4f45-98bb-81ca495226ec@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_021214_749496_E36BAAE7 
X-CRM114-Status: GOOD (  20.20  )
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



On 09/05/2025 9:52, Hannes Reinecke wrote:
> On 5/8/25 23:23, Kamaljit Singh wrote:
>> Hi Hannes, Sagi,
>>
>> On 5/7/25 15:26, Kamaljit Singh wrote:
>>>> Can you please retest with the patchset '[PATCHv5 0/2] nvme-tcp: fixup
>>>> I/O stall on congested sockets' _only_ ?
>>>> (on top of nvme-6.16 latest, of course).
>>>> I think I _should_ have included all the suggestions floating here,
>>>> but we need to have confirmation.
>>>
>>> I've built the kernel against the latest of nvme-6.16 branch along with
>>> these patches. Its with test now. Will let you know when we get some
>>> results back.
>>>
>>> 0. [PATCHv5 0/2] nvme-tcp: fixup I/O stall on congested sockets - 
>>> Apr 29, 01:18
>>>      Hannes Reinecke (2):
>>>        nvme-tcp: sanitize request list handling
>>>        nvme-tcp: fix I/O stalls on congested sockets
>>>
>>> 1. [PATCH 1/2] nvme-tcp: sanitize request list handling - Apr 29, 02:31
>>> 2. [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets - Apr 
>>> 29, 01:18
>> IO timeouts are still occurring with Writes. The only Read that timed
>> out was most likely due to the path error. It takes ~4.5 hours to fail.
>>
>> However, this test does not fail if either ECN is off or if digests
>> are not enabled. These passing combinations were run for 16+ hours
>> without any issues. Both ECN and Header+Data Digests need to be turned
>> on for it to fail.
>>
>> Do you have a failing test as well? If so, is it quicker to cause the
>> failure? Would you mind sharing any details?
>>
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] block nvme1n3: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 
>> opcode 0x2 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 
>> opcode 0x1 (I/O Cmd) QID 4 timeout
>>    [2025-05-07 19:57:13.295] block nvme1n1: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] block nvme1n1: no usable path - 
>> requeuing I/O
>>    [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 seconds...
>>
>> In the current build I had these patches on top of the "nvme-6.16" 
>> branch:
>>    41b2c90a51bd nvme-tcp: sanitize request list handling
>>    9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets
>>
> Extremely wild guess: Can you try with this patch on top?
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0e178115dc04..cdb8ea4eb467 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1277,10 +1277,7 @@ static int nvme_tcp_try_send_ddgst(struct 
> nvme_tcp_request *req)
>                 .iov_len = NVME_TCP_DIGEST_LENGTH - req->offset
>         };
>
> -       if (nvme_tcp_queue_more(queue))
> -               msg.msg_flags |= MSG_MORE;
> -       else
> -               msg.msg_flags |= MSG_EOR;
> +       msg.msg_flags |= MSG_EOR;
>
>         ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>         if (unlikely(ret <= 0))
>
> It _could_ be that we're waiting in sendmsg() due to MSG_MORE, causing
> these I/O timeouts as processing doesn't continue.

This change doesn't make sense to me...

