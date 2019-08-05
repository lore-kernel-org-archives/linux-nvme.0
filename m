From: hare@suse.de (Hannes Reinecke)
Date: Mon, 5 Aug 2019 14:39:19 +0200
Subject: [PATCH rfc v2 3/6] nvme: make nvme_identify_ns propagate errors
 back
In-Reply-To: <20190803024955.29508-4-sagi@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-4-sagi@grimberg.me>
Message-ID: <05c77c73-6bf6-ecc8-ec6a-99f924ea6916@suse.de>

On 8/3/19 4:49 AM, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that
> it failed, but don't know why. Make nvme_identify_ns propagate
> the error back (like nvme_identify_ctrl).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f435c85c4062..802d1b49ecff 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1094,10 +1094,9 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
>  				    NVME_IDENTIFY_DATA_SIZE);
>  }
>  
> -static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
> -		unsigned nsid)
> +static int nvme_identify_ns(struct nvme_ctrl *ctrl,
> +		unsigned nsid, struct nvme_id_ns **id)
>  {
> -	struct nvme_id_ns *id;
>  	struct nvme_command c = { };
>  	int error;
>  
> @@ -1106,18 +1105,17 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
>  	c.identify.nsid = cpu_to_le32(nsid);
>  	c.identify.cns = NVME_ID_CNS_NS;
>  
> -	id = kmalloc(sizeof(*id), GFP_KERNEL);
> -	if (!id)
> -		return NULL;
> +	*id = kmalloc(sizeof(**id), GFP_KERNEL);
> +	if (!*id)
> +		return -ENOMEM;
>  
> -	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
> +	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
>  	if (error) {
>  		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
> -		kfree(id);
> -		return NULL;
> +		kfree(*id);
>  	}
>  
> -	return id;
> +	return error;
>  }
>  
I'd prefer using PTR_ERR() here; that would avoid the **id parameter.
(I'm really biased against this calling model, returning an error _and_
a structure. You can never be sure that both match, and you always get
into weird error handling routines.)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
