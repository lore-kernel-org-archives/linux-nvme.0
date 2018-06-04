From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:32:22 +0200
Subject: [PATCH 4/9] nvme: always failover on path or transport errors
In-Reply-To: <20180601071128.7630-5-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-5-hch@lst.de>
Message-ID: <20180604083222.28b280d6@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:23 +0200
Christoph Hellwig <hch@lst.de> wrote:

> NVMe 1.3 TP 4028 introduced a new status code type 3h for
> "Path Related Status".  We should always retry on another path for
> this class of errors, without even trying to decode them.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/multipath.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c
> b/drivers/nvme/host/multipath.c index d7b664ae5923..9412e5138d65
> 100644 --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -59,6 +59,9 @@ bool nvme_req_needs_failover(struct request *req,
> blk_status_t error) {
>  	if (!(req->cmd_flags & REQ_NVME_MPATH))
>  		return false;
> +	/* always failover for path related errors */
> +	if ((nvme_req(req)->status & 0x700) == 0x300)
> +		return true;
>  	return blk_path_error(error);
>  }
>  

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
