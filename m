From: mlin@kernel.org (Ming Lin)
Date: Sat, 14 May 2016 23:58:40 -0700
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <1461619219-18144-2-git-send-email-mlin@kernel.org>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
Message-ID: <1463295520.5272.4.camel@kernel.org>

On Mon, 2016-04-25@14:20 -0700, Ming Lin wrote:
>?
> @@ -1654,8 +1655,8 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
> ?{
> ?	struct nvme_ns *ns;
> ?
> -	mutex_lock(&ctrl->namespaces_mutex);
> -	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> ?		spin_lock_irq(ns->queue->queue_lock);
> ?		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
> ?		spin_unlock_irq(ns->queue->queue_lock);
> @@ -1663,7 +1664,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
> ?		blk_mq_cancel_requeue_work(ns->queue);

Blame myself.

We hold RCU lock, but?blk_mq_cancel_requeue_work() may sleep.

So "echo 1 > /sys/class/nvme/nvme0/reset_controller" triggers below
BUG.

Thinking on the fix ...

[ 2348.050146] BUG: sleeping function called from invalid context at /home/mlin/linux/kernel/workqueue.c:2783
[ 2348.062044] in_atomic(): 0, irqs_disabled(): 0, pid: 1696, name: kworker/u16:0
[ 2348.070810] 4 locks held by kworker/u16:0/1696:
[ 2348.076900]??#0:??("nvme"){++++.+}, at: [<ffffffff81088c87>] process_one_work+0x147/0x430
[ 2348.086626]??#1:??((&dev->reset_work)){+.+.+.}, at: [<ffffffff81088c87>] process_one_work+0x147/0x430
[ 2348.097326]??#2:??(&dev->shutdown_lock){+.+...}, at: [<ffffffffc08cef2a>] nvme_dev_disable+0x4a/0x350 [nvme]
[ 2348.108577]??#3:??(rcu_read_lock){......}, at: [<ffffffffc0813980>] nvme_stop_queues+0x0/0x1a0 [nvme_core]
[ 2348.119620] CPU: 3 PID: 1696 Comm: kworker/u16:0 Tainted: G???????????OE???4.6.0-rc3+ #197
[ 2348.129220] Hardware name: Dell Inc. OptiPlex 7010/0773VG, BIOS A12 01/10/2013
[ 2348.137827] Workqueue: nvme nvme_reset_work [nvme]
[ 2348.144012]??0000000000000000 ffff8800d94d3a48 ffffffff81379e4c ffff88011a639640
[ 2348.152867]??ffffffff81a12688 ffff8800d94d3a70 ffffffff81094814 ffffffff81a12688
[ 2348.161728]??0000000000000adf 0000000000000000 ffff8800d94d3a98 ffffffff81094904
[ 2348.170584] Call Trace:
[ 2348.174441]??[<ffffffff81379e4c>] dump_stack+0x85/0xc9
[ 2348.181004]??[<ffffffff81094814>] ___might_sleep+0x144/0x1f0
[ 2348.188065]??[<ffffffff81094904>] __might_sleep+0x44/0x80
[ 2348.194863]??[<ffffffff81087b5e>] flush_work+0x6e/0x290
[ 2348.201492]??[<ffffffff81087af0>] ? __queue_delayed_work+0x150/0x150
[ 2348.209266]??[<ffffffff81126cf5>] ? irq_work_queue+0x75/0x90
[ 2348.216335]??[<ffffffff810ca136>] ? wake_up_klogd+0x36/0x50
[ 2348.223330]??[<ffffffff810b7fa6>] ? mark_held_locks+0x66/0x90
[ 2348.230495]??[<ffffffff81088898>] ? __cancel_work_timer+0xf8/0x1c0
[ 2348.238088]??[<ffffffff8108883b>] __cancel_work_timer+0x9b/0x1c0
[ 2348.245496]??[<ffffffff810cadaa>] ? vprintk_default+0x1a/0x20
[ 2348.252629]??[<ffffffff81142558>] ? printk+0x48/0x4a
[ 2348.258984]??[<ffffffff8108896b>] cancel_work_sync+0xb/0x10
[ 2348.265951]??[<ffffffff81350fb0>] blk_mq_cancel_requeue_work+0x10/0x20
[ 2348.273868]??[<ffffffffc0813ae7>] nvme_stop_queues+0x167/0x1a0 [nvme_core]
[ 2348.282132]??[<ffffffffc0813980>] ? nvme_kill_queues+0x190/0x190 [nvme_core]
[ 2348.290568]??[<ffffffffc08cef51>] nvme_dev_disable+0x71/0x350 [nvme]
[ 2348.298308]??[<ffffffff810b8f40>] ? __lock_acquire+0xa80/0x1ad0
[ 2348.305614]??[<ffffffff810944b6>] ? finish_task_switch+0xa6/0x2c0
[ 2348.313099]??[<ffffffffc08cffd4>] nvme_reset_work+0x214/0xd40 [nvme]
[ 2348.320841]??[<ffffffff8176df17>] ? _raw_spin_unlock_irq+0x27/0x50
[ 2348.328410]??[<ffffffff81088ce3>] process_one_work+0x1a3/0x430
[ 2348.335633]??[<ffffffff81088c87>] ? process_one_work+0x147/0x430
[ 2348.343030]??[<ffffffff810891d6>] worker_thread+0x266/0x4a0
[ 2348.349986]??[<ffffffff8176871b>] ? __schedule+0x2fb/0x8d0
[ 2348.356852]??[<ffffffff81088f70>] ? process_one_work+0x430/0x430
[ 2348.364238]??[<ffffffff8108f529>] kthread+0xf9/0x110
[ 2348.370581]??[<ffffffff8176e912>] ret_from_fork+0x22/0x50
[ 2348.377344]??[<ffffffff8108f430>] ? kthread_create_on_node+0x230/0x230
