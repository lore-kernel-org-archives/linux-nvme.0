From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Sat, 24 Feb 2018 00:23:32 +0000
Subject: v4.16-rc2 nvme_rdma ib_destroy_qp() warns about MRs
Message-ID: <1519431811.2904.52.camel@wdc.com>

Hello,

With the v4.16-rc2 nvme_rdma driver on top of the rdma_rxe driver the
following kernel warning appeared in the kernel log:

CPU: 3 PID: 152 Comm: kworker/u8:3 Not tainted 4.16.0-rc2-dbg+ #3
Workqueue: nvme-wq nvme_rdma_error_recovery_work [nvme_rdma]
RIP: 0010:ib_destroy_qp+0x177/0x1a0 [ib_core]
Call Trace:
 nvme_rdma_destroy_queue_ib+0x32/0x70 [nvme_rdma]
 nvme_rdma_free_queue+0x2e/0x90 [nvme_rdma]
 nvme_rdma_destroy_io_queues+0x5d/0xb0 [nvme_rdma]
 nvme_rdma_error_recovery_work+0x4c/0xb0 [nvme_rdma]
 process_one_work+0x20b/0x6a0
 worker_thread+0x35/0x380
 kthread+0x117/0x130
 ret_from_fork+0x24/0x30

Does this mean that the nvme_rdma driver calls ib_destroy_qp() before all MRs
associated with the QP have been destroyed?

Thanks,

Bart.
