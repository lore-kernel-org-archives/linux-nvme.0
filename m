From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 14:48:33 -0700
Subject: [PATCH 3/4] nvme-fabrics: handle the admin-only case properly in
 nvmf_check_ready
In-Reply-To: <20180611154647.32558-4-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-4-hch@lst.de>
Message-ID: <925032f4-4f28-4a2c-4255-61566c71595c@broadcom.com>



On 6/11/2018 8:46 AM, Christoph Hellwig wrote:
> In the ADMIN_ONLY state we don't have any I/O queues, but we should accept
> all admin commands without further checks.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/fabrics.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 2ea949a3868c..e1818a27aa2d 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -169,7 +169,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		bool queue_live)
>   {
> -	if (likely(ctrl->state == NVME_CTRL_LIVE))
> +	if (likely(ctrl->state == NVME_CTRL_LIVE ||
> +		   ctrl->state == NVME_CTRL_ADMIN_ONLY))
>   		return true;
>   	return __nvmf_check_ready(ctrl, rq, queue_live);
>   }

True. Although there was no validation of it being an admin cmd. But 
reitterates my statement of NVME_CTRL_ADMIN_ONLY being just a variant of 
NVME_CTRL_LIVE.

Reviewed-by:?? James Smart? <james.smart at broadcom.com>
