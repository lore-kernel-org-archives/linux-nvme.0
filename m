From: dmilburn@redhat.com (David Milburn)
Date: Fri, 17 May 2019 07:22:48 -0500
Subject: [PATCH v2] nvme: fix memory leak for power latency tolerance req
In-Reply-To: <20190517023007.140656-1-yuyufen@huawei.com>
References: <20190517023007.140656-1-yuyufen@huawei.com>
Message-ID: <0becf386-c4f5-b0f9-2d5f-84da0e58226c@redhat.com>

Hi,

On 05/16/2019 09:30 PM, Yufen Yu wrote:
> nvme_init_ctrl() initialize latency tolerance controls and
> kzalloc structdev_pm_qos_request 'req' in nvme_init_ctrl().
> The only way to free the 'req' is nvme_init_identify(), when
> apst is disable and prev_apst is enable.
> 
> But, prev_apst is disable when device probe, and we will
> miss to free it when the device does't support APST.
> 
> To fix the problem, we need to hide latency tolerance and
> free 'req' in nvme_uninit_ctrl().
> 
> Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")
> Suggested-by: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Yufen Yu <yuyufen at huawei.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 15d114787d6a..e13670dcf590 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3687,6 +3687,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   
>   void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	dev_pm_qos_hide_latency_tolerance(ctrl->device);
>   	cdev_device_del(&ctrl->cdev, ctrl->device);
>   }
>   EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
> 

This one works too. Thanks

Tested-by: David Milburn <dmilburn at redhat.com>
