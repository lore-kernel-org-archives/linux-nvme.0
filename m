From: aeasi@marvell.com (Arun Easi)
Date: Tue, 28 May 2019 16:37:51 -0700
Subject: [PATCH] nvme-fc: Add message when creating new controller
In-Reply-To: <20190528182404.3463-1-jsmart2021@gmail.com>
References: <20190528182404.3463-1-jsmart2021@gmail.com>
Message-ID: <alpine.LRH.2.21.9999.1905281624470.9636@mvluser05.qlc.com>

On Tue, 28 May 2019, 11:24am, James Smart wrote:

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
>  drivers/nvme/host/fc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c17c887f2148..5c9b69ee2c1f 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3129,6 +3129,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>  
>  	nvme_get_ctrl(&ctrl->ctrl);
>  
> +	dev_info(ctrl->ctrl.device,
> +		"NVME-FC{%d}: creating new ctrl: NQN \"%s\"\n",
> +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
> +

Adding rport+lport information would be helpful. It would be good to have 
for all messages, but at least one message establishing the relationship 
would make it easier when looking at logs.

Just wondering if there is any reason why no FC rport/lport info
was logged with any of the messages in fc.c?

Regards,
-Arun

>  	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
>  		nvme_put_ctrl(&ctrl->ctrl);
>  		dev_err(ctrl->ctrl.device,
> 
