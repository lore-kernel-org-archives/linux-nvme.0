From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Feb 2018 15:05:12 +0200
Subject: [PATCH V2] nvmet: Change return code of discard command if not
 supported
In-Reply-To: <1517306821-9908-1-git-send-email-israelr@mellanox.com>
References: <1517306821-9908-1-git-send-email-israelr@mellanox.com>
Message-ID: <50796da2-75d0-4499-5172-1ed125f2ce95@mellanox.com>

Sagi,
I think we agreed on this one,
can you take it to 4.16-rc please ?


On 1/30/2018 12:07 PM, Israel Rukshin wrote:
> Execute discard command on block device that doesn't support it
> should return success.
> Returning internal error while using multi-path fails the path.
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> ---
> 
> Changes from v1:
>   - return success instead of invalid opcode error
> 
> ---
>   drivers/nvme/target/io-cmd.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index 0a4372a..28bbdff 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c
> @@ -105,10 +105,13 @@ static void nvmet_execute_flush(struct nvmet_req *req)
>   static u16 nvmet_discard_range(struct nvmet_ns *ns,
>   		struct nvme_dsm_range *range, struct bio **bio)
>   {
> -	if (__blkdev_issue_discard(ns->bdev,
> +	int ret;
> +
> +	ret = __blkdev_issue_discard(ns->bdev,
>   			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
>   			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
> -			GFP_KERNEL, 0, bio))
> +			GFP_KERNEL, 0, bio);
> +	if (ret && ret != -EOPNOTSUPP)
>   		return NVME_SC_INTERNAL | NVME_SC_DNR;
>   	return 0;
>   }
> 
