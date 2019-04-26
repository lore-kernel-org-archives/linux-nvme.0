From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Apr 2019 17:09:09 +0200
Subject: [PATCH V7 4/9] blk-mq: move all hctx alloction &
 initialization into __blk_mq_alloc_and_init_hctx
In-Reply-To: <20190425005542.GC22636@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-5-ming.lei@redhat.com> <20190424162223.GD23854@lst.de>
 <20190425005542.GC22636@ming.t460p>
Message-ID: <20190426150909.GA20438@lst.de>

On Thu, Apr 25, 2019@08:55:43AM +0800, Ming Lei wrote:
> It prepares for the following patch, otherwise the whole patch may
> become difficult to review.

Honestly, I'd find it much easier to review if this was folded into
the next patch.  That way we only move things around once instead
of twice.
