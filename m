From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Tue, 9 Dec 2014 22:08:57 +0000
Subject: [PATCH] NVMe: Re-introduce nvmeq->q_suspended
In-Reply-To: <546FE2C4.5060905@kernel.dk>
References: <546FD7A2.2070305@micron.com>
 <alpine.LNX.2.00.1411220053400.4225@localhost.lm.intel.com>
 <546FE2C4.5060905@kernel.dk>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945FEA69@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Jens Axboe [mailto:axboe at kernel.dk]
> Sent: Friday, November 21, 2014 5:12 PM
> To: Keith Busch; Sam Bradshaw (sbradshaw)
> Cc: linux-nvme at lists.infradead.org; m at bjorling.me
> Subject: Re: [PATCH] NVMe: Re-introduce nvmeq->q_suspended
> 
> On 11/21/2014 06:07 PM, Keith Busch wrote:
> > On Fri, 21 Nov 2014, Sam Bradshaw wrote:
> >> At some point in the blk-mq transition, q_suspended was removed.
> >> This patch adds it back to address two failure modes, both
> >> illustrated in the attached snippet.  First, it protects the ioctl
> >> path from inadvertently dereferencing invalid nvme_queue data
> >> structures during device shutdown/reset.  Second, it protects
> against
> >> a double
> >> free_irq() if the shutdown/reset/resume sequence doesn't recover a
> >> flaky controller.
> >
> > I could have sworn there was a better way to suspend at the
> > request_queue level with blk-mq so we don't need this in the driver.
> > The blk_start/stop_queue is close, but doesn't work in the ioctl path.
> > Maybe I'm thinking blk-mq freeze, but that's not exported for drivers.
> 
> The freeze stuff should work. I've got a prelim patch that allows
> attach/detach of the namespace/block parts, the first prep patch is
> exporting the freeze bits.

Would it be possible either to incorporate my patch or your patch exporting freeze bits so I could build similar functionality on top of it?  I'm not able to test any interesting hot plug cases with the current state of the nvme driver in for-3.19/drivers.
