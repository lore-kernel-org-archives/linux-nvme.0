From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:23:55 +0200
Subject: [PATCH 10/17] nvme: switch controller refcounting to use struct
 device
In-Reply-To: <20171023145126.2471-11-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-11-hch@lst.de>
Message-ID: <2be01004-39fb-01f9-b0b7-afbe4ee08739@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> Instead of allocating a separate struct device for the character device
> handle embedd it into struct nvme_ctrl and use it for the main controller
> refcounting.  This removes double refcounting and gets us an automatic
> reference for the character device operations.  We keep ctrl->device as a
> pointer for now to avoid chaning printks all over, but in the future we
> could look into message printing helpers that take a controller structure
> similar to what other subsystems do.
> 
> Note the delete_ctrl operation always already has a reference (either
> through sysfs due this change, or because every open file on the
> /dev/nvme-fabrics node has a refernece) when it is entered now, so we
> don't need to do the unless_zero variant there.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c   | 43 ++++++++++++++++++++++---------------------
>  drivers/nvme/host/fc.c     |  8 ++------
>  drivers/nvme/host/nvme.h   | 12 +++++++++++-
>  drivers/nvme/host/pci.c    |  2 +-
>  drivers/nvme/host/rdma.c   |  5 ++---
>  drivers/nvme/target/loop.c |  2 +-
>  6 files changed, 39 insertions(+), 33 deletions(-)
> Round of applause for this :-)

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
