From: hare@suse.de (Hannes Reinecke)
Date: Thu, 22 Jun 2017 08:35:33 +0200
Subject: [PATCH] nvme_fc: fix double calls to nvme_cleanup_cmd()
In-Reply-To: <20170622004305.30603-1-jsmart2021@gmail.com>
References: <20170622004305.30603-1-jsmart2021@gmail.com>
Message-ID: <3a514e0e-aa6b-4553-e767-f5c8ee0460fc@suse.de>

On 06/22/2017 02:43 AM, James Smart wrote:
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
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
