From: hch@lst.de (Christoph Hellwig)
Date: Sat, 15 Jul 2017 10:42:18 +0200
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <20170714151624.GA24157@localhost.localdomain>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
 <20170713212955.GD14716@localhost.localdomain>
 <20170714125309.GA26975@lst.de>
 <20170714151624.GA24157@localhost.localdomain>
Message-ID: <20170715084218.GA23189@lst.de>

On Fri, Jul 14, 2017@11:16:25AM -0400, Keith Busch wrote:
> On Fri, Jul 14, 2017@02:53:09PM +0200, Christoph Hellwig wrote:
> > 
> > Someone has to clear the log page after and AER, and if both the
> > kernel and the user tool do so we risk that the user tool clears
> > the next AER due to a race condition.
> 
> Sorry, bare with me a moment. I may be missing something obvious, as I'm
> not seeing a problem. Reading the event's associated log only rearms
> the AER for that event type. Even if the user tool reads the same log
> as the driver, that doesn't stop the driver from seeing the next AER
> completion and handle it the same as if user space wasn't there.

Take the Changed Namespace List log page for example.

We get an AER, and then both schedule a log page read in the kernel
(as we should, patch pending) and send the uevent.  As soon as the
read the log page in the kernel to clear the log page we get another
event due to another namespace change, but not userspace manages to
read the log page before the kernel acts on the next AER, so the
kernel won't see the changes.

And yes, this is probably a little constructed, but we'll get more
log pages with similar semantics, so I am worried a bit about this.
