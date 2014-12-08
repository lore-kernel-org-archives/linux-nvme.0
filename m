From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 08 Dec 2014 12:18:42 -0700
Subject: [PATCH] NVMe: Fix abort handling
In-Reply-To: <5485FA49.8020707@micron.com>
References: <5485FA49.8020707@micron.com>
Message-ID: <5485F992.7010000@kernel.dk>

On 12/08/2014 12:21 PM, Sam Bradshaw wrote:
> This patch fixes some problems in the abort handling code; freeing the
> correct request (abort_req) and setting abort_limit & rq_aborted if
> submitted the abort request fails.  In addition, a device reset is
> scheduled pro-actively if the device fails to successful abort a command
> rather than waiting for the timeout handler to disposition the condition.

Generally I'm not a huge fan of patches that end up having "in addition" 
or "additionally" in the commit message, that's usually a clear sign 
that it should have been two (or more) patches.

I'll cut this hunk:

> @@ -1054,7 +1066,9 @@ static void nvme_abort_req(struct request *req)
>   		dev_warn(nvmeq->q_dmadev,
>   				"Could not abort I/O %d QID %d",
>   				req->tag, nvmeq->qid);
> -		blk_mq_free_request(req);
> +		blk_mq_free_request(abort_req);
> +		++dev->abort_limit;
> +		cmd_rq->aborted = 0;
>   	}
>   }

since that's a clear bug fix, and you can hash out the details on the 
reset handling with Keith, since he's a lot more qualified to render an 
opinion on that.

OK?

-- 
Jens Axboe
