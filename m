From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Apr 2017 22:34:20 +0000
Subject: scsi: introduce a new result field in struct scsi_request
In-Reply-To: <20170418155229.5977-8-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-8-hch@bombadil.infradead.org>
Message-ID: <1492554858.2689.17.camel@sandisk.com>

On Tue, 2017-04-18@08:52 -0700, Christoph Hellwig wrote:
> --- a/block/bsg.c
> +++ b/block/bsg.c
> @@ -391,13 +391,13 @@ static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
>  	struct scsi_request *req = scsi_req(rq);
>  	int ret = 0;
>  
> -	dprintk("rq %p bio %p 0x%x\n", rq, bio, rq->errors);
> +	dprintk("rq %p bio %p 0x%x\n", rq, bio, rq->result);

Hello Christoph,

Did you perhaps intend "req->result" instead of "rq->result"?

> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -229,8 +229,8 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
>   * @rq_flags:	flags for ->rq_flags
>   * @resid:	optional residual length
>   *
> - * returns the req->errors value which is the scsi_cmnd result
> - * field.
> + * Returns the scsi_cmnd result field if a command was executed, or a negative
> + * Linux error code if we didn't get that war.

Did you intend "war" or is that perhaps a typo?

> @@ -1905,7 +1904,7 @@ static int scsi_mq_prep_fn(struct request *req)
>  static void scsi_mq_done(struct scsi_cmnd *cmd)
>  {
>  	trace_scsi_dispatch_cmd_done(cmd);
> -	blk_mq_complete_request(cmd->request, cmd->request->errors);
> +	blk_mq_complete_request(cmd->request, 0);
>  }

Why has cmd->request->errors been changed into 0?

Bart.
