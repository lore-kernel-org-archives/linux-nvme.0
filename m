From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 25 Apr 2019 15:35:43 +0800
Subject: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
In-Reply-To: <20190425053234.GA7166@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-2-ming.lei@redhat.com>
 <20190424161834.GA23854@lst.de> <20190425005332.GB22636@ming.t460p>
 <20190425053234.GA7166@lst.de>
Message-ID: <20190425073542.GA28630@ming.t460p>

On Thu, Apr 25, 2019@07:32:34AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019@08:53:34AM +0800, Ming Lei wrote:
> > It isn't in other callers of blk_mq_sched_insert_requests(), it is just
> > needed in some corner case like flush plug context.
> > 
> > For other callers of blk_mq_sched_insert_requests(), it is guaranteed
> > that request queue's ref is held.
> 
> In both Linus' tree and Jens' for-5.2 tree I only see these two
> callers of blk_mq_sched_insert_requests.  What am I missing?

OK, what I meant is that the issue is flush plug context specific.
And I didn't notice that this function is only called by
blk_mq_flush_plug_list().

Then it is fine to move the percpu_ref_get()/percpu_ref_put() into
the function, better with comment on this issue.

Thanks, 
Ming
