From: hare@suse.de (Hannes Reinecke)
Date: Tue, 3 Oct 2017 12:08:26 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <20171002164218.GA11886@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
Message-ID: <ece83015-0def-8e36-5645-7be00be95c40@suse.de>

On 10/02/2017 06:42 PM, Christoph Hellwig wrote:
> On Mon, Oct 02, 2017@03:55:56PM +0200, Hannes Reinecke wrote:
>> When setting up a multipath device we need to claim the underlying
>> block devices to avoid other systems and/or programs to access it.
>> And we should be using the standard holders/slave sysfs relationship
>> instead of the hand-crafted 'mpath' links.
> 
> This completely breaks backwards compatibility:
> 
> root at testvm:~# mkfs.xfs /dev/nvme0n1 -f
> mkfs.xfs: cannot open /dev/nvme0n1: Device or resource busy
> 
> Also we really do not want and outstanding struct block_device reference
> all the time - struct block_device should only have a reference if
> the block device node is in use or a file system is mounted.  Avoiding
> this case was the whole point of my refactor to store the gendisk
> instead of the block_device in struct bio.
> 
Uh-oh.

And now the fun begins.

With this patch dm-multipath will ignore this device, so it's
_impossible_ to setup any device-mapper or md device on top of the
'nvme' device.
Without this patch md will happily autostart any RAID device on these
devices when it find a signature.
Or the user can mount it.
Or swap can attach it as a swapspace.

_AND_ you can do the same with the subsystem device, too, without any
indication that anything is amiss.

Do we really want this?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
