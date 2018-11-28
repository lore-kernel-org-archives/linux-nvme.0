From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Nov 2018 23:22:36 -0800
Subject: [PATCH 6/8] ataflop: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181126163556.5181-7-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-7-axboe@kernel.dk>
Message-ID: <20181128072236.GD11774@infradead.org>

On Mon, Nov 26, 2018@09:35:54AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.

queue_rq also calls finish_fdc under atari_disable_irq( IRQ_MFP_FDC ),
do we need that here as well?
