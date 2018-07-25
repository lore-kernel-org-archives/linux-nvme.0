From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 25 Jul 2018 16:05:34 +0000
Subject: blktests/nvme/008
In-Reply-To: <a28a21969b0a5f725b0724e9c7f0a4a5ff40b4a3.camel@wdc.com>
References: <a28a21969b0a5f725b0724e9c7f0a4a5ff40b4a3.camel@wdc.com>
Message-ID: <BYAPR04MB4502AEA409EBADA46E5418F786540@BYAPR04MB4502.namprd04.prod.outlook.com>

I just ran the same test to check if the test is broken on the
different kernel nvme-4.19, and it did pass without any problem
multiple times.

[root at qemu blktests]# for i in `seq 10` ; do ./check tests/nvme/008; done 
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.541s  ...  0.523s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.523s  ...  0.520s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.520s  ...  0.513s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.513s  ...  0.504s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.504s  ...  0.502s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.502s  ...  0.517s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.517s  ...  0.505s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.505s  ...  0.521s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.521s  ...  0.516s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.516s  ...  0.510s
[root at qemu blktests]# 

I'll build the v4.18-rc6 and run it on that tree.

From: Bart Van Assche
Sent: Wednesday, July 25, 2018 8:56 AM
To: linux-nvme at lists.infradead.org
Cc: Chaitanya Kulkarni
Subject: blktests/nvme/008
? 
 
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
????? Not tainted 4.18.0-rc6-dbg+ #15
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u64:4?? D24720?? 375????? 2 0x80000000
Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
Call Trace:
?__schedule+0x444/0xff0
?schedule+0x4e/0xe0
?blk_mq_freeze_queue_wait+0xca/0x180
?blk_freeze_queue+0x30/0x50
?blk_cleanup_queue+0x153/0x340
?nvme_ns_remove+0x20c/0x260 [nvme_core]
?nvme_remove_namespaces+0x18b/0x1e0 [nvme_core]
?nvme_delete_ctrl_work+0x7d/0xe0 [nvme_core]
?process_one_work+0x4fe/0xad0
?worker_thread+0x3a9/0x5a0
?kthread+0x1c1/0x1e0
?ret_from_fork+0x24/0x30

Is this a bug in the test script or in the kernel driver?

Thanks,

Bart.

    
