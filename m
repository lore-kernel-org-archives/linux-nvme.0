From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 Apr 2019 07:32:34 +0200
Subject: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
In-Reply-To: <20190425005332.GB22636@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-2-ming.lei@redhat.com> <20190424161834.GA23854@lst.de>
 <20190425005332.GB22636@ming.t460p>
Message-ID: <20190425053234.GA7166@lst.de>

On Thu, Apr 25, 2019@08:53:34AM +0800, Ming Lei wrote:
> It isn't in other callers of blk_mq_sched_insert_requests(), it is just
> needed in some corner case like flush plug context.
> 
> For other callers of blk_mq_sched_insert_requests(), it is guaranteed
> that request queue's ref is held.

In both Linus' tree and Jens' for-5.2 tree I only see these two
callers of blk_mq_sched_insert_requests.  What am I missing?
