Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE86C3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/Dl3tRyAatsYMwXk7DsOQlOrcgBVVOLMWt0tFBK/SY=; b=DmS1AMM/y9+VZVt5C2LSqpnwtm
	u6Xl+XQRtpBTsgzewbJx3Wwi3G5iZmGR3mpLIwu97n0V769HYpeScEDICkAlGV1xEprtRUV8pVuvR
	JeSYveB5MJWDYXF/i9862D9xOOgK5SCrtP/ESM4HpOhh1Aj5rBZL0Ujun9gVPzp4jKCcKTdnD7ROf
	jKksPSecEyy0dD96gCKwwnjGvc2v6/zFNSTRTkYIB5k/kVIc96JlWcQvF8Emi05liZ/i/BBW/j0IY
	zsbL6V8xTaj4+fxRh8zYSi4ObN00RbWTWaYER05vvgvAVpm+zE6a8GDsD+qQVv7Hamf89Sbiyvkon
	GbSqxD/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVVJL-00000006m8x-3iyn;
	Sun, 21 Jul 2024 12:05:07 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVVJI-00000006m8Z-3rD9
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 12:05:06 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427b9fca517so3039735e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 05:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721563503; x=1722168303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Dl3tRyAatsYMwXk7DsOQlOrcgBVVOLMWt0tFBK/SY=;
        b=c0hgOKi+56kJZR8raiCogh9U+UKNFhmFpnPqHrA9uC0CBu1rq+L2ylesucK+NHNJ2O
         EA6cGG5P/HJluXScVwa+aFKCCUUeMGcJsoo7y/eU5Eny+JQLNHNtNcW9B/HaaAl9lrsu
         kOS10Ig0Zd0Me7d7hVrT+RVj36dtQwFtdVrqecNZ6yYwMWMFbL7ouYLrvdRrQiOi5WnT
         BpiG1VkDbq8XshTOQYzYIxRJYmOceeHe2RtY1xJe+z8l4vS1E72z4IMERf1PPrM3+dwy
         u2ztVLaVacSj7yCyonZ8K6oXH2YksPZK1Y4hICgt+z+GRtqfM+jROENu/eTrkwqfGWs6
         0xaw==
X-Forwarded-Encrypted: i=1; AJvYcCUIkZTUAAh9lTqA9rUS/gdwPYsFo5k292Gv0TrfInwr9+8hv22vNi1fA/A4kCX+Gb0JEGBRLjPfPXxclnhZIAt+SuvpNQKjjbyYJcRMaD8=
X-Gm-Message-State: AOJu0YzzCBzb4VI9WvpG3n6E63e2JhOD1I3TOBHky0Teas+E5hwa6jbZ
	4bANZw3lclwfL8tw3bOCRz1HuPOpJdZBBnQDIvEjTtCFVKUtUA4a
X-Google-Smtp-Source: AGHT+IFv0Hf6ECjJY7tYPW2CPJQuH/gCaDOi1iaNxUam0CofP/t2HmWdLBGG6OSDP/FuR+CcVgxEMA==
X-Received: by 2002:a05:600c:1d04:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-427daa6de29mr21040375e9.5.1721563503014;
        Sun, 21 Jul 2024 05:05:03 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e42bsm117801495e9.30.2024.07.21.05.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 05:05:02 -0700 (PDT)
Message-ID: <c9f67df8-dacf-4e53-9406-0c1dead43488@grimberg.me>
Date: Sun, 21 Jul 2024 15:05:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/8] nvme-tcp: improve scalability
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <3c7aafde-f08b-4ea2-b017-ceceb842238a@grimberg.me>
 <7e1c9300-ab39-47cd-b3aa-c4d66ab70f6b@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7e1c9300-ab39-47cd-b3aa-c4d66ab70f6b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_050504_992731_0BF62A11 
X-CRM114-Status: GOOD (  36.04  )
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




On 18/07/2024 9:20, Hannes Reinecke wrote:
> On 7/17/24 23:01, Sagi Grimberg wrote:
>>
>>
>> On 16/07/2024 10:36, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> for workloads with a lot of controllers we run into workqueue 
>>> contention,
>>> where the single workqueue is not able to service requests fast enough,
>>> leading to spurious I/O errors and connect resets during high load.
>>> One culprit here was a lock contention on the callbacks, where we
>>> acquired the 'sk_callback_lock()' on every callback. As we are dealing
>>> with parallel rx and tx flows this induces quite a lot of contention.
>>> I have also added instrumentation to analyse I/O flows, by adding
>>> a I/O stall debug messages and added debugfs entries to display
>>> detailed statistics for each queue.
>>
>> Hanneds, I'm getting really confused with this...
>>
>> Once again you submit a set that is a different direction almost
>> entirely from v1 and v2... Again without quantifying what each
>> change is giving us, and it makes it very hard to review and understand.
>>
> I fully concur. But the previous patchsets turned out to not give a 
> substantial improvements when scaling up.

I thought they did, at least the numbers you listed did (to some extent 
afaict).

> And getting reliable performance numbers is _really_ hard, as there is
> quite a high fluctuation in them. This was the reason for including
> the statistics patches; there we get a direct insight of the I/O path
> latency, and can directly measure the impact of the changes.
>
> And that's also how I found the lock contention on the callbacks...

I am still not clear at all that we can simply omit this lock. Would 
like the
networking folks to tell us if it is safe to do, and an audit if any 
other socket
consumer does this (and if not, should they?)

>
>> I suggest we split the changes that have consensus to a separate series
>> (still state what each change gets us), and understand better the 
>> rest...
>>
> The patchset here is (apart from the statistics patches) just the one 
> removing lock contention on callbacks (which _really_ were causing 
> issues), and the alignment with blk-mq, for which I do see an 
> improvement.

Let's move forward with the blk-mq alignment patches (after addressing 
the review comments).
Then we can continue to hunt this down.

>
> All other patches posted previously turned out to increase the latency
> (thanks to the statistics patches), so I left them out from this round.

I think that the cover letter should call that out. It does not reflect 
your previous posting.

So there is no mutual interference between rx and tx? at all?

>
>>>
>>> All performance number are derived from the 'tiobench-example.fio'
>>> sample from the fio sources, running on a 96 core machine with one,
>>> two, or four subsystem and two paths, each path exposing 32 queues.
>>> Backend is nvmet using an Intel DC P3700 NVMe SSD.
>>
>> The patchset in v1 started by stating a performance issue when
>> controllers have a limited number of queues, does this test case
>> represent the original issue?
>>
> Oh, but it does. The entire test is run on machine with 96 cores.
>
>>>
>>> write performance:
>>> baseline:
>>> 1 subsys, 4k seq:  bw=523MiB/s (548MB/s), 16.3MiB/s-19.0MiB/s 
>>> (17.1MB/s-20.0MB/s)
>>> 1 subsys, 4k rand: bw=502MiB/s (526MB/s), 15.7MiB/s-21.5MiB/s 
>>> (16.4MB/s-22.5MB/s)
>>> 2 subsys, 4k seq:  bw=420MiB/s (440MB/s), 2804KiB/s-4790KiB/s 
>>> (2871kB/s-4905kB/s)
>>> 2 subsys, 4k rand: bw=416MiB/s (436MB/s), 2814KiB/s-5503KiB/s 
>>> (2881kB/s-5635kB/s)
>>> 4 subsys, 4k seq:  bw=409MiB/s (429MB/s), 1990KiB/s-8396KiB/s 
>>> (2038kB/s-8598kB/s)
>>> 4 subsys, 4k rand: bw=386MiB/s (405MB/s), 2024KiB/s-6314KiB/s 
>>> (2072kB/s-6466kB/s)
>>>
>>> patched:
>>> 1 subsys, 4k seq:  bw=440MiB/s (461MB/s), 13.7MiB/s-16.1MiB/s 
>>> (14.4MB/s-16.8MB/s)
>>> 1 subsys, 4k rand: bw=427MiB/s (448MB/s), 13.4MiB/s-16.2MiB/s 
>>> (13.0MB/s-16.0MB/s)
>>
>> That is a substantial degradation. I also keep asking, how does 
>> null_blk looks like?
>>
> Tested, and doesn't make a difference. Similar numbers.
> Surprisingly, but there you are.

So in effect you should be reaching a ~1+GB/s throughput in this test 
and HW, and yet you see less than
half of it, also with null_blk ?

Is there a configuration that you _are_ able to saturate the wire?

>
>>> 2 subsys, 4k seq:  bw=506MiB/s (531MB/s), 3581KiB/s-4493KiB/s 
>>> (3667kB/s-4601kB/s)
>>> 2 subsys, 4k rand: bw=494MiB/s (518MB/s), 3630KiB/s-4421KiB/s 
>>> (3717kB/s-4528kB/s)
>>> 4 subsys, 4k seq:  bw=457MiB/s (479MB/s), 2564KiB/s-8297KiB/s 
>>> (2625kB/s-8496kB/s)
>>> 4 subsys, 4k rand: bw=424MiB/s (444MB/s), 2509KiB/s-9414KiB/s 
>>> (2570kB/s-9640kB/s)
>>
>> There is still an observed degradation when moving from 2 to 4 
>> subsystems, what is the cause of it?
>>
> All subsystems are running over the same 10GigE link, so some 
> performance degradation is to be expected as we are having higher
> contention.

Not sure why its so expected? I mean, obviously it is the case now, but 
why is it intrinsically expected?

>
>>>
>>> read performance:
>>> baseline:
>>> 1 subsys, 4k seq:  bw=389MiB/s (408MB/s), 12.2MiB/s-18.1MiB/s 
>>> (12.7MB/s-18.0MB/s)
>>> 1 subsys, 4k rand: bw=430MiB/s (451MB/s), 13.5MiB/s-19.2MiB/s 
>>> (14.1MB/s-20.2MB/s)
>>> 2 subsys, 4k seq:  bw=377MiB/s (395MB/s), 2603KiB/s-3987KiB/s 
>>> (2666kB/s-4083kB/s)
>>> 2 subsys, 4k rand: bw=377MiB/s (395MB/s), 2431KiB/s-5403KiB/s 
>>> (2489kB/s-5533kB/s)
>>> 4 subsys, 4k seq:  bw=139MiB/s (146MB/s), 197KiB/s-11.1MiB/s 
>>> (202kB/s-11.6MB/s)
>>> 4 subsys, 4k rand: bw=352MiB/s (369MB/s), 1360KiB/s-13.9MiB/s 
>>> (1392kB/s-14.6MB/s)
>>>
>>> patched:
>>> 1 subsys, 4k seq:  bw=405MiB/s (425MB/s), 2.7MiB/s-14.7MiB/s 
>>> (13.3MB/s-15.4MB/s)
>>> 1 subsys, 4k rand: bw=427MiB/s (447MB/s), 13.3MiB/s-16.1MiB/s 
>>> (13.0MB/s-16.9MB/s)
>>> 2 subsys, 4k seq:  bw=411MiB/s (431MB/s), 2462KiB/s-4523KiB/s 
>>> (2522kB/s-4632kB/s)
>>> 2 subsys, 4k rand: bw=392MiB/s (411MB/s), 2258KiB/s-4220KiB/s 
>>> (2312kB/s-4321kB/s)
>>> 4 subsys, 4k seq:  bw=378MiB/s (397MB/s), 1859KiB/s-8110KiB/s 
>>> (1904kB/s-8305kB/s)
>>> 4 subsys, 4k rand: bw=326MiB/s (342MB/s), 1781KiB/s-4499KiB/s 
>>> (1823kB/s-4607kB/s)
>>
>> Same question here, your patches do not seem to eliminate the overall 
>> loss of efficiency.
>
> Never claimed that, and really I can't see that we can.
> All subsystems are running over the same link, so we are having to push
> more independent frames across it, and we will suffer from higher
> contention here. A performance degradation when scaling up subsystems
> is unavoidable.

I took another look at the fio jobfile. Is my understanding correct that 
there are only 4 inflight
requests at once (numjobs=4)? Maybe I'm missing something here, but I'm 
lost on where is the
high load you are talking about here? Isn't this is a latency 
optimization exercise?

Not questioning the necessity of it, I would just like us to be on the 
same page as you previously
gave the impression that there is very high concurrency and load on the 
system here (for example when we
asked Tejun about workqueues per controller).

