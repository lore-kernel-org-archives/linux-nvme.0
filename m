From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 25 Jul 2018 15:56:33 +0000
Subject: blktests/nvme/008
Message-ID: <a28a21969b0a5f725b0724e9c7f0a4a5ff40b4a3.camel@wdc.com>

Hello,

If I run blktests test nvme/008 against kernel v4.18-rc6 then the following
appears:

run blktests nvme/008 at 2018-07-25 08:38:04
nvmet: adding nsid 1 to subsystem blktests-subsystem-1
nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:5a9f0ba8-37f1-48e9-b3f0-7715fc55c789.
nvme nvme0: creating 32 I/O queues.
nvme nvme0: new ctrl: "blktests-subsystem-1"
nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
nvmet: ctrl 1 fatal error occurred!
INFO: task kworker/u64:4:375 blocked for more than 120 seconds.
      Not tainted 4.18.0-rc6-dbg+ #15
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u64:4   D24720   375      2 0x80000000
Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
Call Trace:
 __schedule+0x444/0xff0
 schedule+0x4e/0xe0
 blk_mq_freeze_queue_wait+0xca/0x180
 blk_freeze_queue+0x30/0x50
 blk_cleanup_queue+0x153/0x340
 nvme_ns_remove+0x20c/0x260 [nvme_core]
 nvme_remove_namespaces+0x18b/0x1e0 [nvme_core]
 nvme_delete_ctrl_work+0x7d/0xe0 [nvme_core]
 process_one_work+0x4fe/0xad0
 worker_thread+0x3a9/0x5a0
 kthread+0x1c1/0x1e0
 ret_from_fork+0x24/0x30

Is this a bug in the test script or in the kernel driver?

Thanks,

Bart.
