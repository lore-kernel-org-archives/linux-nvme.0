From: rakesh@tuxera.com (Rakesh Pandit)
Date: Mon, 5 Jun 2017 13:52:17 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep
 for ever
In-Reply-To: <20170605081817.GA22122@lst.de>
References: <20170530071610.GA2679@hercules.tuxera.com>
 <4da7c939-1f54-80e5-48fc-06e58e14f018@grimberg.me>
 <20170530142346.GA39428@dhcp-216.srv.tuxera.com>
 <20170601114338.GA24855@lst.de>
 <bb2780a8-63af-4d58-6c78-b03152de0439@grimberg.me>
 <20170605081817.GA22122@lst.de>
Message-ID: <20170605105217.GA31313@dhcp-216.srv.tuxera.com>

On Mon, Jun 05, 2017@10:18:17AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 04, 2017@06:28:15PM +0300, Sagi Grimberg wrote:
> >
> >> I think we need the NVME_CTRL_SCHED_RESET state.  In fact I'm pretty
> >> sure some time in the past I already had it in a local tree as a
> >> generalization of rdma and loop already use NVME_CTRL_RESETTING
> >> (they set it before queueing the reset work).
> >
> > I don't remember having it, but I might be wrong...
> >
> > Can you explain again why you think we need it? Sorry for being
> > difficult, but I'm not exactly sure why it makes things better
> > or simpler.
> 
> Motly that we can treat a controller as under reset before scheduling
> the reset work, both to prevent multiple schedules, and to make
> checks like the one in nvme_should_reset robus.
> 
> But I think something along the lines of the earlier patch from
> Rakesh that just sets the RESETTING state earlier + the cancel_work_sync
> suggested by you should also work for that purpose.  So maybe that's
> the way to go after all.

I would post a new patch which includes my RESETTING state earlier
patch + the cancel_work_sync which Sagi suggested after testing.

Sagi: Because my RESETTING patch earlier is subset of your untested
patch with cancel_work_sync, it would be logical to take a signed off
from you as well.  May you review/ack/nack the patch?  Feel free to
let me know if you want me to change it further or instead you want to
post as author.

I am okay with either as long as we fix the issue.
