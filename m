Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC05C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0m1ycGClAI8pu+Re80UY95eqKAnya4GvX4pu0skEd3s=; b=BUGFuivUz9mstasi3KVTsEyD4X
	Y4JXWCLObr4deB0ch8PrAVY/EBPz8iane1VhYo1dtYGsJ6vOhNKYoAlRxG5YtrzWixARDyhKCvKjz
	87OH5BKBkW4gW9hrbC6zJFngS8z5KpRCYOp6T5TvmKpsmRKb6uXcXu5Wfaw3BBbg49+3h/hn7i70T
	6OPqH1t9gpSLb5ccycJfcPTmUncWpDJCkRFj4cFm+LqN3l1PI8om6CdfscLEaXwshiMFHqUvkwnP9
	2xIilZm/SA+1lj7tu2xCHYnkoPEqgqqJYFiHfDcy62uwnmzrvk58sV8A58n2lGzYX2+vAcY61Fta2
	MtTIZd3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQAtG-000Ozz-2R;
	Wed, 17 Jan 2024 18:43:54 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQAtD-000OzE-24
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 18:43:53 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35d374bebe3so8678165ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705517028; x=1706121828; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0m1ycGClAI8pu+Re80UY95eqKAnya4GvX4pu0skEd3s=;
        b=A09aBsNcXmfiwVmds6SKsHxZOi1NodlruGJF6Qe3GZ/SxuWb98XfFWacWzjCbT8fZG
         cnx9hUMCAo820fr87UVTn/MnKICFH4FnXhdihLDloIUs0C7EosL/yBYIwu6DYWSuc9Px
         3qCdST4OBL7FuqmjlihmpNVfWAL0pIOz6dh54BQHax3pjWAvuI2Dnz2cXfquFxsrxYhH
         FOtOKeW2nYpB1UImQ7AUOJT6A7jvWprPYpaHBJb6q6IpG2rFNCs1e04xvbhzlB50kG2W
         Qp0eO4qDMQMiEUWE0nfFaxeCaYy2aqXJWdc5fCqcO+MpDZmH77ZZd0M3RVIUewNlKCrd
         P5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705517028; x=1706121828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0m1ycGClAI8pu+Re80UY95eqKAnya4GvX4pu0skEd3s=;
        b=UY8njO9wD/fO/xmrcwchhnfqfcYbn79lkQtQ6Ev8X5LPMlZLg6RjzMP1NcVNRPXkLZ
         sunLU0OyDTy9mYHfBqNThn1mzUy14rUumDyRvn/pgAuEbACUu0hgvUc9AFYm6Vf5XsBg
         V1Rl8eo+h1ocbIIqJv7k7wDySoEockt0RuqDVe+tmm0ODpMJNPbfLWzNJUaXtS97fmC2
         gPyGEnx4TgS+HLRZl7xUJh7pFfHGUgEJdLAaREk+stvaHy3Uzask1DUFRotBvfdcWq3z
         36NuRIonrpuLaQ9Ks+KJ5SEUbpU+Xtp0lR2RChuYgidF3suvudiGfCEIk4erxUqcsQRo
         bpqg==
X-Gm-Message-State: AOJu0YzDDhFGDrmjuAPG5oBsxWxsxXJ3XiKIyBGcgqpMS0SFZaT73qmD
	C9IHKuNDqXoqdEk63fMYetWCoNAW9pEO4LTJ2hAUJv0avTEkHA==
X-Google-Smtp-Source: AGHT+IFkIYxYV/DPUCmo6RY0/kKekLwm0mFUcgJ8bvfzFQUKklviLuP1Lu2hOB5T/p6Dzou6BB+BHw==
X-Received: by 2002:a6b:6810:0:b0:7be:e376:fc44 with SMTP id d16-20020a6b6810000000b007bee376fc44mr15408400ioc.2.1705517028234;
        Wed, 17 Jan 2024 10:43:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d8405000000b007bbab8c40d2sm3443754ion.44.2024.01.17.10.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 10:43:47 -0800 (PST)
Message-ID: <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
Date: Wed, 17 Jan 2024 11:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_104351_706470_022254FF 
X-CRM114-Status: GOOD (  28.64  )
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

On 1/17/24 11:22 AM, Bart Van Assche wrote:
> On 1/17/24 09:48, Jens Axboe wrote:
>>> When posting this patch series, please include performance results
>>> (IOPS) for a zoned null_blk device instance. mq-deadline doesn't support
>>> more than 200 K IOPS, which is less than what UFS devices support. I
>>> hope that this performance bottleneck will be solved with the new
>>> approach.
>>
>> Not really zone related, but I was very aware of the single lock
>> limitations when I ported deadline to blk-mq. Was always hoping that
>> someone would actually take the time to make it more efficient, but so
>> far that hasn't happened. Or maybe it'll be a case of "just do it
>> yourself, Jens" at some point...
> 
> Hi Jens,
> 
> I think it is something fundamental rather than something that can be
> fixed. The I/O scheduling algorithms in mq-deadline and BFQ require
> knowledge of all pending I/O requests. This implies that data structures
> must be maintained that are shared across all CPU cores. Making these
> thread-safe implies having synchronization mechanisms that are used
> across all CPU cores. I think this is where the (about) 200 K IOPS
> bottleneck comes from.

Has any analysis been done on where the limitation comes from? For
kicks, I ran an IOPS benchmark on a smaller AMD box. It has 4 fast
drives, and if I use mq-deadline on those 4 drives I can get 13.5M IOPS
using just 4 threads, and only 2 cores. That's vastly more than 200K, in
fact that's ~3.3M per drive. At the same time it's vastly slower than
the 5M that they will do without a scheduler.

Doing a quick look at what slows it down, it's a mix of not being able
to use completion side batching (which again then brings in TSC reading
as the highest cycler user...), and some general deadline overhead. In
order:

+    3.32%  io_uring  [kernel.kallsyms]  [k] __dd_dispatch_request
+    2.71%  io_uring  [kernel.kallsyms]  [k] dd_insert_requests
+    1.21%  io_uring  [kernel.kallsyms]  [k] dd_dispatch_request

with the rest being noise. Biggest one is dd_has_work(), which seems
like it would be trivially fixable by just having a shared flag if ANY
of the priorities had work.

Granted, this test case is single threaded as far as a device is
concerned, which is obviously best case. Which then leads me to believe
that it may indeed be locking that's the main issue here, which is what
I suspected from the get-go. And while yes this is a lot of shared data,
there's absolutely ZERO reason why we would end up with a hard limit of
~200K IOPS even maintaining the behavior it has now.

So let's try a single device, single thread:

IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/31

That's device limits, using mq-deadline. Now let's try and have 4
threads banging on it, pinned to the same two cores:

IOPS=3.90M, BW=1903MiB/s, IOS/call=32/31

Certainly slower. Now let's try and have the scheduler place the same 4
threads where it sees fit:

IOPS=1.56M, BW=759MiB/s, IOS/call=32/31

Yikes! That's still substantially more than 200K IOPS even with heavy
contention, let's take a look at the profile:

-   70.63%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
   - submitter_uring_fn
      - entry_SYSCALL_64
      - do_syscall_64
         - __se_sys_io_uring_enter
            - 70.62% io_submit_sqes
                 blk_finish_plug
                 __blk_flush_plug
               - blk_mq_flush_plug_list
                  - 69.65% blk_mq_run_hw_queue
                       blk_mq_sched_dispatch_requests
                     - __blk_mq_sched_dispatch_requests
                        + 60.61% dd_dispatch_request
                        + 8.98% blk_mq_dispatch_rq_list
                  + 0.98% dd_insert_requests

which is exactly as expected, we're spending 70% of the CPU cycles
banging on dd->lock.

Let's run the same thing again, but let's just do single requests at the
time:

IOPS=1.10M, BW=535MiB/s, IOS/call=1/0

worse again, but still a far cry from 200K IOPS. Contention basically
the same, but now we're not able to amortize other submission side
costs.

What I'm getting at is that it's a trap to just say "oh IO schedulers
can't scale beyong low IOPS" without even looking into where those
limits may be coming from. I'm willing to bet that increasing the
current limit for multi-threaded workloads would not be that difficult,
and it would probably 5x the performance potential of such setups.

Do we care? Maybe not, if we accept that an IO scheduler is just for
"slower devices". But let's not go around spouting some 200K number as
if it's gospel, when it depends on so many factors like IO workload,
system used, etc.

> Additionally, the faster storage devices become, the larger the relative
> overhead of an I/O scheduler is (assuming that I/O schedulers won't
> become significantly faster).

FIrst part is definitely true, second assumption I think is a "I just
give up without even looking at why" kind of attitude.

> A fundamental limitation of I/O schedulers is that multiple commands
> must be submitted simultaneously to the storage device to achieve good
> performance. However, if the queue depth is larger than one then the
> device has some control over the order in which commands are executed.

This isn't new, that's been known and understood for decades.

> Because of all the above reasons I'm recommending my colleagues to move
> I/O prioritization into the storage device and to evolve towards a
> future for solid storage devices without I/O schedulers. I/O schedulers
> probably will remain important for rotating magnetic media.

While I don't agree with a lot of your stipulations above, this is a
recommendation I've been giving for a long time as well. Mostly
because it means less cruft for us to maintain in software, also full
well knowing that we're then at the mercy of hardware implementations
which may all behave differently. And even if we historically have not
had good luck punting these problems to hardware and getting the desired
outcome.

-- 
Jens Axboe


