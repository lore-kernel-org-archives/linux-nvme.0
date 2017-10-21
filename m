From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Oct 2017 10:09:06 +0200
Subject: [PATCHv2 5/5] nvme: Send uevent for unhandled AEN completions
In-Reply-To: <20171020223746.31287-1-keith.busch@intel.com>
References: <20171020223746.31287-1-keith.busch@intel.com>
Message-ID: <20171021080906.GE20906@lst.de>

On Fri, Oct 20, 2017@04:37:46PM -0600, Keith Busch wrote:
> This will give udev a chance to handle asynchronous event notification
> and clear the log to unmask future events of the same type. Since the
> core driver allows only one AEN request at a time, we can only have one
> possible oustanding uevent to send.

I don't want to encode that in the userspace ABI.  With all kinds of
new AEN uses coming up we might as well want to go for multiple AERs
in the future.

> This implementation saves the last
> AEN result from the IRQ handler, and sends the uevent change notification
> when the AEN work is rescheduled.
> 
> AEN events that the kernel handles directly will not create a uevent. Such
> events will stop being sent to the user as new handlers are added to
> the kernel.

I think we need an explicit whitelist of the ones we want to expose
to userspace.  Otherwise we'll get all kinds of complaints later
that we'd take something away and break the ABI.
