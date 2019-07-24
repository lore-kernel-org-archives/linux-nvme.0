From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Jul 2019 10:05:02 +0800
Subject: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
In-Reply-To: <8d6268ac-42cb-d14a-d4c3-c8c285fca6b5@oracle.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
 <8d6268ac-42cb-d14a-d4c3-c8c285fca6b5@oracle.com>
Message-ID: <20190724020500.GE22421@ming.t460p>

On Wed, Jul 24, 2019@12:14:24AM +0800, Dongli Zhang wrote:
> Hi Ming,
> 
> On 07/22/2019 01:39 PM, Ming Lei wrote:
> > When aborting in-flight request for recoverying controller, we have
> 
> recovering
> 
> > maken sure that queue's complete function is called on completed
> > request before moving one. For example, the warning of
> > WARN_ON_ONCE(qp->mrs_used > 0) in ib_destroy_qp_user() may be triggered.
> > 
> > Fix this issue by using blk_mq_tagset_drain_completed_request.
> > 
> 
> Should be blk_mq_tagset_wait_completed_request but not
> blk_mq_tagset_drain_completed_request?

Will fix the two in V2.

Thanks,
Ming
