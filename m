From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 19 Apr 2017 21:07:45 +0000
Subject: [PATCH 02/23] block: remove the blk_execute_rq return value
In-Reply-To: <20170419192708.22098-3-hch@lst.de>
References: <20170419192708.22098-1-hch@lst.de>
 <20170419192708.22098-3-hch@lst.de>
Message-ID: <1492636063.2543.18.camel@sandisk.com>

On Wed, 2017-04-19@21:26 +0200, Christoph Hellwig wrote:
> --- a/drivers/scsi/osd/osd_initiator.c
> +++ b/drivers/scsi/osd/osd_initiator.c
> @@ -489,7 +489,10 @@ static void _set_error_resid(struct osd_request *or, struct request *req,
>  
>  int osd_execute_request(struct osd_request *or)
>  {
> -	int error = blk_execute_rq(or->request->q, NULL, or->request, 0);
> +	int error;
> +
> +	blk_execute_rq(or->request->q, NULL, or->request, 0);
> +	error = or->request ? -EIO : 0;

Hello Christoph,

Did you perhaps intend or->request->errors instead of or->request?

Otherwise this patch looks fine to me.

Bart.
