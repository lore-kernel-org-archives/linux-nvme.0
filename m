From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 17 Dec 2018 05:56:20 -0700
Subject: [PATCH 1/2] blk-mq: only dispatch to non-defauly queue maps if
 they have queues
In-Reply-To: <20181217111627.22635-1-hch@lst.de>
References: <20181217111627.22635-1-hch@lst.de>
Message-ID: <1bab4b15-35a5-f59f-184d-d4690b945837@kernel.dk>

On 12/17/18 4:16 AM, Christoph Hellwig wrote:
> We should check if a given queue map actually has queues enabled before
> dispatching to it.  This allows drivers to not initialize optional but
> not used map types, which subsequently will allow fixing problems with
> queue map rebuilds for that case.

Applied, thanks.


-- 
Jens Axboe
