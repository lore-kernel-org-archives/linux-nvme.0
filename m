From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 May 2017 06:06:14 -0400
Subject: [PATCH V2 1/1] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
References: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
Message-ID: <20170526100613.GE24894@localhost.localdomain>

On Wed, May 24, 2017@05:26:25PM +0300, Rakesh Pandit wrote:
> Commit c5f6ce97c1210 tries to address multiple resets but fails as
> work_busy doesn't involve any synchronization and can fail.  This is
> reproducible easily as can be seen by WARNING below which is triggered
> with line:
> 
> WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)
> 
> Allowing multiple resets can result in multiple controller removal as
> well if different conditions inside nvme_reset_work fail and which
> might deadlock on device_release_driver.
> 
> This patch makes sure that work queue item (reset_work) is added only
> if controller state != NVME_CTRL_RESETTING and that is achieved by
> moving state change outside nvme_reset_work into nvme_reset and
> removing old work_busy call.  State change is always synchronizated
> using controller spinlock.

So, the reason the state is changed when the work is running rather than
queueing is for the window when the state may be set to NVME_CTRL_DELETING,
and we don't want the reset work to proceed in that case.

What do you think about adding a new state, like NVME_CTRL_SCHED_RESET,
then leaving the NVME_CTRL_RESETTING state change as-is?
