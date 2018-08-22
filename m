From: hch@lst.de (Christoph Hellwig)
Date: Wed, 22 Aug 2018 15:11:30 +0200
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <20180820205420.25908-1-sagi@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
Message-ID: <20180822131130.GC28149@lst.de>

On Mon, Aug 20, 2018@01:54:20PM -0700, Sagi Grimberg wrote:
> nvme-rdma attempts to map queues based on irq vector affinity.
> However, for some devices, completion vector irq affinity is
> configurable by the user which can break the existing assumption
> that irq vectors are optimally arranged over the host cpu cores.

IFF affinity is configurable we should never use this code,
as it breaks the model entirely.  ib_get_vector_affinity should
never return a valid mask if affinity is configurable.
