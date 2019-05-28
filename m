From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 28 May 2019 21:18:09 +0000
Subject: [PATCH] nvme-fc: Add message when creating new controller
References: <20190528182404.3463-1-jsmart2021@gmail.com>
Message-ID: <BYAPR04MB5749C2F9F987025C2FD6BD5A861E0@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 05/28/2019 11:31 AM, James Smart wrote:
> When looking at console messages to troubleshoot, there are one
> maybe two messages before creation of the controller is complete.
> However, a lot of io takes place to reach that point. It's unclear
> when things have started.
>
> Add a message when the controller is first attempting to be
> connecting to. Thus we know what controller and its NQN is being
> put into place for any subsequent success or failure messages.
>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/nvme/host/fc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c17c887f2148..5c9b69ee2c1f 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3129,6 +3129,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>
>   	nvme_get_ctrl(&ctrl->ctrl);
>
> +	dev_info(ctrl->ctrl.device,
> +		"NVME-FC{%d}: creating new ctrl: NQN \"%s\"\n",
> +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
> +
>   	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
>   		nvme_put_ctrl(&ctrl->ctrl);
>   		dev_err(ctrl->ctrl.device,
>
