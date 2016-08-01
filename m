From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 13:00:15 +0200
Subject: [PATCH 1/5] nvme-rdma: Fix device removal handling
In-Reply-To: <1469822242-3477-2-git-send-email-sagi@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-2-git-send-email-sagi@grimberg.me>
Message-ID: <20160801110015.GB16141@lst.de>

On Fri, Jul 29, 2016@10:57:18PM +0300, Sagi Grimberg wrote:
> Device removal sequence may have crashed because the
> controller (and admin queue space) was freed before
> we destroyed the admin queue resources. Thus we
> want to destroy the admin queue and only then queue
> controller deletion and wait for it to complete.
> 
> More specifically we:
> 1. own the controller deletion (make sure we are not
>    competing with another deletion).
> 2. get rid of inflight reconnects if exists (which
>    also destroy and create queues).
> 3. destroy the queue.
> 4. safely queue controller deletion (and wait for it
>    to complete).
> 
> Reported-by: Steve Wise <swise at opengridcomputing.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
