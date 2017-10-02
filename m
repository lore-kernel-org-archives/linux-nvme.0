From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:42:18 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <1506952559-1588-4-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
Message-ID: <20171002164218.GA11886@lst.de>

On Mon, Oct 02, 2017@03:55:56PM +0200, Hannes Reinecke wrote:
> When setting up a multipath device we need to claim the underlying
> block devices to avoid other systems and/or programs to access it.
> And we should be using the standard holders/slave sysfs relationship
> instead of the hand-crafted 'mpath' links.

This completely breaks backwards compatibility:

root at testvm:~# mkfs.xfs /dev/nvme0n1 -f
mkfs.xfs: cannot open /dev/nvme0n1: Device or resource busy

Also we really do not want and outstanding struct block_device reference
all the time - struct block_device should only have a reference if
the block device node is in use or a file system is mounted.  Avoiding
this case was the whole point of my refactor to store the gendisk
instead of the block_device in struct bio.
