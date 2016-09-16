From: hch@lst.de ('Christoph Hellwig')
Date: Fri, 16 Sep 2016 13:04:12 +0200
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <02c001d20f93$e6a88a60$b3f99f20$@opengridcomputing.com>
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
Message-ID: <20160916110412.GC5476@lst.de>

On Thu, Sep 15, 2016@03:58:25PM -0500, Steve Wise wrote:
> This stack is creating hctx queues for the namespace created for this target
> device.
> 
> Sagi,
> 
> Should nvme_rdma_error_recovery_work() be stopping the hctx queues for
> ctrl->ctrl.connect_q too?

Oh.  Actually we'll probably need to take care of the connect_q just
about anywhere we do anything to the other queues..

Let me look into the details a bit more.
