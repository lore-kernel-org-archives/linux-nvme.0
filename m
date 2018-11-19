From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Nov 2018 08:57:37 +0100
Subject: [PATCH] nvme: default to 0 poll queues
In-Reply-To: <a2d999c8-135a-745f-07c2-e6c2dc52fff1@kernel.dk>
References: <a2d999c8-135a-745f-07c2-e6c2dc52fff1@kernel.dk>
Message-ID: <20181119075737.GA10256@lst.de>

On Sat, Nov 17, 2018@10:06:20AM -0700, Jens Axboe wrote:
> We need a better way of configuring this, and given that
> polling is (still) a bit niche, let's default to using
> 0 poll queues. That way we'll have the same read/write/poll
> behavior as 4.20, and users that want to test/use polling
> are required to do manual configuration of the number of
> poll queues.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Looks good (except that you could use more of each line for the
commit log).

Reviewed-by: Christoph Hellwig <hch at lst.de>

Given that the poll queues were introduced in the block tree, can you
queue it up there?
