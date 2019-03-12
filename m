From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 15:39:18 +0100
Subject: [PATCH v2] multipath: set discard and norot queue flags on the
 multipath stacking device
In-Reply-To: <20190312074134.22566-1-sagi@grimberg.me>
References: <20190312074134.22566-1-sagi@grimberg.me>
Message-ID: <20190312143918.GD1149@lst.de>

On Tue, Mar 12, 2019@12:41:34AM -0700, Sagi Grimberg wrote:
> If the underlying device supports discard we set it and clear it otherwise.
> Without this blkdiscard doesn't work on a multipath device node.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Changes from v1:
> - removed the nonrot queue setting from the mpath device
> 
> Christoph,
> I lost reply and only saw it while searching for something else
> in the archives.
> 
> So to your question,
> "For discard don't we also need to the limits?  Also what about
> Write Zeroes?"
> 
> blk_queue_stack_limits takes care of the discard and write_zeros
> limits, we just need to set the queue flag.
> 
>  drivers/nvme/host/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d29ff9b910d9..40fcd80ec09f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1561,9 +1561,13 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
>  	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
>  }
>  
> -static inline void nvme_ns_config_oncs(struct nvme_ns *ns)
> +static inline void nvme_ns_config_oncs(struct gendisk *disk, struct nvme_ns *ns)
>  {
>  	nvme_config_discard(ns);
> +	if (blk_queue_discard(ns->queue))
> +		blk_queue_flag_set(QUEUE_FLAG_DISCARD, disk->queue);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, disk->queue);
>  	nvme_config_write_zeroes(ns);

This looks a bit odd as I'd expect this code to be inside
nvme_config_discard.  But there is some other oddness in this area,
let me send a small series with a refreshed version of your patch for
comments.
