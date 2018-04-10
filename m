From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 13:47:38 +0300
Subject: [PATCH] nvme: avoid flush dependency in delete controller flow
In-Reply-To: <20180409182213.GO3948@linux.vnet.ibm.com>
References: <20180409065007.GA7760@lst.de>
 <1523285426-26526-1-git-send-email-nitzanc@mellanox.com>
 <20180409164808.GK3948@linux.vnet.ibm.com>
 <c43ce416-244d-808d-bbf9-5e6b28674eb0@mellanox.com>
 <20180409182213.GO3948@linux.vnet.ibm.com>
Message-ID: <2e2cbdbd-a1f1-e515-b1f8-90907b4f6b0e@mellanox.com>



On 4/9/2018 9:22 PM, Paul E. McKenney wrote:
> On Mon, Apr 09, 2018@07:58:48PM +0300, Max Gurtovoy wrote:
>>
>>
>> On 4/9/2018 7:48 PM, Paul E. McKenney wrote:
>>> On Mon, Apr 09, 2018@05:50:26PM +0300, Nitzan Carmi wrote:
>>>> nvme_delete_ctrl queues a work on a MEM_RECLAIM queue
>>>> (nvme_delete_wq), which eventually calls cleanup_srcu_struct,
>>>> which in turn flushes a delayed work from an !MEM_RECLAIM
>>>> queue. This is unsafe as we might trigger deadlocks under
>>>> severe memory pressure.
>>>>
>>>> Since we don't ever invoke call_srcu(), it is safe
>>>> to use the _quiesced() version of srcu cleanup, and
>>>> avoid that flush dependency.
>>>>
>>>> Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
>>>
>>> Very good, thank you!
>>>
>>> I queued this with a few edits to the commit log (please see below),
>>> so please let me know if I messed anything up.
>>>
>>> Given that it only happens under high memory pressure, I am assuming
>>> that sending this up the v4.18 merge window (not this one, but the next
>>> one) will work.  Please let me know if this is more urgent than that.
>>> (If it is not more urgent, I would like to allow the extra time for
>>> people to get used to yet another addition to the SRCU API.)
>>
>> I guess we can wait to v4.18 but not sure we actually need to wait
>> that long, Christoph ?
> 
> Or to look at it another way, do these two patches need to go to -stable,
> and if so, how far back?

I don't know if they need to go to -stable but if so then for nvme_core 
it should go to v4.15 (below commit):

commit ed754e5deeb17f4e675c84e4b6c640cc7344e498
Author: Christoph Hellwig <hch at lst.de>
Date:   Thu Nov 9 13:50:43 2017 +0100

     nvme: track shared namespaces

     Introduce a new struct nvme_ns_head that holds information about an 
actual
     namespace, unlike struct nvme_ns, which only holds the per-controller
     namespace information.  For private namespaces there is a 1:1 
relation of
     the two, but for shared namespaces this lets us discover all the 
paths to
     it.  For now only the identifiers are moved to the new structure, 
but most
     of the information in struct nvme_ns should eventually move over.

     To allow lockless path lookup the list of nvme_ns structures per
     nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
     structure through call_srcu.

     Signed-off-by: Christoph Hellwig <hch at lst.de>
     Reviewed-by: Keith Busch <keith.busch at intel.com>
     Reviewed-by: Javier Gonz<C3><A1>lez <javier at cnexlabs.com>
     Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
     Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
     Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
     Reviewed-by: Hannes Reinecke <hare at suse.com>
     Signed-off-by: Jens Axboe <axboe at kernel.dk>




As for SRCU, I guess you can find it better than me :)

> 
>>> ------------------------------------------------------------------------
>>>
>>> commit 6fde861519fc6e4be50c130272be556ef5656324
>>> Author: Nitzan Carmi <nitzanc at mellanox.com>
>>> Date:   Mon Apr 9 17:50:26 2018 +0300
>>>
>>>      nvme: Avoid flush dependency in delete controller flow
>>>      The nvme_delete_ctrl() function queues a work item on a MEM_RECLAIM
>>>      queue (nvme_delete_wq), which eventually calls cleanup_srcu_struct(),
>>>      which in turn flushes a delayed work from an !MEM_RECLAIM queue. This
>>>      is unsafe as we might trigger deadlocks under severe memory pressure.
>>>      Since we don't ever invoke call_srcu(), it is safe to use the shiny new
>>>      _quiesced() version of srcu cleanup, thus avoiding that flush dependency.
>>>      This commit makes that change.
>>>      Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
>>>      Signed-off-by: Paul E. McKenney <paulmck at linux.vnet.ibm.com>
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 7aeca5db7916..40008d06c365 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -351,7 +351,7 @@ static void nvme_free_ns_head(struct kref *ref)
>>>   	nvme_mpath_remove_disk(head);
>>>   	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>>>   	list_del_init(&head->entry);
>>> -	cleanup_srcu_struct(&head->srcu);
>>> +	cleanup_srcu_struct_quiesced(&head->srcu);
>>>   	kfree(head);
>>>   }
>>
>> Looks good, thanks Nitzan and Paul.
>> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> 
> Added your Reviewed-by, thank you!
> 
> 							Thanx, Paul
> 
