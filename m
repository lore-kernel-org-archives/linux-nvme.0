From: james.smart@broadcom.com (James Smart)
Date: Thu, 20 Dec 2018 15:31:27 -0800
Subject: [PATCH] nvme-fc: flush err and connect work in .stop_ctrl
In-Reply-To: <20181220190420.23515-1-sagi@grimberg.me>
References: <20181220190420.23515-1-sagi@grimberg.me>
Message-ID: <643654d7-2863-74f5-63d8-41aac14291d1@broadcom.com>



On 12/20/2018 11:04 AM, Sagi Grimberg wrote:
> Controller op .stop_ctrl was designed to let the driver
> quiesce any pending works that may be active before starting
> the controller teardown (delete_ctrl).
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 89accc76d71c..bf2ddc6850af 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2802,12 +2802,19 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   }
>   
>   static void
> -nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
> +nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
>   {
>   	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
>   
>   	cancel_work_sync(&ctrl->err_work);
>   	cancel_delayed_work_sync(&ctrl->connect_work);
> +}
> +
> +static void
> +nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
> +
>   	/*
>   	 * kill the association on the link side.  this will block
>   	 * waiting for io to terminate
> @@ -2925,6 +2932,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
>   	.submit_async_event	= nvme_fc_submit_async_event,
>   	.delete_ctrl		= nvme_fc_delete_ctrl,
> +	.stop_ctrl		= nvme_fc_stop_ctrl,
>   	.get_address		= nvmf_get_address,
>   };
>   

Hmm... I don't remember it being described that way when it was added 
and when I looked at it then, I had no need for the entrypoint. if all 
it does is cancel err_work and connect_work, I'm still wondering what it 
really does/achieves. Killing them off seems weird.

I'll take a closer look at where things sit now.

-- james
