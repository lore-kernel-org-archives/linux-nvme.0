From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 27 Sep 2015 10:35:17 +0300
Subject: [PATCH 1/7] blk-mq: fix racy updates of rq->errors
In-Reply-To: <1442860853-26447-2-git-send-email-hch@lst.de>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
 <1442860853-26447-2-git-send-email-hch@lst.de>
Message-ID: <56079C35.207@dev.mellanox.co.il>

On 9/21/2015 9:40 PM, Christoph Hellwig wrote:
> blk_mq_complete_request may be a no-op if the request has already
> been completed by others means (e.g. a timeout or cancellation), but
> currently drivers have to set rq->errors before calling
> blk_mq_complete_request, which might leave us with the wrong error value.
>
> Add an error parameter to blk_mq_complete_request so that we can
> defer setting rq->errors until we known we won the race to complete the
> request.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
