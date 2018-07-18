From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 18 Jul 2018 10:57:15 +0800
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180717143250.GC26925@localhost.localdomain>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
 <20180716110903.GC25386@ming.t460p>
 <20180716133640.GC19967@localhost.localdomain>
 <20180717012301.GB22593@ming.t460p>
 <bfd4154b-a8e0-8688-8b77-40a8041418e3@oracle.com>
 <20180717072136.GB26324@ming.t460p>
 <6833a684-3040-3532-a738-6556bedf6e10@oracle.com>
 <20180717143250.GC26925@localhost.localdomain>
Message-ID: <f5af9390-2034-0d7f-3bc4-822026ea7c78@oracle.com>


Hi Keith

Thanks for your kindly response :)

On 07/17/2018 10:32 PM, Keith Busch wrote:
> On Tue, Jul 17, 2018@03:28:33PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 07/17/2018 03:21 PM, Ming Lei wrote:
>>> nvme_start_freeze() is just for stopping new IO.
>>>
>>> However, if you want to drain IO, new IO may have to be prevented from
>>> being entering queue first, then that is nvme_start_freeze() + nvme_wait_freeze().
>>
>> Yes, I mean, after we invoke blk_mq_freeze_queue_start, we have to invoke blk_mq_freeze_queue_wait
>> to drain the q->q_usage_counter, then invoke blk_mq_unfreeze_queue.
>>
>> But in fact, in this scenario, we just need to stop new IO coming in, no need to drain the IO.
>> So I say, we may need a interface which just stop new IO coming in, but no need to drain IO before
>> allow new IO.
> 
> I think what you are asking for is a way to unfreeze a queue that that
> doesn't have a zero ref count, but I think that breaks the percpu_ref.

Yes.
IMO, this is actually a defect of current freeze queue mechanism.
The q->q_usage_counter basically includes
 - the number of callers which enter into q->make_request_fn from generic_make_request
 - allocated requests
(just ignore other corners here)

When we freeze the request queue, no one would cross the blk_queue_enter in generic_make_request,
this is expected. We want to prevent new IO from coming in.

But when we unfreeze the request_queue, we have to wait the q->q_usage_counter to be drained.
That is waiting for all the entered request to be drained. And this is not we want.

If we split the number of allocated requests away from the q->q_usage_counter, we will not 
have to drain IOs when unfreeze the request_queue.

Thanks
Jianchao
