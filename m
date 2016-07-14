From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 14 Jul 2016 09:59:05 -0500
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <57875835.5050001@grimberg.me>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
 <57875835.5050001@grimberg.me>
Message-ID: <011201d1dde0$444943c0$ccdbcb40$@opengridcomputing.com>

> This patch introduces asymmetry between create and destroy
> of the admin queue. Does this alternative patch solve
> the problem?
> 
> The patch changes the order of device removal flow from:
> 1. delete controller
> 2. destroy queue
> 
> to:
> 1. destroy queue
> 2. delete controller
> 
> Or more specifically:
> 1. own the controller deletion (make sure we are not
> competing with anyone)
> 2. get rid of inflight reconnects (which also destroy and
> create queues)
> 3. destroy the queue
> 4. safely queue controller deletion
> 
> Thoughts?
> 

Your patch causes a deadlock during device removal.  

The controller delete work thread is stuck in c4iw_destroy_qp waiting on all
references to go away.  Either nvmf/rdma or the rdma-cm or both.

(gdb) list *c4iw_destroy_qp+0x155
0x15af5 is in c4iw_destroy_qp (drivers/infiniband/hw/cxgb4/qp.c:1596).
1591                    c4iw_modify_qp(rhp, qhp, C4IW_QP_ATTR_NEXT_STATE,
&attrs, 0);
1592            wait_event(qhp->wait, !qhp->ep);
1593
1594            remove_handle(rhp, &rhp->qpidr, qhp->wq.sq.qid);
1595            atomic_dec(&qhp->refcnt);
1596            wait_event(qhp->wait, !atomic_read(&qhp->refcnt));
1597
1598            spin_lock_irq(&rhp->lock);
1599            if (!list_empty(&qhp->db_fc_entry))
1600                    list_del_init(&qhp->db_fc_entry);

The rdma-cm work thread is stuck trying to grab the cm_id mutex:

(gdb) list *cma_disable_callback+0x2e
0x29e is in cma_disable_callback (drivers/infiniband/core/cma.c:715).
710
711     static int cma_disable_callback(struct rdma_id_private *id_priv,
712                                     enum rdma_cm_state state)
713     {
714             mutex_lock(&id_priv->handler_mutex);
715             if (id_priv->state != state) {
716                     mutex_unlock(&id_priv->handler_mutex);
717                     return -EINVAL;
718             }
719             return 0;

And the nvmf cm event handler is stuck waiting for the controller delete to
finish:

(gdb) list *nvme_rdma_device_unplug+0x97
0x1027 is in nvme_rdma_device_unplug (drivers/nvme/host/rdma.c:1358).
warning: Source file is more recent than executable.
1353    queue_delete:
1354            /* queue controller deletion */
1355            queue_work(nvme_rdma_wq, &ctrl->delete_work);
1356            flush_work(&ctrl->delete_work);
1357            return ret;
1358    }
1359
1360    static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
1361                    struct rdma_cm_event *ev)
1362    {

Seems like the rdma-cm work thread is trying to grab the cm_id lock for the
cm_id that is handling the DEVICE_REMOVAL event.


Here is the detailed log:

[ 1484.568354] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery",
addr 10.0.1.14:4420
[ 1495.939850] nvme nvme1: creating 32 I/O queues.
[ 1496.635114] nvme nvme1: new ctrl: NQN "test-ram0", addr 10.0.1.14:4420
[ 1502.813698] nvme nvme1: Got rdma device removal event, deleting ctrl
[ 1683.259465] INFO: task kworker/0:0:4 blocked for more than 120 seconds.
[ 1683.266147]       Tainted: G            E   4.7.0-rc2-block-for-next+ #78
[ 1683.272986] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[ 1683.280830] kworker/0:0     D ffff8810281579c8     0     4      2 0x10000000
[ 1683.287997] Workqueue: nvme_rdma_wq nvme_rdma_del_ctrl_work [nvme_rdma]
[ 1683.294658]  ffff8810281579c8 ffffffff81c0d4c0 ffff88102809c6c0
ffff880fff04e898
[ 1683.302252]  ffffffff81d448b4 ffff88102809d840 ffff881028154008
ffff88007853b3f8
[ 1683.309763]  ffff881028157ac8 ffff880f67ea5758 ffff880f67ea5760
ffff881028157a18
[ 1683.317281] Call Trace:
[ 1683.319752]  [<ffffffff816eaed0>] schedule+0x40/0xb0
[ 1683.324757]  [<ffffffffa036bac5>] c4iw_destroy_qp+0x155/0x2b0 [iw_cxgb4]
[ 1683.331481]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[ 1683.336639]  [<ffffffff810f515a>] ? lock_timer_base+0x5a/0x80
[ 1683.342402]  [<ffffffff816ede49>] ? schedule_timeout+0x1c9/0x220
[ 1683.348438]  [<ffffffff810ccd80>] ? wait_woken+0x80/0x80
[ 1683.353804]  [<ffffffffa03a25a9>] ? ib_mr_pool_destroy+0x79/0x90 [ib_core]
[ 1683.360699]  [<ffffffffa039893e>] ib_destroy_qp+0xbe/0x160 [ib_core]
[ 1683.367085]  [<ffffffffa0706011>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
[ 1683.373538]  [<ffffffffa038ed99>] nvme_rdma_destroy_queue_ib+0x29/0x90
[nvme_rdma]
[ 1683.381127]  [<ffffffffa038f04d>] nvme_rdma_stop_and_free_queue+0x2d/0x40
[nvme_rdma]
[ 1683.388967]  [<ffffffffa038f157>] nvme_rdma_shutdown_ctrl+0x87/0xe0
[nvme_rdma]
[ 1683.396290]  [<ffffffffa038f224>] nvme_rdma_del_ctrl_work+0x34/0x50
[nvme_rdma]
[ 1683.403629]  [<ffffffff810a4d03>] process_one_work+0x183/0x4d0
[ 1683.409485]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[ 1683.414984]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[ 1683.420142]  [<ffffffff810c4130>] ? dequeue_entity+0x120/0x250
[ 1683.426009]  [<ffffffff810a59bd>] worker_thread+0x16d/0x530
[ 1683.431597]  [<ffffffff8102eb1d>] ? __switch_to+0x1cd/0x5e0
[ 1683.437176]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[ 1683.442674]  [<ffffffff810ccbc6>] ? __wake_up_common+0x56/0x90
[ 1683.448511]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[ 1683.454803]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[ 1683.459951]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[ 1683.466223]  [<ffffffff810aa5dc>] kthread+0xcc/0xf0
[ 1683.471106]  [<ffffffff810b4ffe>] ? schedule_tail+0x1e/0xc0
[ 1683.476699]  [<ffffffff810ae3b0>] ? smpboot_create_threads+0x80/0x80
[ 1683.483053]  [<ffffffff816eed3f>] ret_from_fork+0x1f/0x40
[ 1683.488470]  [<ffffffff810aa510>] ? kthread_freezable_should_stop+0x70/0x70
[ 1683.495476] INFO: task kworker/u64:5:716 blocked for more than 120 seconds.
[ 1683.502441]       Tainted: G            E   4.7.0-rc2-block-for-next+ #78
[ 1683.509237] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[ 1683.517096] kworker/u64:5   D ffff88101d1ff858     0   716      2 0x10000000
[ 1683.524223] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[ 1683.529467]  ffff88101d1ff858 ffff88102819c6c0 ffff88101d200040
ffff880fff04e898
[ 1683.536954]  ffff88101d200040 ffff88101d200040 ffff88101d1fc008
ffff880f67a0720c
[ 1683.544445]  ffff88101d200040 ffff880f67a07210 ffff88101d1ff918
ffff88101d1ff8a8
[ 1683.551932] Call Trace:
[ 1683.554390]  [<ffffffff816eaed0>] schedule+0x40/0xb0
[ 1683.559358]  [<ffffffff811119ae>] ? is_module_text_address+0xe/0x20
[ 1683.565630]  [<ffffffff816eb12e>] schedule_preempt_disabled+0xe/0x10
[ 1683.571990]  [<ffffffff816ecbe3>] __mutex_lock_slowpath+0x93/0x120
[ 1683.578200]  [<ffffffff813789bb>] ? find_next_bit+0xb/0x10
[ 1683.583694]  [<ffffffff81362816>] ? cpumask_next_and+0x26/0x50
[ 1683.589529]  [<ffffffff810c4baa>] ? find_busiest_group+0x14a/0xa00
[ 1683.595713]  [<ffffffff816ecc93>] mutex_lock+0x23/0x40
[ 1683.600871]  [<ffffffffa070326e>] cma_disable_callback+0x2e/0x60 [rdma_cm]
[ 1683.607760]  [<ffffffffa0707b5b>] cma_iw_handler+0x2b/0x1b0 [rdma_cm]
[ 1683.614207]  [<ffffffffa06f61b3>] cm_close_handler+0x93/0xc0 [iw_cm]
[ 1683.620561]  [<ffffffffa06f80e7>] process_event+0xd7/0xf0 [iw_cm]
[ 1683.626665]  [<ffffffffa06f8247>] cm_work_handler+0x147/0x1c0 [iw_cm]
[ 1683.633121]  [<ffffffff810a54f6>] ?
trace_event_raw_event_workqueue_execute_start+0x66/0xa0
[ 1683.641487]  [<ffffffff810a4d03>] process_one_work+0x183/0x4d0
[ 1683.647334]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[ 1683.652831]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[ 1683.657977]  [<ffffffff816eae91>] ? schedule+0x1/0xb0
[ 1683.663038]  [<ffffffff810a59bd>] worker_thread+0x16d/0x530
[ 1683.668612]  [<ffffffff8102eb1d>] ? __switch_to+0x1cd/0x5e0
[ 1683.674197]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[ 1683.679690]  [<ffffffff810ccbc6>] ? __wake_up_common+0x56/0x90
[ 1683.685534]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[ 1683.691821]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[ 1683.696968]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[ 1683.703230]  [<ffffffff810aa5dc>] kthread+0xcc/0xf0
[ 1683.708126]  [<ffffffff810b4ffe>] ? schedule_tail+0x1e/0xc0
[ 1683.713708]  [<ffffffff816eed3f>] ret_from_fork+0x1f/0x40
[ 1683.719118]  [<ffffffff810aa510>] ? kthread_freezable_should_stop+0x70/0x70
[ 1683.726126] INFO: task rmmod:6006 blocked for more than 120 seconds.
[ 1683.732483]       Tainted: G            E   4.7.0-rc2-block-for-next+ #78
[ 1683.739278] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[ 1683.747111] rmmod           D ffff880f647479f8     0  6006   4227 0x10000080
[ 1683.754210]  ffff880f647479f8 ffff88102819af40 ffff880f647017c0
ffff880fff04e898
[ 1683.761729]  ffffffff8116c656 0000000000000001 ffff880f64744008
ffff880f64747b98
[ 1683.769244]  7fffffffffffffff ffff880f647017c0 7fffffffffffffff
ffff880f64747a48
[ 1683.776768] Call Trace:
[ 1683.779229]  [<ffffffff8116c656>] ? trace_event_buffer_commit+0x146/0x1d0
[ 1683.786037]  [<ffffffff816eaed0>] schedule+0x40/0xb0
[ 1683.791009]  [<ffffffff8102eb1d>] ? __switch_to+0x1cd/0x5e0
[ 1683.796585]  [<ffffffff816ede49>] schedule_timeout+0x1c9/0x220
[ 1683.802430]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[ 1683.807922]  [<ffffffff810a3603>] ? insert_work+0x53/0xb0
[ 1683.813341]  [<ffffffff816ebede>] wait_for_completion+0xde/0x110
[ 1683.819386]  [<ffffffff810b6b00>] ? try_to_wake_up+0x230/0x230
[ 1683.825236]  [<ffffffff810a472b>] flush_work+0x2b/0x40
[ 1683.830379]  [<ffffffff810a1810>] ? worker_detach_from_pool+0xa0/0xa0
[ 1683.836830]  [<ffffffffa038eff7>] nvme_rdma_device_unplug+0x97/0xc0
[nvme_rdma]
[ 1683.844142]  [<ffffffffa0390782>] nvme_rdma_cm_handler+0x72/0x2f0 [nvme_rdma]
[ 1683.851297]  [<ffffffff812085c4>] ? kmem_cache_free+0x1f4/0x210
[ 1683.857230]  [<ffffffffa0703669>] ? cma_comp+0x49/0x60 [rdma_cm]
[ 1683.863247]  [<ffffffffa070810f>] cma_remove_id_dev+0x8f/0xa0 [rdma_cm]
[ 1683.869865]  [<ffffffffa07081d7>] cma_process_remove+0xb7/0x100 [rdma_cm]
[ 1683.876681]  [<ffffffff812b2a14>] ? __kernfs_remove+0x114/0x1d0
[ 1683.882608]  [<ffffffffa070825e>] cma_remove_one+0x3e/0x60 [rdma_cm]
[ 1683.888983]  [<ffffffffa039dca0>] ib_unregister_device+0xb0/0x150 [ib_core]
[ 1683.895957]  [<ffffffffa0363034>] c4iw_unregister_device+0x64/0x90 [iw_cxgb4]
[ 1683.903109]  [<ffffffffa0356357>] c4iw_remove+0x27/0x60 [iw_cxgb4]
[ 1683.909303]  [<ffffffffa036e6fd>] c4iw_exit_module+0x31/0x934 [iw_cxgb4]
[ 1683.916018]  [<ffffffff811120e3>] SyS_delete_module+0x183/0x1d0
[ 1683.921955]  [<ffffffff81003476>] ? do_audit_syscall_entry+0x66/0x70
[ 1683.928314]  [<ffffffff8100378c>] ? trace_event_raw_event_sys_exit+0x6c/0xa0
[ 1683.935357]  [<ffffffff81003b45>] ? syscall_trace_enter+0x65/0x70
[ 1683.941501]  [<ffffffff81003f08>] do_syscall_64+0x78/0x1d0
[ 1683.947003]  [<ffffffff8106e367>] ? do_page_fault+0x37/0x90
[ 1683.952587]  [<ffffffff816eebe1>] entry_SYSCALL64_slow_path+0x25/0x25
