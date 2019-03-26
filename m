From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 26 Mar 2019 11:05:53 +0800
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
Message-ID: <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>



On 3/26/19 10:41 AM, Ming Lei wrote:
> On Tue, Mar 26, 2019 at 9:18 AM jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>>
>> Hi Keith
>>
>> On 3/25/19 9:49 PM, Keith Busch wrote:
>>> On Mon, Mar 25, 2019@01:38:37PM +0800, Jianchao Wang wrote:
>>>> blk_mq_tagset_inflight_iter is not safe that it could get stale request
>>>> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
>>>> interface nvme_iterate_inflight_rqs is introduced to iterate
>>>> all of the ns under a ctrl.
>>>
>>> Nak, NVMe only iterates tags when new requests can't enter, allocated
>>> requests can't dispatch, and dispatched commands can't complete. So
>>> it is perfectly safe to iterate if the driver takes reasonable steps
>>> beforehand.
>>
>> nvme_dev_disable just quiesce and freeze the request_queue, but not drain the enters.
>> So there still could be someone escapes the queue freeze checking and tries to allocate
>> request.
> 
> The rq->state is just IDLE for these allocated request, so there
> shouldn't be issue
> in NVMe's case.

What if there used to be a io scheduler and leave some stale requests of sched tags ?
Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?

The stable request could be some tings freed and used
by others and the state field happen to be overwritten to non-zero...

Thanks
Jianchao
