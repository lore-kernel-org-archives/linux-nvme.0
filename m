From: keith.busch@intel.com (Keith Busch)
Date: Tue, 16 Feb 2016 21:57:47 +0000
Subject: [PATCHv2-4.5 08/10] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <20160213094634.GB15318@infradead.org>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <1455221147-24228-9-git-send-email-keith.busch@intel.com>
 <20160213094634.GB15318@infradead.org>
Message-ID: <20160216215746.GB8415@localhost.localdomain>

On Sat, Feb 13, 2016@01:46:34AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 11, 2016@01:05:45PM -0700, Keith Busch wrote:
> > +/**
> > + * nvme_kill_ns_queues(): Ends all namespace queues
> > + * @ctrl: the dead controller that needs to end
> > + *
> > + * Call this function when the driver determines it is unable to get the
> > + * controller in a state capable of servicing IO.
> > + */
> > +void nvme_kill_ns_queues(struct nvme_ctrl *ctrl)
> 
> Why do we have a separate function for this instead of driving this
> from nvme_remove_namespaces?

nvme_remove_namespaces attempts to remove namespaces assuming the
controller is still functional. For example, user pushed the "Attention"
removal button and waits for the acknowledgement.

This new API assumes the controller is not functional and never will be.

If your question is why nvme_remove_namespaces doesn't handle both cases,
it's because the controller could break/link-down only after calling
del_gendisk, at which point its too late for the driver to kill the
queue in that path.
