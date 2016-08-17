From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 17 Aug 2016 09:33:48 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
Message-ID: <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>

> > Hey Sagi,
> >
> > Here is another issue I'm seeing doing reboot testing.  The test does
this:
> >
> > 1) connect 10 ram devices over iw_cxgb4
> > 2) reboot the target node
> > 3) the initiator goes into recovery/reconnect mode
> > 4) reboot the inititator at this point.
> >
> > The initiator gets stuck doing this continually and the system never
reboots:
> >
> > [  596.411842] nvme nvme1: Failed reconnect attempt, requeueing...
> > [  596.907865] nvme nvme9: rdma_resolve_addr wait failed (-104).
> > [  596.914461] nvme nvme9: Failed reconnect attempt, requeueing...
> > [  597.939935] nvme nvme10: rdma_resolve_addr wait failed (-104).
> > [  597.946625] nvme nvme10: Failed reconnect attempt, requeueing...
> > [  598.963995] nvme nvme2: rdma_resolve_addr wait failed (-110).
> > [  598.971968] nvme nvme2: Failed reconnect attempt, requeueing...
> > [  602.036135] nvme nvme3: rdma_resolve_addr wait failed (-104).
> > [  602.043797] nvme nvme3: Failed reconnect attempt, requeueing...
> > [  603.060171] nvme nvme4: rdma_resolve_addr wait failed (-104).
> > [  603.068153] nvme nvme4: Failed reconnect attempt, requeueing...
> > [  604.084223] nvme nvme5: rdma_resolve_addr wait failed (-104).
> > [  604.092191] nvme nvme5: Failed reconnect attempt, requeueing...
> > [  605.108294] nvme nvme6: rdma_resolve_addr wait failed (-104).
> > [  605.116251] nvme nvme6: Failed reconnect attempt, requeueing...
> >
> > Debugging now...
> 
> Hmm...
> 
> Does this reproduce also when you simply delete all the
> controllers (via sysfs)?
>

Yes.

 
> Do you see the hung task watchdog? can you share the
> threads state? (echo t > /proc/sysrq-trigger)

The deleting thread is stuck:

Aug 17 07:21:32 stevo1 kernel: [ 2213.279798] INFO: task bash:4066 blocked
for more than 120 seconds.
Aug 17 07:21:32 stevo1 kernel: [ 2213.279802]       Tainted: G            E
4.8.0-rc2-nvmf-4.8-rc-rebased-rc2+ #15
Aug 17 07:21:32 stevo1 kernel: [ 2213.279803] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 17 07:21:32 stevo1 kernel: [ 2213.279811] bash            D
ffff881034547ac8     0  4066   4056 0x10000080
Aug 17 07:21:32 stevo1 kernel: [ 2213.279819]  ffff881034547ac8
ffff881033f04140 ffff88102bc80000 ffff881032b66250
Aug 17 07:21:32 stevo1 kernel: [ 2213.279824]  ffff880fefe64230
ffff88103e88aa50 ffff881034544008 ffff881034547c98
Aug 17 07:21:32 stevo1 kernel: [ 2213.279828]  ffff881034547c08
ffff88102bc80000 7fffffffffffffff ffff881034547b18
Aug 17 07:21:32 stevo1 kernel: [ 2213.279829] Call Trace:
Aug 17 07:21:32 stevo1 kernel: [ 2213.279842]  [<ffffffff816ddde0>]
schedule+0x40/0xb0
Aug 17 07:21:32 stevo1 kernel: [ 2213.279850]  [<ffffffff810b2de4>] ?
try_to_wake_up+0x54/0x240
Aug 17 07:21:32 stevo1 kernel: [ 2213.279856]  [<ffffffff816e0a8d>]
schedule_timeout+0x2ad/0x410
Aug 17 07:21:32 stevo1 kernel: [ 2213.279861]  [<ffffffff810b3025>] ?
wake_up_process+0x15/0x20
Aug 17 07:21:32 stevo1 kernel: [ 2213.279868]  [<ffffffff8109d940>] ?
wake_up_worker+0x30/0x40
Aug 17 07:21:32 stevo1 kernel: [ 2213.279873]  [<ffffffff8109fdbc>] ?
insert_work+0x6c/0xb0
Aug 17 07:21:32 stevo1 kernel: [ 2213.279878]  [<ffffffff816deefe>]
wait_for_completion+0xde/0x110
Aug 17 07:21:32 stevo1 kernel: [ 2213.279882]  [<ffffffff810b2fd0>] ?
try_to_wake_up+0x240/0x240
Aug 17 07:21:32 stevo1 kernel: [ 2213.279887]  [<ffffffff810a0e0b>]
flush_work+0x2b/0x40
Aug 17 07:21:32 stevo1 kernel: [ 2213.279892]  [<ffffffff8109dcc0>] ?
worker_detach_from_pool+0xa0/0xa0
Aug 17 07:21:32 stevo1 kernel: [ 2213.279902]  [<ffffffffa064e46a>] ?
__nvme_rdma_del_ctrl+0x4a/0x60 [nvme_rdma]
Aug 17 07:21:32 stevo1 kernel: [ 2213.279908]  [<ffffffffa064e4b8>]
nvme_rdma_del_ctrl+0x38/0x50 [nvme_rdma]
Aug 17 07:21:32 stevo1 kernel: [ 2213.279918]  [<ffffffffa02703d4>]
nvme_sysfs_delete+0x34/0x50 [nvme_core]
Aug 17 07:21:32 stevo1 kernel: [ 2213.279923]  [<ffffffff814884a0>]
dev_attr_store+0x20/0x30
Aug 17 07:21:32 stevo1 kernel: [ 2213.279931]  [<ffffffff812ae29e>]
sysfs_kf_write+0x3e/0x40
Aug 17 07:21:32 stevo1 kernel: [ 2213.279935]  [<ffffffff812add13>]
kernfs_fop_write+0x113/0x1b0
Aug 17 07:21:32 stevo1 kernel: [ 2213.279942]  [<ffffffff8115a588>] ?
trace_buffer_unlock_commit_regs+0x68/0x80
Aug 17 07:21:32 stevo1 kernel: [ 2213.279949]  [<ffffffff8122cfe4>]
__vfs_write+0x34/0x120
Aug 17 07:21:32 stevo1 kernel: [ 2213.279957]  [<ffffffff81003725>] ?
trace_event_raw_event_sys_enter+0xb5/0x130
Aug 17 07:21:32 stevo1 kernel: [ 2213.279963]  [<ffffffff810d1d06>] ?
percpu_down_read+0x16/0x60
Aug 17 07:21:32 stevo1 kernel: [ 2213.279967]  [<ffffffff8122d191>]
vfs_write+0xc1/0x130
Aug 17 07:21:32 stevo1 kernel: [ 2213.279974]  [<ffffffff81249633>] ?
__fdget+0x13/0x20
Aug 17 07:21:32 stevo1 kernel: [ 2213.279978]  [<ffffffff8122d306>]
SyS_write+0x56/0xc0
Aug 17 07:21:32 stevo1 kernel: [ 2213.279983]  [<ffffffff81003e7d>]
do_syscall_64+0x7d/0x230
Aug 17 07:21:32 stevo1 kernel: [ 2213.279991]  [<ffffffff8106f057>] ?
do_page_fault+0x37/0x90
Aug 17 07:21:32 stevo1 kernel: [ 2213.279997]  [<ffffffff816e1921>]
entry_SYSCALL64_slow_path+0x25/0x25



Nvme_rdma_wq is doing nothing:

Aug 17 07:20:08 stevo1 kernel: [ 2130.461614] nvme_rdma_wq    S
ffff880fedd7bd58     0  4607      2 0x10000080
Aug 17 07:20:08 stevo1 kernel: [ 2130.469572]  ffff880fedd7bd58
ffff8810381a15c0 ffff88102bdb5700 ffff881032b66250
Aug 17 07:20:08 stevo1 kernel: [ 2130.477972]  ffffffff81038959
ffff880fedd7bd48 ffff880fedd78008 ffff8810206dde00
Aug 17 07:20:08 stevo1 kernel: [ 2130.486357]  ffff88102bdb5700
ffffffff810a1730 ffff8810381abed8 ffff880fedd7bda8
Aug 17 07:20:08 stevo1 kernel: [ 2130.494755] Call Trace:
Aug 17 07:20:08 stevo1 kernel: [ 2130.498088]  [<ffffffff81038959>] ?
sched_clock+0x9/0x10
Aug 17 07:20:08 stevo1 kernel: [ 2130.504287]  [<ffffffff810a1730>] ?
process_one_work+0x4d0/0x4d0
Aug 17 07:20:08 stevo1 kernel: [ 2130.511168]  [<ffffffff816ddde0>]
schedule+0x40/0xb0
Aug 17 07:20:08 stevo1 kernel: [ 2130.517002]  [<ffffffff810b1064>] ?
set_user_nice+0x114/0x1b0
Aug 17 07:20:08 stevo1 kernel: [ 2130.523623]  [<ffffffff810a1a22>]
rescuer_thread+0x2f2/0x380
Aug 17 07:20:08 stevo1 kernel: [ 2130.530146]  [<ffffffff816dd920>] ?
__schedule+0x1f0/0x5b0
Aug 17 07:20:08 stevo1 kernel: [ 2130.536501]  [<ffffffff810cb8a6>] ?
__wake_up_common+0x56/0x90
Aug 17 07:20:08 stevo1 kernel: [ 2130.543173]  [<ffffffff810a1730>] ?
process_one_work+0x4d0/0x4d0
Aug 17 07:20:08 stevo1 kernel: [ 2130.550013]  [<ffffffff816ddde0>] ?
schedule+0x40/0xb0
Aug 17 07:20:08 stevo1 kernel: [ 2130.555971]  [<ffffffff810a1730>] ?
process_one_work+0x4d0/0x4d0
Aug 17 07:20:08 stevo1 kernel: [ 2130.562800]  [<ffffffff810a6bbc>]
kthread+0xcc/0xf0
Aug 17 07:20:08 stevo1 kernel: [ 2130.568485]  [<ffffffff810b157e>] ?
schedule_tail+0x1e/0xc0
Aug 17 07:20:08 stevo1 kernel: [ 2130.574871]  [<ffffffff816e1a7f>]
ret_from_fork+0x1f/0x40
Aug 17 07:20:08 stevo1 kernel: [ 2130.581073]  [<ffffffff810a6af0>] ?
kthread_freezable_should_stop+0x70/0x70

Here is another thread in the delete controller sysfs path:

Aug 17 07:20:05 stevo1 kernel: [ 2127.184581] bash            D
ffff881034547ac8     0  4066   4056 0x10000080
Aug 17 07:20:05 stevo1 kernel: [ 2127.192445]  ffff881034547ac8
ffff881033f04140 ffff88102bc80000 ffff881032b66250
Aug 17 07:20:05 stevo1 kernel: [ 2127.200730]  ffff880fefe64230
ffff88103e88aa50 ffff881034544008 ffff881034547c98
Aug 17 07:20:05 stevo1 kernel: [ 2127.209022]  ffff881034547c08
ffff88102bc80000 7fffffffffffffff ffff881034547b18
Aug 17 07:20:05 stevo1 kernel: [ 2127.217278] Call Trace:
Aug 17 07:20:05 stevo1 kernel: [ 2127.220523]  [<ffffffff816ddde0>]
schedule+0x40/0xb0
Aug 17 07:20:05 stevo1 kernel: [ 2127.226244]  [<ffffffff810b2de4>] ?
try_to_wake_up+0x54/0x240
Aug 17 07:20:05 stevo1 kernel: [ 2127.232753]  [<ffffffff816e0a8d>]
schedule_timeout+0x2ad/0x410
Aug 17 07:20:05 stevo1 kernel: [ 2127.239353]  [<ffffffff810b3025>] ?
wake_up_process+0x15/0x20
Aug 17 07:20:05 stevo1 kernel: [ 2127.245871]  [<ffffffff8109d940>] ?
wake_up_worker+0x30/0x40
Aug 17 07:20:05 stevo1 kernel: [ 2127.252285]  [<ffffffff8109fdbc>] ?
insert_work+0x6c/0xb0
Aug 17 07:20:05 stevo1 kernel: [ 2127.258432]  [<ffffffff816deefe>]
wait_for_completion+0xde/0x110
Aug 17 07:20:05 stevo1 kernel: [ 2127.263351] nvme nvme4: rdma_resolve_addr
wait failed (-110).
Aug 17 07:20:05 stevo1 kernel: [ 2127.263355] nvme nvme4: Failed reconnect
attempt, requeueing...
Aug 17 07:20:05 stevo1 kernel: [ 2127.278353]  [<ffffffff810b2fd0>] ?
try_to_wake_up+0x240/0x240
Aug 17 07:20:05 stevo1 kernel: [ 2127.284912]  [<ffffffff810a0e0b>]
flush_work+0x2b/0x40
Aug 17 07:20:05 stevo1 kernel: [ 2127.290771]  [<ffffffff8109dcc0>] ?
worker_detach_from_pool+0xa0/0xa0
Aug 17 07:20:05 stevo1 kernel: [ 2127.297970]  [<ffffffffa064e46a>] ?
__nvme_rdma_del_ctrl+0x4a/0x60 [nvme_rdma]
Aug 17 07:20:05 stevo1 kernel: [ 2127.305945]  [<ffffffffa064e4b8>]
nvme_rdma_del_ctrl+0x38/0x50 [nvme_rdma]
Aug 17 07:20:05 stevo1 kernel: [ 2127.313577]  [<ffffffffa02703d4>]
nvme_sysfs_delete+0x34/0x50 [nvme_core]
Aug 17 07:20:05 stevo1 kernel: [ 2127.321111]  [<ffffffff814884a0>]
dev_attr_store+0x20/0x30
Aug 17 07:20:05 stevo1 kernel: [ 2127.327343]  [<ffffffff812ae29e>]
sysfs_kf_write+0x3e/0x40
Aug 17 07:20:05 stevo1 kernel: [ 2127.333551]  [<ffffffff812add13>]
kernfs_fop_write+0x113/0x1b0
Aug 17 07:20:05 stevo1 kernel: [ 2127.340127]  [<ffffffff8115a588>] ?
trace_buffer_unlock_commit_regs+0x68/0x80
Aug 17 07:20:05 stevo1 kernel: [ 2127.348017]  [<ffffffff8122cfe4>]
__vfs_write+0x34/0x120
Aug 17 07:20:05 stevo1 kernel: [ 2127.354083]  [<ffffffff81003725>] ?
trace_event_raw_event_sys_enter+0xb5/0x130
Aug 17 07:20:05 stevo1 kernel: [ 2127.362060]  [<ffffffff810d1d06>] ?
percpu_down_read+0x16/0x60
Aug 17 07:20:05 stevo1 kernel: [ 2127.368667]  [<ffffffff8122d191>]
vfs_write+0xc1/0x130
Aug 17 07:20:05 stevo1 kernel: [ 2127.374559]  [<ffffffff81249633>] ?
__fdget+0x13/0x20
Aug 17 07:20:05 stevo1 kernel: [ 2127.380367]  [<ffffffff8122d306>]
SyS_write+0x56/0xc0
Aug 17 07:20:05 stevo1 kernel: [ 2127.386201]  [<ffffffff81003e7d>]
do_syscall_64+0x7d/0x230
Aug 17 07:20:05 stevo1 kernel: [ 2127.392485]  [<ffffffff8106f057>] ?
do_page_fault+0x37/0x90
Aug 17 07:20:05 stevo1 kernel: [ 2127.398866]  [<ffffffff816e1921>]
entry_SYSCALL64_slow_path+0x25/0x25

Here is the reconnect workq thread stuck trying to connect:

Aug 17 07:19:45 stevo1 kernel: [ 2107.446780] Workqueue: nvme_rdma_wq
nvme_rdma_reconnect_ctrl_work [nvme_rdma]
Aug 17 07:19:45 stevo1 kernel: [ 2107.454764]  ffff881033a57aa8
ffff88103815c140 ffff8810371dab80 ffff881032b66250
Aug 17 07:19:45 stevo1 kernel: [ 2107.463091]  00000001001b93e9
0000000000000001 ffff881033a54008 ffff88103ee500c0
Aug 17 07:19:45 stevo1 kernel: [ 2107.471431]  00000001001b93e9
0000000000000000 ffff88103ee500c0 ffff881033a57af8
Aug 17 07:19:45 stevo1 kernel: [ 2107.479805] Call Trace:
Aug 17 07:19:45 stevo1 kernel: [ 2107.483076]  [<ffffffff816ddde0>]
schedule+0x40/0xb0
Aug 17 07:19:45 stevo1 kernel: [ 2107.488892]  [<ffffffff810f4a80>] ?
internal_add_timer+0x70/0x80
Aug 17 07:19:45 stevo1 kernel: [ 2107.495765]  [<ffffffff816e09fb>]
schedule_timeout+0x21b/0x410
Aug 17 07:19:45 stevo1 kernel: [ 2107.502464]  [<ffffffff810f4c10>] ?
del_timer+0x70/0x70
Aug 17 07:19:45 stevo1 kernel: [ 2107.508547]  [<ffffffffa031da9f>] ?
rdma_resolve_ip+0x1cf/0x1e0 [ib_core]
Aug 17 07:19:45 stevo1 kernel: [ 2107.516183]  [<ffffffffa0736fe0>] ?
cma_work_handler+0xa0/0xa0 [rdma_cm]
Aug 17 07:19:45 stevo1 kernel: [ 2107.523721]  [<ffffffff816deb6f>]
wait_for_completion_interruptible_timeout+0xef/0x130
Aug 17 07:19:45 stevo1 kernel: [ 2107.532472]  [<ffffffff810b2fd0>] ?
try_to_wake_up+0x240/0x240
Aug 17 07:19:45 stevo1 kernel: [ 2107.539152]  [<ffffffffa064f5c2>]
nvme_rdma_init_queue+0xe2/0x180 [nvme_rdma]
Aug 17 07:19:45 stevo1 kernel: [ 2107.547132]  [<ffffffffa064f9bc>]
nvme_rdma_reconnect_ctrl_work+0x9c/0x1f0 [nvme_rdma]
Aug 17 07:19:45 stevo1 kernel: [ 2107.555908]  [<ffffffff810a13e3>]
process_one_work+0x183/0x4d0
Aug 17 07:19:45 stevo1 kernel: [ 2107.562592]  [<ffffffff816dd920>] ?
__schedule+0x1f0/0x5b0
Aug 17 07:19:45 stevo1 kernel: [ 2107.568938]  [<ffffffff816ddde0>] ?
schedule+0x40/0xb0
Aug 17 07:19:45 stevo1 kernel: [ 2107.574927]  [<ffffffff810a207d>]
worker_thread+0x16d/0x530
Aug 17 07:19:45 stevo1 kernel: [ 2107.581346]  [<ffffffff810a1f10>] ?
maybe_create_worker+0x120/0x120
Aug 17 07:19:45 stevo1 kernel: [ 2107.588474]  [<ffffffff816dd920>] ?
__schedule+0x1f0/0x5b0
Aug 17 07:19:45 stevo1 kernel: [ 2107.594813]  [<ffffffff810cb8a6>] ?
__wake_up_common+0x56/0x90
Aug 17 07:19:45 stevo1 kernel: [ 2107.601488]  [<ffffffff810a1f10>] ?
maybe_create_worker+0x120/0x120
Aug 17 07:19:45 stevo1 kernel: [ 2107.608625]  [<ffffffff816ddde0>] ?
schedule+0x40/0xb0
Aug 17 07:19:45 stevo1 kernel: [ 2107.614626]  [<ffffffff810a1f10>] ?
maybe_create_worker+0x120/0x120
Aug 17 07:19:45 stevo1 kernel: [ 2107.621745]  [<ffffffff810a6bbc>]
kthread+0xcc/0xf0
Aug 17 07:19:45 stevo1 kernel: [ 2107.627464]  [<ffffffff810b157e>] ?
schedule_tail+0x1e/0xc0
Aug 17 07:19:45 stevo1 kernel: [ 2107.633886]  [<ffffffff816e1a7f>]
ret_from_fork+0x1f/0x40
Aug 17 07:19:45 stevo1 kernel: [ 2107.640121]  [<ffffffff810a6af0>] ?
kthread_freezable_should_stop+0x70/0x70

Here is controller delete workq thread:

Aug 17 07:19:42 stevo1 kernel: [ 2104.515910] Workqueue: nvme_rdma_wq
nvme_rdma_del_ctrl_work [nvme_rdma]
Aug 17 07:19:42 stevo1 kernel: [ 2104.523373]  ffff881033f13888
ffff88103817ab80 ffff881033f04140 ffff881032b66250
Aug 17 07:19:42 stevo1 kernel: [ 2104.531744]  00000001001c1a60
0000000000000005 ffff881033f10008 ffff88103ef500c0
Aug 17 07:19:42 stevo1 kernel: [ 2104.540116]  00000001001c1a60
0000000000000000 ffff88103ef500c0 ffff881033f138d8
Aug 17 07:19:42 stevo1 kernel: [ 2104.548501] Call Trace:
Aug 17 07:19:42 stevo1 kernel: [ 2104.551777]  [<ffffffff816ddde0>]
schedule+0x40/0xb0
Aug 17 07:19:42 stevo1 kernel: [ 2104.557593]  [<ffffffff810f4a80>] ?
internal_add_timer+0x70/0x80
Aug 17 07:19:42 stevo1 kernel: [ 2104.564445]  [<ffffffff816e09fb>]
schedule_timeout+0x21b/0x410
Aug 17 07:19:42 stevo1 kernel: [ 2104.571117]  [<ffffffff810f4c10>] ?
del_timer+0x70/0x70
Aug 17 07:19:42 stevo1 kernel: [ 2104.577191]  [<ffffffff810fe67c>] ?
ktime_get+0x4c/0xc0
Aug 17 07:19:42 stevo1 kernel: [ 2104.583248]  [<ffffffff816dd6c4>]
io_schedule_timeout+0xa4/0x110
Aug 17 07:19:42 stevo1 kernel: [ 2104.590083]  [<ffffffff816df013>]
wait_for_completion_io_timeout+0xe3/0x120
Aug 17 07:19:42 stevo1 kernel: [ 2104.597943]  [<ffffffff810b2fd0>] ?
try_to_wake_up+0x240/0x240
Aug 17 07:19:42 stevo1 kernel: [ 2104.604613]  [<ffffffff81332a4d>] ?
blk_execute_rq_nowait+0x7d/0x160
Aug 17 07:19:42 stevo1 kernel: [ 2104.611810]  [<ffffffff81332bbc>]
blk_execute_rq+0x8c/0x110
Aug 17 07:19:42 stevo1 kernel: [ 2104.618221]  [<ffffffffa02715c5>]
__nvme_submit_sync_cmd+0x85/0xe0 [nvme_core]
Aug 17 07:19:42 stevo1 kernel: [ 2104.626293]  [<ffffffffa0672526>]
nvmf_reg_write32+0x66/0xb0 [nvme_fabrics]
Aug 17 07:19:42 stevo1 kernel: [ 2104.634086]  [<ffffffffa027095e>]
nvme_shutdown_ctrl+0x4e/0xe0 [nvme_core]
Aug 17 07:19:42 stevo1 kernel: [ 2104.641796]  [<ffffffffa064f161>]
nvme_rdma_shutdown_ctrl+0xa1/0xe0 [nvme_rdma]
Aug 17 07:19:42 stevo1 kernel: [ 2104.649940]  [<ffffffffa064f21c>]
__nvme_rdma_remove_ctrl+0x7c/0x80 [nvme_rdma]
Aug 17 07:19:42 stevo1 kernel: [ 2104.658093]  [<ffffffffa064f25a>]
nvme_rdma_del_ctrl_work+0x1a/0x20 [nvme_rdma]
Aug 17 07:19:42 stevo1 kernel: [ 2104.666248]  [<ffffffff810a13e3>]
process_one_work+0x183/0x4d0
Aug 17 07:19:42 stevo1 kernel: [ 2104.672936]  [<ffffffff816dd920>] ?
__schedule+0x1f0/0x5b0
Aug 17 07:19:42 stevo1 kernel: [ 2104.679269]  [<ffffffff8109daf2>] ?
move_linked_works+0x62/0x90
Aug 17 07:19:42 stevo1 kernel: [ 2104.686032]  [<ffffffff810a2204>]
worker_thread+0x2f4/0x530
Aug 17 07:19:42 stevo1 kernel: [ 2104.692441]  [<ffffffff810a1f10>] ?
maybe_create_worker+0x120/0x120
Aug 17 07:19:42 stevo1 kernel: [ 2104.699540]  [<ffffffff816dd920>] ?
__schedule+0x1f0/0x5b0
Aug 17 07:19:42 stevo1 kernel: [ 2104.705867]  [<ffffffff810cb8a6>] ?
__wake_up_common+0x56/0x90
Aug 17 07:19:42 stevo1 kernel: [ 2104.712534]  [<ffffffff810a1f10>] ?
maybe_create_worker+0x120/0x120
Aug 17 07:19:42 stevo1 kernel: [ 2104.719257] nvme nvme4: rdma_resolve_addr
wait failed (-104).
Aug 17 07:19:42 stevo1 kernel: [ 2104.719261] nvme nvme4: Failed reconnect
attempt, requeueing...
Aug 17 07:19:42 stevo1 kernel: [ 2104.733085]  [<ffffffff816ddde0>] ?
schedule+0x40/0xb0
Aug 17 07:19:42 stevo1 kernel: [ 2104.739063]  [<ffffffff810a1f10>] ?
maybe_create_worker+0x120/0x120
Aug 17 07:19:42 stevo1 kernel: [ 2104.746163]  [<ffffffff810a6bbc>]
kthread+0xcc/0xf0
Aug 17 07:19:42 stevo1 kernel: [ 2104.751878]  [<ffffffff810b157e>] ?
schedule_tail+0x1e/0xc0
