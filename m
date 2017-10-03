From: hch@lst.de (Christoph Hellwig)
Date: Tue, 3 Oct 2017 13:55:07 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
Message-ID: <20171003115506.GC24650@lst.de>

On Tue, Oct 03, 2017@12:08:26PM +0200, Hannes Reinecke wrote:
> With this patch dm-multipath will ignore this device, so it's
> _impossible_ to setup any device-mapper or md device on top of the
> 'nvme' device.
> Without this patch md will happily autostart any RAID device on these
> devices when it find a signature.
> Or the user can mount it.
> Or swap can attach it as a swapspace.
> 
> _AND_ you can do the same with the subsystem device, too, without any
> indication that anything is amiss.
> 
> Do we really want this?

I though we agreed last week to do dynamic claiming.

That is if someone claims the multipath-device we extend that claim to
all /dev/nvmeXnY devices, and if someone claims one of the /dev/nvmeXnY
devices we extent it to the multipath node.  That should solve all of
the above issues.
