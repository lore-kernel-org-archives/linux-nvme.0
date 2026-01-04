Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555A0C2A062
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUXHQ1NIIkmgR++fQQeHacJTtAhIOFinX+lxjT3SiiY=; b=gcVirz6FjNsOnGLBwiR45Xqi3a
	WFnpfMtil/iXRJxf7IxkucG8txseYQyJ6VRRyQdCTxYp3iOQlXJA9rlqP22z4/IS4xVSUozeSnd1j
	nTZBqnVaWO5hoNwI0S41F0DFZVZsrr0+m4o18+ACob26BqW3ysCkcXKRQnrS0lkI89LPsyuBvMF9N
	k9ZYP3v4UVff0uv0FZ6NiU6mrH2ajFBXUNGaPzlH9k07gHRCcO7fV6tidrgbh37TWyTyDsep1U9Rl
	F3ftiH7WO4srINv088uGfaa7AuyEK3I4P0a2gtgGU4pO+OQhpPMx5IXFPgqCWS1xOWrs9cYs8za0N
	Rb1mrPkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVJ4-0000000AS1k-26BX;
	Sun, 04 Jan 2026 21:06:34 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVJ2-0000000AS1O-1Dpi
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:06:33 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso108490705e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767560789; x=1768165589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUXHQ1NIIkmgR++fQQeHacJTtAhIOFinX+lxjT3SiiY=;
        b=kWBxviMhIxQ71r9F2X3rXHAWODzGh02D8k5SxFda/XrHygwzXCYPOXR72T6nFuf/ub
         2ieWa+KCszNSAO/ura3Qjx/kBJzsKjKEWNKzlfKAFjnrDnsjPAvc/SyeEo01/UbYldVt
         uQYlN/gYrPgAOHXdhGpxroq2MWWK6QQSkIhtXXAzLDb07AiYaoWRZRVGwNpW7jgjRzv/
         b0XY1YwrboaX2eUHPQUFQ2mm7IPyf7LaFsc/1we3QYsRo3YwUPJPDkF8AMD7VjVPbXcg
         dOj6AHDHM2h4JdX26Pf49QCeQoRxBrRQtiPi/LS4dUjTJFzjUtj/UdAArZ1x1nGpDtfa
         JRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWF/eBgEq1e4Am6LPQNEDMH7+hNMdK9Qs2xEtYulomQHbgtfvabgw3M6ouI+/Ugt4b59LOnQEcHgNF@lists.infradead.org
X-Gm-Message-State: AOJu0YzU2AL8REIQ+ChXmOEAjvczgRW0F0t+avmhpfB2uPHTyAbNmq6N
	wvSTTDrWG56XZYtWsrjb233M01KcHVqcftnNcidspnY25zet4ZEvVIyo
X-Gm-Gg: AY/fxX5bmXvJL0hBpJz++kxL+v2XcLBD16fnMG20ulAlRxlK9Ap6env/o1syZjRu5/w
	2eV+cTxOd4yc61/v1XibICuo/iPCcWJ5XqAV8GaxY3wFGuJDP2BtpRAtmLEKjkiwQIpa7bybTMF
	YTLAHhoqfmbfN+ThANzE8AkPQt37lMomtuhUHjthLiN62f8uva8gy7xT+GAnsZn1ZayiNIlA+YT
	tYXNuuI0TGoV3GNvdmY1zntosIUT4cFixke0uAwPqiN1YS1PghDP+N87vBT20Ku13y1kuzcJA/k
	g/O8uracLHfuz34P+5fRlZoyFq5KDfw8sehZjmBJWlVVaOs4NXxZsSqVeN5GR3L4ROZPbUOY1Mt
	2VZHg7qSBpY1dw49FVQZqBtyAOgI7AlvOYK28y5srIjwR439OcYCxLX/Ednp1qjOHvkUsgwLRLh
	G+UCTnouE2IV1GFrPgYUHTv9/QUAeIbLa3i7IiZvaDxdA=
X-Google-Smtp-Source: AGHT+IHJcPSo14yPlIKF+PbyMXZKesAiK4QG9R0uXIo3/rfKuovRYyep78zTmb8RDoH7qHdqTUB4tQ==
X-Received: by 2002:a05:600d:486:10b0:47d:333d:868a with SMTP id 5b1f17b1804b1-47d333d86c2mr386718055e9.33.1767560789343;
        Sun, 04 Jan 2026 13:06:29 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm96063885f8f.3.2026.01.04.13.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:06:28 -0800 (PST)
Message-ID: <ccc78156-8969-486d-b1e9-3ed7f05b668d@grimberg.me>
Date: Sun, 4 Jan 2026 23:06:27 +0200
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
 <37a61dbc-7d5e-4f28-b6cf-5c5c21e9cdbb@grimberg.me>
 <81d9feb1-9134-464c-9c4e-393694732426@linux.ibm.com>
 <b98e91ef-254c-44bc-b46a-0039c66539e2@grimberg.me>
 <c8fa5728-5ee1-4f79-b288-71edcefe135d@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c8fa5728-5ee1-4f79-b288-71edcefe135d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_130632_418968_77919EEC 
X-CRM114-Status: GOOD (  18.35  )
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



On 04/01/2026 11:07, Nilay Shroff wrote:
>
> On 12/27/25 3:07 PM, Sagi Grimberg wrote:
>>>> Can you please run benchmarks with `blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?
>>> Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. Below is the job
>>> file I used for the test, followed by the observed throughput result for reference.
>>>
>>> Job file:
>>> =========
>>>
>>> [global]
>>> time_based
>>> runtime=120
>>> group_reporting=1
>>>
>>> [cpu]
>>> ioengine=cpuio
>>> cpuload=85
>>> cpumode=qsort
>>> numjobs=32
>>>
>>> [disk]
>>> ioengine=io_uring
>>> filename=/dev/nvme1n2
>>> rw=<randread/randwrite/randrw>
>>> bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
>>> iodepth=32
>>> numjobs=32
>>> direct=1
>>>
>>> Throughput:
>>> ===========
>>>
>>>            numa          round-robin   queue-depth    adaptive
>>>            -----------   -----------   -----------    ---------
>>> READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
>>> WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
>>> RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
>>>            W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s
>>>
>>> When comparing the results, I did not observe a significant throughput
>>> difference between the queue-depth, round-robin, and adaptive policies.
>>> With random I/O of mixed sizes, the adaptive policy appears to average
>>> out the varying latency values and distribute I/O reasonably evenly
>>> across the active paths (assuming symmetric paths).
>>>
>>> Next I'd implement I/O size buckets and also per-numa node weight and
>>> then rerun tests and share the result. Lets see if these changes help
>>> further improve the throughput number for adaptive policy. We may then
>>> again review the results and discuss further.
>>>
>>> Thanks,
>>> --Nilay
>> two comments:
>> 1. I'd make reads split slightly biased towards small block sizes, and writes biased towards larger block sizes
>> 2. I'd also suggest to measure having weights calculation averaged out on all numa-node cores and then set percpu (such that
>> the datapath does not introduce serialization).
> Thanks for the suggestions. I ran experiments incorporating both points—
> biasing I/O sizes by operation type and comparing per-CPU vs per-NUMA
> weight calculation—using the following setup.
>
> Job file:
> =========
> [global]
> time_based
> runtime=120
> group_reporting=1
>
> [cpu]
> ioengine=cpuio
> cpuload=85
> numjobs=32
>
> [disk]
> ioengine=io_uring
> filename=/dev/nvme1n1
> rw=<randread/randwrite/randrw>
> bssplit=<based-on-I/O-pattern-type>[1]
> iodepth=32
> numjobs=32
> direct=1
> ==========
>
> [1] Block-size distributions:
>      randread  => bssplit = 512/30:4k/25:8k/20:16k/15:32k/10
>      randwrite => bssplit = 4k/10:64k/20:128k/30:256k/40
>      randrw    => bssplit = 512/20:4k/25:32k/25:64k/20:128k/5:256k/5
>
> Results:
> =======
>
> i) Symmetric paths + system load
>     (CPU stress using cpuload):
>
>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>           -------   -------------------      --------   -------------------
> READ:    636          621                   613           618
> WRITE:   1832         1847                  1840          1852
> RW:      R:872        R:869                 R:866         R:874
>           W:872        W:870                 W:867         W:876
>
> ii) Asymmetric paths + system load
>     (CPU stress using cpuload and iperf3 traffic for inducing network congestion):
>
>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>           -------   -------------------      --------   -------------------
> READ:    553          543                   540           533
> WRITE:   1705         1670                  1710          1655
> RW:      R:769        R:771                 R:784         R:772
>           W:768        W:767                 W:785         W:771
>
>
> Looking at the above results,
> - Per-CPU vs per-CPU with I/O buckets:
>    The per-CPU implementation already averages latency effectively across CPUs.
>    Introducing per-CPU I/O buckets does not provide a meaningful throughput
>    improvement and remains largely comparable.
>
> - Per-CPU vs per-NUMA aggregation:
>    Calculating or averaging weights at the NUMA level does not significantly
>    improve throughput over per-CPU weight calculation. Across both symmetric
>    and asymmetric scenarios, the results remain very close.
>
> So now based on above results and assessment, unless there are additional
> scenarios or metrics of interest, shall we proceed with per-CPU weight
> calculation for this new I/O policy?

I think it is counter intuitive that bucketing I/O sizes does not 
present any advantage. Don't you?
Maybe the test is not good enough of a representation...

Lets also test what happens with multiple clients against the same 
subsystem.

