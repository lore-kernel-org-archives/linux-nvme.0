From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 19 Nov 2017 23:31:42 -0800
Subject: [PATCH] nvmet_fc: correct ref counting error when deferred rcv
 used
In-Reply-To: <20171110233845.32002-1-jsmart2021@gmail.com>
References: <20171110233845.32002-1-jsmart2021@gmail.com>
Message-ID: <20171120073142.GB6511@infradead.org>

Thanks,

pplied to nvme-4.15.

On Fri, Nov 10, 2017@03:38:45PM -0800, James Smart wrote:
> Whenever a cmd is received a reference is taken while looking up the
> queue. The reference is removed after the cmd is done as the iod is
> returned for reuse. The fod may be reused for a deferred (recevied but
> no job context) cmd.  Existing code removes the reference only if the
> fod is not reused for another command. Given the fod may be used for
> one or more ios, although a reference was taken per io, it won't be
> matched on the frees.
> 
> Remove the reference on every fod free. This pairs the references to
> each io.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/target/fc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 5f2570f5dfa9..5da4777ab8fb 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -534,15 +534,15 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
>  
>  	tgtport->ops->fcp_req_release(&tgtport->fc_target_port, fcpreq);
>  
> +	/* release the queue lookup reference on the completed IO */
> +	nvmet_fc_tgt_q_put(queue);
> +
>  	spin_lock_irqsave(&queue->qlock, flags);
>  	deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
>  				struct nvmet_fc_defer_fcp_req, req_list);
>  	if (!deferfcp) {
>  		list_add_tail(&fod->fcp_list, &fod->queue->fod_list);
>  		spin_unlock_irqrestore(&queue->qlock, flags);
> -
> -		/* Release reference taken at queue lookup and fod allocation */
> -		nvmet_fc_tgt_q_put(queue);
>  		return;
>  	}
>  
> @@ -761,6 +761,9 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
>  		tgtport->ops->fcp_req_release(&tgtport->fc_target_port,
>  				deferfcp->fcp_req);
>  
> +		/* release the queue lookup reference */
> +		nvmet_fc_tgt_q_put(queue);
> +
>  		kfree(deferfcp);
>  
>  		spin_lock_irqsave(&queue->qlock, flags);
> -- 
> 2.13.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
