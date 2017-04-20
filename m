From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Apr 2017 15:25:37 +0000
Subject: [PATCH 11/23] dm rq: don't pass irrelevant error code to
 blk_mq_complete_request
In-Reply-To: <20170420140316.6546-12-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-12-hch@lst.de>
Message-ID: <1492701936.2642.2.camel@sandisk.com>

On Thu, 2017-04-20@16:03 +0200, Christoph Hellwig wrote:
> dm never uses rq->errors, so there is no need to pass an error argument
> to blk_mq_complete_request.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
