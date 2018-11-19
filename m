From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Nov 2018 00:02:56 -0800
Subject: [PATCH 5/7] blk-mq: remove 'tag' parameter from mq_ops->poll()
In-Reply-To: <20181117214354.822-6-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-6-axboe@kernel.dk>
Message-ID: <20181119080256.GE9622@infradead.org>

On Sat, Nov 17, 2018@02:43:52PM -0700, Jens Axboe wrote:
> We always pass in -1 now and none of the callers use the tag value,
> remove the parameter.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
