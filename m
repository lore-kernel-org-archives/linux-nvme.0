From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Jul 2017 17:29:55 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <20170707181436.GC24427@lst.de>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
Message-ID: <20170713212955.GD14716@localhost.localdomain>

On Fri, Jul 07, 2017@08:14:36PM +0200, Christoph Hellwig wrote:
> 
> Can we have an nvme-aen helper that gets invoked by a trivial udev rule,
> which would read a config file for policy?

Sure, I can work on an aen helper for udev. Do you know if there is an
existing project for these sorts of things that would take this feature?
 
> Also I think we need to document our policy on which AERs
> get forwarded to userspace. There are some we really should be
> handling in the kernel (fw activation which is in progress, namespace
> data changes really needs fixing, and ANA will also require kernel
> handling).  Is there a way to state it's up to the kernel to reserve
> any even for itself?  Or should we just forward very specific AERs
> to userspace?

I was hoping to not have a policy in the kernel. If we filter them with
evolving black or white lists, user space would still need to account
for difference across kernel versions.

Instead, sending everything is a lot more straight forward policy,
and user space can decide what to do with it. It's future proof to any
new event and use case. Even if the driver handles the event, there
shouldn't be anything user space can do to harm it. In the worst case,
it's just giving information that udev doesn't need.
