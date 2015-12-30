From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 10:14:33 -0800
Subject: [PATCH 4/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <20151230180254.GA12454@localhost.localdomain>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-5-git-send-email-keith.busch@intel.com>
 <20151230175829.GE21400@infradead.org>
 <20151230180254.GA12454@localhost.localdomain>
Message-ID: <20151230181433.GB27087@infradead.org>

On Wed, Dec 30, 2015@06:02:54PM +0000, Keith Busch wrote:
> My bad. I applied the patches in the wrong order when generating the
> series. Need to swap 4/5 with 5/5.
>  
> > > +	if (disable_ctrl)
> > > +		nvme_disable_ctrl(&dev->ctrl,
> > > +			lo_hi_readq(dev->bar + NVME_REG_CAP));
> > 
> > Why can't this be done outside this function, similar to the
> > shutdown case?
> 
> I thought it made sense to do it inline with disabling the admin queue
> since there's no command to delete it. A controller disable is the only
> way, and there's no need to disable it if it was shutdown prior.

Well, the only place ever setting disable_ctrl is nvme_dev_disable,
which will call nvme_shutdown_ctrl if it doesn't set disable.

Having the whole controller state manipulation in nvme_dev_disable
with a neat if / else and outside a function that claims to only
operate on the admin queue would seem sensible to me.  The only
thing I wondered about is if disable vs shutdown had different
interactions with the nvme_suspend_queue call, but I couldn't think
of any.
