From: keith.busch@intel.com (Keith Busch)
Date: Mon, 17 Jul 2017 11:22:32 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <20170715084218.GA23189@lst.de>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
 <20170713212955.GD14716@localhost.localdomain>
 <20170714125309.GA26975@lst.de>
 <20170714151624.GA24157@localhost.localdomain>
 <20170715084218.GA23189@lst.de>
Message-ID: <20170717152232.GC24365@localhost.localdomain>

On Sat, Jul 15, 2017@10:42:18AM +0200, Christoph Hellwig wrote:
> 
> Take the Changed Namespace List log page for example.
> 
> We get an AER, and then both schedule a log page read in the kernel
> (as we should, patch pending) and send the uevent.  As soon as the
> read the log page in the kernel to clear the log page we get another
> event due to another namespace change, but not userspace manages to
> read the log page before the kernel acts on the next AER, so the
> kernel won't see the changes.
> 
> And yes, this is probably a little constructed, but we'll get more
> log pages with similar semantics, so I am worried a bit about this.

That event needs to already be handled by the driver without relying
on the Changed Namespace List log, like when the list exceeds the log
size. But okay, I see the concern in general if reading a log page may
change the results.
