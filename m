From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Nov 2018 16:51:05 -0700
Subject: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
In-Reply-To: <20181127234954.GF846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-8-axboe@kernel.dk> <20181127234954.GF846@vader>
Message-ID: <cf96f72c-bf3d-f44f-166d-1b3e8c959de1@kernel.dk>

On 11/27/18 4:49 PM, Omar Sandoval wrote:
> On Mon, Nov 26, 2018@09:35:55AM -0700, Jens Axboe wrote:
>> If we are issuing a list of requests, we know if we're at the last one.
>> If we fail issuing, ensure that we call ->commits_rqs() to flush any
>> potential previous requests.
> 
> One comment below, otherwise
> 
> Reviewed-by: Omar Sandoval <osandov at fb.com>

>> @@ -1260,6 +1260,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>>  	if (!list_empty(list)) {
>>  		bool needs_restart;
>>  
>> +		/*
>> +		 * If we didn't flush the entire list, we could have told
>> +		 * the driver there was more coming, but that turned out to
>> +		 * be a lie.
>> +		 */
>> +		if (q->mq_ops->commit_rqs)
>> +			q->mq_ops->commit_rqs(hctx);
>> +
> 
> This hunk seems like it should go with the patch adding commit_rqs.

Agree, that would be better, since that also makes that patch fix an
actual issue instead of just being a prep patch. I'll shuffle that hunk
to that patch.

-- 
Jens Axboe
