From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 16 Feb 2017 15:38:53 -0700
Subject: [PATCH v2] nvme/core: Check for Security send/recv support before
 issuing commands.
In-Reply-To: <1487283420-4649-1-git-send-email-scott.bauer@intel.com>
References: <1487283420-4649-1-git-send-email-scott.bauer@intel.com>
Message-ID: <9daa1e48-90c9-9138-4683-4edafffbb613@intel.com>

Looks fine,
Reviewed-by: Jon Derrick <jonathan.derrick at intel.com>

On 02/16/2017 03:17 PM, Scott Bauer wrote:
> We need to verify that the controller supports the security
> commands before actually trying to issue them.
> 
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> ---
>  drivers/nvme/host/core.c | 4 ++++
>  drivers/nvme/host/nvme.h | 1 +
>  include/linux/nvme.h     | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8aeb4a6..5e0cf2b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1091,6 +1091,9 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  	struct nvme_ctrl *ctrl = data;
>  	struct nvme_command cmd;
>  
> +	if (!(ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP))
> +		return -EOPNOTSUPP;
> +
>  	memset(&cmd, 0, sizeof(cmd));
>  	if (send)
>  		cmd.common.opcode = nvme_admin_security_send;
> @@ -1285,6 +1288,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return -EIO;
>  	}
>  
> +	ctrl->oacs = le16_to_cpu(id->oacs);
>  	ctrl->vid = le16_to_cpu(id->vid);
>  	ctrl->oncs = le16_to_cpup(&id->oncs);
>  	atomic_set(&ctrl->abort_limit, id->acl + 1);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5126c4b..14cfc6f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -140,6 +140,7 @@ struct nvme_ctrl {
>  	u32 max_hw_sectors;
>  	u16 oncs;
>  	u16 vid;
> +	u16 oacs;
>  	atomic_t abort_limit;
>  	u8 event_limit;
>  	u8 vwc;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 3e2ed49..0b676a0 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -244,6 +244,7 @@ enum {
>  	NVME_CTRL_ONCS_DSM			= 1 << 2,
>  	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
>  	NVME_CTRL_VWC_PRESENT			= 1 << 0,
> +	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
>  };
>  
>  struct nvme_lbaf {
> 
