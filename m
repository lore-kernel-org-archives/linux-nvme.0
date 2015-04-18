From: axboe@fb.com (Jens Axboe)
Date: Sat, 18 Apr 2015 14:13:51 -0600
Subject: [PATCH] NVMe: allow discard timeouts to be configurable
In-Reply-To: <20150418201111.GA20311@infradead.org>
References: <20150417213148.GA22587@kernel.dk>
 <20150418201111.GA20311@infradead.org>
Message-ID: <5532BAFF.3010504@fb.com>

On 04/18/2015 02:11 PM, Christoph Hellwig wrote:
>>   static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
>>   				nvme_completion_fn handler)
>>   {
>> +	struct request *rq = blk_mq_rq_from_pdu(cmd);
>> +
>>   	cmd->fn = handler;
>>   	cmd->ctx = ctx;
>>   	cmd->aborted = 0;
>> -	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
>> +
>> +	if (rq->cmd_flags & REQ_DISCARD)
>> +		rq->timeout = nvme_discard_timeout * HZ;
>> +
>
> Can you move this to the discard-specific branch of nvme_queue_rq
> please?

Sure, I just wanted to keep it closer to where we call start request. 
But I can move it, does save a branch.

-- 
Jens Axboe
