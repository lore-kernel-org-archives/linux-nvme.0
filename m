From: keith.busch@intel.com (Keith Busch)
Date: Fri, 18 Jan 2019 08:22:48 -0700
Subject: [PATCH 1/1] nvme pci: fix the check of the cqe->command_id
In-Reply-To: <20190118051755.1818-1-m.misono760@gmail.com>
References: <20190118051755.1818-1-m.misono760@gmail.com>
Message-ID: <20190118152248.GG31543@localhost.localdomain>

On Fri, Jan 18, 2019@05:17:55AM +0000, Masanori Misono wrote:
> nvme_pci_submit_async_event() sets the command_id as
> NVME_AQ_BLK_MQ_DEPTH. So only call nvme_complete_async_event()
> if the cqe->command_is exactly matches the value.
> 
> If the cqe->command_id is invalid due to the hardware bug,
> blk_mq_tag_to_rq() returns NULL. Check that value to prevent NULL
> pointer dereference. Remove the duplicate check if the command_id
> is bigger than or equal to the nvmeq->q_depth.
> 
> Signed-off-by: Masanori Misono <m.misono760 at gmail.com>

This looks fine, though end result should be the same as before. We're
just trading one of the bounds checks for a NULL check, and I'm okay
with that.

Reviewed-by: Keith Busch <keith.busch at intel.com>

>  drivers/nvme/host/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c33bb201b884..cc6bb7abb752 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -878,13 +878,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> -		dev_warn(nvmeq->dev->ctrl.device,
> -			"invalid id %d completed on queue %d\n",
> -			cqe->command_id, le16_to_cpu(cqe->sq_id));
> -		return;
> -	}
> -
>  	/*
>  	 * AEN requests are special as they don't time out and can
>  	 * survive any kind of queue freeze and often don't respond to
> @@ -892,13 +885,20 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	 * for them but rather special case them here.
>  	 */
>  	if (unlikely(nvmeq->qid == 0 &&
> -			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
> +			cqe->command_id == NVME_AQ_BLK_MQ_DEPTH)) {
>  		nvme_complete_async_event(&nvmeq->dev->ctrl,
>  				cqe->status, &cqe->result);
>  		return;
>  	}
>  
>  	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> +	if (unlikely(req == NULL)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"invalid id %d completed on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}
> +
>  	nvme_end_request(req, cqe->status, cqe->result);
>  }
>  
> -- 
> 2.17.1
