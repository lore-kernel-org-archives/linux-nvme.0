From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 11:50:15 +0200
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <1486768553-13738-6-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
Message-ID: <c42e8e1e-f96f-9b2d-f3e6-72599430a327@grimberg.me>


> If the nvme driver is shutting down, it will not start the queues back
> up until asked to resume. If the block layer has entered requests and
> gets a CPU hot plug event prior to the resume event, it will wait for
> those requests to exit. Those requests will never exit since the NVMe
> driver is quieced, creating a deadlock.
>
> This patch fixes that by freezing the queue and flushing all entered
> requests to either their natural completion, or forces their demise. We
> only need to do this when requesting to shutdown the controller since
> we will not be starting the IO queues back up again.

How is this is something specific to nvme? What prevents this
for other multi-queue devices that shutdown during live IO?

Can you please describe the race in specific? Is it stuck on
nvme_ns_remove (blk_cleanup_queue)? If so, then I think we
might want to fix blk_cleanup_queue to start/drain/wait
instead?

I think it's acceptable to have drivers make their own use
of freeze_start and freeze_wait, but if this is not
nvme specific perhaps we want to move it to block instead?
