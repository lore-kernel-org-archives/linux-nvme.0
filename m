From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 04 Dec 2014 10:57:05 -0700
Subject: [PATCH] NVMe: Remove remnants of cpu hotplug
In-Reply-To: <54809D53.4060404@micron.com>
References: <54809D53.4060404@micron.com>
Message-ID: <5480A071.3080103@kernel.dk>

On 12/04/2014 10:43 AM, Sam Bradshaw wrote:
> This patch cleans up some code inherited from the cpu hotplug handling,
> including correcting a bug where hctx->cpumask included non-schedulable
> cpus (backtrace attached).

Getting rid of the notifier_block is definitely right, that should not 
be there anymore.

I'm curious with the num_possible -> num_online change. This should be 
handled by blk-mq, so no worries there. But how did it trigger the unset 
CPU in the run mask? Ran into the same issue here on a different test 
case, just curious if you looked into this.

-- 
Jens Axboe
