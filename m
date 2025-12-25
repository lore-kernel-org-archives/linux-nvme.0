Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6231BE7AD43
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zh4TXy46WI+7oFor8UqiHhxclGNsNkWHgpLiVJkoBE=; b=w7vhTUmkHzaXY0pKxQnvrWmaN9
	oUgYsieDznGa7xya4TzL3Xfbsb7u6+gVhs6v/4UH2JaR5H0ZbsUr2VhsUj9oDepJ3+ArBbG2P6JdL
	JrJZS8ChE0fL6Bfluo0lTuOKIzo80EHIGBtioMV4b9uN47/9Knz8WfOwbtJ+GCGotCfkAdV1kjrYa
	mMTwBuBSArtqz6J7fQp9SX+/zryN3G3I+oHSlyAqOeR2fGeTMiXQrHKi/b6ssB/Umb9laZoakrxL3
	jM5NjQqrNEsv+uN6oVh0NHIhO3Uu9LzaPudpEqYVwiglQ+J0oFU59tRPfCtEX8kH32s34d5Fc1gFp
	V/KY+BdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkiN-00000000PaJ-1ZZC;
	Thu, 25 Dec 2025 12:45:11 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkiK-00000000PZs-17Y8
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 12:45:10 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477aa218f20so40426755e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 04:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766666706; x=1767271506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zh4TXy46WI+7oFor8UqiHhxclGNsNkWHgpLiVJkoBE=;
        b=YK8i1PPy/FaSqUaWEXm4k3stjjidNFHKiuen2zIsH4dG26NUlm7LSLRlVNPSgsRJxC
         5HUHshyYcjaJw7mAaG4OiVVALgpqsGm9QEuFlq1Tr4ii/TBbr7gKFrMLUQqYPXGwET6r
         YipCKz3er6FvuGVNGnS0CTAU4un26QmhC2wXzlM3bU2E85//KX/oo+BGa09NZCYONGwh
         2F/04WlRu1WqWDF9soTCK9ckEe/Q6hlQDnJ1pkvKLrMkgMvl4O0dYN+nAUBmW8wXrTWn
         sNXbM0xZwYKFhXvgCEb2Rq5c20WASQn4MLx+nLGo0NbxsHZF01rNdTufHiKQq1XkYKVi
         HEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWubDVMGG18JAUJDeLggwdaXTb//icdHBU6zJqKlHdlbhMNxNo1jWb0lM58dTetVE1k+yyaOfrbALA9@lists.infradead.org
X-Gm-Message-State: AOJu0YzJihPYj2r9aet36fy6cKdlF7YdloqZL/HwfHSR2oGI1GjDyoW/
	hchFoXzbnYyZAXkAcvfmg3Al+umPkQZYgF2lqGTV5CH/ML4IqfN+cvvB
X-Gm-Gg: AY/fxX4Cn5wBXMv/gngAWP6aIzrxz7K7gXKhN6uhSCHvo4D1hXOg+ybfPIq6ss0ZTdt
	WeW27UEcKEt5Z9pKcabV8xwkGXK+VguAZgrgDn+Xg0EbxJg+8y85t4pwdYmGI48DXGQSlw08kUo
	62UOvOHSX9ZInjO2cOF9jCdgXWEm7DgIiN2UTU1QKT9e/Znr2b6NhinnGenu3K6Q9kskrxXr7pH
	A4ApOQVopqYxY8g0aQ0GWzvXNrnv9X6KRTswpjpta+nrc87r7tqfsARLHQcMMJ/s4EJVQbo9Nfh
	+Bt93eHtvrALLzRcWolRW+8Zw8UUWDERjuAvfbiTZOM4cRe6hc2apXvXbIBN27bZZd2+/GMbnhM
	trtIc1g200YH0r1906M650uaJY8xO9mOYO0My5W97BYyG9WnSvy5CdJ7+QrGfG+8SoYpGMAvhz4
	6iigzwnVFjZZ7ust3PrFLF8FSPxxL7ftYiGTLSRCSWI+XqFg==
X-Google-Smtp-Source: AGHT+IGzmSjMQshEMQVg95z1paOwxSbOXoxpDxS5L1mP/wzRrPp7XL87sS7k4K1to4bzx5bJi9cH9w==
X-Received: by 2002:a05:600c:8484:b0:477:af07:dd17 with SMTP id 5b1f17b1804b1-47d422bf61fmr29315635e9.24.1766666705891;
        Thu, 25 Dec 2025 04:45:05 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a7b687sm165478265e9.6.2025.12.25.04.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 04:45:05 -0800 (PST)
Message-ID: <37a61dbc-7d5e-4f28-b6cf-5c5c21e9cdbb@grimberg.me>
Date: Thu, 25 Dec 2025 14:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, dwagner@suse.de, axboe@kernel.dk,
 kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
 <abe16085-f0dd-4f82-b48c-f2eb125da2ee@linux.ibm.com>
 <7358ab3b-b04c-4451-85b0-5bb8073f7134@grimberg.me>
 <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
 <afcc3e2b-0317-42c0-8968-ed771ac6af14@suse.de>
 <03a08de2-07af-43f9-8d68-f5ef6b048536@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <03a08de2-07af-43f9-8d68-f5ef6b048536@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_044508_444974_F735683E 
X-CRM114-Status: GOOD (  29.94  )
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



On 23/12/2025 16:50, Nilay Shroff wrote:
> [...]
>>>> I am not sure that normalizing to 512 blocks is a good proxy. I think that large IO will
>>>> have much lower amortized latency per 512 block. which could create an false bias
>>>> to place a high weight on a path, if that path happened to host large I/Os no?
>>>>
>>> Hmm, I think yes, good point, I think for nvme over fabrics this could be true.
>>>
>> Although technically we are then measure two different things (IO latency vs block latency). But yeah, block latency might be better
>> suited for the normal case; I do wonder, though, if for high-speed
>> links we do see a difference as the data transfer time is getting
>> really fast...
>>
> For a high speed/bandwidth NIC card the transfer speed would be very fast,
> though I think for a very large I/O size, we would see a higer latency due
> to tcp segmentation and re-assembly.
>
> On my nvmf-tcp testbed, I do see the latency differences as shown below
> for varying I/O size (captured for random-read direct I/O workload):
> I/O-size	Avg-latency(usec)
>   512            12113
>   1k             10058
>   2k             11246
>   4k             12458
>   8k             12189
>   16k            11617
>   32k            17686
>   64k            28504
>   128k           59013
>   256k           118984
>   512k           233428
>   1M             460000
>
> As can be seen, for smaller block sizes (512B–16K), latency remains relatively
> stable in the ~10–12 ms range. Starting at 32K and more noticeably at 64K and
> above, latency increases significantly and roughly doubles with each step in
> block size. Based on this data, I propose using coarse-grained I/O size buckets
> to preserve latency characteristics while avoiding excessive fragmentation of
> statistics. The suggested bucket layout is as follows:
>
> Bucket		block-size-range
> small		512B-32k
> medium		32k-64k
> large-64k	64k-128k
> large-128k	128k-256k
> large-256k	256k-512k
> large-512k	512k-1M
> very-large	>=1M
>
> In this model,
> - A single small bucket captures latency for I/O sizes where latency remains
>    largely uniform.
> - A medium bucket captures the transition region.
> - Separate large buckets preserve the rapidly increasing latency behavior
>    observed for larger block sizes.
> - A very-large bucket handles any I/O beyond 1M.
>
> This approach allows the adaptive policy to retain meaningful latency distinctions across
> I/O size regimes while keeping the number of buckets manageable and statistically stable,
> make sense?

Yes

>
>> [ .. ]
>>>>> I understand your concern about whether it really makes sense to keep this
>>>>> per-cpu-per-ns, and I see your point that you would prefer maintaining the
>>>>> stat per-hctx instead of per-CPU.
>>>>>
>>>>> However, as mentioned earlier, during path selection we cannot reliably map an
>>>>> I/O to a specific hctx, so using per-hctx statistics becomes problematic in
>>>>> practice. On the other hand, maintaining the metrics per-CPU has an additional
>>>>> advantage: on a NUMA-aware system, the measured I/O latency naturally reflects
>>>>> the NUMA distance between the workload’s CPU and the I/O controller. This means
>>>>> that on multi-node systems, the policy can automatically favor I/O paths/controllers
>>>>> that are local/near to the CPU issuing the request, which may lead to better
>>>>> latency characteristics.
>>>> With this I tend to agree. but per-cpu has lots of other churns IMO.
>>>> Maybe the answer is that paths weights are maintained per NUMA node?
>>>> then accessing these weights in the fast-path is still cheap enough?
>>> That’s a fair point, and I agree that per-CPU accounting can introduce additional
>>> variability. However, moving to per-NUMA path weights would implicitly narrow the
>>> scope of what we are trying to measure, as it would largely exclude components of
>>> end-to-end latency that arise from scheduler behavior and application-level scheduling
>>> effects. As discussed earlier, the intent of the adaptive policy is to capture the
>>> actual I/O cost observed by the workload, which includes not only path and controller
>>> locality but also fabric, stack, and scheduling effects. From that perspective, IMO,
>>> maintaining per-CPU path weights remains a better fit for the stated goal. It also
>>> offers a dual advantage: naturally reflecting NUMA locality on a per-CPU basis while
>>> preserving a true end-to-end view of path latency, agreed?
>>>
>> Well, for fabrics you can easily have several paths connected to the same NUMA node (like in the classical 'two initiator ports cross-connected to two target ports', resulting in four paths in total.
>> But two of these paths will always be on the same NUMA node).
>> So that doesn't work out.
>>
>>> I conducted an experiment on my NVMe-oF TCP testbed while simultaneously running
>>> iperf3 TCP traffic to introduce both CPU and network load alongside fio. The
>>> host system has 32 cpus, so iperf3 was configured with 32 parallel TCP streams.
>>> And fio was configured with numjobs=32, iodepth=32, bs=4K, direct I/O, and
>>> ioengine=io_uring. Below are the aggregated throughput results observed under
>>> different NVMe multipath I/O policies:
>>>
>>>           numa         round-robin   queue-depth  adaptive
>>>           -----------  -----------   -----------  ---------
>>> READ:   61.1 MiB/s   87.2 MiB/s    93.1 MiB/s   107 MiB/s
>>> WRITE:  95.8 MiB/s   138 MiB/s     159 MiB/s    179 MiB/s
>>> RW:     R:29.8 MiB/s R:53.1 MiB/s  R:58.8 MiB/s R:66.6 MiB/s
>>>           W:29.6 MiB/s W:52.7 MiB/s  W:58.2 MiB/s W:65.9 MiB/s
>>>
>>> These results show that under combined CPU and network stress, the adaptive I/O policy
>>> consistently delivers higher throughput across read, write, and mixed workloads when
>>> comapred against existing policies.
>>>    
>> And that is probably the best argument; we should put it under stress with various scenarios. I must admit I am _really_ in favour of this
>> iopolicy, as it would be able to handle any temporary issues on the fabric (or backend) without the need of additional signalling.
>> Talk to me about FPIN ...
>>
> I ran additional experiments on the NVMe-oF TCP testbed. The host has 32 cpus so fio
> was configured with numjobs=32, iodepth=32, bs=4K, direct I/O, and ioengine=io_uring.
> Below are the aggregated throughput results observed under different NVMe multipath
> I/O policies.
>
> i) Stressing all 32 cpus using stress-ng
>
> All 32 CPUs were stressed using:
> # stress-ng --cpu 0 --cpu-method all -t 60m
>
>           numa          round-robin   queue-depth  adaptive
>           -----------   -----------   -----------  ---------
> READ:    159 MiB/s     193 MiB/s     215 MiB/s    255 MiB/s
> WRITE:   188 MiB/s     186 MiB/s     195 MiB/s    199 MiB/s
> RW:      R:83.4 MiB/s  R:101 MiB/s   R:104 MiB/s  R: 111 MiB/s
>           W:83.3 MiB/s  W:101 MiB/s   W:105 MiB/s  W: 112 MiB/s
>
> ii) Symmetric paths (No CPU stress and no induced network load):
>
>           numa          round-robin   queue-depth   adaptive
>           -----------   -----------   -----------   ---------
> READ:    171 MiB/s     298 MiB/s     320 MiB/s     348 MiB/s
> WRITE:   229 MiB/s     419 MiB/s     442 MiB/s     460 MiB/s
> RW:     R: 93.0 MiB/s  R: 166 MiB/s  R: 171 MiB/s  R: 179 MiB/s
>          W: 94.2 MiB/s  W: 168 MiB/s  W: 168 MiB/s  W: 178 MiB/s
>
> These results show that the adaptive I/O policy consistently delivers higher
> throughput under CPU stress and asymmetric path conditions. In case of symmetric
> paths the adaptive policy achieves throughput comparable to—or slightly
> better than—existing policies.

I still think that accounting uncorrelated latency is the best approach 
here.

My intuition tells me that:
1. averaging latencies over numa-node
2. calculating weights
3. distribute new weights per-cpu in the numa-node

Is a better approach. It is hard to evaluate without adding some randomness.

Can you please run benchmarks with 
`blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?

