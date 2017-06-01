From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 14:35:13 +0200
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible
 sleep for ever
In-Reply-To: <20170601122818.GA18830@dhcp-216.srv.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
 <20170601122818.GA18830@dhcp-216.srv.tuxera.com>
Message-ID: <20170601123513.GA28067@lst.de>

On Thu, Jun 01, 2017@03:28:18PM +0300, Rakesh Pandit wrote:
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

Ok, thanks.  But I think the Point from Sagi that we should move
the state check all the way down to submit_sync_command still makes
sense to me.
