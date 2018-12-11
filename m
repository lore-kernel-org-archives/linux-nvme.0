From: hch@lst.de (Christoph Hellwig)
Date: Tue, 11 Dec 2018 14:28:43 +0100
Subject: [PATCH 0/5] implement nvmf read/write queue maps
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Message-ID: <20181211132843.GA20401@lst.de>

On Tue, Dec 11, 2018@02:49:30AM -0800, Sagi Grimberg wrote:
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
>    then switch to polling which is not trivial behind the
>    cq API we use.

I think we should enhance the CQ API to better support polling,
the old poll code was a bit of a layering violation vs the core
code..
