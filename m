From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Feb 2017 12:13:20 +0200
Subject: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on every
 request.
In-Reply-To: <1486507066-23168-1-git-send-email-parav@mellanox.com>
References: <1486507066-23168-1-git-send-email-parav@mellanox.com>
Message-ID: <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>



On 08/02/17 00:37, Parav Pandit wrote:
> Fabric operations are constants of a registered transport. They don't
> change with every target request that gets processed by the nvmet-core.
> Therefore this patch moves fabrics_ops initialization out of the hot
> request processing path for rdma and fc.
> It continues to remain in same way for loop target through extra API.

Can't you add it to nvme_loop_init_iod()?

> Additionally this patch further avoid nvme cq and sq pointer
> initialization for every request during every request processing
> for rdma because nvme queue linking occurs during queue allocation
> time for AQ and IOQ.

This breaks SRQ mode where every nvmet_rdma_cmd serves different
queues in it's lifetime..
