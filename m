From: kbusch@kernel.org (Keith Busch)
Date: Mon, 22 Apr 2019 08:57:46 -0600
Subject: [PATCH] nvmet: loop: kill timeout handler
In-Reply-To: <20190415015146.22580-1-ming.lei@redhat.com>
References: <20190415015146.22580-1-ming.lei@redhat.com>
Message-ID: <20190422145746.GA13273@localhost.localdomain>

On Sun, Apr 14, 2019@06:51:46PM -0700, Ming Lei wrote:
> Firstly it doesn't make sense to handle timeout for loop: 1) for admin
> queue, the request is always completed in code path of queuing IO. 2)
> for normal IO request, the timeout on these IOs have been handled by
> underlying queue already.
> 
> Secondly nvme-loop's timeout handler is simply broken, and easy to
> cause issue: 1) no any sync/protection between timeout and normal
> completion, and now it is driver's responsibility to deal with
> that; 2) bad reset implementation, blk_mq_update_nr_hw_queues()
> is called after all NSs's queue is stopped(quiesced), and easy
> to trigger deadlock.
> 
> So kill the timeout handler.

Makes sense to me, looks good.

Reviewd-by: Keith Busch <keith.busch at intel.com>
