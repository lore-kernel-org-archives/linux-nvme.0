From: hare@suse.de (Hannes Reinecke)
Date: Sat, 10 Aug 2019 14:09:50 +0200
Subject: [PATCH v3 3/7] nvme: make nvme_identify_ns propagate errors back
In-Reply-To: <20190808205325.24036-4-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-4-sagi@grimberg.me>
Message-ID: <9bf08266-c51c-d1e1-1881-6817cfbd0c59@suse.de>

On 8/8/19 10:53 PM, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that it failed,
> but don't know why. Make nvme_identify_ns propagate the error back.
> 
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f435c85c4062..e503fd14de81 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1108,13 +1108,13 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
>   
>   	id = kmalloc(sizeof(*id), GFP_KERNEL);
>   	if (!id)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   
>   	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
>   	if (error) {
>   		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
>   		kfree(id);
> -		return NULL;
> +		return ERR_PTR(error);
>   	}
>   
>   	return id;
> @@ -1748,8 +1748,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   	}
>   
>   	id = nvme_identify_ns(ctrl, ns->head->ns_id);
> -	if (!id)
> -		return -ENODEV;
> +	if (IS_ERR(id))
> +		return PTR_ERR(id);
>   
>   	if (id->ncap == 0) {
>   		ret = -ENODEV;
> @@ -3337,8 +3337,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	nvme_set_queue_limits(ctrl, ns->queue);
>   
>   	id = nvme_identify_ns(ctrl, nsid);
> -	if (!id) {
> -		ret = -EIO;
> +	if (IS_ERR(id)) {
> +		ret = PTR_ERR(id);
>   		goto out_free_queue;
>   	}
>   
> 
See my comments to the previous patch. This will only work if we return 
POSIX error codes only; it'll probably fall flat on its face when 
returning blk_status_t codes.
Once we have converted nvme_submit_sync_cmd() to return POSIX error 
codes this is fine.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
