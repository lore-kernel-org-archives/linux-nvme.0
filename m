Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD7AC3065C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XcIooAx9kK7iNj1ayngbObhGFoKqHUDa013uj6AIQA=; b=w9iNiGxWUsCdQRBFETECUtQWld
	LH/7rlcVYqW2xOetPsBIZpE7RHXiyKyxOtJ/DO6XfDKst/tg6CdZOX+iZDAt8NvuzvfoJI6VydgjH
	urCO1gKp71wVfK/VsYQwnQAdzeM+hIMKPf7xPI8IaUHGeiN4eqk6s+2KFaf/6Ncx8kegShXDpJlWk
	WE195nU+Ge7PGYXyyabjtUkKXxVYEdx8vvJkb8BnLNwoJRBsrhLQ+MWyJ/yZAHt6RPihwwvQylXhK
	Fn0KMF6sCzGXnl83Eq1krwdKZxOP/EkJ2lFI1fMjCfBjo8gspiFDFkLdigMF+yO/nXIXQW+1Se3Nl
	yB1AaPFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIRV-0000000Chd9-1m2N;
	Thu, 04 Jul 2024 09:07:53 +0000
Received: from mail-lj1-f179.google.com ([209.85.208.179])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIRS-0000000Chcj-2r1e
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 09:07:52 +0000
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee714bd9dbso519211fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jul 2024 02:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084069; x=1720688869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XcIooAx9kK7iNj1ayngbObhGFoKqHUDa013uj6AIQA=;
        b=noV+rdl52pm95GQ3FNRAiA28ov7I9luIl+srkvuYmdup0Fz4FbZ3Q+6SpTR/EtRUZQ
         DbZpQPZuHoOYXCl8gWjjWEBvwYItKXZVGusyaf7k14yadjlV2krvzGlc2F/0M4AxMkv4
         o4qOdTnqZ7IfFYiZ24LEpGgZhdXm/4sGhIKL3JfdQDhKJU72Spaq+1yG7zqBDD8ipELG
         UVIIdQMbkXu/lHAf0UmSfIbjtxYZKkqD5ixQA7BLqGTcx6Z7lDY8/W8OH13+J6pb+7K5
         AJxIzUoe7g384jeqNGiwK/B5UFxPTaIIfRpzLqYill1oK0XWzS9qFMO9rPLqV3slC6na
         HXOg==
X-Forwarded-Encrypted: i=1; AJvYcCVFvi7fwkkwFKdueNXUTb9n5wscWDLeQQUa8N14PksVdn034ZvScSH1IZaLalu5f3xsJbL5X+wCchsAyTGrERV+cdnj5JaRIkdqx5nPpl8=
X-Gm-Message-State: AOJu0Yz829WYK/p3Y1bRggZpO7h+CuV6LpIFJqoXsuNEJm4UcYlqxIzT
	7nvMUazW+6+b0UUvFeMZBv0bvkVVaG1Dx1AW2L6nojcy2U+DuSYh
X-Google-Smtp-Source: AGHT+IFius+7Ajks+wXOxcVWXVH0egcuwOaneQ44+Fao6GoZ7IuxARx3ZSlXb3MsxDil/Y+4iEvXFg==
X-Received: by 2002:a19:ee0b:0:b0:52e:7498:118a with SMTP id 2adb3069b0e04-52ea072e954mr518450e87.4.1720084068307;
        Thu, 04 Jul 2024 02:07:48 -0700 (PDT)
Received: from [10.100.102.67] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc8bcsm15551025e9.44.2024.07.04.02.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:07:48 -0700 (PDT)
Message-ID: <37c87a22-ef34-4ed7-ab6c-14c23b11adef@grimberg.me>
Date: Thu, 4 Jul 2024 12:07:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
 <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
 <11c0b02b-03a3-4097-948b-651b14baa0cf@suse.de>
 <9bc9d94f-a129-4c6e-ac9e-d0eb8db341b0@grimberg.me>
 <dc849cb6-8bf3-4363-9bd1-9b13138c0fb7@suse.de>
 <34d22ad9-1d10-44df-a131-c9aea18fde0c@grimberg.me>
 <2ea2706d-65a1-419e-aa96-6ca353d954e0@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2ea2706d-65a1-419e-aa96-6ca353d954e0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_020750_748859_CB50618C 
X-CRM114-Status: GOOD (  52.56  )
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



On 7/4/24 09:43, Hannes Reinecke wrote:
> On 7/3/24 21:38, Sagi Grimberg wrote:
> [ .. ]
>>>>
>>>> We should make the io_cpu come from blk-mq hctx mapping by default, 
>>>> and for every controller it should use a different cpu from the 
>>>> hctx mapping. That is the default behavior. in the wq_unbound case, 
>>>> we skip all of that and make io_cpu = WORK_CPU_UNBOUND, as it was 
>>>> before.
>>>>
>>>> I'm not sure I follow your logic.
>>>>
>>> Hehe. That's quite simple: there is none :-)
>>> I have been tinkering with that approach in the last weeks, but got 
>>> consistently _worse_ results than with the original implementation.
>>> So I gave up on trying to make that the default.
>>
>> What is the "original implementation" ?
>
> nvme-6.10
>
>> What is you target? nvmet?
>
> nvmet with brd backend
>
>> What is the fio job file you are using?
>
> tiobench-example.fio from the fio samples
>
>> what is the queue count? controller count?
>
> 96 queues, 4 subsystems, 2 controller each.
>
>> What was the queue mapping?
>>
> queue 0-5 maps to cpu 6-11
> queue 6-11 maps to cpu 54-59
> queue 12-17 maps to cpu 18-23
> queue 18-23 maps to cpu 66-71
> queue 24-29 maps to cpu 24-29
> queue 30-35 maps to cpu 72-77
> queue 36-41 maps to cpu 30-35
> queue 42-47 maps to cpu 78-83
> queue 48-53 maps to cpu 36-41
> queue 54-59 maps to cpu 84-89
> queue 60-65 maps to cpu 42-47
> queue 66-71 maps to cpu 90-95
> queue 72-77 maps to cpu 12-17
> queue 78-83 maps to cpu 60-65
> queue 84-89 maps to cpu 0-5
> queue 90-95 maps to cpu 48-53

What are the io_cpu for each queue?

>
>> Please lets NOT condition any of this on wq_unbound option at this 
>> point. This modparam was introduced to address
>> a specific issue. If we see IO timeouts, we should fix them, not tell 
>> people to filp a modparam as a solution.
>>
> Thing is, there is no 'best' solution. The current implementation is 
> actually quite good in the single subsystem case. Issues start to appear
> when doing performance testing with a really high load.
> Reason for this is a high contention on the per-cpu workqueues, which 
> are simply overwhelmed by doing I/O _and_ servicing 'normal' OS workload
> like writing do disk etc.

What other 'normal' workloads are you seeing in your test?

> Switching to wq_unbound reduces the contention and makes the system to 
> scale better, but that scaling leads to a performance regression for
> the single subsystem case.

The kthreads are the same kthreads, the only difference is concurrency 
management, which may take advantage of different cpu cores, but pays
a price in latency and bouncing cpus.

> (See my other mail for performance numbers)
> So what is 'better'?

Which email? To Tejun? it seems that bound is better than unbound for 
all cases. You are suggesting that you regress with multiple controllers
though. That is why I suggested that we _spread_ queue io_cpu 
assignments for the bound case (as I suggested in your first attempt), 
I'd want
to see what happens in this case.

>
>>>
>>>>>
>>>>> And it makes the 'CPU hogged' messages go away, which is a bonus 
>>>>> in itself...
>>>>
>>>> Which messages? aren't these messages saying that the work spent 
>>>> too much time? why are you describing the case where the work does 
>>>> not get
>>>> cpu quota to run?
>>>
>>> I means these messages:
>>>
>>> workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 32771 
>>> times, consider switching to WQ_UNBOUND
>>
>> That means that we are spending too much time in io_work, This is a 
>> separate bug. If you look at nvme_tcp_io_work it has
>> a stop condition after 1 millisecond. However, when we call 
>> nvme_tcp_try_recv() it just keeps receiving from the socket until
>> the socket receive buffer has no more payload. So in theory nothing 
>> prevents from the io_work from looping there forever.
>>
> Oh, no. It's not the loop which is the problem. It's the actual sending
> which takes long; in my test runs I've seen about 250 requests timing 
> out, the majority of which was still pending on the send_list.
> So the io_work function wasn't even running to fetch the requests off 
> the list.

That, is unexpected. This means that either the socket buffer is full 
(is it?), or that the rx is taking a long time, taking
away tx cpu time. I am not sure I understand why would unbound wq would 
solve either other than maybe hide it in
some cases.

In what workloads do you see this issue? reads/writes?

Can you try the following patch:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0b04a2bde81d..3360de9ef034 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -350,7 +350,7 @@ static inline void nvme_tcp_advance_req(struct 
nvme_tcp_request *req,
         }
  }

-static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
+static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue)
  {
         int ret;

@@ -358,6 +358,7 @@ static inline void nvme_tcp_send_all(struct 
nvme_tcp_queue *queue)
         do {
                 ret = nvme_tcp_try_send(queue);
         } while (ret > 0);
+       return ret;
  }

  static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue 
*queue)
@@ -1276,7 +1277,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
                 int result;

                 if (mutex_trylock(&queue->send_mutex)) {
-                       result = nvme_tcp_try_send(queue);
+                       result = nvme_tcp_send_all(queue);
                         mutex_unlock(&queue->send_mutex);
                         if (result > 0)
                                 pending = true;
--

Just to understand if there is a starvation problem where in io_work() 
the tx is paced, but
the rx is not.
>
>> This is indeed a bug that we need to address. Probably by setting 
>> rd_desc.count to some limit, decrement it for every
>> skb that we consume, and if we reach that limit and there are more 
>> skbs pending, we break and self-requeue.
>>
>> If we indeed spend much time processing a single queue in io_work, it 
>> is possible that we have a starvation problem
>> that is escalating to the timeouts you are seeing.
>>
> See above; this is the problem. Most of the requests are still stuck 
> on the send_list (with some even still on the req_list) when timeouts 
> occur. This means the io_work function is not being scheduled fast 
> enough (or often enough) to fetch the requests from the list.

Or, maybe some other root-cause is creating a large backlog of send 
requests.

>
> My theory here is that this is due to us using bound workqueues;
> each workqueue function has to execute on a given cpu, and we can
> only schedule one io_work function per cpu. So if that cpu is busy
> (with receiving packets, say, or normal OS tasks) we cannot execute,
> and we're seeing a starvation.

The issue that you are seeing io_work is running over 10ms is the first 
red-light here.
Because it has an explicit stop condition after 1ms. This means that a 
single while loop
is exceeding 10ms. Something is causing that.

>
> With wq_unbound we are _not_ tied to a specific cpu, but rather
> scheduled in a round-robin fashion. This avoids the starvation
> and hence the I/O timeouts do not occur.
> But we need to set the 'cpu' affinity for wq_unbound to keep
> the cache locality, otherwise the performance _really_ suffers
> as we're bouncing threads all over the place.

The unbound workqueue exists to solve a specific user issue. I think 
that if we come to
a conclusion that unbound workqueues are better (i.e. we have a bug that 
is a result of
a bound workqueue), we change it, and stop using bound workqueues 
altogether.

To be clear, I'm do not hold that opinion yet.

>
>>>
>>> which I get consistently during testing with the default 
>>> implementation.
>>
>> Hannes, let's please separate this specific issue with the 
>> performance enhancements.
>> I do not think that we should search for performance enhancements to 
>> address what appears to be a logical starvation issue.
>
> I am perfectly fine with that approach. This patchset is indeed just 
> to address the I/O timeout issues I've been seeing.

And the solution cannot be "use unbound workqueues - change this modparam".

