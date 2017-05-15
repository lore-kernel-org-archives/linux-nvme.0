From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:25:35 +0200
Subject: [PATCH 04/10] nvme_fc: revise comment on teardown
In-Reply-To: <20170513190309.25417-5-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-5-jsmart2021@gmail.com>
Message-ID: <a2851cc8-13ab-9bf6-01ff-b52086e11811@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> Per the recommendation by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> An extra reference was pointed out.  There's no issue with the
> references, but rather a literal interpretation of what the comment
> is saying.
> 
> Reword the comment to avoid confusion.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/fc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index d2cf4e2e560b..2708c0caee14 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2539,10 +2539,10 @@ nvme_fc_delete_ctrl_work(struct work_struct *work)
>  
>  	/*
>  	 * tear down the controller
> -	 * This will result in the last reference on the nvme ctrl to
> -	 * expire, calling the transport nvme_fc_nvme_ctrl_freed() callback.
> -	 * From there, the transport will tear down it's logical queues and
> -	 * association.
> +	 * After the last reference on the nvme ctrl is removed,
> +	 * the transport nvme_fc_nvme_ctrl_freed() callback will be
> +	 * invoked. From there, the transport will tear down it's
> +	 * logical queues and association.
>  	 */
>  	nvme_uninit_ctrl(&ctrl->ctrl);
>  
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
