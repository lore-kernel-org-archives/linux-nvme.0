From: hare@suse.de (Hannes Reinecke)
Date: Wed, 31 Jul 2019 14:03:45 +0200
Subject: [PATCH] nvme-rdma: fix possible use-after-free in connect error
 flow
In-Reply-To: <20190726172949.1635-1-sagi@grimberg.me>
References: <20190726172949.1635-1-sagi@grimberg.me>
Message-ID: <8b7a4d91-1524-4f33-d165-0529f0e9c7f3@suse.de>

On 7/26/19 7:29 PM, Sagi Grimberg wrote:
> When start_queue fails, we need to make sure to drain the
> queue cq before freeing the rdma resources because we might
> still race with the completion path. Have start_queue() error
> path safely stop the queue.
> 
> --
> [30371.808111] nvme nvme1: Failed reconnect attempt 11
> [30371.808113] nvme nvme1: Reconnecting in 10 seconds...
> [...]
> [30382.069315] nvme nvme1: creating 4 I/O queues.
> [30382.257058] nvme nvme1: Connect Invalid SQE Parameter, qid 4
> [30382.257061] nvme nvme1: failed to connect queue: 4 ret=386
> [30382.305001] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
> [30382.305022] IP: qedr_poll_cq+0x8a3/0x1170 [qedr]
> [30382.305028] PGD 0 P4D 0
> [30382.305037] Oops: 0000 [#1] SMP PTI
> [...]
> [30382.305153] Call Trace:
> [30382.305166]  ? __switch_to_asm+0x34/0x70
> [30382.305187]  __ib_process_cq+0x56/0xd0 [ib_core]
> [30382.305201]  ib_poll_handler+0x26/0x70 [ib_core]
> [30382.305213]  irq_poll_softirq+0x88/0x110
> [30382.305223]  ? sort_range+0x20/0x20
> [30382.305232]  __do_softirq+0xde/0x2c6
> [30382.305241]  ? sort_range+0x20/0x20
> [30382.305249]  run_ksoftirqd+0x1c/0x60
> [30382.305258]  smpboot_thread_fn+0xef/0x160
> [30382.305265]  kthread+0x113/0x130
> [30382.305273]  ? kthread_create_worker_on_cpu+0x50/0x50
> [30382.305281]  ret_from_fork+0x35/0x40
> --
> 
> Reported-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
