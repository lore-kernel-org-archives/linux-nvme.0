From: hch@lst.de (Christoph Hellwig)
Date: Fri, 23 Oct 2015 07:57:15 +0200
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <20151022203650.GF21840@localhost.localdomain>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-9-git-send-email-hch@lst.de>
 <20151022181014.GE21840@localhost.localdomain>
 <20151022181240.GA22482@lst.de>
 <20151022203650.GF21840@localhost.localdomain>
Message-ID: <20151023055715.GC30808@lst.de>

On Thu, Oct 22, 2015@08:36:50PM +0000, Busch, Keith wrote:
> On Thu, Oct 22, 2015@08:12:40PM +0200, Christoph Hellwig wrote:
> > Oops - I'm queing it both on the system workqueue and nvme_workq, which
> > is clearly broken.  I'll fix it in the next resend.
> 
> Ha, let's just get rid of nvme_workq.

I thought about this a bit and I'm not sure it's the right thing -
as we reset controllers as part of error handling we'd really need a
WQ_MEM_RECLAIM workqueue here to be guranteed to make progress.  Although
hopefully not a single threaded one.

> I've got that plus a couple other fixups below. I noticed that earlier
> in the recent changes (18/18 from the previous series) we lost the
> "device_remove_file()" on the reset controller attribute.

Indeed.  For some reason I assumed we don't need the device_remove_file
when dropping the device and it didn't complain in my testing either.

> We also don't
> want to leave the nvme management handle available when we're trying to
> release it, so we need to delete the sysfs and char dev immediately on
> removal instead of after all references are released.
> 
> This fixes a WARN in fs/sysfs/group.c line 222.

I guess we need to sort out this life time model in more detail later
as the existing one you restored here looks a bit odd to me.  Nothing
I'll be able to finish this week, though.

> Here's all my "fixes", also pushed to my linux-nvme master:

Thanks.  So what's the plan for the patches in it?  They'll clash a bit
with the PR API and integrity branches due to all the moves.  But those
are also the reason why I'd really like to see it go into 4.4.  Do you
need help with a rebase?
