From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 26 Jul 2018 02:01:27 +0000
Subject: [PATCH 0/2] blktests: test ANA base support
In-Reply-To: <20180725210001.GB16847@vader>
References: <20180717133118.39026-1-hare@suse.de>
 <BYAPR04MB4502201C7DCD5AC4514AC6BC86500@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20180725191712.GA16847@vader>
 <BYAPR04MB4502890F18B77778B8EF6E5686540@BYAPR04MB4502.namprd04.prod.outlook.com>,
 <20180725210001.GB16847@vader>
Message-ID: <BYAPR04MB4502FE260EA90730B4522657862B0@BYAPR04MB4502.namprd04.prod.outlook.com>


Thanks for the report and correction. I was able to run the test and reproduce the problem, I also confirm that it is not that consistent.

As I suspected the problem is in the nvme disconnect in the following call chain:-


nvme_sysfs_delete
?nvme_delete_ctrl_sync
? ?nvme_delete_ctrl_work
? ? nvme_remove_namespaces
? ? ?nvme_ns_remove
? ? ?  nvme_ns_remove
? ? ? ?? blk_cleanup_queue
? ? ? ?    blk_freeze_queue
? ? ? ? ??   blk_freeze_queue_start
? ? ? ? ?      wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));?<----- Stuck here.
? ? ? ??
blk_cleanup_queue()?that's where it is blocking and then target ctrl is timing out on keep alive.

It will take some time for me to debug and find a fix let's merge this test once we fix this issue.



How should we go about other tests ? should we merge them and keep this one out in the nvmeof branch?
Regards,
Chaitanya



From: Omar Sandoval <osandov@osandov.com>
Sent: Wednesday, July 25, 2018 2:00 PM
To: Chaitanya Kulkarni
Cc: Hannes Reinecke; Omar Sandoval; Christoph Hellwig; Sagi Grimberg; Keith Busch; linux-nvme at lists.infradead.org; linux-block at vger.kernel.org
Subject: Re: [PATCH 0/2] blktests: test ANA base support
? 
 
On Wed, Jul 25, 2018@07:27:35PM +0000, Chaitanya Kulkarni wrote:
> 
> Thanks, Omar.

Tests nvme/014 and nvme/015 had a pretty bad typo that I didn't notice
last time:

dd=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k

That should be

dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none

When I fix that (and change the nvme flush call as mentioned before), I
sometimes get a hung task:

[? 273.844440] run blktests nvme/015 at 2018-07-25 13:44:11
[? 273.861950] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[? 273.875014] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:c5e36fdf-8e4d-4c27-be56-da373db583b2.
[? 273.877457] nvme nvme1: creating 4 I/O queues.
[? 273.879141] nvme nvme1: new ctrl: "blktests-subsystem-1"
[? 276.247708] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[? 276.262835] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[? 289.755361] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[? 289.760579] nvmet: ctrl 1 fatal error occurred!
[? 491.095890] INFO: task kworker/u8:0:7 blocked for more than 120 seconds.
[? 491.104407]?????? Not tainted 4.18.0-rc6 #18
[? 491.108330] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[? 491.116521] kworker/u8:0??? D??? 0???? 7????? 2 0x80000000
[? 491.121754] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
[? 491.129604] Call Trace:
[? 491.131611]? ? __schedule+0x2a1/0x890
[? 491.135112]? ? _raw_spin_unlock_irqrestore+0x20/0x40
[? 491.140542]? schedule+0x32/0x90
[? 491.142030]? blk_mq_freeze_queue_wait+0x41/0xa0
[? 491.144186]? ? wait_woken+0x80/0x80
[? 491.145726]? blk_cleanup_queue+0x75/0x160
[? 491.150235]? nvme_ns_remove+0xf9/0x130 [nvme_core]
[? 491.151910]? nvme_remove_namespaces+0x86/0xc0 [nvme_core]
[? 491.153127]? nvme_delete_ctrl_work+0x4b/0x80 [nvme_core]
[? 491.154727]? process_one_work+0x18c/0x360
[? 491.155428]? worker_thread+0x1c6/0x380
[? 491.156160]? ? process_one_work+0x360/0x360
[? 491.157493]? kthread+0x112/0x130
[? 491.159119]? ? kthread_flush_work_fn+0x10/0x10
[? 491.160008]? ret_from_fork+0x35/0x40
[? 491.160729] INFO: task nvme:1139 blocked for more than 120 seconds.
[? 491.162416]?????? Not tainted 4.18.0-rc6 #18
[? 491.164348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[? 491.166012] nvme??????????? D??? 0? 1139?? 1072 0x00000000
[? 491.167946] Call Trace:
[? 491.168459]? ? __schedule+0x2a1/0x890
[? 491.169312]? schedule+0x32/0x90
[? 491.170180]? schedule_timeout+0x311/0x4a0
[? 491.171921]? ? kernfs_fop_release+0xa0/0xa0
[? 491.172884]? wait_for_common+0x1a0/0x1d0
[? 491.173813]? ? wake_up_q+0x70/0x70
[? 491.174410]? flush_work+0x10e/0x1c0
[? 491.174991]? ? flush_workqueue_prep_pwqs+0x130/0x130
[? 491.176113]? nvme_delete_ctrl_sync+0x41/0x50 [nvme_core]
[? 491.177969]? nvme_sysfs_delete+0x28/0x30 [nvme_core]
[? 491.178632]? kernfs_fop_write+0x116/0x190
[? 491.179254]? __vfs_write+0x36/0x190
[? 491.179812]? vfs_write+0xa9/0x190
[? 491.180344]? ksys_write+0x4f/0xb0
[? 491.181056]? do_syscall_64+0x5b/0x170
[? 491.181583]? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[? 491.182311] RIP: 0033:0x7fc04176b9d4
[? 491.182863] Code: Bad RIP value.
[? 491.183650] RSP: 002b:00007ffc33bd15a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[? 491.184622] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc04176b9d4
[? 491.185606] RDX: 0000000000000001 RSI: 000055884bd0810a RDI: 0000000000000004
[? 491.186719] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000f
[? 491.187684] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[? 491.189045] R13: 00007ffc33bd2c20 R14: 00007ffc33bd15f0 R15: 0000000000000010

I pushed what I have to  https://github.com/osandov/blktests/tree/nvmeof,
can you please take a look?
    
