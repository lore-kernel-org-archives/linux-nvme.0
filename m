From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 08:07:56 +0100
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <20181212070756.GC28461@lst.de>

On Tue, Dec 11, 2018@03:36:47PM -0800, Sagi Grimberg wrote:
> Add an additional queue mapping for polling queues that will
> host polling for latency critical I/O.
> 
> One caveat is that we don't want these queues to be pure polling
> as we don't want to bother with polling for the initial nvmf connect
> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
> context from SOFTIRQ to DIRECT.

So do we really care?  Yes, polling for the initial connect is not
exactly efficient, but then again it doesn't happen all that often.

Except for efficiency is there any problem with just starting out
in polling mode?
