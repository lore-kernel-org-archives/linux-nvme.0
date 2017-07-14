From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Jul 2017 11:16:25 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <20170714125309.GA26975@lst.de>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
 <20170713212955.GD14716@localhost.localdomain>
 <20170714125309.GA26975@lst.de>
Message-ID: <20170714151624.GA24157@localhost.localdomain>

On Fri, Jul 14, 2017@02:53:09PM +0200, Christoph Hellwig wrote:
> 
> Someone has to clear the log page after and AER, and if both the
> kernel and the user tool do so we risk that the user tool clears
> the next AER due to a race condition.

Sorry, bare with me a moment. I may be missing something obvious, as I'm
not seeing a problem. Reading the event's associated log only rearms
the AER for that event type. Even if the user tool reads the same log
as the driver, that doesn't stop the driver from seeing the next AER
completion and handle it the same as if user space wasn't there.
