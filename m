From: maxg@mellanox.com (Max Gurtovoy)
Date: Sat, 24 Feb 2018 16:49:20 +0200
Subject: v4.16-rc2 nvme_rdma ib_destroy_qp() warns about MRs
In-Reply-To: <1519431811.2904.52.camel@wdc.com>
References: <1519431811.2904.52.camel@wdc.com>
Message-ID: <a331fbc9-4404-e1bc-e6cd-869895864392@mellanox.com>



On 2/24/2018 2:23 AM, Bart Van Assche wrote:
> Hello,
> 
> With the v4.16-rc2 nvme_rdma driver on top of the rdma_rxe driver the
> following kernel warning appeared in the kernel log:
> 
> CPU: 3 PID: 152 Comm: kworker/u8:3 Not tainted 4.16.0-rc2-dbg+ #3
> Workqueue: nvme-wq nvme_rdma_error_recovery_work [nvme_rdma]
> RIP: 0010:ib_destroy_qp+0x177/0x1a0 [ib_core]
> Call Trace:
>   nvme_rdma_destroy_queue_ib+0x32/0x70 [nvme_rdma]
>   nvme_rdma_free_queue+0x2e/0x90 [nvme_rdma]
>   nvme_rdma_destroy_io_queues+0x5d/0xb0 [nvme_rdma]
>   nvme_rdma_error_recovery_work+0x4c/0xb0 [nvme_rdma]
>   process_one_work+0x20b/0x6a0
>   worker_thread+0x35/0x380
>   kthread+0x117/0x130
>   ret_from_fork+0x24/0x30
> 
> Does this mean that the nvme_rdma driver calls ib_destroy_qp() before all MRs
> associated with the QP have been destroyed?

I guess it happens to you in some port toggling during IO (or some other 
recovery scenario).
The answer is yes, and I've started looking into it and started a thread:

https://www.mail-archive.com/linux-block at vger.kernel.org/msg18559.html



> 
> Thanks,
> 
> Bart.
> 

Thanks,
-Max.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C64b749f9d50d4cc8f0c808d57b1ce8a6%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636550286469377682&sdata=DGnEOBEX7Y3GyHByLA68wFb8nCtYVsX1kYtyoHgelTA%3D&reserved=0
> 
