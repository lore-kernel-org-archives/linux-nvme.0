From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Mar 2019 13:33:13 +0100
Subject: [PATCH] nvme-fc: fix numa_node when dev is null
In-Reply-To: <20190301211933.26297-1-jsmart2021@gmail.com>
References: <20190301211933.26297-1-jsmart2021@gmail.com>
Message-ID: <669d787c-b538-eddc-6309-ef68aaaca0d1@suse.de>

On 3/1/19 10:19 PM, James Smart wrote:
> A recent change added a numa_node field to the nvme controller
> and has the transport assign the node using dev_to_node().
> However, fcloop registers with a NULL device struct, so the
> dev_to_node() call oops.
> 
> Revise the assignment to assign no node when device struct is null.
> 
> Fixes: 	103e515efa89b  ("nvme: add a numa_node field to struct nvme_ctrl")
> Reported-by: Mike Snitzer <snitzer at redhat.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/nvme/host/fc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index ba8f2a9cbdaf..865dc0637dbe 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3017,7 +3017,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	ctrl->ctrl.opts = opts;
>   	ctrl->ctrl.nr_reconnects = 0;
> -	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
> +	ctrl->ctrl.numa_node = (lport->dev) ?
> +				dev_to_node(lport->dev) : NUMA_NO_NODE;
>   	INIT_LIST_HEAD(&ctrl->ctrl_list);
>   	ctrl->lport = lport;
>   	ctrl->rport = rport;
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
