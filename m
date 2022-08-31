Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3151ECAAD1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=diN0L+J4H81TvQbIYTfvEWCjK9q8m/EMK0tdXWtLRrQ=; b=R/FWFvBXTQatMY728ElHBz0nAt
	FQJiuT/BLKC8UXdaUgGOdmEsb2DRgXJWFkMgLW82QKGDmKXq7N7F1VHDJLJRtRzu9YvgQF/p37vGs
	uArEdn4GZAGmR10okPBuyN+hCttxQiZkpSoRdjYiLS06Lfi9hGPQH0Pf/kD+vJi1Plf5+BdodIXLE
	ejd6xbdL8TbHOJzfLqbI3x0degnrqn52tr4I3Ixs6t+pyxHhL01ERX2jG1weeKiksH5Rh9Ynye4p8
	pRUKivxnFvzF1cjQM9eThiXz667rMze0VzTRzPrH39y1g62HrVtZlXTykI8ZZVRu89H3HavSN4SFx
	tGxGTshg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTSnM-007gHG-V2; Wed, 31 Aug 2022 18:50:36 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTSnK-007gGK-4f
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 18:50:36 +0000
Received: by mail-wm1-f47.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so98409wmb.4
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 11:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=diN0L+J4H81TvQbIYTfvEWCjK9q8m/EMK0tdXWtLRrQ=;
        b=gPG4ZfD1+n7dAJgq+/ge1isdfzBMdkUGUXJc6fRhp+sBd9SzEMlaLF9s++0rSRFkAa
         aja0tkSfD8oNEhbODcvV4zI1sfDFaLche+6L+0mKwtNGvoulg27DZUhTGfu1YaFSaQob
         uiVxvsCYZzLctFysItQPyfyuQusJqjfN1ckwJ3nyx6Xh3gyc0dHjApHecKvgCxR2Eqyx
         F1es3JP03mRgnkaXpj8wNMpJneZKuimHr0eFa8pRM+vJgzrcB4IPj0qs/udfI8vExb4X
         ENEicDE2jwVHCj4SwP7fDbCeMVw9e1Fnrpqm0q3fmfDok6KOe/JKGBTeRWJWGAGSHHw/
         WekA==
X-Gm-Message-State: ACgBeo1Z3FgvNpwY1f/L0KfWEZsBTFzwXTd42oPN8m3eW44MmGPxBYoE
	UJUHlAhglMyHCudnShk78gBT4hdFzDo=
X-Google-Smtp-Source: AA6agR5QVFIeHsSkmzmPO/6OYxuTnlZLTDhBO9IxGyivmJt/JLjr4g3XS5vwWhz/++AtRwdMZ+IS8w==
X-Received: by 2002:a05:600c:1f0f:b0:3a5:c132:66e9 with SMTP id bd15-20020a05600c1f0f00b003a5c13266e9mr2851723wmb.205.1661971831238;
        Wed, 31 Aug 2022 11:50:31 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b002250f9abdefsm14771823wri.117.2022.08.31.11.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:50:30 -0700 (PDT)
Message-ID: <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me>
Date: Wed, 31 Aug 2022 21:50:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
 <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_115034_221157_1512EE67 
X-CRM114-Status: GOOD (  27.58  )
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



On 8/31/22 19:04, Jonathan Nicklin wrote:
> On Wed, Aug 31, 2022 at 5:02 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>> Hello,
>>
>> Hey Jonathan,
>>
>>> We've seen sporadic I/O errors with nvme-tcp in our lab when testing
>>> with kernel versions 5.15 through 5.19. Using a combination of tracing
>>> events and network traces, we can see nvme_setup_cmd() trace events
>>> that do not result in transmitted commands PDUs.
>>>
>>> Here's a snippet of the relevant portion of the nvme trace. The
>>> following events are the last of tens of thousands of successully
>>> executed reads...
>>>
>>> tar-9004    [004] ..... 22457.614117: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=53272, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760448, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> tar-9004    [004] ..... 22457.614118: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=61463, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760384, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=16406, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760376, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=28693, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760312, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=40980, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760248, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>>>
>>> The following 5 commands are issued to nvme, but never make it to the
>>> wire. The wire state was verified manually using tcpdump on the host and
>>> trace events on the target. Perhaps the "need-resched" marker in the
>>> trace and the context switch to the kernel worker are relevant
>>> to the failure?
>>>
>>> tar-9004    [004] .n... 22457.614171: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=61469, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760704, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> kworker/4:1H-8668    [004] ..... 22457.614183: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=45084, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760640, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=28699, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760632, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=40986, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760568, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
>>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=16409, nsid=1, flags=0x0, meta=0x0,
>>>     cmd=(nvme_cmd_read slba=15760504, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>>>
>>> The reads above eventually timeout and recover after reset. Here are
>>> the related reset messages.
>>>
>>> [22486.420606] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760568, 64 blocks, I/O
>>> Error (sct 0x3 / sc 0x71)
>>> [22486.429326] I/O error, dev nvme1c1n1, sector 15760568 op 0x0:(READ)
>>> flags 0x4084700 phys_seg 1 prio class 0
>>> [22486.439262] nvme nvme1: queue 5: timeout request 0x1b type 4
>>> [22486.461788] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760632, 8 blocks, I/O
>>> Error (sct 0x3 / sc 0x71)
>>> [22486.470440] I/O error, dev nvme1c1n1, sector 15760632 op 0x0:(READ)
>>> flags 0x4084700 phys_seg 1 prio class 0
>>> [22486.480386] nvme nvme1: queue 5: timeout request 0x1c type 4
>>> [22486.486256] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760640, 64 blocks, I/O
>>> Error (sct 0x3 / sc 0x71)
>>> [22486.494994] I/O error, dev nvme1c1n1, sector 15760640 op 0x0:(READ)
>>> flags 0x4084700 phys_seg 2 prio class 0
>>> [22486.504946] nvme nvme1: queue 5: timeout request 0x1d type 4
>>> [22486.510822] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760704, 56 blocks, I/O
>>> Error (sct 0x3 / sc 0x71)
>>> [22486.519563] I/O error, dev nvme1c1n1, sector 15760704 op 0x0:(READ)
>>> flags 0x4080700 phys_seg 2 prio class 0
>>> [22486.529723] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760504, 64 blocks, I/O
>>> Error (sct 0x3 / sc 0x71)
>>> [22486.538610] I/O error, dev nvme1c1n1, sector 15760504 op 0x0:(READ)
>>> flags 0x4084700 phys_seg 2 prio class 0
>>>
>>> To further aid in debugging, I resurrected Keith's nvme_tcp tracing event
>>> patch from a ways back. If my understanding is correct,
>>> nvme_tcp_cmd_pdu() is being called for the commands in question.
>>>
>>> I've isolated the failure to a scenario we can reproduce at will
>>> in about a minute of runtime. Is there any additional debug that we can
>>> provide to help locate the bug?
>>
>> Would be interesting to understand if for these requests,
>> nvme_tcp_queue_request scheduled io_work or not (can be marked on the
>> command and printed during the timeout expiration). If not, would be
>> interesting to understand why.
> 
> Okay, here's a repro with a bit more context. I recorded the state
> from nvme_tcp_queue_request() in the request and printed it out as you
> suggested. I also added trace events for nvme_tcp_queue_rq() to make
> it easier to match the state.
> 
> - lock is the return value of trylock() (if executed)
> - more is the return value of nvme_tcp_queue_more(if executed)
> - this_cpu is raw_smp_processor_id();
> 
> Here's the trace output for the failed requests with the associated
> completion messages (from dmesg) stitched in.
> 
>    tar-2153 [001] .....   536.383588: nvme_tcp_queue_rq:
>      nvme1: qid=2 tag=5 op=0 data_len=32768
>    tar-2153 [001] .....   536.383588: nvme_setup_cmd:
>      nvme1: disk=nvme1c1n1, qid=2, cmdid=8197, nsid=1, flags=0x0, meta=0x0,
>        cmd=(nvme_cmd_read slba=9950336, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>    dmesg.out           [  565.574700] nvme_tcp_queue_request()
>      state: tag 0x5 io_cpu 1 this_cpu 1 lock 1 sync 1 empty 1 last 0 more 1

This is strange...
cpu matches, and the lock is taken, this means that the request should
have been sent immediately to the wire...

However last=0, this will make the send marked with MSG_SENDPAGE_NOTLAST
which means the network stack will not send it right away...

> 
>   tar-2153  [001] .N...   536.383594: nvme_tcp_queue_rq:
>     nvme1: qid=2 tag=4 op=0 data_len=32768
>   tar-2153  [001] .N...   536.383594: nvme_setup_cmd:
>     nvme1: disk=nvme1c1n1, qid=2, cmdid=16388, nsid=1, flags=0x0, meta=0x0,
>       cmd=(nvme_cmd_read slba=9950272, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>   dmesg.out            [  565.540965] nvme_tcp_queue_request()
>     state: tag 0x4 io_cpu 1 this_cpu 5 lock 1 sync 1 empty 1 last 0 more 1

Same here... sent down the network stack, but with MSG_SENDPAGE_NOTLAST.

> kworker/1:0H-23  [001] .....   536.383619: nvme_tcp_queue_rq:
>    nvme1: qid=2 tag=3 op=0 data_len=32768
> kworker/1:0H-23  [001] .....   536.383619: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=2, cmdid=24579, nsid=1, flags=0x0, meta=0x0,
>      cmd=(nvme_cmd_read slba=9950208, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> dmesg.out              [  565.490597] nvme_tcp_queue_request()
>    state: tag 0x3 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 0 more 1

Here, the queue is not empty, so we are not sending right away, and its
also not the last in the batch, so we are also not queueing io_work, we
will wait for the last request in the batch to schedule io_work, to send
the batch to the network.

> kworker/1:0H-23  [001] .....   536.383620: nvme_tcp_queue_rq:
>    nvme1: qid=2 tag=2 op=0 data_len=32768
> kworker/1:0H-23  [001] .....   536.383620: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=2, cmdid=40962, nsid=1, flags=0x0, meta=0x0,
>      cmd=(nvme_cmd_read slba=9950144, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> dmesg.out                   [  565.470687] nvme_tcp_queue_request()
>    state: tag 0x2 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 1 more 1

Here again, the queue is not empty, and its the last request in the 
batch, so we should have scheduled io_work to send the queued requests
in the send_list along.

These are not necessarily requests that were one after the other,
however the last request, should have flushed all the prior ones...

Can you add an indication that a command was actually sent to the wire
(i.e. nvme_tcp_try_send_cmd_pdu() sends the entire cmd pdu).

