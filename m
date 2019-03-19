From: james.smart@broadcom.com (James Smart)
Date: Mon, 18 Mar 2019 20:37:35 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190319010601.GA22459@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
 <20190319010601.GA22459@ming.t460p>
Message-ID: <606d3477-e7ed-d876-f132-11627a77a760@broadcom.com>



On 3/18/2019 6:06 PM, Ming Lei wrote:
> On Mon, Mar 18, 2019@10:37:08AM -0700, James Smart wrote:
>>
>> On 3/17/2019 8:29 PM, Ming Lei wrote:
>>> In NVMe's error handler, follows the typical steps for tearing down
>>> hardware:
>>>
>>> 1) stop blk_mq hw queues
>>> 2) stop the real hw queues
>>> 3) cancel in-flight requests via
>>> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>>> cancel_request():
>>> 	mark the request as abort
>>> 	blk_mq_complete_request(req);
>>> 4) destroy real hw queues
>>>
>>> However, there may be race between #3 and #4, because blk_mq_complete_request()
>>> actually completes the request asynchronously.
>>>
>>> This patch introduces blk_mq_complete_request_sync() for fixing the
>>> above race.
>>>
>> This won't help FC at all. Inherently, the "completion" has to be
>> asynchronous as line traffic may be required.
>>
>> e.g. FC doesn't use nvme_complete_request() in the iterator routine.
> Yeah, I saw the FC code, it is supposed to address the asynchronous
> completion of blk_mq_complete_request() in error handler.
>
> Also I think it is always the correct thing to abort requests
> synchronously in error handler, isn't it?
>

not sure I fully follow you, but if you're asking shouldn't it always be 
synchronous - why would that be the case ?? I really don't want a 
blocking thread that could block for several seconds on a single io to 
complete.? The controller has changed state and the queues frozen which 
should have been sufficient - but bottom-end io can still complete at 
any time.

-- james
