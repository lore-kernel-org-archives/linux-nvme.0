From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jul 2017 20:14:36 +0200
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <1499444581-28268-8-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
Message-ID: <20170707181436.GC24427@lst.de>

On Fri, Jul 07, 2017@12:23:01PM -0400, Keith Busch wrote:
> This will give udev a chance to handle asynchronous event notification
> and clear the log to unmask future events of the same type. Since the
> core driver allows only one AEN request at a time, we can only have one
> possible oustanding uevent to send. This implementation saves the last
> AEN result from the IRQ handler, and sends the uevent change notification
> when the AEN work is rescheduled.
> 
> The udev rule used to test this was the following:
> 
>   ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="*", \
>         RUN+="/bin/sh -c '/usr/local/sbin/nvme get-log $env{DEVNAME} --log-id=$(( ($env{NVME_AEN} >> 16) & 0xff )) --log-len=4096 >> /tmp/nvme-log'"


Can we have an nvme-aen helper that gets invoked by a trivial udev rule,
which would read a config file for policy?

Also I think we need to document our policy on which AERs
get forwarded to userspace. There are some we really should be
handling in the kernel (fw activation which is in progress, namespace
data changes really needs fixing, and ANA will also require kernel
handling).  Is there a way to state it's up to the kernel to reserve
any even for itself?  Or should we just forward very specific AERs
to userspace?
