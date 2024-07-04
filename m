Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C5CC3065C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LtjdzxKyhYhDYgQd38DjpnlGmWC1h3DS/QgiILardZ8=; b=uPs1nJfYlZyBIz+MHS9bbxQ0wB
	wyaICQQEJuacKrPc/GCsl6g/CW5CkfPki2lv08OmOMZc6CplHE+q8r3hbQlPb959PLHBjHmoibWzz
	fU0GAAaYmY7WS4z58NpPF81+mrqO4jAxHK0YPOz06YFYo1Q2thKL0QvJiipWeG2UehtGjQDKG2bhZ
	feQKY4fGXBDIuCbon6MpmkVxvhi2FyxJVImrIn9Dy4vDI88Ynw/DkMf/CJC2hhJN9PTtQoSmpw9tT
	GvvFRaJiUm5ewcT4fetT0gZztdhUVIThvgVFfal4fu/mynJ9ZrCV4U+2oc8U451x0KxkfuRQl9OO6
	nP01Ig7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJpg-0000000CtGM-3zLZ;
	Thu, 04 Jul 2024 10:36:56 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJpS-0000000CtDt-3MEZ
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 10:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ltjdz
	xKyhYhDYgQd38DjpnlGmWC1h3DS/QgiILardZ8=; b=Hu6XfAg7RP2M+pb7+iRzf
	ThuKAE0JoR9//c8HU8QJYKAB3vgqxjVpXgejndRUIWR6Pm2VUCE8F4js3543SPy0
	AnXJNIAkA2qJfNxs8qSPttjH0Y5Fq1IA2nh+D7S/s3Tj0KnUtBVfHQfR5pYo6WOK
	WsxWIes0ifOxzHJMmXSaHM=
Received: from localhost.localdomain (unknown [183.192.130.88])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDnDxsqe4Zm5Yo3Bg--.37145S2;
	Thu, 04 Jul 2024 18:36:27 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP 
Date: Thu,  4 Jul 2024 18:35:32 +0800
Message-Id: <20240704103533.68118-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2797ce03-a52a-459a-a1a1-7591233f51cd@grimberg.me>
References: <2797ce03-a52a-459a-a1a1-7591233f51cd@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnDxsqe4Zm5Yo3Bg--.37145S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW7Jw4ftFW3Jry3Jw1DKFg_yoW3XrW7pr
	W5JF1UJr4DJr1jyr1qyw4DZryUKw18Jw15XF1rJr1UJr1Dt34UJr1Utry5GrykGr18tr15
	tF1DJF9xZF1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIFAXUUUUU=
X-Originating-IP: [183.192.130.88]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKAsSKWXAmGPvLgAAsH
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_033643_277261_ED1E8CE4 
X-CRM114-Status: GOOD (  26.26  )
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

> On 7/4/24 11:10, Ping Gan wrote:
>>> On 02/07/2024 13:02, Ping Gan wrote:
>>>>> On 01/07/2024 10:42, Ping Gan wrote:
>>>>>>> Hey Ping Gan,
>>>>>>>
>>>>>>>
>>>>>>> On 26/06/2024 11:28, Ping Gan wrote:
>>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA
>>>>>>>> and
>>>>>>>> TCP use kworker to handle IO. But if there is other high
>>>>>>>> workload
>>>>>>>> in the system(eg: on kubernetes), the competition between the
>>>>>>>> kworker and other workload is very radical. And since the
>>>>>>>> kworker
>>>>>>>> is scheduled by OS randomly, it's difficult to control OS
>>>>>>>> resource
>>>>>>>> and also tune the performance. If target support to use
>>>>>>>> delicated
>>>>>>>> polling task to handle IO, it's useful to control OS resource
>>>>>>>> and
>>>>>>>> gain good performance. So it makes sense to add polling task in
>>>>>>>> rdma-rdma and rdma-tcp modules.
>>>>>>> This is NOT the way to go here.
>>>>>>>
>>>>>>> Both rdma and tcp are driven from workqueue context, which are
>>>>>>> bound
>>>>>>> workqueues.
>>>>>>>
>>>>>>> So there are two ways to go here:
>>>>>>> 1. Add generic port cpuset and use that to direct traffic to the
>>>>>>> appropriate set of cores
>>>>>>> (i.e. select an appropriate comp_vector for rdma and add an
>>>>>>> appropriate
>>>>>>> steering rule
>>>>>>> for tcp).
>>>>>>> 2. Add options to rdma/tcp to use UNBOUND workqueues, and allow
>>>>>>> users
>>>>>>> to
>>>>>>> control
>>>>>>> these UNBOUND workqueues cpumask via sysfs.
>>>>>>>
>>>>>>> (2) will not control interrupts to steer to other workloads
>>>>>>> cpus,
>>>>>>> but
>>>>>>> the handlers may
>>>>>>> run on a set of dedicated cpus.
>>>>>>>
>>>>>>> (1) is a better solution, but harder to implement.
>>>>>>>
>>>>>>> You also should look into nvmet-fc as well (and nvmet-loop for
>>>>>>> that
>>>>>>> matter).
>>>>>> hi Sagi Grimberg,
>>>>>> Thanks for your reply, actually we had tried the first advice you
>>>>>> suggested, but we found the performance was poor when using spdk
>>>>>> as initiator.
>>>>> I suggest that you focus on that instead of what you proposed.
>>>>> What is the source of your poor performance?
>>>> Before these patches, we had used linux's RPS to forward the
>>>> packets
>>>> to a fixed cpu set for nvmet-tcp. But when did that we can still
>>>> not
>>>> cancel the competition between softirq and workqueue since nvme
>>>> target's
>>>> kworker cpu core bind on socket's cpu which is from skb. Besides
>>>> that
>>>> we found workqueue's wait latency was very high even we enabled
>>>> polling
>>>> on nvmet-tcp by module parameter idle_poll_period_usecs. So when
>>>> initiator
>>>> is polling mode, the target of workqueue is the bottleneck. Below
>>>> is
>>>> work's wait latency trace log of our test on our cluster(per node
>>>> uses
>>>> 4 numas 96 cores, 192G memory, one dual ports mellanox CX4LX(25Gbps
>>>> X
>>>> 2)
>>>> ethernet adapter and randrw 1M IO size) by RPS to 6 cpu cores. And
>>>> system's CPU and memory were used about 80%.
>>> I'd try a simple unbound CPU case, steer packets to say cores [0-5]
>>> and
>>> assign
>>> the cpumask of the unbound workqueue to cores [6-11].
>> Okay, thanks for your guide.
>>
>>>> ogden-brown:~ #/usr/share/bcc/tools/wqlat -T -w nvmet_tcp_wq 1 2
>>>> 01:06:59
>>>>    usecs               : count     distribution
>>>>        0 -> 1          : 0        |                              |
>>>>        2 -> 3          : 0        |                              |
>>>>        4 -> 7          : 0        |                              |
>>>>        8 -> 15         : 3        |                              |
>>>>       16 -> 31         : 10       |                              |
>>>>       32 -> 63         : 3        |                              |
>>>>       64 -> 127        : 2        |                              |
>>>>      128 -> 255        : 0        |                              |
>>>>      256 -> 511        : 5        |                              |
>>>>      512 -> 1023       : 12       |                              |
>>>>     1024 -> 2047       : 26       |*                             |
>>>>     2048 -> 4095       : 34       |*                             |
>>>>     4096 -> 8191       : 350      |************                  |
>>>>     8192 -> 16383      : 625      |******************************|
>>>>    16384 -> 32767      : 244      |*********                     |
>>>>    32768 -> 65535      : 39       |*                             |
>>>>
>>>> 01:07:00
>>>>    usecs               : count     distribution
>>>>        0 -> 1          : 1        |                              |
>>>>        2 -> 3          : 0        |                              |
>>>>        4 -> 7          : 4        |                              |
>>>>        8 -> 15         : 3        |                              |
>>>>       16 -> 31         : 8        |                              |
>>>>       32 -> 63         : 10       |                              |
>>>>       64 -> 127        : 3        |                              |
>>>>      128 -> 255        : 6        |                              |
>>>>      256 -> 511        : 8        |                              |
>>>>      512 -> 1023       : 20       |*                             |
>>>>     1024 -> 2047       : 19       |*                             |
>>>>     2048 -> 4095       : 57       |**                            |
>>>>     4096 -> 8191       : 325      |****************              |
>>>>     8192 -> 16383      : 647      |******************************|
>>>>    16384 -> 32767      : 228      |***********                   |
>>>>    32768 -> 65535      : 43       |**                            |
>>>>    65536 -> 131071     : 1        |                              |
>>>>
>>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>>> improvement.
>>> I think you will see similar performance with unbound workqueue and
>>> rps.
>> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting
>> unbound
>> workqueue, and in same prerequisites of above to run test, and
>> compared
>> the result of unbound workqueue and polling mode task. And I got a
>> good
>> performance for unbound workqueue. For unbound workqueue TCP we got
>> 3850M/node, it's almost equal to polling task. And also tested
>> nvmet-rdma
>> we get 5100M/node for unbound workqueue RDMA versus 5600M for polling
>> task,
>> seems the diff is very small. Anyway, your advice is good.
>
> I'm a bit surprised that you see ~10% delta here. I would look into
> what 
> is the root-cause of
> this difference. If indeed the load is high, the overhead of the 
> workqueue mgmt should be
> negligible. I'm assuming you used IB_POLL_UNBOUND_WORKQUEUE ?

Yes, we used IB_POLL_UNBOUND_WORKQUEUE to create ib CQ. And I observed
3% CPU
usage of unbound workqueue versus 6% of polling task. 

>>   Do you think
>> we
>> should submit the unbound workqueue patches for nvmet-tcp and
>> nvmet-rdma
>> to upstream nvmet?
>
> For nvmet-tcp, I think there is merit to split socket processing from 
> napi context. For nvmet-rdma
> I think the only difference is if you have multiple CQs assigned with 
> the same comp_vector.
>
> How many queues do you have in your test?

We used 24 IO queues to nvmet-rdma target. I think this may also be 
related to workqueue's wait latency. We still see some several ms wait
latency for unbound workqueue of RMDA. You can see below trace log.

ogden-brown:~ # /usr/share/bcc/tools/wqlat -T -w ib-comp-unb-wq 1 3
Tracing work queue request latency time... Hit Ctrl-C to end.

10:09:10
     usecs               : count     distribution
         0 -> 1          : 6        |                              |
         2 -> 3          : 105      |**                            |
         4 -> 7          : 1732     |******************************|
         8 -> 15         : 1597     |******************************|
        16 -> 31         : 526      |************                  |
        32 -> 63         : 543      |************                  |
        64 -> 127        : 950      |*********************         |
       128 -> 255        : 1335     |***************************** |
       256 -> 511        : 1534     |******************************|
       512 -> 1023       : 1039     |***********************       |
      1024 -> 2047       : 592      |*************                 |
      2048 -> 4095       : 112      |**                            |
      4096 -> 8191       : 6        |                              |

10:09:11
     usecs               : count     distribution
         0 -> 1          : 3        |                              |
         2 -> 3          : 62       |*                             |
         4 -> 7          : 1459     |***************************** |
         8 -> 15         : 1869     |******************************|
        16 -> 31         : 612      |*************                 |
        32 -> 63         : 478      |**********                    |
        64 -> 127        : 844      |******************            |
       128 -> 255        : 1123     |************************      |
       256 -> 511        : 1278     |***************************   |
       512 -> 1023       : 1113     |***********************       |
      1024 -> 2047       : 632      |*************                 |
      2048 -> 4095       : 158      |***                           |
      4096 -> 8191       : 18       |                              |
      8192 -> 16383      : 1        |                              |

10:09:12
     usecs               : count     distribution
         0 -> 1          : 1        |                              |
         2 -> 3          : 68       |*                             |
         4 -> 7          : 1399     |***************************   |
         8 -> 15         : 1822     |******************************|
        16 -> 31         : 559      |************                  |
        32 -> 63         : 513      |***********                   |
        64 -> 127        : 906      |*******************           |
       128 -> 255        : 1217     |***********************       |
       256 -> 511        : 1391     |***************************   |
       512 -> 1023       : 1135     |************************      |
      1024 -> 2047       : 569      |************                  |
      2048 -> 4095       : 110      |**                            |
      4096 -> 8191       : 26       |                              |
      8192 -> 16383      : 11       |                              |

Thanks,
Ping



