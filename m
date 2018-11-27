From: emilne@redhat.com (Ewan D. Milne)
Date: Tue, 27 Nov 2018 17:11:54 -0500
Subject: [PATCH] nvme-core: flush namespace scanning work just before
 removing namespaces
In-Reply-To: <20181121231737.6802-1-sagi@grimberg.me>
References: <20181121231737.6802-1-sagi@grimberg.me>
Message-ID: <6f3e821ee1a17354ce1ac36cd5c7fa48caa72991.camel@redhat.com>

On Wed, 2018-11-21@15:17 -0800, Sagi Grimberg wrote:
> nvme_stop_ctrl can be called also for reset flow and there is no need to
> flush the scan_work as namespaces are not being removed. This can cause
> deadlock in rdma, fc and loop drivers since nvme_stop_ctrl barriers
> before controller teardown (and specifically I/O cancellation of the
> scan_work itself) takes place, but the scan_work will be blocked anyways
> so there is no need to flush it.
> 
> Instead, move scan_work flush to nvme_remove_namespaces() where it really
> needs to flush.
> 
> Reported-by: Ming Lei <ming.lei at redhat.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> This is a stable candidate...
> 
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c418b7a347e0..2e0571584e7a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3327,6 +3327,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns, *next;
>  	LIST_HEAD(ns_list);
>  
> +	/* prevent racing with ns scanning */
> +	flush_work(&ctrl->scan_work);
> +
>  	/*
>  	 * The dead states indicates the controller was not gracefully
>  	 * disconnected. In that case, we won't be able to flush any data while
> @@ -3489,7 +3492,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  	nvme_mpath_stop(ctrl);
>  	nvme_stop_keep_alive(ctrl);
>  	flush_work(&ctrl->async_event_work);
> -	flush_work(&ctrl->scan_work);
>  	cancel_work_sync(&ctrl->fw_act_work);
>  	if (ctrl->ops->stop_ctrl)
>  		ctrl->ops->stop_ctrl(ctrl);

With this change, I can no longer reproduce the NVMe fabrics reset hangs
I was seeing (e.g. after a few hundred resets).  A longer-duration fabric
connection bounce test survived as well, this change looks good to me.

Thanks for fixing this, Sagi.

Tested-by: Ewan D. Milne <emilne at redhat.com>
