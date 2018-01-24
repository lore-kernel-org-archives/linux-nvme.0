From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 24 Jan 2018 12:20:33 +0200
Subject: [PATCH 1/4] IB/core: add support for draining Shared receive
 queues
In-Reply-To: <11f8c447-065f-ee0c-f88e-ee3a006f8571@grimberg.me>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
 <1516197178-26493-2-git-send-email-maxg@mellanox.com>
 <11f8c447-065f-ee0c-f88e-ee3a006f8571@grimberg.me>
Message-ID: <bc8a714b-6241-0363-c830-3d245d2b6c92@mellanox.com>



On 1/24/2018 8:39 AM, Sagi Grimberg wrote:
> Hi Max,

Hi Sagi,

> 
>> diff --git a/drivers/infiniband/core/verbs.c 
>> b/drivers/infiniband/core/verbs.c
>> index 7868727..7604450 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -886,8 +886,10 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
>> ????????? if (qp_init_attr->recv_cq)
>> ????????????? atomic_inc(&qp_init_attr->recv_cq->usecnt);
>> ????????? qp->srq = qp_init_attr->srq;
>> -??????? if (qp->srq)
>> +??????? if (qp->srq) {
>> ????????????? atomic_inc(&qp_init_attr->srq->usecnt);
>> +??????????? init_completion(&qp->srq_completion);
>> +??????? }
>> ????? }
> 
> How about initializing the completion at ib_drain_srq and complete it
> always in last wqe reached event in the core instead of relying on ULPs
> to call ib_notify_qp?

I don't think I can. The event can arrive *before* the call to ib_drain_srq.

> 
> The simplest way I can think of is to have the core register its own
> event handler for that..

Do you mean not raising this event to ULP at all ? I can check this (I 
don't think we do it for other events we get...).
