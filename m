From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 28 Jan 2016 16:48:16 +0200
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <20160127141931.GA19346@localhost.localdomain>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <56A8AE61.6070100@dev.mellanox.co.il>
 <20160127141931.GA19346@localhost.localdomain>
Message-ID: <56AA2A30.2040304@dev.mellanox.co.il>


>>>   		blk_mq_abort_requeue_list(ns->queue);
>>> +		__nvme_start_queue_locked(ns);
>>
>> Why not making sure that all the pending requests are moved to
>> the requeue list before we even get here? call nvme_cancel_io on
>> pending requests which would either fail the requests (blk_queue_dying)
>> or move them to the requeue list?
>
> That works only for active requests. There could be processes that entered
> the queue and waiting for request tags to become available. These need
> to be flushed to completion somehow ... maybe they shouldn't even succeed
> in getting a request on a dying queue?

Isn't that what blk_mq_wake_waiters() is for?
