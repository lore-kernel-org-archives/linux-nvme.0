From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 17 May 2018 22:50:13 +0800
Subject: [PATCH V2] nvme-rdma: fix double free in nvme_rdma_free_queue
In-Reply-To: <c32eef8a-ae1e-ce7e-ee39-eee60192e517@mellanox.com>
References: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
 <c32eef8a-ae1e-ce7e-ee39-eee60192e517@mellanox.com>
Message-ID: <fcfa5a80-83db-c5bf-a46d-c53629a3c9db@oracle.com>

Hi Max

Thanks for kindly review and suggestion for this.

On 05/16/2018 08:18 PM, Max Gurtovoy wrote:
> I don't know exactly what Christoph meant but IMO the best place to allocate it is in nvme_rdma_alloc_queue just before calling
> 
> "set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);"
> 
> then you will never get to double free since we clear the NVME_RDMA_Q_ALLOCATED bit in the beginning of nvme_rdma_free_queue.

Yes, I will investigate the whether there is some special reason for async_event_sqe is not allocated in nvme_rdma_alloc_queue next.

Thanks
Jianchao
