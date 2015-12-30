From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 18:02:54 +0000
Subject: [PATCH 4/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <20151230175829.GE21400@infradead.org>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-5-git-send-email-keith.busch@intel.com>
 <20151230175829.GE21400@infradead.org>
Message-ID: <20151230180254.GA12454@localhost.localdomain>

On Wed, Dec 30, 2015@09:58:29AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 30, 2015@10:27:50AM -0700, Keith Busch wrote:
> > We don't need to shutdown a controller for a reset. A controller in a
> > shutdown state may take longer to become ready than one that was simply
> > disabled. This patch has the driver shut down a controller only if the
> > device is about to be powered off or being removed. When the taking
> > the controller down for a reset reason, the controller will be disabled
> > instead.
> > 
> > Function names have been updated in this patch to reflect their changed
> > semantics.
> 
> Am I missing something?  What happens to the calls to nvme_disable_queue
> in nvme_disable_io_queues and nvme_wait_dq?

My bad. I applied the patches in the wrong order when generating the
series. Need to swap 4/5 with 5/5.
 
> > +	if (disable_ctrl)
> > +		nvme_disable_ctrl(&dev->ctrl,
> > +			lo_hi_readq(dev->bar + NVME_REG_CAP));
> 
> Why can't this be done outside this function, similar to the
> shutdown case?

I thought it made sense to do it inline with disabling the admin queue
since there's no command to delete it. A controller disable is the only
way, and there's no need to disable it if it was shutdown prior.
