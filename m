From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:22:54 +0200
Subject: [PATCH 6/6] nvme: ignore retries for multipath devices
In-Reply-To: <1506952559-1588-7-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-7-git-send-email-hare@suse.de>
Message-ID: <20171002162254.GA11497@lst.de>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1ef11ca..ac7676a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -201,7 +201,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
>  		return false;
>  	if (nvme_req(req)->status & NVME_SC_DNR)
>  		return false;
> -	if (nvme_req(req)->retries >= nvme_max_retries)
> +	if (nvme_req(req)->retries >= nvme_max_retries &&
> +	    !(req->cmd_flags & REQ_NVME_MPATH))
>  		return false;
>  	return true;

All failover logic is inside a nvme_req_needs_retry() conditional,
so this change looks completely broken - it basically disables
failover.
