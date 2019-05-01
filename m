From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 1 May 2019 17:18:28 +0800
Subject: [PATCHv3] nvme-multipath: split bios with the ns_head bio_set
 before submitting
In-Reply-To: <20190430165709.106013-1-hare@suse.de>
References: <20190430165709.106013-1-hare@suse.de>
Message-ID: <20190501091826.GB14820@ming.t460p>

On Tue, Apr 30, 2019@06:57:09PM +0200, Hannes Reinecke wrote:
> If the bio is moved to a different queue via blk_steal_bios() and
> the original queue is destroyed in nvme_remove_ns() we'll be ending
> with a crash in bio_endio() as the mempool for the split bio bvecs
> had already been destroyed.
> So split the bio using the original queue (which will remain during the
> lifetime of the bio) before sending it down to the underlying device.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/multipath.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f0716f6ce41f..e6ddc83223df 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -232,6 +232,14 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  	int srcu_idx;
>  
> +	/*
> +	 * The namespace might be going away and the bio might
> +	 * be moved to a different queue via blk_steal_bios(),
> +	 * so we need to use the bio_split pool from the original
> +	 * queue to allocate the bvecs from.
> +	 */
> +	blk_queue_split(q, &bio);
> +
>  	srcu_idx = srcu_read_lock(&head->srcu);
>  	ns = nvme_find_path(head);
>  	if (likely(ns)) {
> -- 
> 2.16.4

Looks fine:

Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks,
Ming
