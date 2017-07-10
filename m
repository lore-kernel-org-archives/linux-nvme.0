From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 11:57:06 -0700
Subject: [PATCH rfc 08/30] nvme-rdma: cleanup error path in controller
 reset
In-Reply-To: <1497799324-19598-9-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-9-git-send-email-sagi@grimberg.me>
Message-ID: <57675cfb-a63a-3fef-ae63-0f8387b67082@broadcom.com>

On 6/18/2017 8:21 AM, Sagi Grimberg wrote:
> No need to queue an extra work to indirect controller
> uninit and put the final reference.
>
>
>   static void nvme_rdma_del_ctrl_work(struct work_struct *work)
>   {
>   	struct nvme_rdma_ctrl *ctrl = container_of(work,
>   				struct nvme_rdma_ctrl, delete_work);
>   
> -	__nvme_rdma_remove_ctrl(ctrl, true);
> +	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_rdma_shutdown_ctrl(ctrl, true);
> +	nvme_put_ctrl(&ctrl->ctrl);
>   }
>   
>   static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
> @@ -1791,14 +1784,6 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
>   	return ret;
>   }
>   
...

> @@ -1832,10 +1814,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>   
>   	return;
>   
> -del_dead_ctrl:
> -	/* Deleting this dead controller... */
> +out_destroy_io:
> +	nvme_rdma_destroy_io_queues(ctrl, true);
> +out_destroy_admin:
> +	nvme_rdma_destroy_admin_queue(ctrl, true);
>   	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
> -	WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
> +	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_put_ctrl(&ctrl->ctrl);
>   }
>   
>   static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {

Recommend calls to nvme_stop_keep_alive() prior to nvme_uninit_ctrl().

-- james
