From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 27 Sep 2016 10:31:51 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <00fd01d218d1$5e49ebe0$1addc3a0$@opengridcomputing.com>
References: <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
 <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
 <020001d20f70$9998fde0$cccaf9a0$@opengridcomputing.com>
 <02c001d20f93$e6a88a60$b3f99f20$@opengridcomputing.com>
 <20160916110412.GC5476@lst.de>
 <8fc2cefe-76b6-b0a3-12af-701833c286f7@grimberg.me>
 <02db01d2128b$e9244c70$bb6ce550$@opengridcomputing.com>
 <02c601d2144d$ff453a50$fdcfaef0$@opengridcomputing.com>
 <cea94562-b0d6-fbc0-998d-9597b8969998@grimberg.me>
 <20160926151242.GA16873@lst.de> <20160926222906.GA28881@lst.de>
 <00fd01d218d1$5e49ebe0$1addc3a0$@opengridcomputing.com>
Message-ID: <010b01d218d4$44b0da60$ce128f20$@opengridcomputing.com>

> Hey Christoph,
> 
> To apply Bart's series, I needed to use Jens' for-4.9/block branch.  But I
also
> wanted the latest nvme fixes in linux-4.8-rc8, so I rebased Jens' branch onto
> rc8, then applied Bart's series (which needed a small tweak to patch 2). On
top
> of this I have some debug patches that will BUG_ON() if it detects freed RDMA
> objects (requires mem debug on so freed memory has the 0x6b6b... stamp).
This
> code base can be perused at:
> 
> https://github.com/larrystevenwise/nvme-fabrics/commits/block-for-4.9
> 
> I then tried to reproduce, and still hit a crash.  I'm debugging now.
> 

blk_mq_hw_ctx.state is: 2
nvme_ns.queue.queue_flags is: 0x1f07a00

So the hw_ctx is BLK_MQ_S_TAG_ACTIVE.  And the nvme_ns.queue request queue
doesn't have QUEUE_FLAG_STOPPED set. nvme_rdma_ctrl.ctrl state is RECONNECTING.
