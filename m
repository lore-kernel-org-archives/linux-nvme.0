From: rakesh@tuxera.com (Rakesh Pandit)
Date: Tue, 30 May 2017 17:23:46 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
Message-ID: <20170530142346.GA39428@dhcp-216.srv.tuxera.com>

On Tue, May 30, 2017@01:18:55PM +0300, Sagi Grimberg wrote:
> 
> >  	/*
> > +	 * Avoid configuration and syncing commands if controller is already
> > +	 * being removed and queues have been killed.
> > +	 */
> > +	if (ctrl->state == NVME_CTRL_DELETING || ctrl->state == NVME_CTRL_DEAD)
> > +		return;
> > +
> 
> Hey Rakesh, Christoph,
> 
> Given that the issue is for sync command submission during controller
> removal, I'm wandering if we should perhaps move this check to
> __nvme_submit_sync_cmd?
> 
> AFAICT user-space can just as easily trigger set_features in the same
> condition which will trigger the hang couldn't it?


Seems possible.  But it seems worth keeping this check as it avoids
the instructions between start of nvme_configure_apst and
__nvme_submit_sync_cmd.  This check seems to solve more severe hang as
PID which started off from nvme_remove eventually hangs itself on
blk_execute_rq..

We can fix user-space triggered set_features higger up e.g. in
nvme_ioctl by putting same check.  Introduction of a separate state
NVME_CTRL_SCHED_RESET (being discussed in another thread) has
additional advantage of making sure that only one thread is going
through resetting and eventually through removal (if required) and
solves lot of problems.

It makes sense to push this separately because of above reasons and we
can fix user space trigger of deadlock once discussion on another
thread has moved forward on introducing of new state.
