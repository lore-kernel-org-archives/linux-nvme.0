From: shan.hai@oracle.com (Shan Hai)
Date: Wed, 12 Oct 2016 17:15:06 +0800
Subject: Need help for dead lock of nvme shutdown_lock
In-Reply-To: <CAEj2FWN7ZgdBA4kHhKNSoHJnP9x+KCu8YNK_i9VSs2tSLHj3+g@mail.gmail.com>
References: <CAEj2FWN7ZgdBA4kHhKNSoHJnP9x+KCu8YNK_i9VSs2tSLHj3+g@mail.gmail.com>
Message-ID: <20161012091505.GA11341@shan.hai@oracle.com>

On Wed, Oct 12, 2016@03:44:34PM +0800, ??? wrote:
> Dear maintainers of NVME
> I met a dead lock issue when I was using NVME.
> the shutdown_lock may cause dead lock when nvme_reset_work is working
> and nvme_timeout happens.
> I checked the latest mainline code, it seems still have such issue,
> please help, thank you!
> below is the log:
>

Hi Xiaoguang,

Would you please try the below patch?

 
>From 930fde076dd982d10ee7613214c1e2745551f1dd Mon Sep 17 00:00:00 2001
From: Shan Hai <shan.hai@oracle.com>
Date: Wed, 12 Oct 2016 16:52:51 +0800
Subject: [PATCH 1/1] drivers/nvme: remove redundant nvme_dev_disable calls
 from nvme_timeout

Currently the nvme_dev_disable will be called from both process and
softirq context respectively from nvme_reset_work and nvme_timeout
and it will hold a mutex during its run, this is a <softirq-safe> to
<softirq-unsafe> lockdep senario and could cause a dead lock.

Fix it by removing redundant calls of the nvme_dev_disable from the
nvme_timeout, it's feasible for below reasons:
o it's not necessary to call nvme_dev_disable in the nvme_timeout
	when the controller state is NVME_CTRL_RESETTING, the
	nvme_reset_work has called nvme_dev_disable and then
	set the controller state to NVME_CTRL_RESETTING
o it's not necessary to call nvme_dev_disable before scheduling
	reset work in the nvme_timeout, sine it will be called
	from nvme_reset_work at last

Signed-off-by: Shan Hai <shan.hai at oracle.com>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0..6cd855a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -878,7 +878,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
 		req->errors = NVME_SC_CANCELLED;
 		return BLK_EH_HANDLED;
 	}
@@ -892,7 +891,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
 		queue_work(nvme_workq, &dev->reset_work);
 
 		/*
-- 
2.7.4

Thanks
Shan Hai

> [  122.266109] nvme 0000:01:00.0: I/O 4 QID 2 timeout, reset controller
> [  122.270260]
> [  122.270760] =================================
> [  122.271649] [ INFO: inconsistent lock state ]
> [  122.272586] 4.4.7-g7e84a8a #1403 Not tainted
> [  122.273457] ---------------------------------
> [  122.274378] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  122.275592] swapper/1/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [  122.276600]  (&dev->shutdown_lock){+.?...}, at: [<c032cb44>]
> nvme_dev_shutdown+0x20/0x254
> [  122.278906] {SOFTIRQ-ON-W} state was registered at:
> [  122.279882]   [<c0508640>] mutex_lock_nested+0x50/0x43c
> [  122.281187]   [<c032cb44>] nvme_dev_shutdown+0x20/0x254
> [  122.282419]   [<c032d808>] nvme_reset_work+0x40/0xe00
> [  122.283628]   [<c003eb2c>] process_one_work+0x3a0/0x78c
> [  122.284938]   [<c003fbec>] worker_thread+0x2b0/0x3ec
> [  122.286136]   [<c0044ba4>] kthread+0xdc/0xf0
> [  122.287249]   [<c000fa50>] ret_from_fork+0x14/0x24
> [  122.288505] irq event stamp: 293762
> [  122.289276] hardirqs last  enabled at (293762): [<c050b8e4>]
> _raw_spin_unlock_irqrestore+0x3c/0x74
> [  122.291149] hardirqs last disabled at (293761): [<c050b738>]
> _raw_spin_lock_irqsave+0x18/0x54
> [  122.292919] softirqs last  enabled at (293750): [<c0029fe8>]
> irq_enter+0x4c/0x7c
> [  122.294533] softirqs last disabled at (293751): [<c002a09c>]
> irq_exit+0x84/0x110
> [  122.296107]
> [  122.296107] other info that might help us debug this:
> [  122.297394]  Possible unsafe locking scenario:
> [  122.297394]
> [  122.298567]        CPU0
> [  122.299154]        ----
> [  122.299731]   lock(&dev->shutdown_lock);
> [  122.300805]   <Interrupt>
> [  122.301409]     lock(&dev->shutdown_lock);
> [  122.302508]
> [  122.302508]  *** DEADLOCK ***
> [  122.302508]
> [  122.303774] 1 lock held by swapper/1/0:
> [  122.304571]  #0:  (((&q->timeout))){+.-...}, at: [<c008eb88>]
> call_timer_fn+0x0/0x478
> [  122.306856]
> [  122.306856] stack backtrace:
> [  122.307937] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.7-g7e84a8a #1403
> [  122.310244] [<c0018b74>] (unwind_backtrace) from [<c0014318>]
> (show_stack+0x10/0x14)
> [  122.311918] [<c0014318>] (show_stack) from [<c027acf4>]
> (dump_stack+0xa0/0xd8)
> [  122.313507] [<c027acf4>] (dump_stack) from [<c00f2ed0>]
> (print_usage_bug+0x25c/0x2d0)
> [  122.315196] [<c00f2ed0>] (print_usage_bug) from [<c006dff4>]
> (mark_lock+0x3d0/0x6b8)
> [  122.316854] [<c006dff4>] (mark_lock) from [<c006efcc>]
> (__lock_acquire+0x790/0x19f4)
> [  122.318498] [<c006efcc>] (__lock_acquire) from [<c0070b18>]
> (lock_acquire+0x1d8/0x2a0)
> [  122.320179] [<c0070b18>] (lock_acquire) from [<c0508640>]
> (mutex_lock_nested+0x50/0x43c)
> [  122.321879] [<c0508640>] (mutex_lock_nested) from [<c032cb44>]
> (nvme_dev_shutdown+0x20/0x254)
> [  122.323617] [<c032cb44>] (nvme_dev_shutdown) from [<c032cf80>]
> (nvme_timeout+0x6c/0x1a8)
> [  122.325291] [<c032cf80>] (nvme_timeout) from [<c0266b18>]
> (blk_mq_rq_timed_out+0x2c/0x7c)
> [  122.326972] [<c0266b18>] (blk_mq_rq_timed_out) from [<c0269f70>]
> (bt_for_each+0x84/0xb0)
> [  122.328665] [<c0269f70>] (bt_for_each) from [<c026a400>]
> (blk_mq_queue_tag_busy_iter+0x8c/0x9c)
> [  122.330424] [<c026a400>] (blk_mq_queue_tag_busy_iter) from
> [<c0265d3c>] (blk_mq_rq_timer+0x20/0xb8)
> [  122.332249] [<c0265d3c>] (blk_mq_rq_timer) from [<c008ed40>]
> (call_timer_fn+0x1b8/0x478)
> [  122.333931] [<c008ed40>] (call_timer_fn) from [<c008f30c>]
> (run_timer_softirq+0x30c/0x3c8)
> [  122.335653] [<c008f30c>] (run_timer_softirq) from [<c0029a28>]
> (__do_softirq+0x23c/0x5c8)
> [  122.337342] [<c0029a28>] (__do_softirq) from [<c002a09c>]
> (irq_exit+0x84/0x110)
> [  122.338909] [<c002a09c>] (irq_exit) from [<c007c548>]
> (__handle_domain_irq+0x8c/0xb0)
> [  122.340561] [<c007c548>] (__handle_domain_irq) from [<c0009498>]
> (gic_handle_irq+0x4c/0x90)
> [  122.342238] [<c0009498>] (gic_handle_irq) from [<c0014df8>]
> (__irq_svc+0x58/0x98)
> [  122.343666] Exception stack(0xe00fbf80 to 0xe00fbfc8)
> [  122.344855] bf80: 00000001 00000004 00000000 e00f0c00 e00fa000
> 00000051 10c0387d c0bab424
> [  122.346507] bfa0: e00fbfe0 c050ee80 00000000 c0bb478c c0bab448
> e00fbfd0 c006e4e8 c0010568
> [  122.348018] bfc0: 20000013 ffffffff
> [  122.349016] [<c0014df8>] (__irq_svc) from [<c0010568>]
> (arch_cpu_idle+0x30/0x3c)
> [  122.350618] [<c0010568>] (arch_cpu_idle) from [<c00671d0>]
> (default_idle_call+0x30/0x38)
> [  122.352298] [<c00671d0>] (default_idle_call) from [<c00673f4>]
> (cpu_startup_entry+0x21c/0x380)
> [  122.354007] [<c00673f4>] (cpu_startup_entry) from [<0000956c>] (0x956c)
> [  122.357684] BUG: scheduling while atomic: swapper/1/0/0x00000102
> [  122.358856] INFO: lockdep is turned off.
> [  122.359672] Modules linked in:
> [  122.360606] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.7-g7e84a8a #1403
> [  122.362886] [<c0018b74>] (unwind_backtrace) from [<c0014318>]
> (show_stack+0x10/0x14)
> [  122.364506] [<c0014318>] (show_stack) from [<c027acf4>]
> (dump_stack+0xa0/0xd8)
> [  122.366056] [<c027acf4>] (dump_stack) from [<c00f2590>]
> (__schedule_bug+0x60/0x7c)
> [  122.367682] [<c00f2590>] (__schedule_bug) from [<c0505e08>]
> (__schedule+0x84/0x9c4)
> [  122.369297] [<c0505e08>] (__schedule) from [<c0506974>] (schedule+0xa8/0xc0)
> [  122.370853] [<c0506974>] (schedule) from [<c050aa88>]
> (schedule_timeout+0x1c/0x3a8)
> [  122.372494] [<c050aa88>] (schedule_timeout) from [<c0507294>]
> (wait_for_common+0x110/0x150)
> [  122.374239] [<c0507294>] (wait_for_common) from [<c0507328>]
> (wait_for_completion_killable+0x10/0x28)
> [  122.376138] [<c0507328>] (wait_for_completion_killable) from
> [<c0044a10>] (kthread_create_on_node+0xe0/0x198)
> [  122.378128] [<c0044a10>] (kthread_create_on_node) from [<c032c8f0>]
> (nvme_disable_io_queues+0x74/0x2a8)
> [  122.380004] [<c032c8f0>] (nvme_disable_io_queues) from [<c032cc24>]
> (nvme_dev_shutdown+0x100/0x254)
> [  122.381811] [<c032cc24>] (nvme_dev_shutdown) from [<c032cf80>]
> (nvme_timeout+0x6c/0x1a8)
> [  122.383473] [<c032cf80>] (nvme_timeout) from [<c0266b18>]
> (blk_mq_rq_timed_out+0x2c/0x7c)
> [  122.385166] [<c0266b18>] (blk_mq_rq_timed_out) from [<c0269f70>]
> (bt_for_each+0x84/0xb0)
> [  122.386843] [<c0269f70>] (bt_for_each) from [<c026a400>]
> (blk_mq_queue_tag_busy_iter+0x8c/0x9c)
> [  122.388610] [<c026a400>] (blk_mq_queue_tag_busy_iter) from
> [<c0265d3c>] (blk_mq_rq_timer+0x20/0xb8)
> [  122.390407] [<c0265d3c>] (blk_mq_rq_timer) from [<c008ed40>]
> (call_timer_fn+0x1b8/0x478)
> [  122.392099] [<c008ed40>] (call_timer_fn) from [<c008f30c>]
> (run_timer_softirq+0x30c/0x3c8)
> [  122.393816] [<c008f30c>] (run_timer_softirq) from [<c0029a28>]
> (__do_softirq+0x23c/0x5c8)
> [  122.395502] [<c0029a28>] (__do_softirq) from [<c002a09c>]
> (irq_exit+0x84/0x110)
> [  122.397070] [<c002a09c>] (irq_exit) from [<c007c548>]
> (__handle_domain_irq+0x8c/0xb0)
> [  122.398716] [<c007c548>] (__handle_domain_irq) from [<c0009498>]
> (gic_handle_irq+0x4c/0x90)
> [  122.400395] [<c0009498>] (gic_handle_irq) from [<c0014df8>]
> (__irq_svc+0x58/0x98)
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
