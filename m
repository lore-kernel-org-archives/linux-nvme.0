From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 Jul 2019 13:33:56 -0700
Subject: [PATCH 2/2] nvme-multipath: do not select namespaces which are
 about to be removed
In-Reply-To: <20190703132133.GA8948@lst.de>
References: <20190703131232.58595-1-hare@suse.de>
 <20190703131232.58595-3-hare@suse.de> <20190703132133.GA8948@lst.de>
Message-ID: <c355b6ef-12b9-6a57-f091-a459e937f2ec@grimberg.me>


>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index c8cc82639327..1f6105a5c596 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -130,7 +130,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>>   
>>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>   		if (ns->ctrl->state != NVME_CTRL_LIVE ||
>> -		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>> +		    test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
>> +		    test_bit(NVME_NS_REMOVING, &ns->flags))
>>   			continue;
>>   
>>   		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>> @@ -180,7 +181,8 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>   
>>   	if (list_is_singular(&head->list)) {
>>   		if (old->ctrl->state != NVME_CTRL_LIVE ||
>> -		    test_bit(NVME_NS_ANA_PENDING, &old->flags))
>> +		    test_bit(NVME_NS_ANA_PENDING, &old->flags)||
>> +		    test_bit(NVME_NS_REMOVING, &old->flags))
>>   			return NULL;
>>   		return old;
>>   	}
>> @@ -189,7 +191,8 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>   	     ns != old;
>>   	     ns = nvme_next_ns(head, ns)) {
>>   		if (ns->ctrl->state != NVME_CTRL_LIVE ||
>> -		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>> +		    test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
>> +		    test_bit(NVME_NS_REMOVING, &ns->flags))
>>   			continue;
> 
> I think we clearly need a patch before the two patches in your
> series that factors this check into a little helper with a
> descriptive name.  Also doesn't nvme_path_is_optimized also need
> to have these checks while we are at it?

I definitely agree here.

BTW, while we're on this, do we need the flags check to be
atomic? or can we micro-optimize with a simple flag arithmetic?
