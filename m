Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3A0C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FbDO25MgR0OBg4ghDSk/qfsedlmdOP5SL6u05bo5P8=; b=ES8L6Tt06rVBcMEKpExOz+NnGj
	MKmB03LfeL2bs626tLxjHZXCjdwtFZqUIHU2KoYh9Dmr1hoS8ZcDwxOxUJB7WOwPapmC0JA8MN/Xj
	xzCENHP5/QJSAgg1x9Ngz0DWDuc7FMTZlB27GAcQ8Q19pnT7lxTvzV8jrGP18NhsJRqY818mPmTII
	o9R9DgirRuDZ8UTvkn5b7nA1KZkoyEJIyp16ZCNfb7rKVJtCbho5YMB4+yvDMTgx2o5cjSZbp8HMn
	WG19JR3rhc/v7ukwAoNjbHEo8xCXclRywzaclgFkGFEXdQzN92uTRMEplU2WGaHMs++Acf+TE03eu
	2YgC5MDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaMB-00000006Hd4-0qzx;
	Tue, 02 Jul 2024 10:03:27 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaM7-00000006HbZ-2vjB
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 10:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=8FbDO25MgR0OBg4ghDSk/qfsedlmdOP5SL6u05bo5P8=; b=EiLHhZOFu7tJS
	aZFRQ4lXR+37PglfQm4Z8c0jf2Rnsf91yj97XoQruB8TZMhmmqA7DucuvJ6KYYy9
	D5xd7TlzeWXMMA3DtFgTP/7Wtt4wJ7U8Kvd7LKcyfj/pjeLGofZrqoKih7V6pBg5
	ryDYrO9JlX83IUqU9mX7zx7Karllpc=
Received: from localhost.localdomain (unknown [183.192.130.164])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3_2Vb0INmpmSMBQ--.35615S2;
	Tue, 02 Jul 2024 18:03:08 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP 
Date: Tue,  2 Jul 2024 18:02:14 +0800
Message-Id: <20240702100215.2265-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
References: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_2Vb0INmpmSMBQ--.35615S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF17uFWfCFW5Zr4DXF4xWFg_yoWxGFy7pF
	WftFW5KrsrKrWUCw1IvanruFy09wn3J3y5Jr1fJry7Cw1Y93sxAryxKr15WFyDCr1kKw1a
	qFyDX3sxuF1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI2N_UUUUU=
X-Originating-IP: [183.192.130.164]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEB0QKWXAluk-igAAsb
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_030324_231362_8A8D1C9F 
X-CRM114-Status: GOOD (  26.96  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>On 01/07/2024 10:42, Ping Gan wrote:
>>> Hey Ping Gan,
>>>
>>>
>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>> TCP use kworker to handle IO. But if there is other high workload
>>>> in the system(eg: on kubernetes), the competition between the
>>>> kworker and other workload is very radical. And since the kworker
>>>> is scheduled by OS randomly, it's difficult to control OS resource
>>>> and also tune the performance. If target support to use delicated
>>>> polling task to handle IO, it's useful to control OS resource and
>>>> gain good performance. So it makes sense to add polling task in
>>>> rdma-rdma and rdma-tcp modules.
>>> This is NOT the way to go here.
>>>
>>> Both rdma and tcp are driven from workqueue context, which are bound
>>> workqueues.
>>>
>>> So there are two ways to go here:
>>> 1. Add generic port cpuset and use that to direct traffic to the
>>> appropriate set of cores
>>> (i.e. select an appropriate comp_vector for rdma and add an
>>> appropriate
>>> steering rule
>>> for tcp).
>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>> users
>>> to
>>> control
>>> these UNBOUND workqueues cpumask via sysfs.
>>>
>>> (2) will not control interrupts to steer to other workloads cpus,
>>> but
>>> the handlers may
>>> run on a set of dedicated cpus.
>>>
>>> (1) is a better solution, but harder to implement.
>>>
>>> You also should look into nvmet-fc as well (and nvmet-loop for that
>>> matter).
>> hi Sagi Grimberg,
>> Thanks for your reply, actually we had tried the first advice you
>> suggested, but we found the performance was poor when using spdk
>> as initiator.
>
>I suggest that you focus on that instead of what you proposed.
>What is the source of your poor performance?
Before these patches, we had used linux's RPS to forward the packets
to a fixed cpu set for nvmet-tcp. But when did that we can still not 
cancel the competition between softirq and workqueue since nvme target's
kworker cpu core bind on socket's cpu which is from skb. Besides that
we found workqueue's wait latency was very high even we enabled polling
on nvmet-tcp by module parameter idle_poll_period_usecs. So when
initiator
is polling mode, the target of workqueue is the bottleneck. Below is 
work's wait latency trace log of our test on our cluster(per node uses 
4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps X 2)
ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
system's CPU and memory were used about 80%.
ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
01:06:59
     usecs               : count     distribution
         0 -> 1          : 0        |                              |
         2 -> 3          : 0        |                              |
         4 -> 7          : 0        |                              |
         8 -> 15         : 3        |                              |
        16 -> 31         : 10       |                              |
        32 -> 63         : 3        |                              |
        64 -> 127        : 2        |                              |
       128 -> 255        : 0        |                              |
       256 -> 511        : 5        |                              |
       512 -> 1023       : 12       |                              |
      1024 -> 2047       : 26       |*                             |
      2048 -> 4095       : 34       |*                             |
      4096 -> 8191       : 350      |************                  |
      8192 -> 16383      : 625      |******************************|
     16384 -> 32767      : 244      |*********                     |
     32768 -> 65535      : 39       |*                             |

01:07:00
     usecs               : count     distribution
         0 -> 1          : 1        |                              |
         2 -> 3          : 0        |                              |
         4 -> 7          : 4        |                              |
         8 -> 15         : 3        |                              |
        16 -> 31         : 8        |                              |
        32 -> 63         : 10       |                              |
        64 -> 127        : 3        |                              |
       128 -> 255        : 6        |                              |
       256 -> 511        : 8        |                              |
       512 -> 1023       : 20       |*                             |
      1024 -> 2047       : 19       |*                             |
      2048 -> 4095       : 57       |**                            |
      4096 -> 8191       : 325      |****************              |
      8192 -> 16383      : 647      |******************************|
     16384 -> 32767      : 228      |***********                   |
     32768 -> 65535      : 43       |**                            |
     65536 -> 131071     : 1        |                              |

And the bandwidth of a node is only 3100MB. While we used the patch
and enable 6 polling task, the bandwidth can be 4000MB. It's a good 
improvement.

>>   You know this patch is not only resolving OS resource
>> competition issue, but also the perf issue. We have analyzed if we
>> still use workqueue(kworker) as target when initiator is polling
>> driver(eg: spdk), then workqueue/kworker target is the bottleneck
>> since every nvmf request may have a wait latency from queuing on
>> workqueue to begin processing,
>
>That is incorrect, the work context polls the cq until it either drains
>it
>completely, or exhaust a quota of IB_POLL_BUDGET_WORKQUEUE (or
>NVMET_TCP_IO_WORK_BUDGET). Not every command gets its own workqueue
>queuing delay.
>
>And, what does the spdk initiator has to do with it? Didn't
>understand...
Yes, target workqueue implementation will poll a quota; but when the
work
load was high we found many work will wait too long(some of them at
several
ms to hundred ms shown above histogram). We use the spdk initiator(by 
polling mode) to send IO's read/write to nvme disks of a kubernetes 
cluster's remote node.

>>   and the latency can be traced by wqlat
>> of bcc (https://github.com/iovisor/bcc/blob/master/tools/wqlat.py).
>> We think the latency is a disaster for the polling driver data plane,
>> right?
>
>If you need a target that polls all the time, you should probably
>resort 
>to spdk.
>If there is room for optimization in nvmet we'll gladly take it, but 
>this is not the
>way to go IMO.
Yes, in the begining we did use the spdk as polling target driver,
but we suffered from spdk target could not support disk hot plug/unplug
well, sometimes it will cause data loss when did disk hot plug/unplug.
So we switch to kernel target driver because in production customer's
data security is first priority. And for kernel's target it has no
polling mode target driver, so we implemented these patches.

>> So we think adding a polling task mode on nvmet side to handle
>> IO does really make sense; what's your opinion about this?
>
>I personally think that adding a polling kthread is questionable.
>However there is a precedent, io_uring sqthreads. So please look
>into what is done there. I don't mind having something like 
>IB_POLL_IOTASK (or
>io_task threads in nvmet-tcp) if its done correctly (leverages common
>code).
Yes, we have studied io_uring's code before implementing the patches.
Actually we followed io_uring's design idea in these patches.

>>   And you
>> mentioned we should also look into nvmet-fc, I agree with you.
>> However currently we have no nvmf-fc's testbed; if we get the
>> testbed,
>> will do that.
>
>There is fcloop, you should use that to test, same for loop. We don't
>want
>the transports to diverge in functionality.
Ok, I will try, would you please give me some configuration guide for
fcloop since I never used fcloop before.

Thanks,
Ping



