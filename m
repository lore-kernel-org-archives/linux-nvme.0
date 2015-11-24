From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 13:26:12 -0700
Subject: [PATCHv2 2/2] NVMe: Shutdown fixes
In-Reply-To: <20151124202033.GA6248@localhost.localdomain>
References: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
 <1448390128-25758-2-git-send-email-keith.busch@intel.com>
 <5654BDBA.9080406@fb.com> <20151124202033.GA6248@localhost.localdomain>
Message-ID: <5654C7E4.6080602@fb.com>

On 11/24/2015 01:20 PM, Keith Busch wrote:
> On Tue, Nov 24, 2015@12:42:50PM -0700, Jens Axboe wrote:
>> On 11/24/2015 11:35 AM, Keith Busch wrote:
>>> @@ -2023,6 +2039,11 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
>>>
>>>   	nvme_dev_list_remove(dev);
>>>
>>> +	if (test_and_set_bit(NVME_CTRL_SHUTDOWN, &dev->flags)) {
>>> +		wait_event(dev->shutdown_wait, !test_bit(NVME_CTRL_SHUTDOWN,
>>> +								&dev->flags));
>>> +		return;
>>> +	}
>>>   	if (dev->bar) {
>>>   		nvme_freeze_queues(dev);
>>>   		csts = readl(dev->bar + NVME_REG_CSTS);
>>> @@ -2041,6 +2062,9 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
>>>
>>>   	for (i = dev->queue_count - 1; i >= 0; i--)
>>>   		nvme_clear_queue(dev->queues[i]);
>>> +
>>> +	clear_bit(NVME_CTRL_SHUTDOWN, &dev->flags);
>>> +	wake_up_all(&dev->shutdown_wait);
>>>   }
>>
>> I don't like this. You're essentially protecting the code here, not
>> the data structure. There must be a cleaner way to solve this.
>
> Sure, I'm all for a better solution. We just need to prevent two threads
> from hitting the same controller registers, and return when queues are
> cleared. Is there a better way to control this?
>
> The driver's queue structures are already protected, but the existing
> implementation allows one thread to pass the first that's waiting for
> orderly queue deletion.

Just use a mutex? Check shutdown state after having held the lock, exit 
if we don't need to do anything.

-- 
Jens Axboe
