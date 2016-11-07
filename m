From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 07 Nov 2016 10:41:17 -0800
Subject: [PATCH v2] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <1478453200-16762-1-git-send-email-sagi@grimberg.me>
References: <1478453200-16762-1-git-send-email-sagi@grimberg.me>
Message-ID: <1478544077.3350.26.camel@linux.intel.com>

On Sun, 2016-11-06@19:26 +0200, Sagi Grimberg wrote:
> In the transport, in case of an interal queue error like
> error completion in rdma we trigger a fatal error. However,
> multiple queues in the same controller can serr error completions
> and we don't want to trigger fatal error work more than once.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Changes from v1:
> - reversed the if condition to avoid a goto statement
> 
> Changes from v0:
> - protect with ctrl lock instead of abusing atomic bitops on
> ????ctrl->csts
> 
> ?drivers/nvme/target/core.c | 10 +++++++---
> ?1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 7c0fe31ee654..55ce769cecee 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -840,9 +840,13 @@ static void nvmet_fatal_error_handler(struct
> work_struct *work)
> ?
> ?void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
> ?{
> -	ctrl->csts |= NVME_CSTS_CFS;
> -	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
> -	schedule_work(&ctrl->fatal_err_work);
> +	mutex_lock(&ctrl->lock);
> +	if (!(ctrl->csts & NVME_CSTS_CFS)) {
> +		ctrl->csts |= NVME_CSTS_CFS;
> +		INIT_WORK(&ctrl->fatal_err_work,
> nvmet_fatal_error_handler);
> +		schedule_work(&ctrl->fatal_err_work);
> +	}
> +	mutex_unlock(&ctrl->lock);

Surrounding the mutex_lock()/unlock() around the if() is definitely
safer and a more conservative, but I would think it would be OK to
stick the mutex_lock/unlock() within the if() statement (mutex_lock()
as the first line after the if() check, mutex_unlock() as the last line
of the if()), as trying to acquire a lock before checking the condition
to see if CFS needs to be set is sub-optimal.

> ?}
> ?EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
> ?
