From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 10 Jun 2016 16:22:29 -0500
Subject: [PATCH] nvme-rdma: correctly stop keep alive on error path
In-Reply-To: <1465508227-14143-1-git-send-email-mlin@kernel.org>
References: <1465508227-14143-1-git-send-email-mlin@kernel.org>
Message-ID: <027b01d1c35e$31a082c0$94e18840$@opengridcomputing.com>

> From: Ming Lin <ming.l at samsung.com>
> 
> We didn't stop keep alive when blk_mq_alloc_tag_set() fails
> in nvme_rdma_create_io_queues().
> 
> This caused below hung when unloading nvme-rdma driver.
> 

Tested-by: Steve Wise <swise at opengridcomputing.com>
