From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Tue, 9 Dec 2014 20:50:28 +0000
Subject: [PATCH] NVMe: Remove remnants of cpu hotplug
In-Reply-To: <5480A071.3080103@kernel.dk>
References: <54809D53.4060404@micron.com> <5480A071.3080103@kernel.dk>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945FE6A1@NTXBOIMBX02.micron.com>


> I'm curious with the num_possible -> num_online change. This should be
> handled by blk-mq, so no worries there. But how did it trigger the
> unset CPU in the run mask? Ran into the same issue here on a different
> test case, just curious if you looked into this.

After looking into it, the issue has been fixed on your for-3.19/core 
branch due to:

[PATCH] blk-mq: prevent unmapped hw queue from being scheduled

It's straightforward enough to test that the fix works by setting 
possible_cpus on the kernel command line to something larger than 
online cpus.
