From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 10:05:13 -0800
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>
Message-ID: <bd50927c-c72b-01f6-bad7-080076610cde@grimberg.me>


> Hey Sagi,

Hi Steve,

> Is there no way to handle this in the core?  Maybe have the polling context
> transition to DIRECT when the queue becomes empty and before re-arming the
> CQ?

That is what I suggested, but that would mean that we we need to drain
the cq before making the switch, which means we need to allocate a
dedicated qp for that cq, and even that doesn't guarantee that the
ULP is not posting other wrs on its own qp(s)...

So making this safe for infight I/O would be a challenge... If we end
up agreeing that we are ok with this functionality, I'd much rather not
deal with it and simply document "use with care".

> So ib_change_cq_ctx() would be called to indicate the change should
> happen when it is safe to do so.

You lost me here... ib_change_cq_ctx would get called by who and when?
