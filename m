From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 May 2018 09:30:38 -0600
Subject: [PATCH 1/2] nvme: pci: simplify timeout handling
In-Reply-To: <20180428035015.GB5657@ming.t460p>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
Message-ID: <20180508153038.GA30842@localhost.localdomain>

On Sat, Apr 28, 2018@11:50:17AM +0800, Ming Lei wrote:
> This sync may be raced with one timed-out request, which may be handled
> as BLK_EH_HANDLED or BLK_EH_RESET_TIMER, so the above sync queues can't
> work reliably. 

Ming,

As proposed, that scenario is impossible to encounter. Resetting the
controller inline with the timeout reaps all the commands, and then
sets the controller state to RESETTING. While blk-mq may not allow the
driver to complete those requests, having the driver sync with the queues
will hold the controller in the reset state until blk-mq is done with
its timeout work; therefore, it is impossible for the NVMe driver to
return "BLK_EH_RESET_TIMER", and all commands will be completed through
nvme_timeout's BLK_EH_HANDLED exactly as desired.

Could you please recheck my suggestion? The alternatives proposed are
far too risky for a 4.17 consideration, and I'm hoping we can stabilize
this behavior in the current release if possible.

Thanks,
Keith
