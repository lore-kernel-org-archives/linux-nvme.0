From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Apr 2017 15:28:27 +0000
Subject: [PATCH 16/23] blk-mq: remove the error argument to
 blk_mq_complete_request
In-Reply-To: <20170420140316.6546-17-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-17-hch@lst.de>
Message-ID: <1492702106.2642.4.camel@sandisk.com>

On Thu, 2017-04-20@16:03 +0200, Christoph Hellwig wrote:
> Now that all drivers that call blk_mq_complete_requests have a
> ->complete callback we can remove the direct call to blk_mq_end_request,
> as well as the error argument to blk_mq_complete_request.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
