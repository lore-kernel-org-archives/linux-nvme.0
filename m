From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 21 Aug 2018 10:04:35 +0800
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <20180820205420.25908-1-sagi@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
Message-ID: <20180821020434.GA24247@ming.t460p>

On Mon, Aug 20, 2018@01:54:20PM -0700, Sagi Grimberg wrote:
> nvme-rdma attempts to map queues based on irq vector affinity.
> However, for some devices, completion vector irq affinity is
> configurable by the user which can break the existing assumption
> that irq vectors are optimally arranged over the host cpu cores.
> 
> So we map queues in two stages:
> First map queues according to corresponding to the completion
> vector IRQ affinity taking the first cpu in the vector affinity map.
> if the current irq affinity is arranged such that a vector is not
> assigned to any distinct cpu, we map it to a cpu that is on the same
> node. If numa affinity can not be sufficed, we map it to any unmapped
> cpu we can find. Then, map the remaining cpus in the possible cpumap
> naively.

I guess this way still can't fix the request allocation crash issue
triggered by using blk_mq_alloc_request_hctx(), in which one hw queue may
not be mapped from any online CPU.

Maybe this patch isn't for this issue, but it is closely related.

Thanks,
Ming
