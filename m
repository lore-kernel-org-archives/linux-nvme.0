From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 16:57:43 -0700
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <1499444581-28268-8-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
Message-ID: <6e6d624b-4749-7b72-9ebc-58ba328adc64@broadcom.com>

On 7/7/2017 9:23 AM, Keith Busch wrote:
> This will give udev a chance to handle asynchronous event notification
> and clear the log to unmask future events of the same type. Since the
> core driver allows only one AEN request at a time, we can only have one
> possible oustanding uevent to send. This implementation saves the last
> AEN result from the IRQ handler, and sends the uevent change notification
> when the AEN work is rescheduled.
>
> The udev rule used to test this was the following:
>
>    ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="*", \
>          RUN+="/bin/sh -c '/usr/local/sbin/nvme get-log $env{DEVNAME} --log-id=$(( ($env{NVME_AEN} >> 16) & 0xff )) --log-len=4096 >> /tmp/nvme-log'"
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 16 ++++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 17 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 783db84..4abde2da 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2507,11 +2507,26 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>   
> +void nvme_aen_uevent(struct nvme_ctrl *ctrl)
> +{
> +	char buffer[20]; /* NVME_AEN=0xffffffff\0 */
> +	char *envp[2] = {buffer, NULL};
> +	u32 aen = ctrl->aen;
> +
> +	ctrl->aen = 0;
> +	if (!aen)
> +		return;
> +
> +	snprintf(buffer, sizeof(buffer), "NVME_AEN=%#08x", aen);
> +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +}
> +

Passing on a comment from Christoph received on a similar fc udev event:
"Please use kasprintf so that we have a dynamic allocation and don't 
need to hardcode buffer sizes"

-- james
