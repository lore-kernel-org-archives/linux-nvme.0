From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Nov 2018 23:21:33 -0800
Subject: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181126163556.5181-6-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk>
Message-ID: <20181128072133.GC11774@infradead.org>

On Mon, Nov 26, 2018@09:35:53AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
