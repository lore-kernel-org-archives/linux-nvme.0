From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 17 Jul 2018 08:32:50 -0600
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <6833a684-3040-3532-a738-6556bedf6e10@oracle.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
 <20180716110903.GC25386@ming.t460p>
 <20180716133640.GC19967@localhost.localdomain>
 <20180717012301.GB22593@ming.t460p>
 <bfd4154b-a8e0-8688-8b77-40a8041418e3@oracle.com>
 <20180717072136.GB26324@ming.t460p>
 <6833a684-3040-3532-a738-6556bedf6e10@oracle.com>
Message-ID: <20180717143250.GC26925@localhost.localdomain>

On Tue, Jul 17, 2018@03:28:33PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 07/17/2018 03:21 PM, Ming Lei wrote:
> > nvme_start_freeze() is just for stopping new IO.
> > 
> > However, if you want to drain IO, new IO may have to be prevented from
> > being entering queue first, then that is nvme_start_freeze() + nvme_wait_freeze().
> 
> Yes, I mean, after we invoke blk_mq_freeze_queue_start, we have to invoke blk_mq_freeze_queue_wait
> to drain the q->q_usage_counter, then invoke blk_mq_unfreeze_queue.
> 
> But in fact, in this scenario, we just need to stop new IO coming in, no need to drain the IO.
> So I say, we may need a interface which just stop new IO coming in, but no need to drain IO before
> allow new IO.

I think what you are asking for is a way to unfreeze a queue that that
doesn't have a zero ref count, but I think that breaks the percpu_ref.
