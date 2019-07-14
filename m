From: james.smart@broadcom.com (James Smart)
Date: Sun, 14 Jul 2019 08:04:26 -0700
Subject: [PATCH v2 2/3] nvme: enable aen also for discovery controllers
In-Reply-To: <20190712180211.26333-3-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-3-sagi@grimberg.me>
Message-ID: <52f3e8f8-434c-0f89-31ee-515740d1ba33@broadcom.com>



On 7/12/2019 11:02 AM, Sagi Grimberg wrote:
> If the controller supports discovery log page change events,
> we want to enable it on the host side as well.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3077cd4d75bf..116c210826c2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1190,6 +1190,8 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   	if (!supported_aens)
>   		return;
>   
> +	queue_work(nvme_wq, &ctrl->async_event_work);
> +
>   	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>   			NULL, 0, &result);
>   	if (status)
> @@ -3746,10 +3748,13 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
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

Looks fine, but curious why you needed to qualify the discovery_nqn with 
the FABRICS flag.? I would have assumed discovery_nqn would have been 
sufficient.

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
