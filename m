From: jmoyer@redhat.com (Jeff Moyer)
Date: Fri, 20 Nov 2015 17:20:21 -0500
Subject: [PATCH 02/47] block: fix blk_abort_request for blk-mq drivers
In-Reply-To: <1448037342-18384-3-git-send-email-hch@lst.de> (Christoph
 Hellwig's message of "Fri, 20 Nov 2015 17:34:57 +0100")
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-3-git-send-email-hch@lst.de>
Message-ID: <x49oaeob9ei.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

> We only added the request to the request list for the !blk-mq case,
> so we should only delete it in that case as well.

I think I'd rather see the conditional moved into blk_delete_timer.
Breaking the balance of add/delete seems ugly to me.  I had expected to
see a later patch make use of the list, but nothing does.  So, this is
just a cleanup (as opposed to a preparatory patch), yes ?

-Jeff

> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/blk-timeout.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index 246dfb1..aa40aa9 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -158,11 +158,13 @@ void blk_abort_request(struct request *req)
>  {
>  	if (blk_mark_rq_complete(req))
>  		return;
> -	blk_delete_timer(req);
> -	if (req->q->mq_ops)
> +
> +	if (req->q->mq_ops) {
>  		blk_mq_rq_timed_out(req, false);
> -	else
> +	} else {
> +		blk_delete_timer(req);
>  		blk_rq_timed_out(req);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(blk_abort_request);
