From: james.smart@broadcom.com (James Smart)
Date: Wed, 12 Dec 2018 09:23:57 -0800
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Message-ID: <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>



On 12/11/2018 3:35 PM, Sagi Grimberg wrote:
> This set implements read/write queue maps to nvmf (implemented in tcp
> and rdma). We basically allow the users to pass in nr_write_queues
> argument that will basically maps a separate set of queues to host
> write I/O (or more correctly non-read I/O) and a set of queues to
> hold read I/O (which is now controlled by the known nr_io_queues).
>
> A patchset that restores nvme-rdma polling is in the pipe.
> The polling is less trivial because:
> 1. we can find non I/O completions in the cq (i.e. memreg)
> 2. we need to start with non-polling for a sane connect and
>     then switch to polling which is not trivial behind the
>     cq API we use.
>
> Note that read/write separation for rdma but especially tcp this can be
> very clear win as we minimize the risk for head-of-queue blocking for
> mixed workloads over a single tcp byte stream.

Sagi,

What other wins are there for this split ?

I'm considering whether its worthwhile for fc as well, but the hol issue 
doesn't exist with fc. What else is being resolved ?

-- james
