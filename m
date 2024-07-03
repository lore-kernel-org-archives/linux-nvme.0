Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC53C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VouS0j7SKj9Utpf9IyOLUn5ZlinGhwmqrAJnBX3NUyo=; b=1BjvtWLMCbMjOSIJmGNiSI4rIP
	ZlDvcUzoV5XEqGs+ffkspuBTkH8NaugdMTd/iOEE7x8okqPNciy3d0dRl8AyGITd7KY6TxhGGena9
	3F2houG1hmtus9MmGXZ1fCEC4vGaEQqytyY0QSjtH8qxn+GDQILIZsvCaTv7TtriO+LZUijCn98Z/
	76lXGPm60Ru567hMP2SRxr/NdWYFUS7u4sZo8RGu/0Hi9ufcQBMDoADHT+A6o7kVRf1J0O8liD+c6
	ZzrNLx1eQTHGzzPkwhVdzeqXrDw/8w836KicYyOoVMjUTPS/VxuKTsKv22H2/6YE0zVeWT3Nl5bl6
	KnLmWYGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP67a-0000000BJo0-1iba;
	Wed, 03 Jul 2024 19:58:30 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP67X-0000000BJnV-1MNq
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 19:58:29 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42110872bf9so6388925e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 12:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720036705; x=1720641505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VouS0j7SKj9Utpf9IyOLUn5ZlinGhwmqrAJnBX3NUyo=;
        b=aYDap3qRClo6Qic1+MXeMVF534nDLPxZ5FfjEk/sJakjqrZEGKJVE3sR8clTnmOTFl
         WJhbleMqqtfmK+y3NuB4k8TRNMHtI1tF6rpqLyQa3cr2bg0s+NQzNQrZecQ2ct+hPzPX
         0oTNu2whkn+uTC0VHCam1Ldobf7CaTqcD5oOeG+c7PYSpfe4+I8F0ym8Lf0nfwM6S3gb
         MHB5WYAEUYm2LQFMQcgzpjkUHDNA+JsyHMdacBQ1ulbDYx8+z7kISoMTw8s22fDLdZAw
         xf7WOUy/4VRvDjuI/9OCZFuTtdfpWBc44GT4I7H0ReC4y0UJXjlTyG7U76Eyfnv+fx2R
         OLQg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZUv9hAmQr4unR1XIDLIeYCRqNIB4wTzNTtgkReQzVXqMx8zeZCyrHAgRdCQbI1BNhQEdyIMFpZp47KxQ4X8VXwcEAPvFhtlD1KBcgis=
X-Gm-Message-State: AOJu0YyL+q4XKjPLyowM1bW6jaMRQIAy+2/ncYSss2zbYW242EAPmpu3
	fN7TaZ4Xq8sbq/l/DM2RrVmqyxBH64NOvHZvD0MF29T5YfAxwi2J4yF2iV1p
X-Google-Smtp-Source: AGHT+IHNEE8fqktjGDpzkvE83TaE3G3rqqbp7FOEeVQsU3XpVL+aPvBIWECT4cz2+2bVb7Ru4uvVRg==
X-Received: by 2002:a05:600c:511c:b0:425:73b8:cc4d with SMTP id 5b1f17b1804b1-4257a09a3fdmr86868125e9.1.1720036705440;
        Wed, 03 Jul 2024 12:58:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257d04c742sm167963895e9.7.2024.07.03.12.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:58:25 -0700 (PDT)
Message-ID: <12556163-9efa-461f-826d-264350f4ca58@grimberg.me>
Date: Wed, 3 Jul 2024 22:58:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
 <20240702100215.2265-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240702100215.2265-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_125827_427420_C79F843E 
X-CRM114-Status: GOOD (  34.44  )
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



On 02/07/2024 13:02, Ping Gan wrote:
>> On 01/07/2024 10:42, Ping Gan wrote:
>>>> Hey Ping Gan,
>>>>
>>>>
>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>> TCP use kworker to handle IO. But if there is other high workload
>>>>> in the system(eg: on kubernetes), the competition between the
>>>>> kworker and other workload is very radical. And since the kworker
>>>>> is scheduled by OS randomly, it's difficult to control OS resource
>>>>> and also tune the performance. If target support to use delicated
>>>>> polling task to handle IO, it's useful to control OS resource and
>>>>> gain good performance. So it makes sense to add polling task in
>>>>> rdma-rdma and rdma-tcp modules.
>>>> This is NOT the way to go here.
>>>>
>>>> Both rdma and tcp are driven from workqueue context, which are bound
>>>> workqueues.
>>>>
>>>> So there are two ways to go here:
>>>> 1. Add generic port cpuset and use that to direct traffic to the
>>>> appropriate set of cores
>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>> appropriate
>>>> steering rule
>>>> for tcp).
>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>>> users
>>>> to
>>>> control
>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>
>>>> (2) will not control interrupts to steer to other workloads cpus,
>>>> but
>>>> the handlers may
>>>> run on a set of dedicated cpus.
>>>>
>>>> (1) is a better solution, but harder to implement.
>>>>
>>>> You also should look into nvmet-fc as well (and nvmet-loop for that
>>>> matter).
>>> hi Sagi Grimberg,
>>> Thanks for your reply, actually we had tried the first advice you
>>> suggested, but we found the performance was poor when using spdk
>>> as initiator.
>> I suggest that you focus on that instead of what you proposed.
>> What is the source of your poor performance?
> Before these patches, we had used linux's RPS to forward the packets
> to a fixed cpu set for nvmet-tcp. But when did that we can still not
> cancel the competition between softirq and workqueue since nvme target's
> kworker cpu core bind on socket's cpu which is from skb. Besides that
> we found workqueue's wait latency was very high even we enabled polling
> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
> initiator
> is polling mode, the target of workqueue is the bottleneck. Below is
> work's wait latency trace log of our test on our cluster(per node uses
> 4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps X 2)
> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
> system's CPU and memory were used about 80%.

I'd try a simple unbound CPU case, steer packets to say cores [0-5] and 
assign
the cpumask of the unbound workqueue to cores [6-11].

> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
> 01:06:59
>       usecs               : count     distribution
>           0 -> 1          : 0        |                              |
>           2 -> 3          : 0        |                              |
>           4 -> 7          : 0        |                              |
>           8 -> 15         : 3        |                              |
>          16 -> 31         : 10       |                              |
>          32 -> 63         : 3        |                              |
>          64 -> 127        : 2        |                              |
>         128 -> 255        : 0        |                              |
>         256 -> 511        : 5        |                              |
>         512 -> 1023       : 12       |                              |
>        1024 -> 2047       : 26       |*                             |
>        2048 -> 4095       : 34       |*                             |
>        4096 -> 8191       : 350      |************                  |
>        8192 -> 16383      : 625      |******************************|
>       16384 -> 32767      : 244      |*********                     |
>       32768 -> 65535      : 39       |*                             |
>
> 01:07:00
>       usecs               : count     distribution
>           0 -> 1          : 1        |                              |
>           2 -> 3          : 0        |                              |
>           4 -> 7          : 4        |                              |
>           8 -> 15         : 3        |                              |
>          16 -> 31         : 8        |                              |
>          32 -> 63         : 10       |                              |
>          64 -> 127        : 3        |                              |
>         128 -> 255        : 6        |                              |
>         256 -> 511        : 8        |                              |
>         512 -> 1023       : 20       |*                             |
>        1024 -> 2047       : 19       |*                             |
>        2048 -> 4095       : 57       |**                            |
>        4096 -> 8191       : 325      |****************              |
>        8192 -> 16383      : 647      |******************************|
>       16384 -> 32767      : 228      |***********                   |
>       32768 -> 65535      : 43       |**                            |
>       65536 -> 131071     : 1        |                              |
>
> And the bandwidth of a node is only 3100MB. While we used the patch
> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
> improvement.

I think you will see similar performance with unbound workqueue and rps.

>
>>>    You know this patch is not only resolving OS resource
>>> competition issue, but also the perf issue. We have analyzed if we
>>> still use workqueue(kworker) as target when initiator is polling
>>> driver(eg: spdk), then workqueue/kworker target is the bottleneck
>>> since every nvmf request may have a wait latency from queuing on
>>> workqueue to begin processing,
>> That is incorrect, the work context polls the cq until it either drains
>> it
>> completely, or exhaust a quota of IB_POLL_BUDGET_WORKQUEUE (or
>> NVMET_TCP_IO_WORK_BUDGET). Not every command gets its own workqueue
>> queuing delay.
>>
>> And, what does the spdk initiator has to do with it? Didn't
>> understand...
> Yes, target workqueue implementation will poll a quota; but when the
> work
> load was high we found many work will wait too long(some of them at
> several
> ms to hundred ms shown above histogram). We use the spdk initiator(by
> polling mode) to send IO's read/write to nvme disks of a kubernetes
> cluster's remote node.

The initiator is an orthogonal detail here. the same issue exists 
regardless of
spdk afaiu. Let's ignore it, its confusing.

>
>>>    and the latency can be traced by wqlat
>>> of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py).
>>> We think the latency is a disaster for the polling driver data plane,
>>> right?
>> If you need a target that polls all the time, you should probably
>> resort
>> to spdk.
>> If there is room for optimization in nvmet we'll gladly take it, but
>> this is not the
>> way to go IMO.
> Yes, in the begining we did use the spdk as polling target driver,
> but we suffered from spdk target could not support disk hot plug/unplug
> well, sometimes it will cause data loss when did disk hot plug/unplug.
> So we switch to kernel target driver because in production customer's
> data security is first priority. And for kernel's target it has no
> polling mode target driver, so we implemented these patches.

Well, its a hard sell for upstream nvmet.

>
>>> So we think adding a polling task mode on nvmet side to handle
>>> IO does really make sense; what's your opinion about this?
>> I personally think that adding a polling kthread is questionable.
>> However there is a precedent, io_uring sqthreads. So please look
>> into what is done there. I don't mind having something like
>> IB_POLL_IOTASK (or
>> io_task threads in nvmet-tcp) if its done correctly (leverages common
>> code).
> Yes, we have studied io_uring's code before implementing the patches.
> Actually we followed io_uring's design idea in these patches.

I'm talking about reusing what io_uring sqpoll tasks. Move them to common
code, generalizing it to address what you need, and reuse that. 
Implementing a
half-baked inspired version in nvmet is not going to fly here. Sorry.

