From: hare@suse.de (Hannes Reinecke)
Date: Sun, 24 Feb 2019 18:14:04 +0100
Subject: [PATCH 2/3 rfc] nvme: enable aen also for discovery controllers
In-Reply-To: <20190223023117.20517-3-sagi@grimberg.me>
References: <20190223023117.20517-1-sagi@grimberg.me>
 <20190223023117.20517-3-sagi@grimberg.me>
Message-ID: <b6127cbf-bfac-8df8-2253-a6bd798da5f1@suse.de>

On 2/23/19 3:31 AM, Sagi Grimberg wrote:
> If the controller supports discovery log page change events,
> we want to enable it on the host side as well.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9ec88253ebcd..348af75583e5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1178,6 +1178,8 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   	if (!supported_aens)
>   		return;
>   
> +	queue_work(nvme_wq, &ctrl->async_event_work);
> +
>   	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>   			NULL, 0, &result);
>   	if (status)
> @@ -3662,10 +3664,13 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   	if (ctrl->kato)
>   		nvme_start_keep_alive(ctrl);
>   
> +	if (ctrl->queue_count > 1 ||
> +	    (ctrl->ops->flags & NVME_F_FABRICS &&
> +	     ctrl->opts->discovery_nqn))
> +		nvme_enable_aen(ctrl);
> +
>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
> -		nvme_enable_aen(ctrl);
> -		queue_work(nvme_wq, &ctrl->async_event_work);
>   		nvme_start_queues(ctrl);
>   	}
>   }
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
