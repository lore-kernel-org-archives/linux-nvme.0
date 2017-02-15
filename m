From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 Feb 2017 10:46:49 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <c42e8e1e-f96f-9b2d-f3e6-72599430a327@grimberg.me>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <c42e8e1e-f96f-9b2d-f3e6-72599430a327@grimberg.me>
Message-ID: <20170215154649.GA30251@localhost.localdomain>

On Wed, Feb 15, 2017@11:50:15AM +0200, Sagi Grimberg wrote:
> How is this is something specific to nvme? What prevents this
> for other multi-queue devices that shutdown during live IO?
> 
> Can you please describe the race in specific? Is it stuck on
> nvme_ns_remove (blk_cleanup_queue)? If so, then I think we
> might want to fix blk_cleanup_queue to start/drain/wait
> instead?
> 
> I think it's acceptable to have drivers make their own use
> of freeze_start and freeze_wait, but if this is not
> nvme specific perhaps we want to move it to block instead?

There are many sequences that can get a request queue stuck forever, but
the one that was initially raised is on a system suspend. It could look
something like this:

  CPU A                       CPU B
  -----                       -----
  nvme_suspend
   nvme_dev_disable           generic_make_request
    nvme_stop_queues           blk_queue_enter
     blk_queue_quiesce_queue    blk_mq_alloc_request
                                 blk_mq_map_request
                                  blk_mq_enter_live
                                 blk_mq_run_hw_queue <-- the hctx is stopped,
                                                         request is stuck until
                                                         restarted.

Shortly later, suspend takes a CPU offline:

 blk_mq_queue_reinit_dead
  blk_mq_queue_reinit_work
   blk_mq_free_queue_wait

Now we're stuck forever waiting for that queue to freeze because a request
entered a stopped hctx that we're not going to bring back online. The
driver was told to suspend, and suspend must complete before resume
can start.

The problem is not specific to pci nvme, but control needs to pass back to
the device specific driver: after halting new queue entering by starting
the queue freeze, the driver needs a chance to complete everything that
was submitted. Only after the driver finishes its specific clean up tasks,
it can flush all the entered requests to a failed completion.
