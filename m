From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 18 Nov 2018 23:59:04 -0800
Subject: [PATCH 3/7] nvme-fc: remove unused poll implementation
In-Reply-To: <20181117214354.822-4-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-4-axboe@kernel.dk>
Message-ID: <20181119075904.GC9622@infradead.org>

On Sat, Nov 17, 2018@02:43:50PM -0700, Jens Axboe wrote:
> This relies on the fc taget ops setting ->poll_queue, which
> nobody does. Otherwise it just checks if something has
> completed, which isn't very useful.

Please also remove the unused ->poll_queue method.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
