From: keith.busch@intel.com (Keith Busch)
Date: Wed, 31 May 2017 12:17:56 -0400
Subject: [PATCH V2 1/1] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <29f66b96-0629-177a-be54-dbd638bf0f49@grimberg.me>
References: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
 <20170526100613.GE24894@localhost.localdomain>
 <29f66b96-0629-177a-be54-dbd638bf0f49@grimberg.me>
Message-ID: <20170531161756.GD2845@localhost.localdomain>

On Tue, May 30, 2017@02:58:06PM +0300, Sagi Grimberg wrote:
> > So, the reason the state is changed when the work is running rather than
> > queueing is for the window when the state may be set to NVME_CTRL_DELETING,
> > and we don't want the reset work to proceed in that case.
> > 
> > What do you think about adding a new state, like NVME_CTRL_SCHED_RESET,
> > then leaving the NVME_CTRL_RESETTING state change as-is?
> 
> OK, just got to this one.
> 
> Instead of adding yet another state, how about making controller delete
> cancel the reset_work (cancel_work_sync)?

Yes, that should also work.
