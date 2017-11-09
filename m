From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:27:03 +0100
Subject: [PATCHv3 5/5] nvme: Send uevent for some asynchronous events
In-Reply-To: <20171107221314.27822-6-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-6-keith.busch@intel.com>
Message-ID: <20171109092702.GE17120@lst.de>

On Tue, Nov 07, 2017@03:13:14PM -0700, Keith Busch wrote:
> This will give udev a chance to observe and handle asynchronous event
> notifications and clear the log to unmask future events of the same type.
> The driver will create a change uevent of the asyncronuos event result
> before submitting the next AEN request to the device if a completed AEN
> event is of type error, smart, command set or vendor specific,
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  include/linux/nvme.h     |  4 ++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5e059af65cc..486d02204c5d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2678,11 +2678,28 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>  
> +static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
> +{
> +	char *envp[2] = {NULL, NULL};
> +	u32 aen = ctrl->aen;
> +
> +	ctrl->aen = 0;

Seems like we should use cmpxchg on aen.

> +	if (!aen)
> +		return;
> +
> +	envp[0] = kasprintf(GFP_KERNEL, "NVME_AEN=%#08x", aen);
> +	if (!envp[0])
> +		return;
> +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +	kfree(envp[0]);
> +}
> +
>  static void nvme_async_event_work(struct work_struct *work)
>  {
>  	struct nvme_ctrl *ctrl =
>  		container_of(work, struct nvme_ctrl, async_event_work);
>  
> +	nvme_aen_uevent(ctrl);
>  	ctrl->ops->submit_async_event(ctrl);
>  }
>  
> @@ -2754,6 +2771,17 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
>  		return;
>  
> +	switch (result & 0x7) {
> +	case NVME_AER_ERROR:
> +	case NVME_AER_SMART:
> +	case NVME_AER_CSS:
> +	case NVME_AER_VS:
> +		ctrl->aen = result;

Can we call the field aen_result?

Given that the rest of the series looks good I'd be tempted to just
fix that up and apply it.  Are you ok with that?
