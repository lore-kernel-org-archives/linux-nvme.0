From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 13:43:38 +0200
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible
 sleep for ever
In-Reply-To: <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
Message-ID: <20170601114338.GA24855@lst.de>

On Tue, May 30, 2017@05:23:46PM +0300, Rakesh Pandit wrote:
> We can fix user-space triggered set_features higger up e.g. in
> nvme_ioctl by putting same check.  Introduction of a separate state
> NVME_CTRL_SCHED_RESET (being discussed in another thread) has
> additional advantage of making sure that only one thread is going
> through resetting and eventually through removal (if required) and
> solves lot of problems.

I think we need the NVME_CTRL_SCHED_RESET state.  In fact I'm pretty
sure some time in the past I already had it in a local tree as a
generalization of rdma and loop already use NVME_CTRL_RESETTING
(they set it before queueing the reset work).

But I don't fully understand how the NVME_CTRL_SCHED_RESET fix is
related to this patch?
