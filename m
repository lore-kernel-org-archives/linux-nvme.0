From: keith.busch@intel.com (Keith Busch)
Date: Fri, 8 Jul 2016 21:07:55 -0400
Subject: [PATCHv3 for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <1467825770-27355-1-git-send-email-keith.busch@intel.com>
References: <1467825770-27355-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160709010754.GA28997@localhost.localdomain>

On Wed, Jul 06, 2016@11:22:50AM -0600, Keith Busch wrote:
> We can't block with RCU read lock held, but we need to do potentially
> blocking stuff to namespace queues when iterating the list. This patch
> removes the rcu read locking.
> 
> Any list iteration that does IO has to be done unlocked to allow recovery.
> The caller must ensure the list can not be manipulated under such
> conditions. List iterations that do not issue IO can safely use the lock
> since it wouldn't block recovery from missing IO completions.

Ping? Would hate to release a kernel with obvious bugs.

\ 
> This fixes these two BUGs:
> 
>  BUG: sleeping function called from invalid context at include/linux/writeback.h:185
>  in_atomic(): 1, irqs_disabled(): 0, pid: 757, name: kworker/97:1
>  CPU: 97 PID: 757 Comm: kworker/97:1 Tainted: G            E   4.6.0-2016-06-14+ #1
>  Workqueue: pciehp-2 pciehp_power_thread
>   0000000000000000 ffff880462377b38 ffffffff81310c61 ffff8804623704c0
>   00000000000000b9 ffff880462377b50 ffffffff8108fe14 ffffffff81809e2a
>   ffff880462377b78 ffffffff8108fea9 ffff880469eb4800 ffffc900011824a0
>  Call Trace:
>   [<ffffffff81310c61>] dump_stack+0x63/0x82
>   [<ffffffff8108fe14>] ___might_sleep+0xd4/0x120
>   [<ffffffff8108fea9>] __might_sleep+0x49/0x80
>   [<ffffffff8120d060>] iget5_locked+0xa0/0x210
>   [<ffffffff8122ac80>] ? bdev_test+0x20/0x20
>   [<ffffffff8122b5ce>] bdget+0x3e/0x130
>   [<ffffffff812f2b24>] bdget_disk+0x24/0x40
>   [<ffffffff8122bd3d>] revalidate_disk+0x3d/0x90
>   [<ffffffffa0483208>] nvme_kill_queues+0x38/0xc0 [nvme_core]
>   [<ffffffffa04833da>] nvme_remove_namespaces+0x5a/0x60 [nvme_core]
>   [<ffffffffa048340d>] nvme_uninit_ctrl+0x2d/0xa0 [nvme_core]
>   [<ffffffffa085c9eb>] nvme_remove+0x5b/0x100 [nvme]
>   [<ffffffff8135bfc9>] pci_device_remove+0x39/0xc0
> 
> And:
> 
>  BUG: sleeping function called from invalid context at kernel/workqueue.c:2783
>  in_atomic(): 0, irqs_disabled(): 0, pid: 1696, name: kworker/u16:0
>  CPU: 3 PID: 1696 Comm: kworker/u16:0 Tainted: G           OE   4.6.0-rc3+ #197
>  Hardware name: Dell Inc. OptiPlex 7010/0773VG, BIOS A12 01/10/2013
>  Workqueue: nvme nvme_reset_work [nvme]
>   0000000000000000 ffff8800d94d3a48 ffffffff81379e4c ffff88011a639640
>   ffffffff81a12688 ffff8800d94d3a70 ffffffff81094814 ffffffff81a12688
>   0000000000000adf 0000000000000000 ffff8800d94d3a98 ffffffff81094904
>  Call Trace:
>   [<ffffffff81379e4c>] dump_stack+0x85/0xc9
>   [<ffffffff81094814>] ___might_sleep+0x144/0x1f0
>   [<ffffffff81094904>] __might_sleep+0x44/0x80
>   [<ffffffff81087b5e>] flush_work+0x6e/0x290
>   [<ffffffff81087af0>] ? __queue_delayed_work+0x150/0x150
>   [<ffffffff81126cf5>] ? irq_work_queue+0x75/0x90
>   [<ffffffff810ca136>] ? wake_up_klogd+0x36/0x50
>   [<ffffffff810b7fa6>] ? mark_held_locks+0x66/0x90
>   [<ffffffff81088898>] ? __cancel_work_timer+0xf8/0x1c0
>   [<ffffffff8108883b>] __cancel_work_timer+0x9b/0x1c0
>   [<ffffffff810cadaa>] ? vprintk_default+0x1a/0x20
>   [<ffffffff81142558>] ? printk+0x48/0x4a
>   [<ffffffff8108896b>] cancel_work_sync+0xb/0x10
>   [<ffffffff81350fb0>] blk_mq_cancel_requeue_work+0x10/0x20
>   [<ffffffffc0813ae7>] nvme_stop_queues+0x167/0x1a0 [nvme_core]
>   [<ffffffffc0813980>] ? nvme_kill_queues+0x190/0x190 [nvme_core]
>   [<ffffffffc08cef51>] nvme_dev_disable+0x71/0x350 [nvme]
>   [<ffffffff810b8f40>] ? __lock_acquire+0xa80/0x1ad0
>   [<ffffffff810944b6>] ? finish_task_switch+0xa6/0x2c0
>   [<ffffffffc08cffd4>] nvme_reset_work+0x214/0xd40 [nvme]
