From: hch@lst.de (Christoph Hellwig)
Date: Mon, 7 May 2018 14:27:36 +0200
Subject: [PATCH] nvme-rdma: fix double free in nvme_rdma_free_queue
In-Reply-To: <1525420938-9492-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1525420938-9492-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180507122736.GC27843@lst.de>

On Fri, May 04, 2018@04:02:18PM +0800, Jianchao Wang wrote:
> BUG: KASAN: double-free or invalid-free in nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
> Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
> Call Trace:
>  dump_stack+0x91/0xeb
>  print_address_description+0x6b/0x290
>  kasan_report_invalid_free+0x55/0x80
>  __kasan_slab_free+0x176/0x190
>  kfree+0xeb/0x310
>  nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
>  nvme_rdma_configure_admin_queue+0x1a3/0x4d0 [nvme_rdma]
>  nvme_rdma_reset_ctrl_work+0x4e/0xd0 [nvme_rdma]
>  process_one_work+0x3ca/0xaa0
>  worker_thread+0x4e2/0x6c0
>  kthread+0x18d/0x1e0
>  ret_from_fork+0x24/0x30
> 
> The double free is on ctrl->async_event_sqe.
> If nvme_rdma_start_queue in nvme_rdma_configure_admin_queue fails,
> nvme_rdma_free_queue will be invoked. However, at the moment, the
> ctrl->async_event_sqe has not been allocated and it has been freed
> in
> nvme_rdma_reset_ctrl_work
>   -> nvme_rdma_shutdown_ctrl
>     ->nvme_rdma_destroy_admin_queue
>       -> nvme_rdma_free_queue
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

Can you handle this in the caller instead, maybe including a comment?
