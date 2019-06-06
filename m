From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 6 Jun 2019 21:42:06 +0000
Subject: [PATCH 2/2] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
References: <20190606212854.122478-1-bvanassche@acm.org>
 <20190606212854.122478-3-bvanassche@acm.org>
Message-ID: <BYAPR04MB5749E9F546E6EA5415BEB20686170@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good. One quick question though do you actually have a controller
on which you have tested this feature ?

On 06/06/2019 02:29 PM, Bart Van Assche wrote:
>  From the NVMe 1.4 spec:
>
> NSFEAT bit 4 if set to 1: indicates that the fields NPWG, NPWA, NPDG, NPDA,
> and NOWS are defined for this namespace and should be used by the host for
> I/O optimization;
> [ ... ]
> Namespace Preferred Write Granularity (NPWG): This field indicates the
> smallest recommended write granularity in logical blocks for this namespace.
> This is a 0's based value. The size indicated should be less than or equal
> to Maximum Data Transfer Size (MDTS) that is specified in units of minimum
> memory page size. The value of this field may change if the namespace is
> reformatted. The size should be a multiple of Namespace Preferred Write
> Alignment (NPWA). Refer to section 8.25 for how this field is utilized to
> improve performance and endurance.
> [ ... ]
> Each Write, Write Uncorrectable, or Write Zeroes commands should address a
> multiple of Namespace Preferred Write Granularity (NPWG) (refer to Figure
> 245) and Stream Write Size (SWS) (refer to Figure 515) logical blocks (as
> expressed in the NLB field), and the SLBA field of the command should be
> aligned to Namespace Preferred Write Alignment (NPWA) (refer to Figure 245)
> for best performance.
>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>   drivers/nvme/host/core.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1b7c2afd84cb..c67f2fc8c5c0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1608,6 +1608,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   {
>   	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
>   	unsigned short bs = 1 << ns->lba_shift;
> +	uint32_t phys_bs, io_opt;
>
>   	if (ns->lba_shift > PAGE_SHIFT) {
>   		/* unsupported block size, set capacity to 0 later */
> @@ -1616,9 +1617,18 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	blk_mq_freeze_queue(disk->queue);
>   	blk_integrity_unregister(disk);
>
> +	phys_bs = bs;
> +	io_opt = bs;
> +	if (id->nsfeat & (1 << 4)) {
> +		/* NPWG = Namespace Preferred Write Granularity */
> +		phys_bs *= 1 + le16_to_cpu(id->npwg);
> +		/* NOWS = Namespace Optimal Write Size */
> +		io_opt *= 1 + le16_to_cpu(id->nows);
> +	}
>   	blk_queue_logical_block_size(disk->queue, bs);
> -	blk_queue_physical_block_size(disk->queue, bs);
> -	blk_queue_io_min(disk->queue, bs);
> +	blk_queue_physical_block_size(disk->queue, phys_bs);
> +	blk_queue_io_min(disk->queue, phys_bs);
> +	blk_queue_io_opt(disk->queue, io_opt);
>
>   	if (ns->ms && !ns->ext &&
>   	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>
