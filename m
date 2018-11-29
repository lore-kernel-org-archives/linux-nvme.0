From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 29 Nov 2018 07:49:12 -0800
Subject: [PATCH 6/7] blk-mq: use bd->last == true for list inserts
In-Reply-To: <20181128133538.20329-7-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-7-axboe@kernel.dk>
Message-ID: <20181129154912.GE7234@infradead.org>

On Wed, Nov 28, 2018@06:35:37AM -0700, Jens Axboe wrote:
> If we are issuing a list of requests, we know if we're at the last one.
> If we fail issuing, ensure that we call ->commits_rqs() to flush any
> potential previous requests.
> 
> Reviewed-by: Omar Sandoval <osandov at fb.com>
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
