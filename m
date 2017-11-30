From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 30 Nov 2017 12:40:25 -0500
Subject: [PATCH] nvme: set discard_alignment to zero
In-Reply-To: <20171124153053.23056-1-ddiss@suse.de> (David Disseldorp's
 message of "Fri, 24 Nov 2017 16:30:53 +0100")
References: <20171124153053.23056-1-ddiss@suse.de>
Message-ID: <yq1bmjjekc6.fsf@oracle.com>


David,

> Correcting the discard_alignment parameter to zero has no effect on how
> discard requests are propagated through the block layer - @alignment in
> __blkdev_issue_discard() remains zero. However, it does fix other
> consumers, such as LIO's Block Limits VPD response.
>
> Signed-off-by: David Disseldorp <ddiss at suse.de>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 25da74d310d1..2e224ab5c340 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1287,7 +1287,7 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>  			NVME_DSM_MAX_RANGES);
>  
> -	queue->limits.discard_alignment = size;
> +	queue->limits.discard_alignment = 0;
>  	queue->limits.discard_granularity = size;

This looks good to me.

The alignment parameter was really only there to handle early drives
which were deliberately misaligned internally to avoid performance
penalties on operating systems that started the first partition on LBA
63.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
