From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Thu, 4 Dec 2014 21:54:37 +0000
Subject: [PATCH] NVMe: Remove remnants of cpu hotplug
In-Reply-To: <5480A071.3080103@kernel.dk>
References: <54809D53.4060404@micron.com> <5480A071.3080103@kernel.dk>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945F2BDF@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Jens Axboe [mailto:axboe at kernel.dk]
> Sent: Thursday, December 04, 2014 9:57 AM
> To: Sam Bradshaw (sbradshaw); linux-nvme at lists.infradead.org
> Cc: Selvan Mani (smani) [CONT - Type 2]
> Subject: Re: [PATCH] NVMe: Remove remnants of cpu hotplug
> 
> On 12/04/2014 10:43 AM, Sam Bradshaw wrote:
> > This patch cleans up some code inherited from the cpu hotplug
> > handling, including correcting a bug where hctx->cpumask included
> > non-schedulable cpus (backtrace attached).
> 
> Getting rid of the notifier_block is definitely right, that should not
> be there anymore.
> 
> I'm curious with the num_possible -> num_online change. This should be
> handled by blk-mq, so no worries there. But how did it trigger the
> unset CPU in the run mask? Ran into the same issue here on a different
> test case, just curious if you looked into this.

The systems that exhibit the problem are Dell R620 and R720 with only 1 cpu socket populated out of 2, which creates a difference between cpus online (24) and possible (32).  I don't have direct access to these systems at the moment to verify this but my thinking is that a sw ctx is getting associated to an uninitialized hctx in the mapping step, which appears to be possible if the zeroth cpu in the cpus possible map is offline.  In that case, the sw ctx maps to the zeroth hctx, which may not have that (or any) cpu in the hctx->cpu_mask.  Maybe the default hctx shouldn't be the zeroth but instead the first that has at least one cpu associated with it?
