From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 14:50:23 +0200
Subject: [PATCH] nvme/pci: Remove watchdog timer
In-Reply-To: <20170530142057.GA2845@localhost.localdomain>
References: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
 <20170528094152.GB14199@lst.de> <20170530142057.GA2845@localhost.localdomain>
Message-ID: <20170601125023.GB28652@lst.de>

On Tue, May 30, 2017@10:20:57AM -0400, Keith Busch wrote:
> I am hoping to get this in this round since it would quiet a lot of
> errors I'm frequently pinged on: a non-posted request during a hotremove
> downstream a switch creates a lot of problems for hardware if you don't
> have DPC enabled.

With this round do you mean 4.12-rc or 4.13?

> One thing I'm just realizing, though, this will break subsystem reset.
> We were depending on the watchdog to detect that event, but now we require
> an IO timeout. It's easy enough to fix that from the host initiating
> the NSSR, but there's no way to notify other hosts connected to the
> same subsystem.

I don't think I've actually seen it trigger for that case due to the
PCIe link going down earlier.  But I'll need to double check as I
actually have access to a dual ported drive at the moment, the machine
setup is a bit quirky, though.
