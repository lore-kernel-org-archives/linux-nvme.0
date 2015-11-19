From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Thu, 19 Nov 2015 08:34:09 +0000
Subject: Drives with MDTS set to zero
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93D37DBA9@fmsmsx104.amr.corp.intel.com>
References: <564B9366.1090904@ranbarg.com>
 <20151118225820.GB24252@localhost.localdomain>
 <20151118230226.GC24252@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D37DBA9@fmsmsx104.amr.corp.intel.com>
Message-ID: <564D8981.9080209@ranbarg.com>

Thanks.

That should take care of max_segments.

There is still the issue that blk_queue_max_hw_sectors calls
blk_limits_max_hw_sectors which performs:

(max_hw_sectors << 9)

and so ends up with a strange looking value. I'm not if this is a
problem with the driver calling it with UINT_MAX, or a problem with the
way blk_limits_max_hw_sectors processes max_hw_sectors. This is a minor
issue since the device will still operate.


On 11/18/15 23:08, Busch, Keith wrote:
> Ugh, broken again, sorry, having a distracted day...
>
> I'll resend as a proper patch that really works.
>
>> On Wed, Nov 18, 2015@10:58:20PM +0000, Keith Busch wrote:
>>> We can fix this by reordering the math instead of artificially reducing
>>> the transfer size.
>> Resend with an actually compilable patch.
>>
>> ---
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 5aca81c..f17e3d3 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2266,7 +2266,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
>>  	if (dev->max_hw_sectors) {
>>  		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
>>  		blk_queue_max_segments(ns->queue,
>> -			((dev->max_hw_sectors << 9) / dev->page_size) + 1);
>> +			(dev->max_hw_sectors / (dev->page_size >> 9) + 1);
>>  	}
>>  	if (dev->stripe_size)
>>  		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
>> --
>
