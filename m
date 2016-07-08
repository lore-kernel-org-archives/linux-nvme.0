From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 8 Jul 2016 08:46:41 -0500
Subject: [PATCH 1/5] blk-mq: Introduce blk_mq_reinit_tagset
In-Reply-To: <1467809752-31320-2-git-send-email-hch@lst.de>
References: <1467809752-31320-1-git-send-email-hch@lst.de>
 <1467809752-31320-2-git-send-email-hch@lst.de>
Message-ID: <003401d1d91f$28a153d0$79e3fb70$@opengridcomputing.com>

> From: Sagi Grimberg <sagi at grimberg.me>
> 
> The new nvme-rdma driver will need to reinitialize all the tags as part of
> the error recovery procedure (realloc the tag memory region). Add a helper
> in blk-mq for it that can iterate over all requests in a tagset to make
> this easier.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Tested-by: Ming Lin <ming.l at ssi.samsung.com>
> Reviewed-by: Stephen Bates <Stephen.Bates at pmcs.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks fine.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
