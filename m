From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Dec 2016 08:37:21 -0800
Subject: [PATCH] nvme-fabrics: simplify error handling of
 nvme_fc_create_hw_io_queues
In-Reply-To: <20161215132048.12645-1-jthumshirn@suse.de>
References: <20161215132048.12645-1-jthumshirn@suse.de>
Message-ID: <82b700f4-7a4c-777d-e7c2-b934548a71ba@broadcom.com>

Looks fine

-- james


Signed-off-by: James Smart <james.smart at broadcom.com>



On 12/15/2016 5:20 AM, Johannes Thumshirn wrote:
> Simplify the error handling of nvme_fc_create_hw_io_queues(), this saves us
> one variable and one level of indentation.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>   drivers/nvme/host/fc.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 771e2e7..ca2fd02 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1491,19 +1491,20 @@ enum {
>   nvme_fc_create_hw_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
>   {
>   	struct nvme_fc_queue *queue = &ctrl->queues[1];
> -	int i, j, ret;
> +	int i, ret;
>   
>   	for (i = 1; i < ctrl->queue_count; i++, queue++) {
>   		ret = __nvme_fc_create_hw_queue(ctrl, queue, i, qsize);
> -		if (ret) {
> -			for (j = i-1; j >= 0; j--)
> -				__nvme_fc_delete_hw_queue(ctrl,
> -						&ctrl->queues[j], j);
> -			return ret;
> -		}
> +		if (ret)
> +			goto delete_queues;
>   	}
>   
>   	return 0;
> +
> +delete_queues:
> +	for (; i >= 0; i--)
> +		__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[i], i);
> +	return ret;
>   }
>   
>   static int
