From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jan 2018 15:07:14 +0200
Subject: [PATCH 2/5] nvme: Ending failed unstarted requests
In-Reply-To: <0df52ef8-1880-2d3d-5451-179a8d44a8b1@oracle.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
 <20180122215630.13697-2-keith.busch@intel.com>
 <0df52ef8-1880-2d3d-5451-179a8d44a8b1@oracle.com>
Message-ID: <35e4d354-d81e-83f9-6ab6-987e73d44192@grimberg.me>


> Hi Keith
> 
> On 01/23/2018 05:56 AM, Keith Busch wrote:
>>   	nvme_cancel_requests(&dev->ctrl);
>>   	/*
>>   	 * The driver will not be starting up queues again if shutting down so
>> -	 * must flush all entered requests to their failed completion to avoid
>> +	 * must end all entered requests to their failed completion to avoid
>>   	 * deadlocking blk-mq hot-cpu notifier.
>>   	 */
>>   	if (shutdown)
>> -		nvme_start_queues(&dev->ctrl);
>> +		nvme_end_requests(&dev->ctrl);
> The blk-mq cpuhp notifier has been changed by Christoph's 4b855ad (blk-mq: Create hctx for each present CPU),
> the deadlocking here should have been fixed here.
> So the comment here should be modified at least to avoid confusion.
> On the other hand, we needn't freeze the queue for reset case, the device will be setup soon later, just
> quiesce the blk-mq queue should be ok. And regarding to the shutdown case, frozen and drained queue will
> be safer. To drain the queue, we have to unquiesce it.

I think that this is exactly the point of the patch, not to unquiesce
and rely on .queue_rq to fail the requests.
