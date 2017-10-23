From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Oct 2017 16:32:55 +0200
Subject: [PATCH 2/5] nvme-rdma: rework create_ctrl error flow
In-Reply-To: <1508324864-23087-3-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-3-git-send-email-sagi@grimberg.me>
Message-ID: <20171023143255.GB25448@lst.de>

On Wed, Oct 18, 2017@02:07:41PM +0300, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> The magic ctrl refcount handling we have due to the asymmetric
> behavior in nvme_init/uninit_ctrl is making the controller
> creation error sequence a bit awkward and error prone as we
> rely on magic refcounting to invoke ->free_ctrl from create_ctrl
> error sequence.
> 
> Now that we have nvme_init/uninit_ctrl doing the right thing, we
> can fix this by making the error sequence sane and simple (just
> undo what we did until the error).
> 
> Also, allocate ctrl->queues before calling nvme_init_ctrl, just
> to separate the driver private resource allocation and the core
> resource allocations.

Once we did the init we'll have to do a put and not just free it.
That will become even more important when using a struct device for
refcounting the controller.
