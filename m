From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 8 Oct 2017 12:32:15 +0300
Subject: [PATCH] nvme: simplify compat_ioctl handling
In-Reply-To: <20171005164646.17473-1-hch@lst.de>
References: <20171005164646.17473-1-hch@lst.de>
Message-ID: <3b12ebd1-7282-a807-25e8-7cabde16486a@mellanox.com>



On 10/5/2017 7:46 PM, Christoph Hellwig wrote:
> We can just use our normal ioctl handler for the compat case and remove
> the boilerplate code for it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 26c8913435b2..573cc3b59bfa 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c

Looks good,
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
