From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 31 Mar 2015 10:38:58 -0600
Subject: [PATCH] NVMe: Fix blk-mq hot cpu notification
In-Reply-To: <1427485372-2784-1-git-send-email-keith.busch@intel.com>
References: <1427485372-2784-1-git-send-email-keith.busch@intel.com>
Message-ID: <551ACDA2.9010006@kernel.dk>

On 03/27/2015 01:42 PM, Keith Busch wrote:
> The driver may issue commands to a device that may never return, so its
> request_queue could always have active requests while the controller is
> running. Waiting for the queue to freeze could block forever, which is
> what blk-mq's hot cpu notification handler was doing when nvme drives
> were in use.
>
> This has the nvme driver make the asynchronous event command's tag
> reserved and does not keep the request active. We can't have more than
> one since the request is released back to the request_queue before the
> command is completed. Having only one avoids potential tag collisions,
> and reserving the tag for this purpose prevents other admin tasks from
> reusing the tag.
>
> I also couldn't think of a scenario where issuing AEN requests single
> depth is worse than issuing them in batches, so I don't think we lose
> anything with this change.
>
> As an added bonus, doing it this way removes "Cancelling I/O" warnings
> observed when unbinding the nvme driver from a device.

Nice change, much better to handle it like a reserved tag. Applied for 4.1.

-- 
Jens Axboe
