From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:18:47 +0200
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <20171023145126.2471-7-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de>
Message-ID: <09f8a87b-f8da-9f5a-6efd-f5e9acfaee45@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> With this flag a driver can create a gendisk that can be used for I/O
> submission inside the kernel, but which is not registered as user
> facing block device.  This will be useful for the NVMe multipath
> implementation.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/genhd.c         | 57 +++++++++++++++++++++++++++++++++++----------------
>  include/linux/genhd.h |  1 +
>  2 files changed, 40 insertions(+), 18 deletions(-)
> 
Can we have some information in sysfs to figure out if a gendisk is
hidden? I'd hate having to do an inverse lookup in /proc/partitions;
it's always hard to prove that something is _not_ present.
And we already present various information (like disk_removable_show()),
so it's not without precedent.
And it would make integration with systemd/udev easier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
