From: dmilburn@redhat.com (David Milburn)
Date: Thu, 16 May 2019 15:11:58 -0500
Subject: [PATCH] nvme: fix memory leak for power latency tolerance req
In-Reply-To: <20190516030521.40374-1-yuyufen@huawei.com>
References: <20190516030521.40374-1-yuyufen@huawei.com>
Message-ID: <aa1f1fcc-9bd6-220a-b731-416a3da8d6a1@redhat.com>

Hi,

On 05/15/2019 10:05 PM, Yufen Yu wrote:
> nvme_init_ctrl() initialize latency tolerance controls and
> kzalloc structdev_pm_qos_request 'req' in nvme_init_ctrl().
> The only way to free the 'req' is nvme_init_identify(), when
> apst is disable and prev_apst is enable.
> 
> But, prev_apst is disable when device probe, and we will
> miss to free it when the device does't support APST.
> 
> To fix the problem, we call dev_pm_qos_update_user_latency_tolerance()
> to nvme_init_identify() only when the device actually supports APST.
> And it needs to be hidden when remove nvme ctrl.
> 
> Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")
> 
> Signed-off-by: Yufen Yu <yuyufen at huawei.com>
> ---
>   drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 15d114787d6a..e10756b7c13f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2485,6 +2485,21 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> +static void nvme_expose_latency_tolerance(struct nvme_ctrl *ctrl)
> +{
> +	ctrl->device->power.set_latency_tolerance = nvme_set_latency_tolerance;
> +	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
> +		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
> +
> +	dev_pm_qos_expose_latency_tolerance(ctrl->device);
> +}
> +
> +static void nvme_hide_latency_tolerance(struct nvme_ctrl *ctrl)
> +{
> +	ctrl->device->power.set_latency_tolerance = NULL;
> +	dev_pm_qos_hide_latency_tolerance(ctrl->device);
> +}
> +
>   /*
>    * Initialize the cached copies of the Identify data and various controller
>    * register in our nvme_ctrl structure.  This should be called as soon as
> @@ -2643,9 +2658,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   		return ret;
>   
>   	if (ctrl->apst_enabled && !prev_apst_enabled)
> -		dev_pm_qos_expose_latency_tolerance(ctrl->device);
> +		nvme_expose_latency_tolerance(ctrl);
>   	else if (!ctrl->apst_enabled && prev_apst_enabled)
> -		dev_pm_qos_hide_latency_tolerance(ctrl->device);
> +		nvme_hide_latency_tolerance(ctrl);
>   
>   	ret = nvme_configure_apst(ctrl);
>   	if (ret < 0)
> @@ -3687,6 +3702,13 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   
>   void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	/*
> +	 * If userspace latency tolerance have been exposed,
> +	 * we need to hide it.
> +	 */
> +	if (ctrl->device->power.set_latency_tolerance)
> +		nvme_hide_latency_tolerance(ctrl);
> +
>   	cdev_device_del(&ctrl->cdev, ctrl->device);
>   }
>   EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
> @@ -3773,14 +3795,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	if (ret)
>   		goto out_free_name;
>   
> -	/*
> -	 * Initialize latency tolerance controls.  The sysfs files won't
> -	 * be visible to userspace unless the device actually supports APST.
> -	 */
> -	ctrl->device->power.set_latency_tolerance = nvme_set_latency_tolerance;
> -	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
> -		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
> -
>   	return 0;
>   out_free_name:
>   	kfree_const(ctrl->device->kobj.name);
> 

Tested-by: David Milburn <dmilburn at redhat.com>

Before patch running v5.1

$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff924143eebfc0 (size 64):
   comm "kworker/1:2", pid 418, jiffies 4294679082 (age 275.968s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000001db7845a>] dev_pm_qos_update_user_latency_tolerance+0x63/0xe0
     [<000000008e36e7c0>] nvme_init_ctrl+0x2ec/0x310 [nvme_core]
     [<000000000177edcb>] nvme_probe+0x224/0x3e0 [nvme]
     [<00000000d2397746>] local_pci_probe+0x42/0x80
     [<0000000068201d8c>] work_for_cpu_fn+0x16/0x20
     [<00000000ccf116ec>] process_one_work+0x1a1/0x3a0
     [<000000007b61fbe2>] worker_thread+0x1c9/0x380
     [<0000000073ebfed5>] kthread+0x10c/0x130
     [<000000007f82e90d>] ret_from_fork+0x35/0x40

After patch no more memory leak as indicated above.

Thanks,
David
