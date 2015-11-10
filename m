From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Nov 2015 06:56:04 +0100
Subject: [PATCH 06/12] nvme: switch abort to blk_execute_rq_nowait
In-Reply-To: <56411452.8060509@kernel.dk>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-7-git-send-email-hch@lst.de>
 <20151109212844.GD5386@localhost.localdomain> <56411452.8060509@kernel.dk>
Message-ID: <20151110055604.GA19753@lst.de>

On Mon, Nov 09, 2015@02:46:58PM -0700, Jens Axboe wrote:
> Looks like a mixup of __GFP_WAIT and 'reserved'. Looks like we need to pass 
> in both 'nowait' and 'reserved' to nvme_alloc_request(), so it can do the 
> right thing.
>
> Though both call sites should tolerate sleeping, since we changed the 
> timeout handler to be in process context.

My earlier series actually had a patch to pass a flags argument to
blk_mq_alloc_request instead of the gfp_mask and the nowait bool,
I'll resurrect it.
