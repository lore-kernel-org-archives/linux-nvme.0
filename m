From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 13 Apr 2018 09:27:21 -0600
Subject: [PATCH] nvme: allow lightnvm to have visibility over AER events
In-Reply-To: <1523619780-10882-2-git-send-email-javier@cnexlabs.com>
References: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>
 <1523619780-10882-2-git-send-email-javier@cnexlabs.com>
Message-ID: <20180413152721.4cd2dxrxu4fd6dzs@sbauer-Z170X-UD5>

On Fri, Apr 13, 2018@01:43:00PM +0200, Javier Gonz?lez wrote:
> ---
>  drivers/nvme/host/core.c     | 37 +++++++++++++++++++++----
>  drivers/nvme/host/lightnvm.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h     |  3 ++
>  include/linux/lightnvm.h     | 24 ++++++++++++++++
>  include/linux/nvme.h         |  1 +
>  5 files changed, 125 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f81e3b323366..e08cd59e6049 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3263,15 +3263,31 @@ static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>  	kfree(envp[0]);
>  }
>  
> -static void nvme_async_event_work(struct work_struct *work)
> +static void nvme_async_event(struct nvme_ctrl *ctrl)
>  {
> -	struct nvme_ctrl *ctrl =
> -		container_of(work, struct nvme_ctrl, async_event_work);
> -
>  	nvme_aen_uevent(ctrl);
>  	ctrl->ops->submit_async_event(ctrl);
>  }
>  
> +static void nvme_async_event_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, async_event_work);
> +
> +	nvme_async_event(ctrl);
> +}
> +
> +static void nvme_aer_handle_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, aer_handle_work);
> +
> +	if (ctrl->aen_result & NVME_AER_NOTICE_LNVM_CHUNK)
> +		nvme_nvm_aer_handle(ctrl);

Just throwing ideas out:
Does it make sense to have the lnvm core register an "aer callback" into the
core driver? Then instead of calling the nvm_aer_handle directly we'd do like:

 int res = 0;
 if (child_driver->handle_aer)
   res = child_driver->handle_aer();

 if (!res)
     /* normal nvme driver handle */


If we do it this way if Fabrics, or what ever comes
in the future could register aer handlers as well and we wouldn't have to constantly
update this function.
