From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 15:32:31 +0100
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190311220227.23656-2-sagi@grimberg.me>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me>
Message-ID: <20190312143231.GA1149@lst.de>

On Mon, Mar 11, 2019@03:02:25PM -0700, Sagi Grimberg wrote:
> If our target exposed a namespace with a block size that is greater
> than PAGE_SIZE, set 0 capacity on the namespace as we do not support it.
> 
> This issue encountered when the nvmet namespace was backed by a tempfile.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7321da21f8c9..e08979094eb5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1610,6 +1610,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
>  	unsigned short bs = 1 << ns->lba_shift;
>  
> +	if (ns->lba_shift > PAGE_SHIFT) {
> +		/* unsupported block size, set capacity to 0 later */
> +		bs = (1 << 9);
> +	}
>  	blk_mq_freeze_queue(disk->queue);
>  	blk_integrity_unregister(disk);
>  
> @@ -1621,7 +1625,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	if (ns->ms && !ns->ext &&
>  	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>  		nvme_init_integrity(disk, ns->ms, ns->pi_type);
> -	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
> +	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
> +	    ns->lba_shift > PAGE_SHIFT)
>  		capacity = 0;

I like the idea behind this, but it looks rather convoluted.  I think
for the unusable namespace case we should warn and have a common label
that just sets the capacity, not touching anything else.

Does something like this work for you?

---
>From ec4ce1708eb4d4f536b93f09dab952067f58ba4b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 12 Mar 2019 15:31:09 +0100
Subject: nvme: ignore namespaces with an unusable block size

And also refactor the handling for unusable namespaces to use a common
goto label, and print a warning for invalid metadata formats as well
while we are at it.

Reported-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1597efae6af8..0cf5741ecb7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1599,6 +1599,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
+	if (bs > PAGE_SIZE) {
+		dev_warn(ns->ctrl->device,
+			"unsupported LBA size %u, ignoring namespace\n", bs);
+		goto ignore;
+	}
+
 	blk_queue_logical_block_size(disk->queue, bs);
 	blk_queue_physical_block_size(disk->queue, bs);
 	blk_queue_io_min(disk->queue, bs);
@@ -1606,8 +1612,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
-		capacity = 0;
+	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) {
+		dev_warn(ns->ctrl->device,
+			"unsupported metadata format, ignoring namespace\n");
+		goto ignore;
+	}
 
 	set_capacity(disk, capacity);
 	nvme_ns_config_oncs(ns);
@@ -1618,6 +1627,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		set_disk_ro(disk, false);
 
 	blk_mq_unfreeze_queue(disk->queue);
+	return;
+ignore:
+	blk_mq_unfreeze_queue(disk->queue);
+	set_capacity(disk, 0);
 }
 
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
-- 
2.20.1
