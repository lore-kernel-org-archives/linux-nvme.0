From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 16 Feb 2017 15:23:39 -0500
Subject: hch's native NVMe multipathing [was: Re: [PATCH 1/2] Don't
 blacklist nvme]
In-Reply-To: <1487274356.2612.5.camel@sandisk.com>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org>
 <20170216025357.GA9241@redhat.com>
 <d1f39bbd-d5fe-06d7-34a7-484b723886c9@sandisk.com>
 <20170216123702.GA12047@redhat.com>
 <1487274356.2612.5.camel@sandisk.com>
Message-ID: <20170216202339.GB13742@redhat.com>

On Thu, Feb 16 2017 at  2:46pm -0500,
Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:

> On Thu, 2017-02-16@07:37 -0500, Mike Snitzer wrote:
> > Weird.  I did push back on those changes initially (just felt like
> > churn) but I ultimately did take them:
> > 
> > $ git log --oneline --author=bart drivers/md/dm-mpath.c
> > 6599c84 dm mpath: do not modify *__clone if blk_mq_alloc_request() fails
> > 4813577 dm mpath: change return type of pg_init_all_paths() from int to void
> > 9f4c3f8 dm: convert wait loops to use autoremove_wake_function()
> > 
> > Did I miss any?
> 
> Hello Mike,
> 
> Thank you for having accepted these patches. However, I was not referring
> to these patches but to the eight patches available at
> https://github.com/bvanassche/linux/tree/dm-mpath

Some of these look familiar (the dm-mpath micro-optimize one made me
cringe.. potential for regression, etc.  But careful review should ease
those concerns).  But yeah, these certainly slipped through the cracks.
I'll review these for 4.12 (too late for 4.11, sorry)

Please rebase these ontop of linux-block.git's for-4.11/rq-refactor
because Christoph significantly reworked the request-based DM code (all
request allocation is done in DM multipath now), see:
http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.11/rq-refactor&id=eb8db831be80692bf4bda3dfc55001daf64ec299

Or you can wait to rebase on v4.11-rc1 in ~2 weeks.

Thanks
