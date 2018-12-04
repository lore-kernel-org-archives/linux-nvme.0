From: axboe@fb.com (Jens Axboe)
Date: Tue, 4 Dec 2018 18:19:53 +0000
Subject: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
In-Reply-To: <20181204150517.GC3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-7-hch@lst.de>
 <0997230c-a13e-65ea-130a-cca366336989@grimberg.me>
 <20181204150517.GC3630@lst.de>
Message-ID: <0a96d78e-91c6-8367-e50d-35c239111a79@fb.com>

On 12/4/18 8:05 AM, Christoph Hellwig wrote:
> On Mon, Dec 03, 2018@05:00:59PM -0800, Sagi Grimberg wrote:
>>
>>> @@ -2428,7 +2426,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>>   	nvme_stop_queues(&dev->ctrl);
>>>     	if (!dead && dev->ctrl.queue_count > 0) {
>>> -		nvme_disable_io_queues(dev);
>>> +		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
>>> +			
>>
>> Would be nice if the opcode change would be kept inside but still
>> split like:
> 
> I actually like not having another wrapper to stop through..
> 
> Keith, Jens, any preference?

Fine either way, prefer not having a wrapper.

-- 
Jens Axboe
