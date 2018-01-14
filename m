From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 19:00:26 +0200
Subject: [PATCH] nvme-rdma: fix sysfs invoked reset_ctrl error flow
In-Reply-To: <20180114163203.4771-1-nitzanc@mellanox.com>
References: <20180114163203.4771-1-nitzanc@mellanox.com>
Message-ID: <d562bcd1-042d-d491-8ef6-c4268492773a@grimberg.me>

Hi Nitzan,

This patch looks fine to me,

> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d06641b..890c488 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1791,11 +1791,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>   	return;
>   
>   out_fail:
> -	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
> -	nvme_remove_namespaces(&ctrl->ctrl);
> -	nvme_rdma_shutdown_ctrl(ctrl, true);
> -	nvme_uninit_ctrl(&ctrl->ctrl);
> -	nvme_put_ctrl(&ctrl->ctrl);

Nit, maybe increment nr_reconnects here as this is a failed reconnect...

> +	nvme_rdma_reconnect_or_remove(ctrl);
>   }
>   
>   static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
> 
