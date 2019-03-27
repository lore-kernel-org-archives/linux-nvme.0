From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 27 Mar 2019 15:18:25 +0800
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <20190327065156.GC7389@localhost.localdomain>
References: <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
 <20190327021521.GA7389@localhost.localdomain>
 <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
 <20190327023354.GB7389@localhost.localdomain>
 <9f3a574d-d2ea-3fd0-472c-85ad0bae4daf@oracle.com>
 <20190327065156.GC7389@localhost.localdomain>
Message-ID: <c756aab1-b546-c345-4299-205205ca4cb4@oracle.com>

Hi Keith

On 3/27/19 2:51 PM, Keith Busch wrote:
> On Wed, Mar 27, 2019@10:45:33AM +0800, jianchao.wang wrote:
>> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
>>    The whole request_queue is cleaned up and freed, so the hctx->fq.flush is freed back to a slab
>>
>> 2. a removed io scheduler's sched request
>>    The io scheduled is detached and all of the structures are freed, including the pages where sched
>>    requests locates.
>>
>> So the pointers in tags->rqs[] may point to memory that is not used as a blk layer request.
> 
> Oh, free as in kfree'd, not blk_mq_free_request. So it's a read-after-
> free that you're concerned about, not that anyone explicitly changed a
> request->state.

Yes ;)

> 
> We at least can't free the flush_queue until the queue is frozen. If the
> queue is frozen, we've completed the special fq->flush_rq where its end_io
> replaces tags->rqs[tag] back to the fq->orig_rq from the static_rqs,
> so nvme's iterator couldn't see the fq->flush_rq address if it's invalid.
> 

This is true for the non io-scheduler case in which the flush_rq would steal the driver tag.
But for io-scheduler case, flush_rq would acquire a driver tag itself.


> The sched_tags concern, though, appears theoretically possible.
> 

Thanks
Jianchao
