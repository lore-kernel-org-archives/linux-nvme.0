From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 May 2017 11:37:55 +0200
Subject: [PATCH 1/2] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170523221545.GA23946@dhcp-216.srv.tuxera.com>
References: <20170523221545.GA23946@dhcp-216.srv.tuxera.com>
Message-ID: <20170524093755.GA17483@lst.de>

On Wed, May 24, 2017@01:15:47AM +0300, Rakesh Pandit wrote:
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
> This patch addresses the problem by using state of controller to
> decide whether reset should be queued or not as state change is
> synchronizated using controller spinlock.

But we don't hold the lock over the check and the decision.  I suspect
what we need to do is to actually change to the resetting state
before queueing up the reset work.  Can you give that a spin?
