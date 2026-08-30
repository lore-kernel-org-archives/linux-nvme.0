Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9A2C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fh6bj8ngGgcF0vwrvvWACwbtjg5dFvbiKIk3RronVpc=; b=TBsLjUqyL+qIZ4QB/47qOqKtmu
	oUFYwey5o+qWUeuj5busPKUswB/venefp2fZ5UNzBXbMuwM3CN3/fo9ifzn2agWyQUMzYZWRQWMwu
	CiGIsXvADsFL05Za9Jq1th6lsQU9Qh7j7CY9We3BKWxHHQqlmz4+lYF7pIPj0S3fOjPdisSa5mX2z
	Db/wV2p2Wxp2zrCzePgzMhKNChbByo6371sfUu08zEpSn58FmTMsJGhHgI0VjHMEG5w7ACqg0lFKG
	nw4S18hJXLfb+C80uQtqZN6fO4HbYBh0yBgpIaZsG6s7GA49yui0UFkeDni8YxEL9ogX1S4/RgEKG
	QEgQPgaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nSk-0000000893G-3HcV;
	Sun, 30 Aug 2026 21:53:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nSh-0000000892v-2ufG
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:53:12 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482e4998d28so1960902f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788126790; x=1788731590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fh6bj8ngGgcF0vwrvvWACwbtjg5dFvbiKIk3RronVpc=;
        b=aFyH0j1vUWX5jStoi3+Ur2m4MM+k9dRVduYdicyrygs7HJJOCWS2imX5/o3zvtlJlk
         MB+Gut2ksoXynNqgfdOGR7iD2CMVVXFZwfYWMbL6pXwgQCA3+7F77BdccDXQry/wtDYR
         gEXu7o65cLmH6baNz590myUNd8aOkW3VAwDRCodk/+aUg2dfqMj44uwN82MOsoPvlx5c
         BzlfNp3afi2FHl1nrnOfHLzLbyqynTG5XJjZ48nT1imQXb9jpTeDN8rn+gAF2PhKEJnO
         5FTf1sOHZOnE+lOlW8MsXJyQXt7rAPqrNHPkdZrajMA2N6egCrvEBlwQM87y1/JBNwYt
         xMNg==
X-Forwarded-Encrypted: i=1; AKwUvBx+arf3AYTdS+GixOHNv5gkmNx8q+59jVU6lba1U+Uco3P8ge27asIH55X0vyHNzOGAifZ9mLfWcj39@lists.infradead.org
X-Gm-Message-State: AFuF++mCh7j4P7KBQQ6iscBo/9ttNJjhsbS+NPKavPMDkyvQCCkiNFoP
	K2XczvILEnLvXSZOwgBxEw7gFOiLJanmDUan9Ziq/m2uQk7XIcL/6TL2
X-Gm-Gg: AYBFou1dEWXiY/pUXYfnK29y0vvGWsZ+QqqdKxTE2LntfjuB9J3yeq04v6TQl9nlDMV
	FSpi6YELSvFmmhpf4RDd+tTMCxBF6y4UkQa9J+tfzt62qLU82rA6FhMMtRfHkHpCEqCKNoXBjHC
	DnH2SYUDyAkZzTqUbJrQo5LCFdmvCD4tgtapn4mIhOTNyD35z+dU6cBsuOA4/mt+GM63yUUqNi9
	1ZXLgn1bOOp7AhQCMGGYE7T/fIpNmdXMr7dTpwF8fTRPTVII5/Lyy4Yw7H1E85V8yaO9oLWd/c4
	Z+hPdFp57va1O02EGlAEbOAglT0DCFiOddvjAKeJyYsQRhFm2ZfKReb3D9xC39g33dR+6Tt0T9L
	2cJk2QSVlJBTHyQuqABEDfO0eglJUUEiXxtYsxzTEu6X9ADifkjTHxVUXwMhkNeIiOdpclF1l6d
	5TcUS5spVlVy7r6iwEvYHrxXZIfkrSxA5S47niGaRbSIjPQfMptdeg4CL7zsw/sln2QR91GUn2d
	YT9aM2wNKDUi82r0LadTA==
X-Received: by 2002:a05:6000:3101:b0:484:3728:1367 with SMTP id ffacd0b85a97d-484372813a4mr8470018f8f.1.1788126789535;
        Sun, 30 Aug 2026 14:53:09 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm19201171f8f.34.2026.08.30.14.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:53:08 -0700 (PDT)
Message-ID: <2a03f032-3fed-454c-a960-ac332b4c3fed@grimberg.me>
Date: Mon, 31 Aug 2026 00:53:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
 <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_145311_787863_14B9599C 
X-CRM114-Status: GOOD (  38.11  )
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



On 25/08/2026 8:05, Nilay Shroff wrote:
> On 8/23/26 4:17 AM, Sagi Grimberg wrote:
>>
>>
>> On 15/08/2026 20:34, Nilay Shroff wrote:
>>> Hi,
>>>
>>> This series introduces a new latency I/O policy for NVMe native
>>> multipath. Existing policies such as numa, round-robin, and queue-depth
>>> are static and do not adapt to real-time transport performance. The 
>>> numa
>>> selects the path closest to the NUMA node of the current CPU, 
>>> optimizing
>>> memory and path locality, but ignores actual path performance. The
>>> round-robin distributes I/O evenly across all paths, providing fairness
>>> but not performance awareness. The queue-depth reacts to instantaneous
>>> queue occupancy, avoiding heavily loaded paths, but does not account 
>>> for
>>> actual latency, throughput, or link speed.
>>>
>>> The new latency policy addresses these gaps selecting paths dynamically
>>> based on measured I/O latency for both PCIe and fabrics. Latency is
>>> derived by passively sampling I/O completions. Each path is assigned a
>>> weight proportional to its latency score, and I/Os are then forwarded
>>> accordingly. As condition changes (e.g. latency spikes, bandwidth
>>> differences), path weights are updated, automatically steering traffic
>>> toward better-performing paths.
>>>
>>> Early results show reduced tail latency under mixed workloads and
>>> improved throughput by exploiting higher-speed links more effectively.
>>> For example, with NVMf/TCP using two paths (one throttled with ~30 ms
>>> delay), fio results with random read/write/rw workloads (direct I/O)
>>> showed:
>>
>> TBH, I do not know if this measurement represent any real-life
>> scenario. I do think that occasional packet drops are a real-life 
>> scenario, and
>> it would be a worthy use-case to optimize for. Can you perhaps measure
>> how the path selectors compare in this case?
>>
>
> Okay so I have now measured another workload where I simulated packet 
> loss/drops
> which are occasional and compared different path selectors. In this 
> measurement
> I have a shared NVMe namespace configured which is reachable over two 
> tcp paths.
> Now to simulate the occasional packet loss/drop I have configured one 
> of the paths
> to experience occasional packet loss/drop as shown below over the 
> period of
> 480 seconds:
>
> 0            120           240           360           480
> |-------------|-------------|-------------|-------------|
> |<--5% drop-->|<--no drop-->|<--3% drop-->|<--no drop-->|
>
> As shown above for the first 120 seconds the path experiences 5% 
> packet drop,
> for the next 120 seconds path sees no packet drop and again for 
> subsequent 120
> seconds path experiences 3% packet drop and for the rest of the 
> duration (during
> last 120 seconds) there's no packet drop observed by the path. With 
> this simulation,
> I ran fio workload for 480 seconds leveraging direct I/O, bs=4k, 
> iodepth=64,
> numjobs=32 and ioengine=io_uring. Shown below is bw observed running 
> fio test
> using different I/O policies:
>
>              numa     round-robin queue-depth latency
>              (MiB/s)  (MiB/s)     (MiB/s)     (MiB/s)
>              -------  ----------- ----------- ---------
> randread:    1288     1202        1464        1642
> randwrite:   1456     1493        1779        1944
> randrw:      R:623    R:594       R:750       R:822
>              W:623    W:594       W:750       W:822
>
>>>
>>>          numa         round-robin   queue-depth  adaptive
>>>          -----------  -----------   -----------  ---------
>>> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
>>> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
>>> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>>>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s
>>
>> And I'm assuming there are zero downsides for the normal
>> case?
>>
> For the normal case where all paths are symmetric I saw
> queue-depth, latency and round-robin policies yielding
> nearly same bandwidth. However for numa policy, it depends
> on CPU/numa locality.
>
>>>
>>> This pathcset includes totla 8 patches:
>>> [PATCH 1/10] block: expose blk_stat_{enable,disable}_accounting()
>>>    - Make blk_stat APIs available to block drivers.
>>>    - Needed for per-path latency measurement.
>>>
>>> [PATCH 2/10] block: record I/O request start time for passthru request
>>>    - Record I/O start time for I/O passthru requests.
>>>    - This is prep patch which allows measuring I/O completion latency
>>>      for passthru requests.
>>>
>>> [PATCH 3/10] block: support nesting for blk-mq flag 
>>> QUEUE_FLAG_SAME_FORCE
>>>    - Support nesting for QUEUE_FLAG_SAME_FORCE as multiple users
>>>      could toggle QUEUE_FLAG_SAME_FORCE.
>>>
>>> [PATCH 4/10] nvme-multipath: pass I/O type to nvme_find_path()
>>>    - This is the prep patch which updates nvme_find_path() signature
>>> [PATCH 5/10] nvme-multipath: add latency I/O policy
>>>    - Implement path scoring based on latency (EWMA).
>>>    - Distribute I/O proportionally to per-path weights.
>>>
>>> [PATCH 6/10] nvme: add generic debugfs support
>>>    - Introduce generic debugfs support for NVMe module
>>>
>>> [PATCH 7/10] nvme-multipath: add debugfs attribute latency_ewma_shift
>>>    - Adds a debugfs attribute to control ewma shift
>>>
>>> [PATCH 8/10] nvme-multipath: add debugfs attribute 
>>> latency_batch_timeout
>>>    - Adds a debugfs attribute to control latency batch window interval
>>>
>>> [PATCH 9/10] nvme-multipath: add debugfs attribute latency_stat
>>>    - Add “latency_stat” under per-path and head debugfs directories to
>>>      expose latency policy state and statistics.
>>>
>>> [PATCH 10/10] nvme-multipath: add documentation for latency I/O policy
>>>    - Includes documentation for latency I/O multipath policy.
>>>
>>> LSFMM discussion:
>>> =================
>>> During lsfmm 2026, it was decided to rename this I/O policy from
>>> "adaptive" to "latency". This series reflects that rename.
>>>
>>> The discussion at lsfmm also focused extensively on the latency
>>> measurement model, including whether latency should be tracked
>>> per-CPU or per-NUMA, and whether separate I/O-size buckets should
>>> be maintained for different request sizes.
>>>
>>> After detailed discussion and evaluation of throughput results, the
>>> consensus was to initially measure I/O completion latency on a
>>> per-CPU basis. The available performance data showed that the
>>> per-CPU implementation already provides sufficient averaging across
>>> CPUs while keeping the design relatively simple.
>>>
>>> The use of additional I/O-size buckets did not demonstrate meaningful
>>> throughput improvement in the general case and would introduce extra
>>> complexity into the fast path and accounting logic. As a result, the
>>> consensus was to avoid I/O-size bucketing for now and keep the policy
>>> focused on per-CPU latency measurement.
>>>
>>> If future real-world workloads demonstrate a clear benefit from
>>> I/O-size-aware latency accounting, the policy can be extended later
>>> to support it.
>>>
>>> As ususal, feedback and suggestions are most welcome!
>>
>> Nilay, do we have evidence that round-robin/queue-depth are better
>> for any workload? As a user, I would be very confused with the amount
>> of path selectors I have available and which should I choose.
>
> From my experiments, when the paths are symmetric, both round-robin and
> queue-depth (and for that matter latency) exhibit similar behavior, with
> the workload being distributed roughly equally across the active paths.
>
> When the paths are asymmetric, I found queue-depth to perform better than
> round-robin. Queue-depth tries to steer I/O toward the less-loaded path
> based on the number of in-flight I/Os on each path, whereas round-robin
> continues to distribute I/O evenly across all active paths.
>
> However, queue-depth still has a limitation in this scenario. It uses
> the number of in-flight I/Os as an indirect indication of path
> performance, it does not have a direct signal of the actual I/O
> completion latency. For example, if one path starts experiencing packet
> loss, I/O completion on that path can become significantly slower.
> Queue-depth can react to this as the path accumulates more outstanding
> I/Os, but it can still continue sending I/O to the degraded path as long
> as its queue depth remains comparable to the healthy path. In other
> words, it can reduce the amount of I/O sent to the degraded path, but it
> cannot directly account for how much slower that path has become.
>
> The latency policy uses I/O completion latency as the signal instead.
> When one path becomes degraded, its observed latency increases and its
> path score/weight decreases. Consequently, the policy shifts more I/O 
> towards
> the healthy path. This allows the healthy path to sustain a higher queue
> depth while the degraded path receives substantially less I/O, rather
> than trying to maintain a similar queue depth across both paths.
>
> This is also reflected in the packet-loss experiment above. Round-robin
> continues to distribute I/O across both paths, while queue-depth does a
> better job by reacting to the increased queue occupancy of the degraded
> path. The latency policy goes one step further by directly using the
> increased completion latency as a signal and therefore steers more I/O
> toward the healthy path, resulting in higher throughput.
>
> So based on the results I have so far, I would characterize the existing
> policies as follows: round-robin is useful when paths are symmetric and
> equal distribution is desired. The queue-depth is preferable when 
> paths are
> asymmetric and queue occupancy provides a useful indication of path
> load and the latency policy is intended for cases where path performance
> can vary dynamically and we want the policy to adapt based on actual
> observed latency.

If you have policies A, B, and C and you say:
- In certain conditions policy C > A, B
- In some conditions C = B > A
- In all other cases C = B = A

This means that C should always be used, and A, B should never be used.

Hence I ask, should we really have this as an option? or should we deprecate
round-robin/queue-depth and have only numa|latency?

I would like to avoid introducing this as a config knob if it is always 
behaves
better.

What do others think?

