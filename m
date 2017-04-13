From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 13 Apr 2017 20:03:22 +0000
Subject: [PATCH 02/25] block: remove the blk_execute_rq return value
In-Reply-To: <20170406153944.10058-3-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-3-hch@lst.de>
Message-ID: <1492113800.24345.9.camel@sandisk.com>

On Thu, 2017-04-06@17:39 +0200, Christoph Hellwig wrote:
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 92b4b41d19d2..4b72fdf67548 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -242,8 +242,8 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
>  	req->cmd[4] = bufflen & 0xff;
>  	req->cmd_len = COMMAND_SIZE(INQUIRY);
>  
> -	error = blk_execute_rq(rq->q, NULL, rq, 1);
> -	if (error) {
> +	blk_execute_rq(rq->q, NULL, rq, 1);
> +	if (rq->errors) {
>  		pr_err("pNFS: INQUIRY 0x83 failed with: %x\n",
>  			rq->errors);
>  		goto out_put_request;

Hello Christoph,

That blk_execute_rq() call can only be reached if a few lines above 0 was
assigned to the "error" variable. Since nfsd4_scsi_identify_device() returns
the value of the "error" variable I think -EIO should be assigned to that
variable before the "goto out_put_request" statement is reached.

Bart.
