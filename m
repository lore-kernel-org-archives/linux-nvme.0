From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 12:16:55 -0600
Subject: kill req->errors V4
In-Reply-To: <20170420140316.6546-1-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
Message-ID: <20170420181654.GC22378@kernel.dk>

On Thu, Apr 20 2017, Christoph Hellwig wrote:
> Currently the request structure has an errors field that is used in
> various different ways.  The oldest drivers use it as an error count,
> blk-mq and the generic timeout code assume that it holds a Linux
> errno for block completions, and various drivers use it for internal
> status values, often overwriting them with Linux errnos later,
> that is unless they are processing passthrough requests in which
> case they'll leave their errors in it.
> 
> This series kills the ->errors field and replaced it with new fields
> in the drivers (or an odd hack in a union in struct request for
> two bitrotting old drivers).

Applied for 4.12, thanks.

-- 
Jens Axboe
