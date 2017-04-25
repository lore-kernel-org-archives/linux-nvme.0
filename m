From: james.smart@broadcom.com (James Smart)
Date: Mon, 24 Apr 2017 17:46:50 -0700
Subject: [PATCH 3/3] nvme-rdma: Support ctrl_loss_tmo
In-Reply-To: <1489876941-6401-4-git-send-email-sagi@grimberg.me>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
 <1489876941-6401-4-git-send-email-sagi@grimberg.me>
Message-ID: <d52b4109-e6d7-9085-a358-8812f937d169@broadcom.com>

On 3/18/2017 3:42 PM, Sagi Grimberg wrote:
> Before scheduling a reconnect attempt, check
> nr_reconnects against max_reconnects, if not
> exhausted (or max_reconnects is not -1), schedule
> a reconnect attempts, otherwise schedule ctrl
> removal.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 41 ++++++++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 33f18636ea99..71d1e1a6b928 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -711,6 +711,26 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
>   	kfree(ctrl);
>   }
>   
> +static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
> +{
> +	/* If we are resetting/deleting then do nothing */
> +	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
> +		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
> +			ctrl->ctrl.state == NVME_CTRL_LIVE);
> +		return;
> +	}
> +
> +	if (nvmf_should_reconnect(&ctrl->ctrl)) {
> +		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
> +			ctrl->ctrl.opts->reconnect_delay);
> +		queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
> +				ctrl->ctrl.opts->reconnect_delay * HZ);
> +	} else {
> +		dev_info(ctrl->ctrl.device, "Removing controller...\n");
Shouldn't there be a:
         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
                 return;

right here ?

> +		queue_work(nvme_rdma_wq, &ctrl->delete_work);
> +	}
> +}
> +


-- james
