From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 15:46:09 +0200
Subject: [PATCHv2 2/2] nvme: Complete all stuck requests
In-Reply-To: <1487896561-10454-2-git-send-email-keith.busch@intel.com>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
Message-ID: <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>



On 24/02/17 02:36, Keith Busch wrote:
> If the block layer has entered requests and gets a CPU hot plug event
> prior to the resume event, it will wait for those requests to exit. If
> the nvme driver is shutting down, it will not start the queues back up,
> preventing forward progress.
>
> To fix that, this patch freezes the request queues when the driver intends
> to shut down the controller so that no new requests may enter.  After the
> controller has been disabled, the queues will be restarted to force all
> entered requests to end in failure so that blk-mq's hot cpu notifier may
> progress. To ensure the queue usage count is 0 on a shutdown, the driver
> waits for freeze to complete before completing the controller shutdown.

Keith, can you explain (again) for me why is the freeze_wait must happen
after the controller has been disabled, instead of starting the queues
and waiting right after freeze start?
