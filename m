From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 25 Feb 2019 02:07:42 +0200
Subject: [PATCH 2/3 rfc] nvme: enable aen also for discovery controllers
In-Reply-To: <20190223023117.20517-3-sagi@grimberg.me>
References: <20190223023117.20517-1-sagi@grimberg.me>
 <20190223023117.20517-3-sagi@grimberg.me>
Message-ID: <5873c894-ab14-b012-a0be-6fb80a41b24a@mellanox.com>


On 2/23/2019 4:31 AM, Sagi Grimberg wrote:
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

why queue_count > 1 is a condition to enable AEN ?

Sounds more like an admin related action...

>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
> -		nvme_enable_aen(ctrl);
> -		queue_work(nvme_wq, &ctrl->async_event_work);
>   		nvme_start_queues(ctrl);
>   	}
>   }
