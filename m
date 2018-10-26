From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 25 Oct 2018 18:00:21 -0700
Subject: [PATCH v3 0/2] nvmet-rdma: Rework the DoS mitigation code
In-Reply-To: <20181025211309.100564-1-bvanassche@acm.org>
References: <20181025211309.100564-1-bvanassche@acm.org>
Message-ID: <56c7461f-d6c1-0fd2-30c8-334967fc3013@grimberg.me>


> Hi Christoph,

Hi Bart,

> This patch series reworks the DoS mitigation code in the NVMeOF
> target code and also addresses a lockdep complaint that has been
> discussed recently on the NVMe mailing list. Please consider this
> patch series for the upstream kernel.

I can't say I agree with rejecting random connect requests if we have
more then a maid up define resources queued for deletion. Given that
there is no real locking incorrectness in waiting a bit such that they
all drain. The issue is no more then a false complaint from lockdep.

Given that there are a number of unknown factors that affect this such
as the number of hosts a target is servicing, the number of inflight I/O
that needs quiescing at the time of the removal, and the system resource
limits, any approach that has a hard-coded limit cannot be correct.

If we do indeed want to get around the false report and not annotate it,
perhaps we should invoke rdma_destroy_id outside the work execution
context (such that it is destroyed before the work runs) and then the
dependency no longer exists?
