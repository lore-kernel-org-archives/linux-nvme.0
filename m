From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 21 Feb 2017 23:55:10 +0200
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170217163328.GC18275@localhost.localdomain>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
Message-ID: <2e1c1ca8-1272-5bc1-2b9c-551c872e8dea@grimberg.me>


>>> +
>>> +	/*
>>> +	 * If shutting down, the driver will not be starting up queues again,
>>> +	 * so must drain all entered requests to their demise to avoid
>>> +	 * deadlocking blk-mq hot-cpu notifier.
>>> +	 */
>>> +	if (drain_queue && shutdown) {
>>> +		nvme_start_queues(&dev->ctrl);
>>> +		/*
>>> +		 * Waiting for frozen increases the freeze depth. Since we
>>> +		 * already start the freeze earlier in this function to stop
>>> +		 * incoming requests, we have to unfreeze after froze to get
>>> +		 * the depth back to the desired.
>>> +		 */
>>> +		nvme_wait_freeze(&dev->ctrl);
>>> +		nvme_unfreeze(&dev->ctrl);
>>> +		nvme_stop_queues(&dev->ctrl);
>>
>> And all this (just like the start_free + quience sequence above)
>> really sounds like something we'd need to move to the core.
>
> Maybe. I'm okay with moving it to the core and document the intended
> usage, but the sequence inbetween initiating the freeze and waiting for
> frozen is specific to the driver, as well as knowing when it needs to
> be done. The above could be moved to core, but it only makes sense to
> call it only if the request to start the freeze was done prior to
> reclaiming controller owned IO.

What if we pass a flag to blk_mq_quiesce_queue to indicate that we want
it to flush (and freeze) all entered requests?
