From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 25 Mar 2019 17:12:17 +0800
Subject: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
In-Reply-To: <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
 <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
 <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
Message-ID: <5b8025dc-3aeb-c704-b539-9a2a926c2f02@oracle.com>



On 3/25/19 4:25 PM, Hannes Reinecke wrote:
> On 3/25/19 8:37 AM, jianchao.wang wrote:
>> Hi Hannes
>>
>> On 3/25/19 3:18 PM, Hannes Reinecke wrote:
>>> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>>>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>>>> ---
>>>> ?? block/blk-mq-tag.c???? | 95 --------------------------------------------------
>>>> ?? include/linux/blk-mq.h |? 2 --
>>>> ?? 2 files changed, 97 deletions(-)
>>>>
>>> Please, don't.
>>>
>>> I'm currently implementing reserved commands for SCSI and reworking the SCSI error handling where I rely on
>>> this interface quite heavily.
>>
>>
>> blk_mq_tagset_busy_iter could access some stale requests which maybe freed due to io scheduler switching,
>> request_queue cleanup (shared tagset)
>> when there is someone submits io and gets driver tag. When io scheduler attached, even quiesce
                                                         ^^^^
                                                      s/When/Without
>> request_queue won't work.
>>
>> If this patchset is accepted, blk_mq_tagset_busy_iter could be replaced with blk_mq_queue_inflight_tag_iter
>> which needs to be invoked by every request_queue that shares the tagset.
>>
> The point is, at that time I do _not_ have a request queue to work with.
> 
> Most SCSI drivers have a host-wide shared tagset, which is used by all request queues on that host.
> Iterating over the shared tagset is far more efficient than to traverse over all devices and the attached request queues.
> 
> If I had to traverse all request queues I would need to add additional locking to ensure this traversal is race-free, making it a really cumbersome interface to use.

Yes, the new interface int this patchset is indeed not convenient to use with shared tagset case.
Perhaps we could introduce a interface to iterate all of the request_queue that shares a same tagset, such as,

mutex_lock(&set->tag_list_lock)
list_for_each_entry(q, &set->tag_list, tag_set_list)
...
mutex_unlock(&set->tag_list_lock)

> 
> Plus the tagset iter is understood to be used only in cases where I/O is stopped from the upper layers (ie no new I/O will be submitted).

The window is during get driver tag and store the rq into tags->rqs[].
w/ io-scheduler attached, we need to quiesce the request_queue to stop the driver tag allocation attempts.
w/o io-scheduler attached, quiesce request_queue cannot work, we need to freeze the queue and drain all of tasks that enters blk_mq_make_request
to rule out all of attempts of allocating driver tags. Unfortunately, we cannot distinguish between the task entering .make_request and allocated
requests both of which occupies q_usage_counter.

So to stop all of the attmpts of allocating driver tag, we have freeze & drain and quiesce the request_queue.


Thanks
Jianchao

> So here we only need to protect against I/O being completed, which is not what this patchset is about.
> 
> So my objection still stands: Please, don't.
> 
> Cheers,
> 
> Hannes
