From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Apr 2017 22:24:15 +0000
Subject: block: remove the blk_execute_rq return value
In-Reply-To: <20170418155229.5977-2-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-2-hch@bombadil.infradead.org>
Message-ID: <1492554253.2689.15.camel@sandisk.com>

On Tue, 2017-04-18@08:52 -0700, Christoph Hellwig wrote:
> diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
> index b05e151c9b38..82c6d02193ae 100644
> --- a/drivers/block/paride/pd.c
> +++ b/drivers/block/paride/pd.c
> @@ -747,7 +747,8 @@ static int pd_special_command(struct pd_unit *disk,
>  
>  	rq->special = func;
>  
> -	err = blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
> +	blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
> +	err = req->errors ? -EIO : 0;
>  
>  	blk_put_request(rq);
>  	return err;

Hello Christoph,

Sorry that I hadn't noticed this before but shouldn't "req" be changed into
"rq"? Otherwise this patch looks fine to me. If this comment gets addressed
you can add:

Reviewed-by: Bart Van Assche <bart.vanassche at sandisk.com>
