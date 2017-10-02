From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:19:29 +0200
Subject: [PATCH] nvme: reset retires after path failover
In-Reply-To: <20171002143503.14507-1-jthumshirn@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <20171002143503.14507-1-jthumshirn@suse.de>
Message-ID: <20171002161929.GE11048@lst.de>

On Mon, Oct 02, 2017@04:35:03PM +0200, Johannes Thumshirn wrote:
> When we do a path failover we should also reset the retry counter to 0
> so we're not accidently failing I/O after a path failover.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1ef11ca0fc5e..f1d8b239b7b6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -118,6 +118,7 @@ static void nvme_failover_req(struct request *req)
>  	blk_mq_end_request(req, 0);
>  
>  	nvme_reset_ctrl(ns->ctrl);
> +	nvme_req(req)->retries = 0;

Once we called blk_mq_end_request the request is gone, so this is
use after free.  And also very odd given that any multipath resubmit
will allocate a new request, so I can't see how it could help to start
with.
