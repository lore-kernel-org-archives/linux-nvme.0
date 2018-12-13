From: hare@suse.de (Hannes Reinecke)
Date: Thu, 13 Dec 2018 10:14:12 +0100
Subject: [PATCH 1/4] block: move holder tracking from struct block_device
 to hd_struct
In-Reply-To: <20181206164812.30925-2-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-2-cascardo@canonical.com>
Message-ID: <534a98ae-9da8-bd02-9d7d-f33e4b23e455@suse.de>

On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
> From: Christoph Hellwig <hch at lst.de>
> 
> We'd like to track the slaves and holder for nvme multipath devices
> in the same standard fashion as all the other stacked block devices
> to make the life for things like distro installers easy.
> 
> But struct block_device only exists while we have open instances,
> which we never have for the underlying devices of a nvme-multipath
> setup.  But we can easily move the older list into struct hd_struct
> which exists all the time the block device exists, the only interesting
> bit is that we need a new mutex for it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   block/genhd.c                |  4 +++
>   block/partition-generic.c    |  4 +++
>   drivers/block/drbd/drbd_nl.c |  4 +--
>   drivers/md/bcache/super.c    |  8 +++---
>   drivers/md/dm.c              |  4 +--
>   drivers/md/md.c              |  4 +--
>   fs/block_dev.c               | 48 ++++++++++++++++--------------------
>   include/linux/fs.h           | 11 +++------
>   include/linux/genhd.h        |  4 +++
>   9 files changed, 47 insertions(+), 44 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
