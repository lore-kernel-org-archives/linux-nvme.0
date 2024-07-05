Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7727AC30658
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 05:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qOFWQf+FmtssRjh9fb8oLKyhXKW8Q2mBHM5TAimpaAE=; b=iKIWvbgwx/xeqHLGYFaTCgcCUf
	9/j77RGXWQfXWpuJefvYLE1mRqcDsGNfzGZxLpKaYY4U2EfwS+zUrdZGMfxJjN48MiKZ1ybojknbo
	l+xyfAu8ztmEbTfWIqralcdljET5aFEd4zS7jrHTWNVoDRGaC/P1DqAPJfa+MzTIyRw/6OQ2Ow4go
	b/fnkuidksFn0QLYcRfLA25i/XY7wemOqTdEvYY8b/Z+fpKFm14jEIy/dbCl6RJkliY/vlkn0oZs+
	d0B3+P1zyTOxDh94Qdcqi1BQjO8cIhuMaDoRjcEIeTy6Rkq/0hHjeeIo/fP6kYF+OhlfM73qCtAIu
	m1HNZhhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbyn-0000000EzA8-2XPh;
	Fri, 05 Jul 2024 05:59:33 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbyj-0000000Ez9O-4Bcj
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 05:59:31 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36788bf97d4so49697f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jul 2024 22:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159167; x=1720763967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOFWQf+FmtssRjh9fb8oLKyhXKW8Q2mBHM5TAimpaAE=;
        b=xL+eIEyI2K0LicRjSdKUJvD8lzPwr4Gt26LtLKiNxsUiAdmNfpKorcw4N1CSFIFnLc
         3xXKzrcVwYZ7In0P0GNEpeEOA35RN9YwLEtUxK18Zj7i1zGxlawEDVstgTAn3Iz+vilU
         He1A3A7//nkQSdRpOSVT/lF8O4EqQwJqHE21XIZ4Hf8k+Fzh24/wTtYorIu7PnhfZdlm
         hSjC4G5E0QuDLnlZGze5cYqZ8bhX3Ruo5hRMVr/RuCIBWYNEX4LtMtQHpXfnwV6Wir+K
         jdinSv1HvEfQGYNsylEMoT4JiMgjLr/FWEpeuZCUi0qIUE1CI8Q4P8y25f9lhGX4tb25
         0i1g==
X-Forwarded-Encrypted: i=1; AJvYcCWULC/dSYO28wFkYemrnIpT+G6qB7i2R0mfQR2Nfrhwt7/NiN+vXUpV2knvetXlZ/XwM7WLqCrMXGcfMbDU0OuWq74WqMycPaTnMcnc80Q=
X-Gm-Message-State: AOJu0Yx5tuVAhHgk5IxD4PMsaoDcRJFhjvxxH50c6wV0imso7R5QSt9f
	JYvdMXPWQcJFMufpsE+5an508ZAhQB4GzcvgHHuMPX0fps2mXeZP
X-Google-Smtp-Source: AGHT+IGXBbXqpvxifA8CtOQixJf+StFGVkPBe/fheZZUEN6PENcSaXA4Y5d9M0PYPlfmJhXEKsXeZw==
X-Received: by 2002:a5d:5f84:0:b0:365:da7f:6c17 with SMTP id ffacd0b85a97d-3679de750fdmr2433985f8f.7.1720159166802;
        Thu, 04 Jul 2024 22:59:26 -0700 (PDT)
Received: from [10.100.102.67] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36788e37b53sm8459532f8f.45.2024.07.04.22.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 22:59:26 -0700 (PDT)
Message-ID: <61d73b28-c818-4a20-97b8-8a95b4c46c05@grimberg.me>
Date: Fri, 5 Jul 2024 08:59:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <2797ce03-a52a-459a-a1a1-7591233f51cd@grimberg.me>
 <20240704103533.68118-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240704103533.68118-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_225930_080979_3C33D68A 
X-CRM114-Status: GOOD (  24.52  )
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



On 7/4/24 13:35, Ping Gan wrote:
>> On 7/4/24 11:10, Ping Gan wrote:
>>>> On 02/07/2024 13:02, Ping Gan wrote:
>>>>>> On 01/07/2024 10:42, Ping Gan wrote:
>>>>>>>> Hey Ping Gan,
>>>>>>>>
>>>>>>>>
>>>>>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA
>>>>>>>>> and
>>>>>>>>> TCP use kworker to handle IO. But if there is other high
>>>>>>>>> workload
>>>>>>>>> in the system(eg: on kubernetes), the competition between the
>>>>>>>>> kworker and other workload is very radical. And since the
>>>>>>>>> kworker
>>>>>>>>> is scheduled by OS randomly, it's difficult to control OS
>>>>>>>>> resource
>>>>>>>>> and also tune the performance. If target support to use
>>>>>>>>> delicated
>>>>>>>>> polling task to handle IO, it's useful to control OS resource
>>>>>>>>> and
>>>>>>>>> gain good performance. So it makes sense to add polling task in
>>>>>>>>> rdma-rdma and rdma-tcp modules.
>>>>>>>> This is NOT the way to go here.
>>>>>>>>
>>>>>>>> Both rdma and tcp are driven from workqueue context, which are
>>>>>>>> bound
>>>>>>>> workqueues.
>>>>>>>>
>>>>>>>> So there are two ways to go here:
>>>>>>>> 1. Add generic port cpuset and use that to direct traffic to the
>>>>>>>> appropriate set of cores
>>>>>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>>>>>> appropriate
>>>>>>>> steering rule
>>>>>>>> for tcp).
>>>>>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>>>>>>> users
>>>>>>>> to
>>>>>>>> control
>>>>>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>>>>>
>>>>>>>> (2) will not control interrupts to steer to other workloads
>>>>>>>> cpus,
>>>>>>>> but
>>>>>>>> the handlers may
>>>>>>>> run on a set of dedicated cpus.
>>>>>>>>
>>>>>>>> (1) is a better solution, but harder to implement.
>>>>>>>>
>>>>>>>> You also should look into nvmet-fc as well (and nvmet-loop for
>>>>>>>> that
>>>>>>>> matter).
>>>>>>> hi Sagi Grimberg,
>>>>>>> Thanks for your reply, actually we had tried the first advice you
>>>>>>> suggested, but we found the performance was poor when using spdk
>>>>>>> as initiator.
>>>>>> I suggest that you focus on that instead of what you proposed.
>>>>>> What is the source of your poor performance?
>>>>> Before these patches, we had used linux's RPS to forward the
>>>>> packets
>>>>> to a fixed cpu set for nvmet-tcp. But when did that we can still
>>>>> not
>>>>> cancel the competition between softirq and workqueue since nvme
>>>>> target's
>>>>> kworker cpu core bind on socket's cpu which is from skb. Besides
>>>>> that
>>>>> we found workqueue's wait latency was very high even we enabled
>>>>> polling
>>>>> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
>>>>> initiator
>>>>> is polling mode, the target of workqueue is the bottleneck. Below
>>>>> is
>>>>> work's wait latency trace log of our test on our cluster(per node
>>>>> uses
>>>>> 4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps
>>>>> X
>>>>> 2)
>>>>> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
>>>>> system's CPU and memory were used about 80%.
>>>> I'd try a simple unbound CPU case, steer packets to say cores [0-5]
>>>> and
>>>> assign
>>>> the cpumask of the unbound workqueue to cores [6-11].
>>> Okay, thanks for your guide.
>>>
>>>>> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
>>>>> 01:06:59
>>>>>     usecs               : count     distribution
>>>>>         0 -> 1          : 0        |                              |
>>>>>         2 -> 3          : 0        |                              |
>>>>>         4 -> 7          : 0        |                              |
>>>>>         8 -> 15         : 3        |                              |
>>>>>        16 -> 31         : 10       |                              |
>>>>>        32 -> 63         : 3        |                              |
>>>>>        64 -> 127        : 2        |                              |
>>>>>       128 -> 255        : 0        |                              |
>>>>>       256 -> 511        : 5        |                              |
>>>>>       512 -> 1023       : 12       |                              |
>>>>>      1024 -> 2047       : 26       |*                             |
>>>>>      2048 -> 4095       : 34       |*                             |
>>>>>      4096 -> 8191       : 350      |************                  |
>>>>>      8192 -> 16383      : 625      |******************************|
>>>>>     16384 -> 32767      : 244      |*********                     |
>>>>>     32768 -> 65535      : 39       |*                             |
>>>>>
>>>>> 01:07:00
>>>>>     usecs               : count     distribution
>>>>>         0 -> 1          : 1        |                              |
>>>>>         2 -> 3          : 0        |                              |
>>>>>         4 -> 7          : 4        |                              |
>>>>>         8 -> 15         : 3        |                              |
>>>>>        16 -> 31         : 8        |                              |
>>>>>        32 -> 63         : 10       |                              |
>>>>>        64 -> 127        : 3        |                              |
>>>>>       128 -> 255        : 6        |                              |
>>>>>       256 -> 511        : 8        |                              |
>>>>>       512 -> 1023       : 20       |*                             |
>>>>>      1024 -> 2047       : 19       |*                             |
>>>>>      2048 -> 4095       : 57       |**                            |
>>>>>      4096 -> 8191       : 325      |****************              |
>>>>>      8192 -> 16383      : 647      |******************************|
>>>>>     16384 -> 32767      : 228      |***********                   |
>>>>>     32768 -> 65535      : 43       |**                            |
>>>>>     65536 -> 131071     : 1        |                              |
>>>>>
>>>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>>>> improvement.
>>>> I think you will see similar performance with unbound workqueue and
>>>> rps.
>>> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting
>>> unbound
>>> workqueue, and in same prerequisites of above to run test, and
>>> compared
>>> the result of unbound workqueue and polling mode task. And I got a
>>> good
>>> performance for unbound workqueue. For unbound workqueue TCP we got
>>> 3850M/node, it's almost equal to polling task. And also tested
>>> nvmet-rdma
>>> we get 5100M/node for unbound workqueue RDMA versus 5600M for polling
>>> task,
>>> seems the diff is very small. Anyway, your advice is good.
>> I'm a bit surprised that you see ~10% delta here. I would look into
>> what
>> is the root-cause of
>> this difference. If indeed the load is high, the overhead of the
>> workqueue mgmt should be
>> negligible. I'm assuming you used IB_POLL_UNBOUND_WORKQUEUE ?
> Yes, we used IB_POLL_UNBOUND_WORKQUEUE to create ib CQ. And I observed
> 3% CPU
> usage of unbound workqueue versus 6% of polling task.
>
>>>    Do you think
>>> we
>>> should submit the unbound workqueue patches for nvmet-tcp and
>>> nvmet-rdma
>>> to upstream nvmet?
>> For nvmet-tcp, I think there is merit to split socket processing from
>> napi context. For nvmet-rdma
>> I think the only difference is if you have multiple CQs assigned with
>> the same comp_vector.
>>
>> How many queues do you have in your test?
> We used 24 IO queues to nvmet-rdma target. I think this may also be
> related to workqueue's wait latency. We still see some several ms wait
> latency for unbound workqueue of RMDA. You can see below trace log.

What is the queue size of each? what rdma device are you using?

