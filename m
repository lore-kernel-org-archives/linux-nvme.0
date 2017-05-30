From: rakesh@tuxera.com (Rakesh Pandit)
Date: Tue, 30 May 2017 10:18:50 +0300
Subject: [PATCH 1/1] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170529175839.GC25061@lst.de>
References: <20170529062952.GA6717@hercules.tuxera.com>
 <20170529175839.GC25061@lst.de>
Message-ID: <20170530071850.GA2713@hercules.tuxera.com>

On Mon, May 29, 2017@07:58:39PM +0200, Christoph Hellwig wrote:
> On Mon, May 29, 2017@09:29:54AM +0300, Rakesh Pandit wrote:
> > Once controller is in DEAD or DELETING state a call to delete_destroy
> > from nvme_uninit_ctrl results in setting the latency tolerance via
> > nvme_set_latency_tolerance callback even though queues have already
> > been killed.  This in turn leads the PID to go into uninterruptible
> > sleep and prevents removal of nvme controller from completion.  The
> > stack trace is:
...
> 
> What do you think about moving this into the beginning of
> nvme_configure_apst instead?  And please add a comment while you're
> at it.

Thanks, makes sense.  I have posted V2.
