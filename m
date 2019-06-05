From: alex@zadara.com (Alex Lyakas)
Date: Wed, 5 Jun 2019 22:04:22 +0300
Subject: IO stuck while nvmf initiator is reconnecting
Message-ID: <EA2BFA4D4BAD49629F533A98F74DCE42@alyakaslap>

Greetings nvmf community,

I am testing a scenario, in which a nvmf target disappears. For example, if
the target machine crashes, reboots, or the nvmet drivers on the target
machine are upgraded by being unloaded, and new drivers being loaded. It is
expected that when a target machine comes back, its nvmf target is
configured with same parameters (attr_serial, device_uuid etc), and so nvmf
initiator will see the same device.

I am running kernel 5.1.6, which is the latest stable kernel.

I see that when establishing a nvmf connection on the initiator side, kernel
accepts a "ctrl_loss_tmo" option, which is further translated to
nvmf_ctrl_options::max_reconnects. Then nvmf_should_reconnect() tests this
value, and decides whether it needs to keep reconnecting. So by passing a
very large or negative (-1) value, controller will attempt to reconnect
forever or for a very long time. This behavior is very fine from my
perspective. Unless the user explicitly issues "nvme disconnect", controller
should keep attempting to reconnect.

However, the question is: what happens to the in-flight IOs during this
period?

I see that nvme_core has a "max_retries" parameter. If this parameter is set
to 0, then upon any error IOs are failed. So during the above test, all
in-flight IOs fail. This is not what I would expect, so I set max_retries to
some positive value. In this case, if nvmf connection is lost, all IOs get
stuck until controller succeeds to reconnect. Furthermore, new IOs sent to
the nvme block device at this time, also get stuck. It seems that the blk_mq
is being quiesced in this case, so all IOs are frozen. For example, a
synchronous user-space IO is stuck in stack like [1].

This is not a desirable behavior, because it is not clear when the target
nvmf machine will be back.

The desirable behavior, from my perspective, would be to have a configurable
IO timeout. If a controller succeeds to re-establish the connection within
the timeout, IO resumes with no issues. Otherwise, IO is failed back to the
caller after the timeout.

So, for example, during drivers upgrade on the target side, which is
supposed to take a few seconds, IO will not fail, but will experience a
small delay. On the other hand, If there is an electricity outage on the
target machine, IO will fail after the timeout.

I found that nvme_core has an io_timeout parameter, defaulting to 30
seconds. However, I do not see this parameter being obeyed in this case.
(Although this parameter is used in:
https://elixir.bootlin.com/linux/latest/source/drivers/nvme/host/rdma.c#L741).

Can you please comment if the described behavior can be improved?

Thanks,
Alex.


[1]
[  980.040901] block nvme0n1: no path available - requeuing I/O
[  980.040902] block nvme0n1: no path available - requeuing I/O
[  980.040903] block nvme0n1: no path available - requeuing I/O
[  980.575500] nvme nvme0: failed nvme_keep_alive_end_io error=10
[  980.603209] nvme nvme0: Reconnecting in 10 seconds...
[  993.846221] nvme nvme0: rdma connection establishment failed (-110)
[  993.856498] nvme nvme0: Failed reconnect attempt 1
[  993.856501] nvme nvme0: Reconnecting in 10 seconds...
[ 1007.157953] nvme nvme0: rdma connection establishment failed (-110)
[ 1007.168340] nvme nvme0: Failed reconnect attempt 2
[ 1007.168342] nvme nvme0: Reconnecting in 10 seconds...
[ 1020.469680] nvme nvme0: rdma connection establishment failed (-110)
[ 1020.480327] nvme nvme0: Failed reconnect attempt 3
[ 1020.480330] nvme nvme0: Reconnecting in 10 seconds...
[ 1033.781399] nvme nvme0: rdma connection establishment failed (-110)
[ 1033.792467] nvme nvme0: Failed reconnect attempt 4
[ 1033.792470] nvme nvme0: Reconnecting in 10 seconds...
[ 1047.093131] nvme nvme0: rdma connection establishment failed (-110)
[ 1047.103771] nvme nvme0: Failed reconnect attempt 5
[ 1047.103774] nvme nvme0: Reconnecting in 10 seconds...
[ 1060.404864] nvme nvme0: rdma connection establishment failed (-110)
[ 1060.415429] nvme nvme0: Failed reconnect attempt 6
[ 1060.415432] nvme nvme0: Reconnecting in 10 seconds...
[ 1073.716608] nvme nvme0: rdma connection establishment failed (-110)
[ 1073.727234] nvme nvme0: Failed reconnect attempt 7
[ 1073.727236] nvme nvme0: Reconnecting in 10 seconds...
[ 1087.028464] nvme nvme0: rdma connection establishment failed (-110)
[ 1087.039441] nvme nvme0: Failed reconnect attempt 8
[ 1087.039443] nvme nvme0: Reconnecting in 10 seconds...
[ 1100.340106] nvme nvme0: rdma connection establishment failed (-110)
[ 1100.351073] nvme nvme0: Failed reconnect attempt 9
[ 1100.351077] nvme nvme0: Reconnecting in 10 seconds...
[ 1113.651821] nvme nvme0: rdma connection establishment failed (-110)
[ 1113.662804] nvme nvme0: Failed reconnect attempt 10
[ 1113.662808] nvme nvme0: Reconnecting in 10 seconds...
[ 1126.963566] nvme nvme0: rdma connection establishment failed (-110)
[ 1126.974063] nvme nvme0: Failed reconnect attempt 11
[ 1126.974066] nvme nvme0: Reconnecting in 10 seconds...
[ 1130.922091] nvme_ns_head_make_request: 6 callbacks suppressed
[ 1130.922094] block nvme0n1: no path available - requeuing I/O
[ 1139.000499] sysrq: Show Blocked State
[ 1139.000513]   task                        PC stack   pid father
[ 1139.000548] dd              D    0  1524   1443 0x00000004
[ 1139.000550] Call Trace:
[ 1139.000558]  __schedule+0x2d3/0x840
[ 1139.000561]  schedule+0x2c/0x70
[ 1139.000565]  io_schedule+0x16/0x40
[ 1139.000568]  __blkdev_direct_IO_simple+0x214/0x410
[ 1139.000570]  ? blkdev_iopoll+0x30/0x30
[ 1139.000572]  blkdev_direct_IO+0x459/0x490
[ 1139.000574]  ? __do_page_fault+0x259/0x4b0
[ 1139.000578]  generic_file_direct_write+0x9a/0x160
[ 1139.000580]  __generic_file_write_iter+0xba/0x1f0
[ 1139.000581]  blkdev_write_iter+0xa0/0x120
[ 1139.000584]  new_sync_write+0x114/0x180
[ 1139.000585]  __vfs_write+0x29/0x40
[ 1139.000588]  vfs_write+0xab/0x1b0
[ 1139.000589]  ksys_write+0x5c/0xd0
[ 1139.000591]  __x64_sys_write+0x1a/0x20
[ 1139.000594]  do_syscall_64+0x5a/0x110
[ 1139.000596]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1139.000598] RIP: 0033:0x7f5fa7382154
[ 1139.000602] Code: Bad RIP value.
[ 1139.000603] RSP: 002b:00007ffcde10e1a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 1139.000605] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f5fa7382154
[ 1139.000606] RDX: 0000000000004000 RSI: 000055e31b749000 RDI:
0000000000000001
[ 1139.000607] RBP: 0000000000004000 R08: 0000000000000077 R09:
0000000000000000
[ 1139.000608] R10: 000055e31b748010 R11: 0000000000000246 R12:
000055e31b749000
[ 1139.000609] R13: 0000000000000000 R14: 0000000000000000 R15:
000055e31b749000
[ 1140.275301] nvme nvme0: rdma connection establishment failed (-110)
[ 1140.286111] nvme nvme0: Failed reconnect attempt 12
[ 1140.286115] nvme nvme0: Reconnecting in 10 seconds...
[ 1153.587060] nvme nvme0: rdma connection establishment failed (-110)
[ 1153.597995] nvme nvme0: Failed reconnect attempt 13
[ 1153.597999] nvme nvme0: Reconnecting in 10 seconds...
[ 1166.898837] nvme nvme0: rdma connection establishment failed (-110)
[ 1166.910022] nvme nvme0: Failed reconnect attempt 14
[ 1166.910025] nvme nvme0: Reconnecting in 10 seconds...
[ 1180.210561] nvme nvme0: rdma connection establishment failed (-110)
[ 1180.221555] nvme nvme0: Failed reconnect attempt 15
[ 1180.221558] nvme nvme0: Reconnecting in 10 seconds...
[ 1193.522315] nvme nvme0: rdma connection establishment failed (-110)
[ 1193.533206] nvme nvme0: Failed reconnect attempt 16
[ 1193.533209] nvme nvme0: Reconnecting in 10 seconds...
[ 1206.834079] nvme nvme0: rdma connection establishment failed (-110)
[ 1206.845018] nvme nvme0: Failed reconnect attempt 17
