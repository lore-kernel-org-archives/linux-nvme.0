From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:53:09 +0200
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <20170713212955.GD14716@localhost.localdomain>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
 <20170713212955.GD14716@localhost.localdomain>
Message-ID: <20170714125309.GA26975@lst.de>

On Thu, Jul 13, 2017@05:29:55PM -0400, Keith Busch wrote:
> On Fri, Jul 07, 2017@08:14:36PM +0200, Christoph Hellwig wrote:
> > 
> > Can we have an nvme-aen helper that gets invoked by a trivial udev rule,
> > which would read a config file for policy?
> 
> Sure, I can work on an aen helper for udev. Do you know if there is an
> existing project for these sorts of things that would take this feature?

I would have expected this to be part of nvme-cli in one form or another.

> I was hoping to not have a policy in the kernel. If we filter them with
> evolving black or white lists, user space would still need to account
> for difference across kernel versions.
> 
> Instead, sending everything is a lot more straight forward policy,
> and user space can decide what to do with it. It's future proof to any
> new event and use case. Even if the driver handles the event, there
> shouldn't be anything user space can do to harm it. In the worst case,
> it's just giving information that udev doesn't need.

Someone has to clear the log page after and AER, and if both the
kernel and the user tool do so we risk that the user tool clears
the next AER due to a race condition.

But maybe we can work around this by adding a bit to the event
that indicates if the kernel has cleared the event.
