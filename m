From: snitzer@redhat.com (Mike Snitzer)
Date: Fri, 1 Jun 2018 11:27:11 -0400
Subject: [PATCH 4/9] nvme: always failover on path or transport errors
In-Reply-To: <20180601071128.7630-5-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-5-hch@lst.de>
Message-ID: <20180601152711.GA98855@redhat.com>

On Fri, Jun 01 2018 at  3:11P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> NVMe 1.3 TP 4028 introduced a new status code type 3h for
> "Path Related Status".  We should always retry on another path for this
> class of errors, without even trying to decode them.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/multipath.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d7b664ae5923..9412e5138d65 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -59,6 +59,9 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error)
>  {
>  	if (!(req->cmd_flags & REQ_NVME_MPATH))
>  		return false;
> +	/* always failover for path related errors */
> +	if ((nvme_req(req)->status & 0x700) == 0x300)
> +		return true;
>  	return blk_path_error(error);
>  }

Shouldn't this go into nvme_error_status(), with a new NVME_SC if
needed, so that blk_path_error() just works?

Mike
