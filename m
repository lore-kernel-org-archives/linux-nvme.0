From: yuyufen@huawei.com (yuyufen)
Date: Fri, 17 May 2019 10:09:02 +0800
Subject: [PATCH] nvme: fix memory leak for power latency tolerance req
In-Reply-To: <20190516211326.GB23955@localhost.localdomain>
References: <20190516030521.40374-1-yuyufen@huawei.com>
 <20190516211326.GB23955@localhost.localdomain>
Message-ID: <92a282ec-ddfc-5632-b584-06723ea410aa@huawei.com>



On 2019/5/17 5:13, Keith Busch wrote:
> It's perfectly safe to call dev_pm_qos_hide_latency_tolerance even if we
> never exposed it, so I think you're making this more complicated than
> necessary. Would the following one-liner work for you instead?
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f2411d50e764..0899dc5645a9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3697,6 +3697,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   
>   void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	dev_pm_qos_hide_latency_tolerance(ctrl->device);
>   	cdev_device_del(&ctrl->cdev, ctrl->device);
>   }

Yes, you are right.
I have worried that it will create a new 'req' if it has been free and 
set 'NULL'.
Thus, I try to hide it based on device->power.set_latency_tolerance.

Actually, I ignore the fact that dev_pm_qos_hide_latency_tolerance() 
will pass '-1' to
dev_pm_qos_update_user_latency_tolerance(). It will not create a new 'req'.

I will send patch v2 with the suggestion.

Yufen
Thanks a lot

>   EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
> --
>
> .
>
