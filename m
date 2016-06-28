From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 28 Jun 2016 14:20:38 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <1467132596.7205.11.camel@ssi>
References: <576306EE.4020306@grimberg.me>
 <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>
 <CAF1ivSYUG4c7Ej-gNqA=aPFR2zkNq8KhBoodhp64wdY=eQLx6g@mail.gmail.com>
 <01c101d1c80d$96d13c80$c473b580$@opengridcomputing.com>
 <20160616203437.GA19079@lst.de>
 <01e701d1c810$91d851c0$b588f540$@opengridcomputing.com>
 <020201d1c812$ec94b430$c5be1c90$@opengridcomputing.com>
 <1467066582.7205.7.camel@ssi> <20160628091433.GA14149@lst.de>
 <005001d1d147$81cd8cb0$8568a610$@opengridcomputing.com>
 <20160628155159.GA3084@lst.de>
 <01dc01d1d15a$84f42670$8edc7350$@opengridcomputing.com>
 <1467132596.7205.11.camel@ssi>
Message-ID: <022701d1d172$2743d990$75cb8cb0$@opengridcomputing.com>

> > Hey Ming,
> >
> > For what its worth, the change you proposed in this thread isn't working for
me.
> > I see maybe one or two recoveries successful, then the target gets stuck.  I
see
> > several workq threads stuck destroying various qps, one thread stuck
draining a
> > qp.  If this change is not the proper fix, then I'm not going to debug this
> > further.
> 
> I didn't see this during overnight test. Possibly another bug.
> Could you post the stuck call stack?
> 


below...

> I assume you are still doing below tests on host:
>

yes.  

It could be another bug, but it happens so quickly I assumed it was introduced
by your change.  Maybe not...  Here are the (several) stuck threads.   They're
stuck destroying the iwarp qps, which usually means the lower level connections
are stuck somehow.  This is a familiar stall point when things go bad on the
cxgb4 connections below the QP.  But the link Is up and running, so it seems
like a deadlock somewhere.  I'm using a ram disk for the target.  Perhaps before
I was using a real nvme device.  I'll try that too and see if I still hit this
deadlock/stall...



INFO: task kworker/3:0:28 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:0     D ffff88102fc73988     0    28      2 0x10000000
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff88102fc73988 ffff88102fc54340 ffff88102f900340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff881000000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:1:124 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:1     D ffff88102ea93988     0   124      2 0x10000000
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff88102ea93988 ffff88102f900340 ffff88101d8fa340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff881000000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810b640c>] ? wake_up_klogd+0x3c/0x40
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/u32:4:475 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u32:4   D ffff8810286876b8     0   475      2 0x10000000
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
 ffff8810286876b8 ffff881028fd2340 ffff8810300be340 ffff881028a75d90
 ffff88102fc03e00 ffff881000000000 0000000000000046 ffffffff00000000
 0000000000000000 ffff881000000000 ffffffff81119f54 ffff881000000001
Call Trace:
 [<ffffffff81119f54>] ? ring_buffer_unlock_commit+0x24/0xb0
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffff81131826>] ? trace_event_buffer_commit+0x146/0x1d0
 [<ffffffff8162753f>] schedule_timeout+0x16f/0x1f0
 [<ffffffff81091eb6>] ? trace_event_raw_event_sched_wakeup_template+0x96/0xe0
 [<ffffffff81624c93>] wait_for_completion+0xa3/0x120
 [<ffffffff81090130>] ? try_to_wake_up+0x230/0x230
 [<ffffffffa02b4670>] c4iw_drain_sq+0x50/0x60 [iw_cxgb4]
 [<ffffffffa05f503a>] ib_drain_sq+0x1a/0x30 [ib_core]
 [<ffffffffa05f5066>] ib_drain_qp+0x16/0x40 [ib_core]
 [<ffffffffa02511aa>] __nvmet_rdma_queue_disconnect+0x5a/0xc0 [nvmet_rdma]
 [<ffffffffa0252651>] nvmet_rdma_cm_handler+0xe1/0x1d0 [nvmet_rdma]
 [<ffffffff8162620e>] ? mutex_lock+0x1e/0x40
 [<ffffffffa023e27e>] ? cma_disable_callback+0x2e/0x60 [rdma_cm]
 [<ffffffffa0242d12>] cma_iw_handler+0xf2/0x1b0 [rdma_cm]
 [<ffffffffa02301b3>] cm_close_handler+0x93/0xc0 [iw_cm]
 [<ffffffffa0232177>] process_event+0xd7/0xf0 [iw_cm]
 [<ffffffffa02322de>] cm_work_handler+0x14e/0x1d0 [iw_cm]
 [<ffffffff81119e9d>] ? rb_commit+0x10d/0x1a0
 [<ffffffff8107f1e6>] ? trace_event_raw_event_workqueue_execute_start+0x66/0xa0
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff812eac7f>] ? __delay+0xf/0x20
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:2:9626 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:2     D ffff881006fe7988     0  9626      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff881006fe7988 ffff881028f34340 ffff88102e6bc340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff881000000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810b640c>] ? wake_up_klogd+0x3c/0x40
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81119f54>] ? ring_buffer_unlock_commit+0x24/0xb0
 [<ffffffff81120391>] ? trace_buffer_unlock_commit_regs+0x61/0x80
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:3:9853 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:3     D ffff880f780fb988     0  9853      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff880f780fb988 ffff8810118b0340 ffff8810284a6340 ffff881028a75d90
 ffff881076c01280 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff880f00000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff810a23e3>] ? __wake_up+0x53/0x70
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:4:9854 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:4     D ffff880ff1997988     0  9854      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff880ff1997988 ffff88102561b340 ffff88102e6bc340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff880f00000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:5:9855 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:5     D ffff880f792d3988     0  9855      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff880f792d3988 ffff88102e6bc340 ffff88102a009340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff880f00000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:6:9856 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:6     D ffff880f79363988     0  9856      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff880f79363988 ffff88101d8fa340 ffff88101dbba340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff880f00000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810b640c>] ? wake_up_klogd+0x3c/0x40
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:7:9857 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:7     D ffff880f780ff988     0  9857      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff880f780ff988 ffff8810284a6340 ffff88101dbba340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff880f00000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810b640c>] ? wake_up_klogd+0x3c/0x40
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff812d8f94>] ? cfq_completed_request+0x4c4/0x7e0
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
INFO: task kworker/3:8:9858 blocked for more than 120 seconds.
      Tainted: G            E   4.7.0-rc2-nvmf-all.3-debug+ #97
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/3:8     D ffff880f78877988     0  9858      2 0x10000080
Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
 ffff880f78877988 ffff88102a009340 ffff880ff18cd340 ffff881028a75d90
 ffffffff811b45c9 0000000000000000 ffff88101afd4b88 ffff880f00000000
 0000000000000292 ffff880f00000000 0000000000000002 ffff881000000001
Call Trace:
 [<ffffffff811b45c9>] ? cache_free_debugcheck+0x1b9/0x290
 [<ffffffff81623c90>] schedule+0x40/0xb0
 [<ffffffffa02b7aa8>] c4iw_destroy_qp+0x148/0x290 [iw_cxgb4]
 [<ffffffffa02b93bb>] ? c4iw_pblpool_free+0x7b/0xb0 [iw_cxgb4]
 [<ffffffffa02b10f6>] ? c4iw_dereg_mr+0x106/0x1d0 [iw_cxgb4]
 [<ffffffff810a1f20>] ? woken_wake_function+0x20/0x20
 [<ffffffffa05feacb>] ? ib_mr_pool_destroy+0x9b/0xb0 [ib_core]
 [<ffffffff811798bd>] ? pcpu_free_area+0x15d/0x1d0
 [<ffffffffa05f49d0>] ib_destroy_qp+0x120/0x1a0 [ib_core]
 [<ffffffffa0241021>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
 [<ffffffffa0251926>] nvmet_rdma_free_queue+0x36/0xa0 [nvmet_rdma]
 [<ffffffffa02519c3>] nvmet_rdma_release_queue_work+0x33/0x70 [nvmet_rdma]
 [<ffffffff8107df1b>] process_one_work+0x18b/0x520
 [<ffffffff810ca283>] ? try_to_del_timer_sync+0x53/0x70
 [<ffffffff8162806f>] ? _raw_spin_lock_irq+0xf/0x20
 [<ffffffff8107f550>] ? maybe_create_worker+0x90/0x110
 [<ffffffff8162504b>] ? __mutex_unlock_slowpath+0xbb/0x160
 [<ffffffff8107f736>] worker_thread+0x166/0x580
 [<ffffffff8162372f>] ? __schedule+0x23f/0x640
 [<ffffffff81090142>] ? default_wake_function+0x12/0x20
 [<ffffffff810a1de5>] ? __wake_up_common+0x55/0x80
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff81623c90>] ? schedule+0x40/0xb0
 [<ffffffff8107f5d0>] ? maybe_create_worker+0x110/0x110
 [<ffffffff810843de>] kthread+0xde/0x100
 [<ffffffff8108e59e>] ? schedule_tail+0x1e/0xc0
 [<ffffffff8162838f>] ret_from_fork+0x1f/0x40
 [<ffffffff81084300>] ? __init_kthread_worker+0x40/0x40
