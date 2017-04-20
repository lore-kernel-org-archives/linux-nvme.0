From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Apr 2017 15:19:01 +0000
Subject: [PATCH 02/23] block: remove the blk_execute_rq return value
In-Reply-To: <20170420140316.6546-3-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-3-hch@lst.de>
Message-ID: <1492701540.2642.0.camel@sandisk.com>

On Thu, 2017-04-20@16:02 +0200, Christoph Hellwig wrote:
> The function only returns -EIO if rq->errors is non-zero, which is not
> very useful and lets a large number of callers ignore the return value.
> 
> Just let the callers figure out their error themselves.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
