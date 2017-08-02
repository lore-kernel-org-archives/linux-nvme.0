From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 2 Aug 2017 10:16:17 +0200
Subject: [PATCH 1/2] nvmet_fc: add defer_req callback for deferment of
 cmd buffer return
In-Reply-To: <20170801221240.31723-2-jsmart2021@gmail.com>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-2-jsmart2021@gmail.com>
Message-ID: <20170802081617.GD4256@linux-x5ow.site>

On Tue, Aug 01, 2017@03:12:39PM -0700, James Smart wrote:
> @@ -463,9 +472,9 @@ static struct nvmet_fc_fcp_iod *
>  nvmet_fc_alloc_fcp_iod(struct nvmet_fc_tgt_queue *queue)
>  {
>  	static struct nvmet_fc_fcp_iod *fod;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&queue->qlock, flags);
> +	/* Caller must hold queue->qlock */
+       lockped_assert_held(&queue->qlock); 
So we can check if the caller really holds the queue lock.

> +
>  	fod = list_first_entry_or_null(&queue->fod_list,
>  					struct nvmet_fc_fcp_iod, fcp_list);
>  	if (fod) {

[...]

> +	for (;;) {
> +		deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
> +				struct nvmet_fc_defer_fcp_req, req_list);
> +		if (!deferfcp)
> +			break;

        while ((deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
				struct nvmet_fc_defer_fcp_req,
				req_list)) != NULL) {
?

Other than that,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
