From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 11:31:40 +0200
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <20180111213815.2107-1-roland@kernel.org>
References: <20180111213815.2107-1-roland@kernel.org>
Message-ID: <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>


> From: Roland Dreier <roland at purestorage.com>
> 
> In nvme_keep_alive() we pass a request with a pointer to an NVMe command on
> the stack into blk_execute_rq_nowait().  However, the block layer doesn't
> guarantee that the request is fully queued before blk_execute_rq_nowait()
> returns.  If not, and the request is queued after nvme_keep_alive() returns,
> then we'll end up using stack memory that might have been overwritten to
> form the NVMe command we pass to hardware.
> 
> Fix this by keeping a special command struct in the nvme_ctrl struct right
> next to the delayed work struct used for keep-alives.

Thanks Roland,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
