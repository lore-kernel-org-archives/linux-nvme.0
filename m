From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 9 Nov 2015 14:46:58 -0700
Subject: [PATCH 06/12] nvme: switch abort to blk_execute_rq_nowait
In-Reply-To: <20151109212844.GD5386@localhost.localdomain>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-7-git-send-email-hch@lst.de>
 <20151109212844.GD5386@localhost.localdomain>
Message-ID: <56411452.8060509@kernel.dk>

On 11/09/2015 02:33 PM, Keith Busch wrote:
> On Sat, Nov 07, 2015@09:45:00AM +0100, Christoph Hellwig wrote:
>> And remove the new unused nvme_submit_cmd helper.
>>
>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>> ---
>>   drivers/nvme/host/core.c |  8 +++---
>>   drivers/nvme/host/nvme.h |  2 +-
>>   drivers/nvme/host/pci.c  | 66 ++++++++++++++++++++----------------------------
>>   3 files changed, 32 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 37f7d69..3600a0c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -86,12 +86,12 @@ void nvme_requeue_req(struct request *req)
>>   }
>>
>>   struct request *nvme_alloc_request(struct request_queue *q,
>> -		struct nvme_command *cmd)
>> +		struct nvme_command *cmd, bool nowait)
>>   {
>>   	bool write = cmd->common.opcode & 1;
>>   	struct request *req;
>>
>> -	req = blk_mq_alloc_request(q, write, GFP_KERNEL, false);
>> +	req = blk_mq_alloc_request(q, write, GFP_KERNEL, nowait);
>
> The "nowait" flag tells blk_mq_alloc_request to allocate out of the
> reserved tags, but we've reserved only one of these for AEN requests.
> Your next patch changes the AEN notification a bit, but this will still
> create a command id conflict for the controller.

Looks like a mixup of __GFP_WAIT and 'reserved'. Looks like we need to 
pass in both 'nowait' and 'reserved' to nvme_alloc_request(), so it can 
do the right thing.

Though both call sites should tolerate sleeping, since we changed the 
timeout handler to be in process context.

-- 
Jens Axboe
