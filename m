From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 16 May 2018 15:06:39 +0300
Subject: [PATCH V2] nvme-rdma: stop queue first before free it in config
 admin queue
In-Reply-To: <1525945347-1964-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1525945347-1964-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <06a4d7a3-969d-c9ed-f40b-715b4d774bf1@mellanox.com>



On 5/10/2018 12:42 PM, Jianchao Wang wrote:
> When any of cases after nvme_rdma_start_queue in
> nvme_rdma_configure_admin_queue fails, the ctrl->queues[0] will be
> freed but the NVME_RDMA_Q_LIVE is still set. If nvme_rdma_stop_queue
> is invoked, we will incur use-after-free which will cause memory
> corruption.
> BUG: KASAN: use-after-free in rdma_disconnect+0x1f/0xe0 [rdma_cm]
> Read of size 8 at addr ffff8801dc3969c0 by task kworker/u16:3/9304
> 
> CPU: 3 PID: 9304 Comm: kworker/u16:3 Kdump: loaded Tainted: G        W         4.17.0-rc3+ #20
> Workqueue: nvme-delete-wq nvme_delete_ctrl_work
> Call Trace:
>   dump_stack+0x91/0xeb
>   print_address_description+0x6b/0x290
>   kasan_report+0x261/0x360
>   rdma_disconnect+0x1f/0xe0 [rdma_cm]
>   nvme_rdma_stop_queue+0x25/0x40 [nvme_rdma]
>   nvme_rdma_shutdown_ctrl+0xf3/0x150 [nvme_rdma]
>   nvme_delete_ctrl_work+0x98/0xe0
>   process_one_work+0x3ca/0xaa0
>   worker_thread+0x4e2/0x6c0
>   kthread+0x18d/0x1e0
>   ret_from_fork+0x24/0x30
> 
> To fix it, call nvme_rdma_stop_queue for all the failed cases after
> nvme_rdma_start_queue.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
> 
> V2:
> based on Sagi's suggestion, add out_stop_queue lable and invoke
> nvme_rdma_stop_queue in all the failed cases after nvme_rdma_start_queue
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
