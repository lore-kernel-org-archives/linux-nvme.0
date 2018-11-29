From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 29 Nov 2018 07:47:36 -0800
Subject: [PATCH 5/7] ataflop: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181128133538.20329-6-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-6-axboe@kernel.dk>
Message-ID: <20181129154736.GD7234@infradead.org>

On Wed, Nov 28, 2018@06:35:36AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.
> 
> Reviewed-by: Omar Sandoval <osandov at fb.com>
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
