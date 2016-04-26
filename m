From: axboe@fb.com (Jens Axboe)
Date: Tue, 26 Apr 2016 08:31:07 -0600
Subject: [PATCH] nvme: fix cntlid type
In-Reply-To: <1460833078-15646-1-git-send-email-hch@lst.de>
References: <1460833078-15646-1-git-send-email-hch@lst.de>
Message-ID: <571F7BAB.6080808@fb.com>

On 04/16/2016 12:57 PM, Christoph Hellwig wrote:
> Controller IDs in NVMe are unsigned 16-bit types.  In the Fabrics driver we
> actually pass ctrl->id by reference, so we need it to have the correct type.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/nvme.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 8e8fae8..9b96e75 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -84,7 +84,7 @@ struct nvme_ctrl {
>   	char serial[20];
>   	char model[40];
>   	char firmware_rev[8];
> -	int cntlid;
> +	u16 cntlid;
>
>   	u32 ctrl_config;

Looks fine, added for 4.7.

-- 
Jens Axboe
