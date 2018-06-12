From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 12 Jun 2018 14:48:16 -0600
Subject: [PATCH 5/5] nvmet: fcloop: use irqsave spinlocks
In-Reply-To: <20180515074043.22843-6-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-6-jthumshirn@suse.de>
Message-ID: <3f977939-4b92-4d3f-3a7e-1d2404896420@kernel.dk>

On 5/15/18 1:40 AM, Johannes Thumshirn wrote:
> Lockdep complains about inconsistent hardirq states when using
> nvme-fcloop. So use the irqsave variant of spin_locks for the
> nvmefc_fcp_req's reqlock.
> 
> Here's the lockdep report:
> [   11.138417] ================================
> [   11.139085] WARNING: inconsistent lock state
> [   11.139207] nvmet: creating controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:046394e7-bff7-4403-9502-1816800efaa0.
> [   11.139727] 4.17.0-rc5+ #883 Not tainted
> [   11.139732] --------------------------------
> [   11.144441] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> [   11.145341] swapper/8/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> [   11.146108]         (ptrval) (&(&tfcp_req->reqlock)->rlock){?.+.}, at: fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.148633] {HARDIRQ-ON-W} state was registered at:
> [   11.149380]   _raw_spin_lock+0x34/0x70
> [   11.149940]   fcloop_fcp_recv_work+0x17/0x90 [nvme_fcloop]
> [   11.150746]   process_one_work+0x1d8/0x5c0
> [   11.151346]   worker_thread+0x45/0x3e0
> [   11.151886]   kthread+0x101/0x140
> [   11.152370]   ret_from_fork+0x3a/0x50
> [   11.152903] irq event stamp: 36666
> [   11.153402] hardirqs last  enabled at (36663): [<ffffffffafc601c3>] default_idle+0x13/0x180
> [   11.154601] hardirqs last disabled at (36664): [<ffffffffafe00964>] interrupt_entry+0xc4/0xe0
> [   11.155817] softirqs last  enabled at (36666): [<ffffffffaf267409>] irq_enter+0x59/0x60
> [   11.156952] softirqs last disabled at (36665): [<ffffffffaf2673ee>] irq_enter+0x3e/0x60
> [   11.158092]
> [   11.158092] other info that might help us debug this:
> [   11.159436]  Possible unsafe locking scenario:
> [   11.159436]
> [   11.160299]        CPU0
> [   11.160663]        ----
> [   11.161026]   lock(&(&tfcp_req->reqlock)->rlock);
> [   11.161709]   <Interrupt>
> [   11.162091]     lock(&(&tfcp_req->reqlock)->rlock);
> [   11.163148]
> [   11.163148]  *** DEADLOCK ***
> [   11.163148]
> [   11.164007] no locks held by swapper/8/0.
> [   11.164596]
> [   11.164596] stack backtrace:
> [   11.165238] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 4.17.0-rc5+ #883
> [   11.166180] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> [   11.167673] Call Trace:
> [   11.168037]  <IRQ>
> [   11.168349]  dump_stack+0x78/0xb3
> [   11.168864]  print_usage_bug+0x1ed/0x1fe
> [   11.169440]  ? check_usage_backwards+0x110/0x110
> [   11.170111]  mark_lock+0x263/0x2a0
> [   11.170995]  __lock_acquire+0x675/0x1870
> [   11.171865]  ? __lock_acquire+0x48d/0x1870
> [   11.172460]  lock_acquire+0xd4/0x220
> [   11.172981]  ? fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.173709]  _raw_spin_lock+0x34/0x70
> [   11.174243]  ? fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.174978]  fcloop_fcp_op+0x20/0x1d0 [nvme_fcloop]
> [   11.175673]  nvmet_fc_transfer_fcp_data+0x9b/0x130 [nvmet_fc]
> [   11.176507]  nvmet_req_complete+0x10/0x110 [nvmet]
> [   11.177210]  nvmet_bio_done+0x23/0x40 [nvmet]
> [   11.177837]  blk_update_request+0xab/0x3b0
> [   11.178434]  blk_mq_end_request+0x13/0x60
> [   11.179033]  flush_smp_call_function_queue+0x58/0x150
> [   11.179755]  smp_call_function_single_interrupt+0x49/0x260
> [   11.180531]  call_function_single_interrupt+0xf/0x20
> [   11.181236]  </IRQ>
> [   11.181542] RIP: 0010:native_safe_halt+0x2/0x10
> [   11.182186] RSP: 0018:ffffa481006cbec0 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff04
> [   11.183265] RAX: ffff9f54f8b86200 RBX: ffff9f54f8b86200 RCX: 0000000000000000
> [   11.184264] RDX: ffff9f54f8b86200 RSI: 0000000000000001 RDI: ffff9f54f8b86200
> [   11.185270] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
> [   11.186271] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   11.187280] R13: 0000000000000000 R14: ffff9f54f8b86200 R15: ffff9f54f8b86200
> [   11.188280]  default_idle+0x18/0x180
> [   11.188806]  do_idle+0x176/0x260
> [   11.189273]  cpu_startup_entry+0x5a/0x60
> [   11.189832]  start_secondary+0x18f/0x1b0
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Cc: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/target/fcloop.c | 52 ++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index d2209c60f95f..f4a3700201c1 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -406,9 +406,10 @@ fcloop_fcp_recv_work(struct work_struct *work)
>  		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
>  	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
>  	int ret = 0;
> +	unsigned long flags;
>  	bool aborted = false;
>  
> -	spin_lock(&tfcp_req->reqlock);
> +	spin_lock_irqsave(&tfcp_req->reqlock, flags);

This should just be spin_lock_irq(), you don't need irq saving locks when
you are always called from a workqueue handler.

Ditto the other workqueue handlers. fcloop_fcp_op() part looks fine.

-- 
Jens Axboe
