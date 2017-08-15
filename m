From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 15 Aug 2017 10:46:20 +0800
Subject: [PATCH] blk-mq: Fix queue usage on failed request allocation
In-Reply-To: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
References: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170815024618.GA6137@ming.t460p>

On Mon, Aug 14, 2017@04:40:11PM -0400, Keith Busch wrote:
> blk_mq_get_request() does not release the callers queue usage counter
> when allocation fails. The caller still needs to account for its own
> queue usage when it is unable to allocate a request.
> 
> Fixes: 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")
> 
> Reported-by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Ming Lei <ming.lei at redhat.com>

-- 
Ming
