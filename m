From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:18:58 +0100
Subject: [PATCH v2 1/3] nvme-rdma: don't suppress send completions
In-Reply-To: <20171108100616.26605-2-sagi@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-2-sagi@grimberg.me>
Message-ID: <20171109091858.GA16966@lst.de>

On Wed, Nov 08, 2017@12:06:14PM +0200, Sagi Grimberg wrote:
> The entire completions suppress mechanism is currently
> broken because the HCA might retry a send operation
> (due to dropped ack) after the nvme transaction has completed.
> 
> In order to handle this, we signal all send completions (besides
> async event which is not racing anything).

Oh well, so much for all these unsignalled completion optimizations..

So in which cases do unsignalled completions work at all?  Seems like
we need to fix up a lot of other ULPs as well.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

> -	 */
> -	if (nvme_rdma_queue_sig_limit(queue) || flush)
> -		wr.send_flags |= IB_SEND_SIGNALED;
> +	wr.send_flags = IB_SEND_SIGNALED;

But..  Is there any benefit in just setting IB_SIGNAL_ALL_WR on the QP?
