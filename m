From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 17:50:00 +0200
Subject: [PATCH rfc 2/3] RDMA/core: expose cpu affinity based
 completion vector lookup
In-Reply-To: <1499007694-7231-3-git-send-email-sagi@grimberg.me>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
 <1499007694-7231-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170713155000.GA2577@lst.de>

On Sun, Jul 02, 2017@06:01:33PM +0300, Sagi Grimberg wrote:
> A ULP might want to lookup an optimal completion vector based on
> a given cpu core affinity. Expose a lookup routine for it iterating
> on the device completion vectors searching a vector with affinity
> matching the given cpu.

Shouldn't this return the mask of cpus with the matching affinity
instead of always the first one?
