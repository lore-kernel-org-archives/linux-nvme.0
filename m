From: hare@suse.de (Hannes Reinecke)
Date: Wed, 31 Jul 2019 14:04:59 +0200
Subject: [PATCH] nvme/multipath: revalidate nvme_ns_head gendisk in
 nvme_validate_ns
In-Reply-To: <20190729124040.16581-1-ailiopoulos@suse.com>
References: <20190729124040.16581-1-ailiopoulos@suse.com>
Message-ID: <b85af4b7-bf17-709f-cf45-d1fbc7573131@suse.de>

On 7/29/19 2:40 PM, Anthony Iliopoulos wrote:
> When CONFIG_NVME_MULTIPATH is set, only the hidden gendisk associated
> with the per-controller ns is run through revalidate_disk when a
> rescan is triggered, while the visible blockdev never gets its size
> (bdev->bd_inode->i_size) updated to reflect any capacity changes that
> may have occurred.
> 
> This prevents online resizing of nvme block devices and in extension of
> any filesystems atop that will are unable to expand while mounted, as
> userspace relies on the blockdev size for obtaining the disk capacity
> (via BLKGETSIZE/64 ioctls).
> 
> Fix this by explicitly revalidating the actual namespace gendisk in
> addition to the per-controller gendisk, when multipath is enabled.
> 
> Signed-off-by: Anthony Iliopoulos <ailiopoulos at suse.com>
> ---
>  drivers/nvme/host/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8f3fbe5ca937..80c7a7ee240b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1715,6 +1715,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	if (ns->head->disk) {
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
> +		revalidate_disk(ns->head->disk);
>  	}
>  #endif
>  }
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
