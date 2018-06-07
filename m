From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 11:41:11 +0300
Subject: [PATCH 1/3] nvme: also check for RESETTING state in
 nvmf_check_if_ready()
In-Reply-To: <20180607083847.51019-2-hare@suse.de>
References: <20180607083847.51019-1-hare@suse.de>
 <20180607083847.51019-2-hare@suse.de>
Message-ID: <91d12804-7d49-0109-6c7b-43a902f8c809@grimberg.me>

Thank you Hannes - just spotted that...

On 06/07/2018 11:38 AM, Hannes Reinecke wrote:
> When resetting the controller some transports go into 'RESETTING' state
> before issuing the actual 'reset' command. So add the 'RESETTING' state
> to nvmf_check_if_ready() to give them a chance to submit it.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fabrics.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index fa32c1216409..909dd337221a 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -548,6 +548,7 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_CONNECTING:
>   	case NVME_CTRL_DELETING:
> +	case NVME_CTRL_RESETTING:

I guess ADMIN_ONLY should also allow commands to pass.

>   		/*
>   		 * This is the case of starting a new or deleting an association
>   		 * but connectivity was lost before it was fully created or torn

Looks like we have almost all the states? Shouldn't we reverse such that
we check only for DEAD (and WARN_ON for state NEW)?
