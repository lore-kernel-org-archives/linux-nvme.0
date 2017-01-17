From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 Jan 2017 12:53:13 -0500
Subject: [PATCH 5/6] blk-mq: Fix queue freeze deadlock
In-Reply-To: <1483601585.2811.5.camel@sandisk.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-6-git-send-email-keith.busch@intel.com>
 <1483601585.2811.5.camel@sandisk.com>
Message-ID: <20170117175312.GA8989@localhost.localdomain>

On Thu, Jan 05, 2017@07:33:22AM +0000, Bart Van Assche wrote:
> This patch adds a second code path to the blk-mq core for running queues and
> hence will make the blk-mq core harder to maintain. Have you considered to
> implement this functionality by introducing a new "fail all requests" flag
> for hctx queues such that blk_mq_abandon_stopped_requests() can reuse the
> existing mechanism for running a queue?

Thanks for the suggestion. I'll look into that. I wanted to avoid more
flags to test for in the fast-path, but I see that a special queue run
method is problematic for maintenance.
