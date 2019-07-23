From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 23 Jul 2019 12:22:46 -0700
Subject: [PATCH 3/5] nvme: don't abort completed request in
 nvme_cancel_request
In-Reply-To: <20190723010845.GD30776@ming.t460p>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-4-ming.lei@redhat.com>
 <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
 <20190723010845.GD30776@ming.t460p>
Message-ID: <7e484af3-15d5-06fd-5c7b-2fbe38e5b8f1@acm.org>

On 7/22/19 6:08 PM, Ming Lei wrote:
> On Mon, Jul 22, 2019@08:27:32AM -0700, Bart Van Assche wrote:
>> On 7/21/19 10:39 PM, Ming Lei wrote:
>>> Before aborting in-flight requests, all IO queues have been shutdown.
>>> However, request's completion fn may not be done yet because it may
>>> be scheduled to run via IPI.
>>>
>>> So don't abort one request if it is marked as completed, otherwise
>>> we may abort one normal completed request.
>>>
>>> Cc: Max Gurtovoy <maxg at mellanox.com>
>>> Cc: Sagi Grimberg <sagi at grimberg.me>
>>> Cc: Keith Busch <keith.busch at intel.com>
>>> Cc: Christoph Hellwig <hch at lst.de>
>>> Signed-off-by: Ming Lei <ming.lei at redhat.com>
>>> ---
>>>    drivers/nvme/host/core.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index cc09b81fc7f4..cb8007cce4d1 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>>    bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>>>    {
>>> +	/* don't abort one completed request */
>>> +	if (blk_mq_request_completed(req))
>>> +		return;
>>> +
>>>    	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>>>    				"Cancelling I/O %d", req->tag);
>>
>> Something I probably already asked before: what prevents that
>> nvme_cancel_request() is executed concurrently with the completion handler
>> of the same request?
> 
> The commit log did mention the point:
> 
> 	Before aborting in-flight requests, all IO queues have been shutdown.
> 
> which implies that no concurrent normal completion.

How about adding that explanation as a comment above
nvme_cancel_request()? That would make that explanation much easier to 
find compared to having to search through commit logs.

Thanks,

Bart.
