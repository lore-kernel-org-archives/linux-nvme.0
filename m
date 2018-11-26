From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Nov 2018 09:02:30 -0800
Subject: [PATCH 1/8] block: sum requests in the plug structure
In-Reply-To: <20181126163556.5181-2-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-2-axboe@kernel.dk>
Message-ID: <20181126170230.GA5816@infradead.org>

On Mon, Nov 26, 2018@09:35:49AM -0700, Jens Axboe wrote:
> This isn't exactly the same as the previous count, as it includes
> requests for all devices. But that really doesn't matter, if we have
> more than the threshold (16) queued up, flush it. It's not worth it
> to have an expensive list loop for this.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
