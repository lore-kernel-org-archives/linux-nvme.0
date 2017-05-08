From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 11:54:53 +0200
Subject: [PATCH] nvmet_fc: Add queue create and delete callbacks in LLDD
 api
In-Reply-To: <20170426040409.3121-1-jsmart2021@gmail.com>
References: <20170426040409.3121-1-jsmart2021@gmail.com>
Message-ID: <6e4a8196-1b1e-ba2f-74a3-0b845c91d772@suse.de>

On 04/26/2017 06:04 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> To facilitate LLDD resource management on nvme queue creation and
> deletion, add optional callbacks queue_create and queue_delete.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/target/fc.c       | 18 +++++++++++++++++-
>  include/linux/nvme-fc-driver.h | 18 ++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index da6e5a3..e9e96cc 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -555,6 +555,7 @@ static struct nvmet_fc_tgt_queue *
>  nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>  			u16 qid, u16 sqsize)
>  {
> +	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
>  	struct nvmet_fc_tgt_queue *queue;
>  	unsigned long flags;
>  	int ret;
> @@ -568,8 +569,14 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>  	if (!queue)
>  		return NULL;
>  
> +	if (tgtport->ops->queue_create) {
> +		if (tgtport->ops->queue_create(&tgtport->fc_target_port,
> +				nvmet_fc_makeconnid(assoc, qid), sqsize))
> +			goto out_free_queue;
> +	}
> +
>  	if (!nvmet_fc_tgt_a_get(assoc))
> -		goto out_free_queue;
> +		goto out_queue_delete;
>  
>  	queue->fod = (struct nvmet_fc_fcp_iod *)&queue[1];
>  	queue->qid = qid;
> @@ -601,6 +608,10 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>  out_fail_iodlist:
>  	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
>  	nvmet_fc_tgt_a_put(assoc);
> +out_queue_delete:
> +	if (tgtport->ops->queue_delete)
> +		tgtport->ops->queue_delete(&tgtport->fc_target_port,
> +				nvmet_fc_makeconnid(assoc, qid), sqsize);
>  out_free_queue:
>  	kfree(queue);
>  	return NULL;
> @@ -676,6 +687,11 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
>  	if (disconnect)
>  		nvmet_sq_destroy(&queue->nvme_sq);
>  
> +	if (tgtport->ops->queue_delete)
> +		tgtport->ops->queue_delete(&tgtport->fc_target_port,
> +				nvmet_fc_makeconnid(queue->assoc, queue->qid),
> +				queue->sqsize);
> +
>  	nvmet_fc_tgt_q_put(queue);
>  }
>  
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 8dbf164..abcefb7 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -806,6 +806,20 @@ struct nvmet_fc_target_port {
>   *       to the LLDD after all operations on the fcp operation are complete.
>   *       This may be due to the command completing or upon completion of
>   *       abort cleanup.
> + *       Entrypoint is Mandatory.
> + *
> + * @queue_create:  Called by the transport to indicate the creation of an
> + *       nvme queue and to allow the LLDD to allocate resources for the
> + *       queue.
> + *       Returns 0 on successfull allocation of resources for the queue.
> + *       -<errno> on failure.  Failure will result in failure of the
> + *       FC-NVME Create Assocation or Create Connection LS's.
> + *       Entrypoint is Optional.
> + *
> + * @queue_delete:  Called by the transport to indicate the deletion of an
> + *       nvme queue and to allow the LLDD to de-allocate resources for the
> + *       queue.
> + *       Entrypoint is Optional.
>   *
>   * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
>   *       supports for cpu affinitization.
> @@ -846,6 +860,10 @@ struct nvmet_fc_target_template {
>  				struct nvmefc_tgt_fcp_req *fcpreq);
>  	void (*fcp_req_release)(struct nvmet_fc_target_port *tgtport,
>  				struct nvmefc_tgt_fcp_req *fcpreq);
> +	int (*queue_create)(struct nvmet_fc_target_port *tgtport,
> +				u64 connection_id, u16 qsize);
> +	void (*queue_delete)(struct nvmet_fc_target_port *tgtport,
> +				u64 connection_id, u16 qsize);
>  
>  	u32	max_hw_queues;
>  	u16	max_sgl_segments;
> 


One minor addition, please add a sanity check to
nvmet_fc_register_targetport() making sure if one registers a
queue_create() a matching queue_delete() has to be provided as well,
otherwise someone could theoretically build a memory leak.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
