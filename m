From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Nov 2018 00:05:59 -0800
Subject: [PATCH 7/7] blk-mq: ensure mq_ops ->poll() is entered at least
 once
In-Reply-To: <20181117214354.822-8-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-8-axboe@kernel.dk>
Message-ID: <20181119080558.GG9622@infradead.org>

On Sat, Nov 17, 2018@02:43:54PM -0700, Jens Axboe wrote:
> Right now we immediately bail if need_resched() is true, but
> we need to do at least one loop in case we have entries waiting.
> So just invert the need_resched() check, putting it at the
> bottom of the loop.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
