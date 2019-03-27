From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 27 Mar 2019 10:03:26 +0800
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <20190326235726.GC4328@localhost.localdomain>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
Message-ID: <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>

Hi Keith

On 3/27/19 7:57 AM, Keith Busch wrote:
> On Mon, Mar 25, 2019@08:05:53PM -0700, jianchao.wang wrote:
>> What if there used to be a io scheduler and leave some stale requests of sched tags ?
>> Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?
> 
> Requests internally queued in scheduler or block layer are not eligible
> for the nvme driver's iterator callback. We only use it to reclaim
> dispatched requests that the target can't return, which only applies to
> requests that must have a valid rq->tag value from hctx->tags.
>  
>> The stable request could be some tings freed and used
>> by others and the state field happen to be overwritten to non-zero...
> 
> I am not sure I follow what this means. At least for nvme, every queue
> sharing the same tagset is quiesced and frozen, there should be no
> request state in flux at the time we iterate.
> 

In nvme_dev_disable, when we try to reclaim the in-flight requests with blk_mq_tagset_busy_iter,
the request_queues are quiesced but just start-freeze.
We will try to _drain_ the in-flight requests for the _shutdown_ case when controller is not dead.
For the reset case, there still could be someone escapes the checking of queue freezing and enters
blk_mq_make_request and tries to allocate tag, then we may get,

generic_make_request        nvme_dev_disable
 -> blk_queue_enter              
                              -> nvme_start_freeze (just start freeze, no drain)
                              -> nvme_stop_queues
 -> blk_mq_make_request
  - > blk_mq_get_request      -> blk_mq_tagset_busy_iter
     -> blk_mq_get_tag
                      ??        -> bt_tags_for_each
                         ???       -> bt_tags_iter
                              ??       -> rq = tags->rqs[] ---> [1]
     -> blk_mq_rq_ctx_init
       -> data->hctx->tags->rqs[rq->tag] = rq;

The rq got on position [1] could be a stale request that has been freed due to,
1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
2. a removed io scheduler's sched request

And this stale request may have been used by others and the request->state is changed to a non-zero
value and passes the checking of blk_mq_request_started and then it will be handled by nvme_cancel_request.

Thanks
Jianchao
