From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 12 Dec 2018 10:37:59 -0600
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>

Hey Sagi,

> Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
> 
> Add an additional queue mapping for polling queues that will
> host polling for latency critical I/O.
> 
> One caveat is that we don't want these queues to be pure polling
> as we don't want to bother with polling for the initial nvmf connect
> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
> context from SOFTIRQ to DIRECT. Note that this function is not safe
> with inflight I/O so the caller must make sure not to call it without
> having all I/O quiesced (we also relax the ib_cq_completion_direct warning
> as we have a scenario that this can happen).

Is there no way to handle this in the core?  Maybe have the polling context
transition to DIRECT when the queue becomes empty and before re-arming the
CQ?  So ib_change_cq_ctx() would be called to indicate the change should
happen when it is safe to do so.  

Just a thought..
