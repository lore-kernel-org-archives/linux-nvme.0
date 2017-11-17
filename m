From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 17 Nov 2017 21:17:11 +0200
Subject: [PATCH 1/3] IB/core: add a simple SRQ pool per PD
In-Reply-To: <49940a5c-4a9e-7c66-5077-79fe45415155@grimberg.me>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
 <1510852885-25519-2-git-send-email-maxg@mellanox.com>
 <49940a5c-4a9e-7c66-5077-79fe45415155@grimberg.me>
Message-ID: <5cb60ddd-4223-db53-d91f-4ec51fb3d1f4@mellanox.com>



On 11/16/2017 8:32 PM, Sagi Grimberg wrote:
> 
>> +EXPORT_SYMBOL(ib_srq_pool_init);
>> +
>> +void ib_srq_pool_destroy(struct ib_pd *pd)
>> +{
>> +??? struct ib_srq *srq;
>> +??? unsigned long flags;
>> +
>> +??? spin_lock_irqsave(&pd->srq_lock, flags);
>> +??? while (!list_empty(&pd->srqs)) {
>> +??????? srq = list_first_entry(&pd->srqs, struct ib_srq, pd_entry);
>> +??????? list_del(&srq->pd_entry);
>> +
>> +??????? spin_unlock_irqrestore(&pd->srq_lock, flags);
>> +??????? ib_destroy_srq(srq);
>> +??????? spin_lock_irqsave(&pd->srq_lock, flags);
>> +??? }
>> +??? spin_unlock_irqrestore(&pd->srq_lock, flags);
> 
> Why not just splicing the list and iterate sanely?

sure, I'll use list_splice_init(&pd->srqs, &tmp_list)
