From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 1 Dec 2017 15:15:26 -0700
Subject: [PATCH] nvme: set discard_alignment to zero
In-Reply-To: <20171128123812.GB1736@infradead.org>
References: <20171124153053.23056-1-ddiss@suse.de>
 <20171128123812.GB1736@infradead.org>
Message-ID: <e4698065-6338-2831-9416-0a8bc258e912@kernel.dk>

On 11/28/2017 05:38 AM, Christoph Hellwig wrote:
> Adding Jens, who added this code, but it looks fine to me.
> 
> On Fri, Nov 24, 2017@04:30:53PM +0100, David Disseldorp wrote:
>> Similar to 7c084289795b ("rbd: set discard_alignment to zero"), NVMe
>> devices are currently incorrectly initialised with the block queue
>> discard_alignment set to the NVMe stream alignment.
>>
>> As per Documentation/ABI/testing/sysfs-block:
>>   The discard_alignment parameter indicates how many bytes the beginning
>>   of the device is offset from the internal allocation unit's natural
>>   alignment.
>>
>> Correcting the discard_alignment parameter to zero has no effect on how
>> discard requests are propagated through the block layer - @alignment in
>> __blkdev_issue_discard() remains zero. However, it does fix other
>> consumers, such as LIO's Block Limits VPD response.
>>
>> Signed-off-by: David Disseldorp <ddiss at suse.de>
>> ---
>>  drivers/nvme/host/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 25da74d310d1..2e224ab5c340 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1287,7 +1287,7 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
>>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>>  			NVME_DSM_MAX_RANGES);
>>  
>> -	queue->limits.discard_alignment = size;
>> +	queue->limits.discard_alignment = 0;
>>  	queue->limits.discard_granularity = size;
>>  
>>  	blk_queue_max_discard_sectors(queue, UINT_MAX);

Looks good to me.

-- 
Jens Axboe
