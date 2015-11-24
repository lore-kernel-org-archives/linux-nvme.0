From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 14:21:10 -0700
Subject: [PATCH 06/47] blk-mq: add a flags parameter to
 blk_mq_alloc_request
In-Reply-To: <1448037342-18384-7-git-send-email-hch@lst.de>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-7-git-send-email-hch@lst.de>
Message-ID: <5654D4C6.7010601@fb.com>

On 11/20/2015 09:35 AM, Christoph Hellwig wrote:
> We already have the reserved flag, and a nowait flag awkwardly encoded as
> a gfp_t.  Add a real flags argument to make the scheme more extensible and
> allow for a nicer calling convention.

I've been reviewing these in the nvme-req.9 branch, I'll pick them out 
when for-4.5/xx is forked off. That should happen when Linus pulls the 
recent for-linus pull request.

This one looks fine, but:

>   create mode 100644 drivers/nvme/host/core.c

that should obviously not be there.

-- 
Jens Axboe
