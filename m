From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 23 May 2018 18:07:15 +0300
Subject: [PATCH] nvme: host: core: fix precedence of ternary operator
In-Reply-To: <20180523145611.10297-1-brnkv.i1@gmail.com>
References: <20180523145611.10297-1-brnkv.i1@gmail.com>
Message-ID: <2cdc9032-901d-fbec-69e5-63087923e4b1@mellanox.com>



On 5/23/2018 5:56 PM, Ivan Bornyakov wrote:
> Ternary operator have lower precedence then bitwise or, so 'cdw10' was
> calculated wrong.
> 
> Signed-off-by: Ivan Bornyakov <brnkv.i1 at gmail.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b070c659391f..1eba9b0cb9dc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1577,7 +1577,7 @@ static int nvme_pr_reserve(struct block_device *bdev, u64 key,
>   static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
>   		enum pr_type type, bool abort)
>   {
> -	u32 cdw10 = nvme_pr_type(type) << 8 | abort ? 2 : 1;
> +	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
>   	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
>   }
>   
> @@ -1589,7 +1589,7 @@ static int nvme_pr_clear(struct block_device *bdev, u64 key)
>   
>   static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
>   {
> -	u32 cdw10 = nvme_pr_type(type) << 8 | key ? 1 << 3 : 0;
> +	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
>   	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
>   }
>   
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
