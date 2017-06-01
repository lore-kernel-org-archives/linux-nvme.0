From: rakesh@tuxera.com (Rakesh Pandit)
Date: Thu, 1 Jun 2017 15:36:50 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170601122818.GA18830@dhcp-216.srv.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
 <20170601122818.GA18830@dhcp-216.srv.tuxera.com>
Message-ID: <20170601123650.GA18883@dhcp-216.srv.tuxera.com>

On Thu, Jun 01, 2017@03:28:18PM +0300, Rakesh Pandit wrote:
> On Thu, Jun 01, 2017@01:43:38PM +0200, Christoph Hellwig wrote:
> > On Tue, May 30, 2017@05:23:46PM +0300, Rakesh Pandit wrote:
> > > We can fix user-space triggered set_features higger up e.g. in
> > > nvme_ioctl by putting same check.  Introduction of a separate state
> > > NVME_CTRL_SCHED_RESET (being discussed in another thread) has
> > > additional advantage of making sure that only one thread is going
> > > through resetting and eventually through removal (if required) and
> > > solves lot of problems.
> > 
> > I think we need the NVME_CTRL_SCHED_RESET state.  In fact I'm pretty
> > sure some time in the past I already had it in a local tree as a
> > generalization of rdma and loop already use NVME_CTRL_RESETTING
> > (they set it before queueing the reset work).
> >
> > But I don't fully understand how the NVME_CTRL_SCHED_RESET fix is
> > related to this patch?
> 
> They aren't related.  Sorry for confusion.  I intended to answer
> another thread but instead wrote it here.
> 

Also Sagi pointed out that user space set_features ioctl if fired up
in a window after nvme_removal it can also result in this issue seems
to be correct.  I would prefer to keep this as it is and introduce
similar check higher up in nvme_ioctrl instead so that we don't send
sync commands if queues are killed already.

Would you prefer a patch ? Thanks,
