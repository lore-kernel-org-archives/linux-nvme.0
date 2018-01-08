From: hare@suse.com (Hannes Reinecke)
Date: Mon, 8 Jan 2018 09:58:30 +0100
Subject: [PATCH 4/5] nvme/multipath: Use blk_retryable
In-Reply-To: <20180104224623.8944-5-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-5-keith.busch@intel.com>
Message-ID: <724fb25f-ad34-d4f1-4351-90289efca7fb@suse.com>

On 01/04/2018 11:46 PM, Keith Busch wrote:
> Uses common code for determining if an error should be retried on
> alternate path.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/multipath.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae9abb600c0f..93bb72b6efb6 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -37,19 +37,7 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error)
>  {
>  	if (!(req->cmd_flags & REQ_NVME_MPATH))
>  		return false;
> -
> -	switch (error) {
> -	case BLK_STS_NOTSUPP:
> -	case BLK_STS_NOSPC:
> -	case BLK_STS_TARGET:
> -	case BLK_STS_NEXUS:
> -	case BLK_STS_MEDIUM:
> -	case BLK_STS_PROTECTION:
> -		return false;
> -	}
> -
> -	/* Everything else could be a path failure, so should be retried */
> -	return true;
> +	return blk_retryable(error);
>  }
>  
>  void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
