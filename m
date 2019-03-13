From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 13 Mar 2019 11:02:34 +0200
Subject: [PATCH 1/2] nvmet: ignore EOPNOTSUPP for discard
In-Reply-To: <20190312170635.25470-1-hch@lst.de>
References: <20190312170635.25470-1-hch@lst.de>
Message-ID: <1af75a27-65a7-212c-c537-0090e4833889@mellanox.com>


On 3/12/2019 7:06 PM, Christoph Hellwig wrote:
> NVMe DSM is a pure hint, so if the underlying device / file system
> does not support discard-like operations we should not fail the
> operation but rather return success.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 7 ++++---
>   drivers/nvme/target/io-cmd-file.c | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 71dfedbadc26..df7e00de0dcd 100644
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
> +		return blk_to_nvme_status(req, errno_to_blk_status(ret));
> +	}

this was fixed in the past by IsraelR commit and somehow got broken in 
commit 3b031d15995f3e4c (nvmet: add error log support for bdev backend)

can you please add a "fixes" clause to the commit message ?



>   
> -	return blk_to_nvme_status(req, errno_to_blk_status(ret));
> +	return 0;

maybe we can return NVME_SC_SUCCESS (not really a must)


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
