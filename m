From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 21 Jan 2015 21:40:37 -0700
Subject: [patch] NVMe: return an error code if blk_mq_alloc_tag_set() fails
In-Reply-To: <20150119144327.GE19086@mwanda>
References: <20150119144327.GE19086@mwanda>
Message-ID: <54C07F45.4070406@kernel.dk>

On 01/19/2015 07:43 AM, Dan Carpenter wrote:
> In the current code, if blk_mq_alloc_tag_set() fails then it returns
> zero (success) instead of preserving the error code.  The caller is not
> expecting that and the kernel could be left in an inconsistent state.
>
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

Looks good to me, Keith, could you ack/review it? Leaving it below...

> Static analysis stuff.  Not tested.
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index cb529e9..2ff5efc 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2152,7 +2152,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
>   	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>   	dev->tagset.driver_data = dev;
>
> -	if (blk_mq_alloc_tag_set(&dev->tagset))
> +	res = blk_mq_alloc_tag_set(&dev->tagset);
> +	if (res)
>   		goto out;
>
>   	id_ns = mem;
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


-- 
Jens Axboe
