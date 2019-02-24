From: hare@suse.de (Hannes Reinecke)
Date: Sun, 24 Feb 2019 18:16:18 +0100
Subject: [PATCH 3/3 rfc] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20190223023117.20517-4-sagi@grimberg.me>
References: <20190223023117.20517-1-sagi@grimberg.me>
 <20190223023117.20517-4-sagi@grimberg.me>
Message-ID: <d65021ac-b9ef-fa99-0a89-379f4583c646@suse.de>

On 2/23/19 3:31 AM, Sagi Grimberg wrote:
> Provide userspace with nvme discovery controller device instance,
> controller traddr and trsvcid. We'd expect userspace to handle
> this event by issuing a discovery + connect.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 348af75583e5..d29ff9b910d9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1168,7 +1168,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   
>   #define NVME_AEN_SUPPORTED \
> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
> +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE | \
> +	 NVME_AEN_CFG_DISC_CHANGE)
>   
>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
> @@ -3527,6 +3528,28 @@ static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>   	kfree(envp[0]);
>   }
>   
> +static void nvme_disc_aen_uevent(struct nvme_ctrl *ctrl)
> +{
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	char *envp[16];
> +	int i, envloc = 0;
> +
> +	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_EVENT=discovery");
> +	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_INSTANCE=%d", ctrl->instance);
> +	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRTYPE=%s", opts->transport);
> +	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRADDR=%s", opts->traddr);
> +	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRSVCID=%s", opts->trsvcid);
> +	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_HOST_TRADDR=%s",
> +			opts->host_traddr ?: "none");
> +	envp[envloc] = NULL;
> +
trsvcid is also optional, so we should be using

opts->trsvcid ?: "none"

here, too.

Cheers,

Hannes
