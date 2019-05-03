From: james.smart@broadcom.com (James Smart)
Date: Fri, 3 May 2019 10:46:43 -0700
Subject: [PATCH] nvme-fc: use separate work queue to avoid warning
In-Reply-To: <20190503094352.17923-1-hare@suse.de>
References: <20190503094352.17923-1-hare@suse.de>
Message-ID: <456b12ed-f713-951b-feab-49fa663d7f96@broadcom.com>

On 5/3/2019 2:43 AM, Hannes Reinecke wrote:
> When tearing down a controller the following warning is issued:
>
> WARNING: CPU: 0 PID: 30681 at ../kernel/workqueue.c:2418 check_flush_dependency
>
> This happens as the err_work workqueue item is scheduled on the
> system workqueue (which has WQ_MEM_RECLAIM not set), but is flushed
> from a workqueue which has WQ_MEM_RECLAIM set.
>
> Fix this by providing an FC-NVMe specific workqueue.
>
> Fixes: 4cff280a5fcc ("nvme-fc: resolve io failures during connect")
> Cc: James Smart <james.smart at broadcom.com>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fc.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 143c2b81ffc5..a1080fa4b046 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -204,7 +204,7 @@ static LIST_HEAD(nvme_fc_lport_list);
>   static DEFINE_IDA(nvme_fc_local_port_cnt);
>   static DEFINE_IDA(nvme_fc_ctrl_cnt);
>   
> -
> +static struct workqueue_struct *nvme_fc_wq;
>   
>   /*
>    * These items are short-term. They will eventually be moved into
> @@ -2060,7 +2060,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>   	 */
>   	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
>   		active = atomic_xchg(&ctrl->err_work_active, 1);
> -		if (!active && !schedule_work(&ctrl->err_work)) {
> +		if (!active && !queue_work(nvme_fc_wq, &ctrl->err_work)) {
>   			atomic_set(&ctrl->err_work_active, 0);
>   			WARN_ON(1);
>   		}
> @@ -3406,6 +3406,10 @@ static int __init nvme_fc_init_module(void)
>   {
>   	int ret;
>   
> +	nvme_fc_wq = alloc_workqueue("nvme_fc_wq", WQ_MEM_RECLAIM, 0);
> +	if (!nvme_fc_wq)
> +		return -ENOMEM;
> +
>   	/*
>   	 * NOTE:
>   	 * It is expected that in the future the kernel will combine
> @@ -3423,7 +3427,7 @@ static int __init nvme_fc_init_module(void)
>   	ret = class_register(&fc_class);
>   	if (ret) {
>   		pr_err("couldn't register class fc\n");
> -		return ret;
> +		goto out_destroy_wq;
>   	}
>   
>   	/*
> @@ -3447,6 +3451,9 @@ static int __init nvme_fc_init_module(void)
>   	device_destroy(&fc_class, MKDEV(0, 0));
>   out_destroy_class:
>   	class_unregister(&fc_class);
> +out_destroy_wq:
> +	destroy_workqueue(nvme_fc_wq);
> +
>   	return ret;
>   }
>   
> @@ -3463,6 +3470,7 @@ static void __exit nvme_fc_exit_module(void)
>   
>   	device_destroy(&fc_class, MKDEV(0, 0));
>   	class_unregister(&fc_class);
> +	destroy_workqueue(nvme_fc_wq);
>   }
>   
>   module_init(nvme_fc_init_module);

Reviewed-by:?? James Smart <james.smart at broadcom.com>

Looks fine to me.? And we're back to were we were in the beginning. And 
it also says the other transports are likely to be in the same boat as 
the effort to move everything over to the system workqueue was a 
commonization cleanup made to all transports.

-- james
