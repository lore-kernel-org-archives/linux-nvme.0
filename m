From: hal@dev.mellanox.co.il (Hal Rosenstock)
Date: Mon, 14 Aug 2017 08:13:04 -0400
Subject: Flush warning
In-Reply-To: <20170813103359.GW24282@mtr-leonro.local>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
 <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>
 <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
 <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>
 <20170809162749.GA4069@obsidianresearch.com>
 <011601d3112d$fa305b70$ee911250$@opengridcomputing.com>
 <20170813064651.GR24282@mtr-leonro.local>
 <90ada4f5-d6a1-2b93-5164-c593955c20cf@grimberg.me>
 <20170813103359.GW24282@mtr-leonro.local>
Message-ID: <3d9cca62-4612-53dc-776c-3aeb2df58365@dev.mellanox.co.il>

On 8/13/2017 6:33 AM, Leon Romanovsky wrote:
> On Sun, Aug 13, 2017@02:14:58AM -0700, Sagi Grimberg wrote:
>>
>>>>>> Does anyone else know?
>>>>>
>>>>> Consider that the ib_core can be used to back storage. Ie consider a
>>>>> situation where iSER/NFS/SRP needs to reconnect to respond to kernel
>>>>> paging/reclaim.
>>>>>
>>>>> On the surface it seems reasonable to me that these are on a reclaim
>>>>> path?
>>
>> I'm pretty sure that ULP connect will trigger memory allocations, which
>> will fail under memory pressure... Maybe I'm missing something.
>>
>>>> hmm.  That seems reasonable.  Then I would think the nvme_rdma would also need
>>>> to be using a reclaim workqueue.
>>>>
>>>> Sagi, Do you think I should add a private workqueue with WQ_MEM_RECLAIM to
>>>> nvme_rdma vs using the system_wq?  nvme/target probably needs one also...
>>
>> I'm not sure, being unable to flush system workqueue from CM context is
>> somewhat limiting... We could use a private workqueue for nvmet
>> teardowns but I'm not sure we want to do that.
>>
>>> The workqueue which frees the memory and doesn't allocate memory during execution
>>> is supposed to be marked as WQ_MEM_RECLAIM. This flag will cause to priority increase
>>> for such workqueue during low memory conditions.
>>
>> Which to my understanding means that CM workqueue should not use it as
>> on each CM connect, by definition the ULP allocates memory (qp, cq etc).
> 
> From my understanding too.
> That workqueue was introduced in 2005, in a977049dacde
> ("[PATCH] IB: Add the kernel CM implementation"), it is not clear if it
> was intentionally.
> 
> Hal,
> do you remember the rationale there?

Sean is best to respond to this.

-- Hal

> 
> Thanks
> 
