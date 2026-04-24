Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B61FF8850
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kzletzoO7iup8F+w8YFOUeHZSCu/nk7K6WtY6dKL3M=; b=pO/jfhFxAh6cJPmKE3PU1iNYWD
	71kR9Py6P9oPpPuOSf6fBHFf6ucuwLF6TduPl9HWVY0EpLd0hQcg/Qwi7Mc8Acj6zESSTakH9lyjP
	D73wpG+Y2qbWBHBJW3mq6nKSIVZqY0wI0kqFaZcgV3DUrU8IF/7nS/86gEAj4A9sY4x5kTDchJ+3E
	k4Q//Eqe9OfXr7Hw4qvhZTtethheDgCtCpH6J3TjPZIZlqqZ/I4vodW8UtDOjqLzKs9mpHDdpCepA
	Hmf0mNt1tozZeppVNRN3MtdDXkcyqLJXR5Tfw9HzJVvWIC5xwo9LOSjlniugIYVIWBKZNz69JDvGN
	INtxckzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGP2G-0000000DobH-2QT5;
	Fri, 24 Apr 2026 22:30:08 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGP2E-0000000Doaw-3cfe
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:30:08 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso65196155e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 15:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069805; x=1777674605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kzletzoO7iup8F+w8YFOUeHZSCu/nk7K6WtY6dKL3M=;
        b=CL+8ktlwWF8SBjCJizl9ltFUh/3wJjYqnKJDtuFDyF5I/ifkTwIX6mP1kaOJSFTwEc
         uOuQhuLuTzixoqae0eYdy16It3kFI40ZPPDYgRJaM//bIBG7lgClSY5WoOvcsNpnSsm6
         NQf0Vq3N93BioyZBvOzT+0yyr7TJFBhW+VDwOrdAhFALBa02/ufNkcKpd0LrYOSABZOZ
         vHaEW8uy1rzdlGwSMUEcCnoVwY2ySlThKHv8S0XjC6NTkvMC9FXzSVJNQ53Qt2wJ23yo
         5MW0frArBHOj9+YL1Ald67PtuqSUGoosGoPb15SUd3z6fCNuUAJ3Y5d3znOtQz/qjMqn
         lvSg==
X-Forwarded-Encrypted: i=1; AFNElJ8TBP1UflR5+MQO4pBLbeOA7CGZtY4JAP03YCKtcOHEDd1pO0Q9x4MeVKmKNan9Wj9jJHZG6oHjEIrb@lists.infradead.org
X-Gm-Message-State: AOJu0YzUDV1FJRWDCKDOH6lCfG0NRrd3loMJiEuXIMf3Q8LEwcleEDCi
	RoiO8YUjYHyXHGUZut0I1SplE7RkJj4DnUmzrU6h6ROOYDYQTKM2G1+a
X-Gm-Gg: AeBDievkqtwvQKb29WwuUioODSzfhbRnKZL/y71Py14Xt1+BqwJoLtPgcZVsQo+3xmr
	Ps56TFnhcMvovUrY1NGINmogxzIOrYA/dqvBA8f5Y1uG1SLxLXVlAZ7qL3NnRvEMJZXKzlI2HtJ
	2FvdlouXFnD+KSpMDSVDRvUqs74hO2YdYGIbxIf1bD4Fl1M6Js0yIDTDsv8aoAU8eujpzzriaB6
	iigIlL9CZEc0etpaVu385dZhuZtWq9cgGmJKF50NmDcxPt6G+XPuenEQcZUtBGvdqbxLum4wxWS
	mA8tJ+4q3tSid9hooCJsNR5rooZtpNPZHf7CIxGMKeA+denEBbAQrtU3lTPAKgaiZ4/UNf4Jqrp
	6epzGz3kE/djWivIFx48shV+raRkX0eFDSiDqPs8beZhuHoTw8hiNydZxaSArCNfVUjtr3iaKpM
	W9fYcmyYESLwyQuBvo66zwhg2bhcJIfKtLMAF63ss0sXSajYRIp/k+JpLpkqd70iZRH/3g
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr456147475e9.1.1777069804673;
        Fri, 24 Apr 2026 15:30:04 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm65581120f8f.17.2026.04.24.15.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:30:04 -0700 (PDT)
Message-ID: <faeb48dc-5672-465b-9650-558522dc4f65@grimberg.me>
Date: Sat, 25 Apr 2026 01:30:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] nvme-tcp: NIC topology aware I/O queue scaling
 and queue info export
To: Hannes Reinecke <hare@suse.de>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <649036dd-b99f-4f60-93f4-16979e11f520@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <649036dd-b99f-4f60-93f4-16979e11f520@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_153006_936176_9BFF982A 
X-CRM114-Status: GOOD (  22.85  )
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



On 22/04/2026 14:10, Hannes Reinecke wrote:
> On 4/20/26 13:49, Nilay Shroff wrote:
>> Hi,
>>
>> The NVMe/TCP host driver currently provisions I/O queues primarily based
>> on CPU availability rather than the capabilities and topology of the
>> underlying network interface.
>>
>> On modern systems with many CPUs but fewer NIC hardware queues, this can
>> lead to multiple NVMe/TCP I/O workers contending for the same TX/RX 
>> queue,
>> resulting in increased lock contention, cacheline bouncing, and degraded
>> throughput.
>>
>> This RFC proposes a set of changes to better align NVMe/TCP I/O queues
>> with NIC queue resources, and to expose queue/flow information to enable
>> more effective system-level tuning.
>>
>> Key ideas
>> ---------
>>
>> 1. Scale NVMe/TCP I/O queues based on NIC queue count
>>     Instead of relying solely on CPU count, limit the number of I/O 
>> workers
>>     to:
>>         min(num_online_cpus, netdev->real_num_{tx,rx}_queues)
>>
>> 2. Improve CPU locality
>>     Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ 
>> affinity
>>     to reduce cross-CPU traffic and improve cache locality.
>>
>> 3. Expose queue and flow information via debugfs
>>     Export per-I/O queue information including:
>>         - queue id (qid)
>>         - CPU affinity
>>         - TCP flow (src/dst IP and ports)
>>
>>     This enables userspace tools to configure:
>>         - IRQ affinity
>>         - RPS/XPS
>>         - ntuple steering
>>         - or any other scaling as deemed feasible
>>
>> 4. Provide infrastructure for extensible debugfs support in NVMe
>>
>> Together, these changes allow better alignment of:
>>      flow -> NIC queue -> IRQ -> CPU -> NVMe/TCP I/O worker
>>
>> Performance Evaluation
>> ----------------------
>> Tests were conducted using fio over NVMe/TCP with the following 
>> parameters:
>>      ioengine=io_uring
>>      direct=1
>>      bs=4k
>>      numjobs=<#nic-queues>
>>      iodepth=64
>> System:
>>      CPUs: 72
>>      NIC: 100G mlx5
>>
>> Two configurations were evaluated.
>>
>> Scenario 1: NIC queues < CPU count
>> ----------------------------------
>> - CPUs: 72
>> - NIC queues: 32
>>
>>                  Baseline        Patched        Patched + tuning
>> randread        3141 MB/s       3228 MB/s      7509 MB/s
>>                  (767k IOPS)     (788k IOPS)    (1833k IOPS)
>>
>> randwrite       4510 MB/s       6172 MB/s      7518 MB/s
>>                  (1101k IOPS)    (1507k IOPS)   (1836k IOPS)
>>
>> randrw (read)   2156 MB/s       2560 MB/s      3932 MB/s
>>                  (526k IOPS)     (625k IOPS)    (960k IOPS)
>>
>> randrw (write)  2155 MB/s       2560 MB/s      3932 MB/s
>>                  (526k IOPS)     (625k IOPS)    (960k IOPS)
>>
>> Observation:
>> When CPU count exceeds NIC queue count, the baseline configuration
>> suffers from queue contention. The proposed changes provide modest
>> improvements on their own, and when combined with queue-aware tuning
>> (IRQ affinity, ntuple steering, and CPU alignment), enable up to
>> ~1.5x–2.5x throughput improvement.
>>
>> Scenario 2: NIC queues == CPU count
>> -----------------------------------
>>
>> - CPUs: 72
>> - NIC queues: 72
>>
>>                  Baseline                Patched + tuning
>> randread        4310 MB/s               7987 MB/s
>>                  (1052k IOPS)            (1950k IOPS)
>>
>> randwrite       7947 MB/s               7972 MB/s
>>                  (1940k IOPS)            (1946k IOPS)
>>
>> randrw (read)   3583 MB/s               4030 MB/s
>>                  (875k IOPS)             (984k IOPS)
>>
>> randrw (write)  3583 MB/s               4029 MB/s
>>                  (875k IOPS)             (984k IOPS)
>>
>> Observation:
>> When NIC queues are already aligned with CPU count, the baseline 
>> performs
>> well. The proposed changes maintain write performance (no regression) 
>> and
>> still improve read and mixed workloads due to better flow-to-CPU 
>> locality.
>>
>> Notes on tuning
>> ---------------
>> The "patched + tuning" configuration includes:
>>      - aligning NVMe/TCP I/O workers with NIC queue count
>>      - IRQ affinity configuration per RX queue
>>      - ntuple-based flow steering
>>      - CPU/queue affinity alignment
>>
>> These tuning steps are enabled by the queue/flow information exposed 
>> through
>> this patchset.
>>
>> Discussion
>> ----------
>> This RFC aims to start discussion around:
>>    - Whether NVMe/TCP queue scaling should consider NIC queue topology
>>    - How best to expose queue/flow information to userspace
>>    - The role of userspace vs kernel in steering decisions
>>
>> As usual, feedback/comment/suggestions are most welcome!
>>
>> Reference to LSF/MM/BPF abstarct: 
>> https://lore.kernel.org/all/5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com/
>>
>
> Weelll ... we have been debating this back and forth over recent years:
> Should we check for hardware limitations for NVMe-over-Fabrics or not?
>
> Initially it sounds appealing, and in fact I've worked on several 
> attempts myself. But in the end there are far more things which need
> to be considered:
> -> For networking, number of queues is not really telling us anything.
>    Most NICs have distinct RX and TX queues, and the number (of both!)
>    varies quite dramatically.
> -> The number of queues does _not_ indicate that all queues are used
>    simultaneously. That is down to things like RSS and friends.
>    I gave a stab at configuring _that_ but it's patently horrible
>    trying to out-guess things for yourself.
> -> It'll only work if you run directly on the NIC. As soon as there
>    is anything in between (qemu? Tunnelling?) you are out of luck.
>
> So yeah, we should have a discussion here.

TBH, I don't think that this is very useful. I mentioned some areas on 
why on patch #1

But the main reason is that I think that the majority the gains that you 
are showing
is the tuning - which is somewhat unrelated to the driver, and TBH, I 
doubt anyone
will actually do in reality.

