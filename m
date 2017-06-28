From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 17:38:12 +0300
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Message-ID: <37fea86b-ce87-ac03-e465-5daf62a456c4@grimberg.me>

Hi Max,

> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).

The explanation can be a bit clearer...

I still need to take a look at the patch itself, but do note that
ideally we will never get to blk_mq_map_queues since we prefer
to map queues based on MSIX assignments. for nvme-rdma, this is
merely a fallback. And looking ahead, MSIX based mapping should
be the primary mapping logic.

Can you please test with my patchset on converting nvme-rdma to
MSIX based mapping (I assume you are testing with mlx5 yes)?
I'd be very much interested to know if the original problem
exists with this applied.

I'll take a closer look into the patch.
