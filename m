From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:23:54 +0200
Subject: [PATCH v3 05/11] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
In-Reply-To: <7b52319b-03f7-e432-909a-2f46232770c6@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <7b52319b-03f7-e432-909a-2f46232770c6@sandisk.com>
Message-ID: <20161019132354.GE6323@lst.de>

On Tue, Oct 18, 2016@02:51:02PM -0700, Bart Van Assche wrote:
> Most blk_mq_requeue_request() and blk_mq_add_to_requeue_list() calls
> are followed by kicking the requeue list. Hence add an argument to
> these two functions that allows to kick the requeue list. This was
> proposed by Christoph Hellwig.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>

Thanks Bart, this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
