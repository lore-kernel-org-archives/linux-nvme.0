From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:24:53 +0300
Subject: [PATCHv3 1/9] nvme: Sync request queues on reset
In-Reply-To: <96a98ecf-9b35-1f4f-da20-3729d7a2de68@broadcom.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-2-keith.busch@intel.com>
 <20180525124209.GD23463@lst.de>
 <20180525142233.GN11037@localhost.localdomain>
 <20180525143253.GA26539@lst.de>
 <96a98ecf-9b35-1f4f-da20-3729d7a2de68@broadcom.com>
Message-ID: <e86bf817-8a25-8235-d981-ad146307c585@grimberg.me>


>>> Right, the bring up is single threaded, but the NVMe Controller Level
>>> Reset (CC.EN 1 -> 0) can happen through a timeout. This patch is really
>>> just working with the way blk-mq's timeout handler claims requests
>>> and prevents the driver from completing them. The reset_work operates
>>> under the assumption that there are no outstanding commands after
>>> nvme_dev_disable, so this patch just ensures that's the case.
>> Ok, so we are talking about simultaneous nvme_dev_disable calls, which
>> makes more sense.
>>
>> That being said I really like the idea that Jianchao floated about
>> always returning BLK_EH_RESET_TIMER and just letting the reset work
>> do the work.? I hope it actually works and doesn't have hidden
>> pitfalls..
>>
> 
> I came to this same conclusion and this is how FC works.

and rdma saw a patch for it but was differed to when the block layer
complete/timeout races were resolved.. Perhaps we should
resurrect that.
