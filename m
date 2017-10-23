From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Oct 2017 09:01:33 -0600
Subject: [PATCHv2 5/5] nvme: Send uevent for unhandled AEN completions
In-Reply-To: <20171021080906.GE20906@lst.de>
References: <20171020223746.31287-1-keith.busch@intel.com>
 <20171021080906.GE20906@lst.de>
Message-ID: <20171023150133.GD30713@localhost.localdomain>

On Sat, Oct 21, 2017@10:09:06AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 20, 2017@04:37:46PM -0600, Keith Busch wrote:
> > This will give udev a chance to handle asynchronous event notification
> > and clear the log to unmask future events of the same type. Since the
> > core driver allows only one AEN request at a time, we can only have one
> > possible oustanding uevent to send.
> 
> I don't want to encode that in the userspace ABI.  With all kinds of
> new AEN uses coming up we might as well want to go for multiple AERs
> in the future.

Okay, that's certainly possible to do. The motivation for just one active
AEN was just to avoid having a second method for tracking outstanding
command tags.

> > This implementation saves the last
> > AEN result from the IRQ handler, and sends the uevent change notification
> > when the AEN work is rescheduled.
> > 
> > AEN events that the kernel handles directly will not create a uevent. Such
> > events will stop being sent to the user as new handlers are added to
> > the kernel.
> 
> I think we need an explicit whitelist of the ones we want to expose
> to userspace.  Otherwise we'll get all kinds of complaints later
> that we'd take something away and break the ABI.

Oh, I was thinking of this differently. The ABI proposed here is saying
all unhandled events are sent to the user, and the kernel has the right
to handle these in the future as the need arises; user space can't
depend on seeing an event if the kernel should handle it, but it gets to
know about all events the kernel didn't handle.

While this changes user visible events when new driver handling is
added, this is forward compatible with new events that aren't defined
yet.

I'm not particularly concerned about it either way. I just thought it
was easier treating the kernel handling as a blacklist to suppress
notification rather than have a whitelist.
