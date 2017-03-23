From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 Mar 2017 15:00:42 +0100
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
Message-ID: <20170323140042.GA30536@lst.de>

On Thu, Mar 23, 2017@10:04:09AM +0100, Marta Rybczynska wrote:
> In the case of small NVMe-oF queue size (<32) we may enter
> a deadlock caused by the fact that the IB completions aren't sent
> waiting for 32 and the send queue will fill up.
> 
> The error is seen as (using mlx5):
> [ 2048.693355] mlx5_0:mlx5_ib_post_send:3765:(pid 7273):
> [ 2048.693360] nvme nvme1: nvme_rdma_post_send failed with error code -12
> 
> The patch doesn't change the behaviour for remote devices with
> larger queues.

Thanks, this looks useful.  But wouldn't it be better to do something
like queue_size divided by 2 or 4 to get a better refill latency?
