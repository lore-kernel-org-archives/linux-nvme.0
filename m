From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Apr 2018 08:58:13 -0600
Subject: [PATCH v2] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
References: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
Message-ID: <20180402145813.GE28945@localhost.localdomain>

On Mon, Apr 02, 2018@11:49:41AM -0300, Rodrigo R. Galvao wrote:
> When trying to issue write_zeroes command against TARGET with a 4K block
> size, it ends up hitting the following condition at __blkdev_issue_zeroout:
> 
>      if ((sector | nr_sects) & bs_mask)
>                 return -EINVAL;
> 
> Causing the command to always fail.
> Considering we need to add 1 to get the correct block count, that addition
> needs to be performed in the native format, so we moved the +1 to within
> le16_to_cpu prior to converting to 512b.
> 
> Signed-off-by: Rodrigo R. Galvao <rosattig at linux.vnet.ibm.com>
> ---
>  drivers/nvme/target/io-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index 28bbdff..5292bc3 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c
> @@ -173,8 +173,8 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
>  
>  	sector = le64_to_cpu(write_zeroes->slba) <<
>  		(req->ns->blksize_shift - 9);
> -	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
> -		(req->ns->blksize_shift - 9)) + 1;
> +	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length + 1)) <<
> +		(req->ns->blksize_shift - 9));

I'm terribly sorry, but the +1 actually needs to be outside the
le16_to_cpu. The above will work on little-endian machines, but not big.
