From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jan 2018 20:30:45 +0200
Subject: [PATCH] nvmet: Change error code of discard command if not
 supported
In-Reply-To: <1517234450-16502-1-git-send-email-israelr@mellanox.com>
References: <1517234450-16502-1-git-send-email-israelr@mellanox.com>
Message-ID: <0012e13c-a621-fdc3-f072-294641b00136@grimberg.me>


> Execute discard command on block device that doesn't support it
> should return not supported error.
> Returning internal error while using multi-path fails the path.
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> ---
>   drivers/nvme/target/io-cmd.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index 0a4372a..00d4607a 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c
> @@ -105,10 +105,15 @@ static void nvmet_execute_flush(struct nvmet_req *req)
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
> +	if (ret == -EOPNOTSUPP)
> +		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;

Actually I don't think we are allowed to fail with this status. We claim
we support dsm regardless of the underlying backend device (because we
can expose different devices in the same subsystem), so we can't fail
a valid dsm command on invalid opcode. Either we keep the existing
behavior or we simply return success as dsm is a hint anyways...

> +	else if (ret)
>   		return NVME_SC_INTERNAL | NVME_SC_DNR;
>   	return 0;
>   }
> 
