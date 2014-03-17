From: keith.busch@intel.com (Keith Busch)
Date: Mon, 17 Mar 2014 11:53:51 -0600 (MDT)
Subject: [PATCH] NVMe: core: Fix bug on maximum hardware sectors support
 by driver
In-Reply-To: <1395075645-19774-1-git-send-email-mundu2510@gmail.com>
References: <1395075645-19774-1-git-send-email-mundu2510@gmail.com>
Message-ID: <alpine.LRH.2.03.1403171131270.2885@AMR>

On Mon, 17 Mar 2014, Mundu wrote:
> NVMe spec defines maximum data transfer size as 0 in case no size restriction.
> Fixed exception - divide by zero in function nvme_trans_io_get_num_cmds.
> Change to maximum hardware sector supports as Block safe max sectors,
> when mdts set as zero.
>
> Signed-off-by: Mundu <mundu2510 at gmail.com>

That's a good catch, but I think we need to handle this differently. The
device's max_hw_sectors is per device rather than namespace.

I don't think the nvme-scsi should be using dev->max_hw_sectors directly,
though. Maybe something like this instead:

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 4a0ceb6..b0bd260 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2045,7 +2045,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
  	struct nvme_command c;
  	u8 opcode = (is_write ? nvme_cmd_write : nvme_cmd_read);
  	u16 control;
-	u32 max_blocks = nvme_block_nr(ns, dev->max_hw_sectors);
+	u32 max_blocks = queue_max_hw_sectors(ns->queue);

  	num_cmds = nvme_trans_io_get_num_cmds(hdr, cdb_info, max_blocks);

> ---
> drivers/block/nvme-core.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index cd39390..c8c0ccc 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1847,6 +1847,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
> 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
> 	if (dev->max_hw_sectors)
> 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
> +	else
> +		dev->max_hw_sectors = ns->queue->limits.max_hw_sectors;
>
> 	disk->major = nvme_major;
> 	disk->first_minor = 0;
