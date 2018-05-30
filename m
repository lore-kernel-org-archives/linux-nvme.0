From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:34:33 +0300
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
References: <20180307175626.15222-1-sagi@grimberg.me>
 <20180308155147.GD3766@localhost.localdomain>
 <20180308172018.GA6785@ziepe.ca>
 <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
Message-ID: <84ebcf65-d1a2-2ee5-d4d7-b96d61ed3c16@grimberg.me>

resurrecting this one...

Can anyone say why this is _not_ needed?

On 03/08/2018 07:56 PM, Sagi Grimberg wrote:
> 
>>>> @@ -437,8 +437,14 @@ static void __nvme_submit_cmd(struct nvme_queue 
>>>> *nvmeq,
>>>> ????? if (++tail == nvmeq->q_depth)
>>>> ????????? tail = 0;
>>>> ????? if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
>>>> -????????????????????????? nvmeq->dbbuf_sq_ei))
>>>> +????????????????????????? nvmeq->dbbuf_sq_ei)) {
>>>> +??????? /*
>>>> +???????? * Make sure that descriptors are written before
>>>> +???????? * doorbell record.
>>>> +???????? */
>>>> +??????? wmb();
>>>> ????????? writel(tail, nvmeq->q_db);
>>>> +??? }
>>>> ????? nvmeq->sq_tail = tail;
>>>> ? }
>>>
>>> If this really is necessary, we'd need this before updating the event
>>> shadow registers too.
>>>
>>> I'd like to understand this a bit more as we haven't done this in eight
>>> years and I can't recall any issues around this section. Have we just
>>> been fortunate that the problem this fixes is extraordinarily unlikely,
>>> or is something else implicitly ordering within this critical section?
>>
>> Well, there is a wmb() already inside
>> nvme_dbbuf_update_and_check_event so any failure would only
>> be related to dbbuf_sq_db being wrong when tail is written to q_db.
> 
> Right, we have that covered.
> 
>> Guessing that might be a basically undetectable situation, maybe some
>> temporary higher latency or something?
> 
> If the SQE and DB update have been reordered, and the device was able
> to fetch the old copy of the SQE, it would be either silent data
> corruption or dma access to unmapped memory or unexpected behavior (if
> the SQE wasn't initialized). I just think its a *very* rare race that
> can happen...
