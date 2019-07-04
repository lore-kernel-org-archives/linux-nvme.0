From: hare@suse.de (Hannes Reinecke)
Date: Thu, 4 Jul 2019 08:00:34 +0200
Subject: [PATCH 2/2] nvme-multipath: do not select namespaces which are
 about to be removed
In-Reply-To: <c355b6ef-12b9-6a57-f091-a459e937f2ec@grimberg.me>
References: <20190703131232.58595-1-hare@suse.de>
 <20190703131232.58595-3-hare@suse.de> <20190703132133.GA8948@lst.de>
 <c355b6ef-12b9-6a57-f091-a459e937f2ec@grimberg.me>
Message-ID: <ad40ac7c-ba0a-db72-6ee4-81556816f633@suse.de>

On 7/3/19 10:33 PM, Sagi Grimberg wrote:
> 
>>> diff --git a/drivers/nvme/host/multipath.c
>>> b/drivers/nvme/host/multipath.c
>>> index c8cc82639327..1f6105a5c596 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -130,7 +130,8 @@ static struct nvme_ns *__nvme_find_path(struct
>>> nvme_ns_head *head, int node)
>>> ? ????? list_for_each_entry_rcu(ns, &head->list, siblings) {
>>> ????????? if (ns->ctrl->state != NVME_CTRL_LIVE ||
>>> -??????????? test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>>> +??????????? test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
>>> +??????????? test_bit(NVME_NS_REMOVING, &ns->flags))
>>> ????????????? continue;
>>> ? ????????? if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>>> @@ -180,7 +181,8 @@ static struct nvme_ns
>>> *nvme_round_robin_path(struct nvme_ns_head *head,
>>> ? ????? if (list_is_singular(&head->list)) {
>>> ????????? if (old->ctrl->state != NVME_CTRL_LIVE ||
>>> -??????????? test_bit(NVME_NS_ANA_PENDING, &old->flags))
>>> +??????????? test_bit(NVME_NS_ANA_PENDING, &old->flags)||
>>> +??????????? test_bit(NVME_NS_REMOVING, &old->flags))
>>> ????????????? return NULL;
>>> ????????? return old;
>>> ????? }
>>> @@ -189,7 +191,8 @@ static struct nvme_ns
>>> *nvme_round_robin_path(struct nvme_ns_head *head,
>>> ?????????? ns != old;
>>> ?????????? ns = nvme_next_ns(head, ns)) {
>>> ????????? if (ns->ctrl->state != NVME_CTRL_LIVE ||
>>> -??????????? test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>>> +??????????? test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
>>> +??????????? test_bit(NVME_NS_REMOVING, &ns->flags))
>>> ????????????? continue;
>>
>> I think we clearly need a patch before the two patches in your
>> series that factors this check into a little helper with a
>> descriptive name.? Also doesn't nvme_path_is_optimized also need
>> to have these checks while we are at it?
> 
> I definitely agree here.
> 
> BTW, while we're on this, do we need the flags check to be
> atomic? or can we micro-optimize with a simple flag arithmetic?

Depends on your definition of 'atomic' here.
No, the _combined_ check does not need to be atomic (ie we do not need
to take a lock around the check here) as the flags are set in two wildly
different places.
Yes, the check itself needs to be atomic (ie any update to the flags
bitmap needs to be visible) as this check protect against a race condition.
We could try to micro-optimize here with using bitmap_and(), but then
this would probably amount to out-guess the compiler, and I'd rather not
attempt it for the sake of readability.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
