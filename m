From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 06 Feb 2019 08:44:42 -0500
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <20190205173902.17947-1-jsmart2021@gmail.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
Message-ID: <ff8525a2d7720cc6a684517adaaae96a72364adc.camel@redhat.com>

On Tue, 2019-02-05@09:39 -0800, James Smart wrote:
> The FC-NVME spec, when finally approved, modified the disconnect LS
> such that the only scope available is the association.
> 
> Rework the Disconnect LS processing to be in accordance with the
> change.
> 
> Signed-off-by: Nigel Kirkland <nigel.kirkland at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>  drivers/nvme/target/fc.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 9d065850cda4..2f67b315674b 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1514,10 +1514,8 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>  			(struct fcnvme_ls_disconnect_rqst *)iod->rqstbuf;
>  	struct fcnvme_ls_disconnect_acc *acc =
>  			(struct fcnvme_ls_disconnect_acc *)iod->rspbuf;
> -	struct nvmet_fc_tgt_queue *queue = NULL;
>  	struct nvmet_fc_tgt_assoc *assoc;
>  	int ret = 0;
> -	bool del_assoc = false;
>  
>  	memset(acc, 0, sizeof(*acc));
>  
> @@ -1548,18 +1546,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>  		assoc = nvmet_fc_find_target_assoc(tgtport,
>  				be64_to_cpu(rqst->associd.association_id));
>  		iod->assoc = assoc;
> -		if (assoc) {
> -			if (rqst->discon_cmd.scope ==
> -					FCNVME_DISCONN_CONNECTION) {
> -				queue = nvmet_fc_find_target_queue(tgtport,
> -						be64_to_cpu(
> -							rqst->discon_cmd.id));
> -				if (!queue) {
> -					nvmet_fc_tgt_a_put(assoc);
> -					ret = VERR_NO_CONN;
> -				}
> -			}
> -		} else
> +		if (!assoc)
>  			ret = VERR_NO_ASSOC;
>  	}
>  
> @@ -1587,26 +1574,10 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>  				sizeof(struct fcnvme_ls_disconnect_acc)),
>  			FCNVME_LS_DISCONNECT);
>  
> -
> -	/* are we to delete a Connection ID (queue) */
> -	if (queue) {
> -		int qid = queue->qid;
> -
> -		nvmet_fc_delete_target_queue(queue);
> -
> -		/* release the get taken by find_target_queue */
> -		nvmet_fc_tgt_q_put(queue);
> -
> -		/* tear association down if io queue terminated */
> -		if (!qid)
> -			del_assoc = true;
> -	}
> -
>  	/* release get taken in nvmet_fc_find_target_assoc */
>  	nvmet_fc_tgt_a_put(iod->assoc);
>  
> -	if (del_assoc)
> -		nvmet_fc_delete_target_assoc(iod->assoc);
> +	nvmet_fc_delete_target_assoc(iod->assoc);
>  }
>  
>  

Reviewed-by: Ewan D. Milne <emilne at redhat.com>
