From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 15:18:06 +0200
Subject: [PATCH V2] nvmet: use Retain Async Event bit to clear AEN
In-Reply-To: <20180726210041.15129-1-chaitanya.kulkarni@wdc.com>
References: <20180726210041.15129-1-chaitanya.kulkarni@wdc.com>
Message-ID: <4af8eacd-cddc-9327-0580-fa045ff0170d@suse.de>

On 07/26/2018 11:00 PM, Chaitanya Kulkarni wrote:
> In the current implementation, we clear the AEN bit when we get the
> "get log page" command if given log page is associated with AEN.
> This patch allows optionally retaining the AEN for the ctrl
> under consideration when Retain Asynchronous Event (RAE) bit is set
> as a part of "get log page" command.
> 
> This allows the host to read the Log page and optionally retaining the
> AEN associated with this log page when using userspace tools like
> nvme-cli.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
> Changes since V1:-
> 
> 1. Add aen_bit to the helper so it be used for different log pages.
> ---
>  drivers/nvme/target/admin-cmd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 16a9b24270f9..731b620ddc06 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -19,6 +19,19 @@
>  #include <asm/unaligned.h>
>  #include "nvmet.h"
>  
> +/*
> + * This helper allows us to clear the AEN based on the RAE bit,
> + * Please use this helper when processing the log pages which are
> + * associated with the AEN.
> + */
> +static inline void nvmet_clear_aen(struct nvmet_req *req, u32 aen_bit)
> +{
> +	int rae = le32_to_cpu(req->cmd->common.cdw10[0]) & 1 << 15;
> +
> +	if (!rae)
> +		clear_bit(aen_bit, &req->sq->ctrl->aen_masked);
> +}
> +
>  u32 nvmet_get_log_page_len(struct nvme_command *cmd)
>  {
>  	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
> @@ -176,7 +189,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
>  	if (!status)
>  		status = nvmet_zero_sgl(req, len, req->data_len - len);
>  	ctrl->nr_changed_ns = 0;
> -	clear_bit(NVME_AEN_CFG_NS_ATTR, &ctrl->aen_masked);
> +	nvmet_clear_aen(req, NVME_AEN_CFG_NS_ATTR);
>  	mutex_unlock(&ctrl->lock);
>  out:
>  	nvmet_req_complete(req, status);
> 
Doesn't this apply to the NS CHANGED log page, too?
IIRC RAE is a generic bit, and not restricted to implementation in
individual log pages ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
