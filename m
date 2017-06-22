From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 22 Jun 2017 16:50:35 -0400
Subject: [PATCH] nvme_fc: fix double calls to nvme_cleanup_cmd()
In-Reply-To: <20170622004305.30603-1-jsmart2021@gmail.com>
References: <20170622004305.30603-1-jsmart2021@gmail.com>
Message-ID: <1498164635.31413.15.camel@localhost.localdomain>

On Wed, 2017-06-21@17:43 -0700, James Smart wrote:
> Current fc transport code, on io termination, is calling
> nvme_cleanup_cmd() followed by the transport dma unmap routine
> which also calls nvme_cleanup_cmd(). Which means two kfrees occur
> on the same address, raising havoc. This resulted in odd data errors,
> effectively corruption..
> 
> Fix by removing the extraneous double calls. Call now occurs only in
> teardown paths and as part of dma unmap routine.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5165007e86a6..02a6df84dc3c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1957,10 +1957,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>  					queue->lldd_handle, &op->fcp_req);
>  
>  	if (ret) {
> -		if (op->rq) {			/* normal request */
> +		if (op->rq)			/* normal request */
>  			nvme_fc_unmap_data(ctrl, op->rq, op);
> -			nvme_cleanup_cmd(op->rq);
> -		}
>  		/* else - aen. no cleanup needed */
>  
>  		nvme_fc_ctrl_put(ctrl);
> @@ -2078,7 +2076,6 @@ __nvme_fc_final_op_cleanup(struct request *rq)
>  	op->flags &= ~(FCOP_FLAGS_TERMIO | FCOP_FLAGS_RELEASED |
>  			FCOP_FLAGS_COMPLETE);
>  
> -	nvme_cleanup_cmd(rq);
>  	nvme_fc_unmap_data(ctrl, rq, op);
>  	nvme_complete_rq(rq);
>  	nvme_fc_ctrl_put(ctrl);

I had posted a patch for this back in April, but it doesn't look like
it ever made it in.  I had fixed it by removing the nvme_cleanup_cmd()
call from nvme_fc_unmap_data(), but this looks OK too.

Reviewed-by: Ewan D. Milne <emilne at redhat.com>
