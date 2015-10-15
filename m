From: axboe@fb.com (Jens Axboe)
Date: Thu, 15 Oct 2015 09:04:26 -0600
Subject: [PATCH] nvme: use an integer value to Linux errno values
In-Reply-To: <1444677819-23822-1-git-send-email-hch@lst.de>
References: <1444677819-23822-1-git-send-email-hch@lst.de>
Message-ID: <561FC07A.10205@fb.com>

On 10/12/2015 01:23 PM, Christoph Hellwig wrote:
> Use a separate integer variable to hold the signed Linux errno
> values we pass back to the block layer.  Note that for pass through
> commands those might still be NVMe values, but those fit into the
> int as well.
>
> Fixes: f4829a9b7a61: ("blk-mq: fix racy updates of rq->errors")
> Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me. I'll manually fold this into the 4.3 base as well.

-- 
Jens Axboe
