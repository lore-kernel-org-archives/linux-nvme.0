From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 16 Jul 2018 07:30:59 -0600
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180716103956.GB25386@ming.t460p>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <9bd80570-5b7d-c093-ffbb-a8fbcaa58db0@oracle.com>
 <20180716103956.GB25386@ming.t460p>
Message-ID: <20180716133059.GB19967@localhost.localdomain>

On Mon, Jul 16, 2018@06:39:57PM +0800, Ming Lei wrote:
> On Mon, Jul 16, 2018@04:52:39PM +0800, jianchao.wang wrote:
> > Hi Keith
> > 
> > On 07/14/2018 04:56 AM, Keith Busch wrote:
> > > This patch fixes races that occur with simultaneous controller
> > > resets by synchronizing request queues prior to initializing the
> > > controller. Withouth this, a thread may attempt disabling a controller
> > > at the same time as we're trying to enable it.
> > 
> > This issue is due to the previous blk-mq timeout mechanism will hold
> > all the timed out requests, then nvme_dev_disable cannot grab these requests
> > and when it returns, the blk_mq_timeout_work could be still running.
> > But after commit 12f5b9314545 ("blk-mq: Remove generation seqeunce"),
> > nvme_dev_disble have been able to grab all the requests and when it returns,
> > there will be no any requests in blk_mq_timeout_work so nvme_dev_disable will
> > not be invoked multiple times.
> > So this patch should be unnecessary. :)
> 
> There are multiple namespaces, and all may trigger timeout at the same
> time, so looks the sync is still needed.

Yes, we still need this syncing because each namespace has a different
request queue with their own timeout work.

As an alternative, I looked into having timeout work per tagset rather
than per request-queue, but that turned into a more complicated change
than this patch.
