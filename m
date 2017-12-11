From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 11 Dec 2017 16:50:44 -0700
Subject: [v3,1/9] RDMA/core: Add implicit per-device completion queue pools
In-Reply-To: <20171108095742.25365-2-sagi@grimberg.me>
References: <20171108095742.25365-2-sagi@grimberg.me>
Message-ID: <20171211235044.GA32331@ziepe.ca>

On Wed, Nov 08, 2017@11:57:34AM +0200, Sagi Grimberg wrote:
> Allow a ULP to ask the core to implicitly assign a completion
> queue to a queue-pair based on a least-used search on a per-device
> cq pools. The device CQ pools grow in a lazy fashion with every
> QP creation.
> 
> In addition, expose an affinity hint for a queue pair creation.
> If passed, the core will attempt to attach a CQ with a completion
> vector that is directed to the cpu core as the affinity hint
> provided.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Sagi, Bart,

Did we reach a conclusion on this? Is v3 the series to take, and
should it all go through the RDMA tree? It looks like there are some
missing acks for that??

I think there was also an unapplied comment from bart in the
patchworks notes...

Could you please add some commit messages when you resend it? Not sure
I should be accepting such large commits with empty messages???

Thanks,
Jason
