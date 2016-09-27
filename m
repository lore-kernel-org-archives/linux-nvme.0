From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 27 Sep 2016 09:07:01 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <cea94562-b0d6-fbc0-998d-9597b8969998@grimberg.me>
References: <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
 <021501d20a19$327ba5b0$9772f110$@opengridcomputing.com>
 <00ab01d20ab1$ed212ff0$c7638fd0$@opengridcomputing.com>
 <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com>
 <da2e918b-0f18-e032-272d-368c6ec49c62@grimberg.me>
 <011501d20f5f$b94e6c80$2beb4580$@opengridcomputing.com>
 <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
 <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
 <020001d20f70$9998fde0$cccaf9a0$@opengridcomputing.com>
 <02c001d20f93$e6a88a60$b3f99f20$@opengridcomputing.com>
 <20160916110412.GC5476@lst.de>
 <8fc2cefe-76b6-b0a3-12af-701833c286f7@grimberg.me>
 <02db01d2128b$e9244c70$bb6ce550$@opengridcomputing.com>
 <02c601d2144d$ff453a50$fdcfaef0$@opengridcomputing.com>
 <cea94562-b0d6-fbc0-998d-9597b8969998@grimberg.me>
Message-ID: <00c501d218c8$6afff1d0$40ffd570$@opengridcomputing.com>

> Christoph,
> 
> I'm still trying to understand how it is possible to
> get to a point where the request queue is stopped while
> the hardware context is not...
> 
> The code in rdma.c seems to do the right thing, but somehow
> a stray request sneaks in to our submission path when its not
> expected to.
> 
> Steve, is the request a normal read/write? or is it something
> else triggered from the reconnect flow?

It is a normal IO request I think.  length 64. 1 sge.   Sometimes I see a REG_MR
also filled out in the nvme_rdma_request->reg_wr struct.

I'm going to try Bart's series now to see if it fixes this issue...

Steve.
