From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 Feb 2016 00:06:01 -0800
Subject: [PATCHv2-4.5 08/10] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <20160216215746.GB8415@localhost.localdomain>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <1455221147-24228-9-git-send-email-keith.busch@intel.com>
 <20160213094634.GB15318@infradead.org>
 <20160216215746.GB8415@localhost.localdomain>
Message-ID: <20160217080601.GB14303@infradead.org>

On Tue, Feb 16, 2016@09:57:47PM +0000, Keith Busch wrote:
> > 
> > Why do we have a separate function for this instead of driving this
> > from nvme_remove_namespaces?
> 
> nvme_remove_namespaces attempts to remove namespaces assuming the
> controller is still functional. For example, user pushed the "Attention"
> removal button and waits for the acknowledgement.

But we'll always call it before removing a controller anyway.

> This new API assumes the controller is not functional and never will be.
> 
> If your question is why nvme_remove_namespaces doesn't handle both cases,
> it's because the controller could break/link-down only after calling
> del_gendisk, at which point its too late for the driver to kill the
> queue in that path.

My idea was more to have a kill flag for nvme_remove_namespaces given
that we basically always follow up with a nvme_remove_namespaces when
calling nvme_kill_ns_queues.  But looking at the code this might
actually end up more convoluted, so I'll take my comment back.
