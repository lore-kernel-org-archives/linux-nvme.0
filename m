From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 12 Mar 2019 16:58:20 +0000
Subject: [PATCH] nvmet: ignore EOPNOTSUPP for discard
References: <20190312153005.19373-1-hch@lst.de>
Message-ID: <SN6PR04MB45274EEAD33D2D744B69EF5386490@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

On 3/12/19 8:30 AM, Christoph Hellwig wrote:
> NVMe DSM is a pure hint, so if the underlying device / file system
> does not support discard-like operations we should not fail the
> operation but rather return success.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 7 ++++---
>   drivers/nvme/target/io-cmd-file.c | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 71dfedbadc26..28d742d7bdaf 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -194,11 +194,12 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
>   			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
>   			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
>   			GFP_KERNEL, 0, bio);
> -
> -	if (ret)
> +	if (ret && ret != -EOPNOTSUPP) {
>   		req->error_slba = le64_to_cpu(range->slba);
> +		return errno_to_nvme_status(req, ret);
> +	}
>   
> -	return blk_to_nvme_status(req, errno_to_blk_status(ret));
> +	return 0;
>   }
>   
>   static void nvmet_bdev_execute_discard(struct nvmet_req *req)
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 517522305e5c..3e43212d3c1c 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -297,7 +297,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
>   		}
>   
>   		ret = vfs_fallocate(req->ns->file, mode, offset, len);
> -		if (ret) {
> +		if (ret && ret != -EOPNOTSUPP) {
>   			req->error_slba = le64_to_cpu(range.slba);
>   			status = errno_to_nvme_status(req, ret);
>   			break;
> 
