From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 00:23:11 +0200
Subject: NVMe-oF Crash Under Load
In-Reply-To: <DE927C68B458BE418D582EC97927A9285464CD14@ORSMSX112.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9285464CD14@ORSMSX112.amr.corp.intel.com>
Message-ID: <2386be95-16b1-eddb-a2cf-d2e9cdd1774f@grimberg.me>


> Hi folks-
>
> We're doing some NVMe-oF testing in our lab and having trouble with crash behavior under certain loads.  We have 16x P3700 400GB SSDs connected through a Microsemi 8536 PCIe switch to a dual socket Haswell Xeon node acting as our target system.  That target system has a Mellanox CX4 50Gb NIC connected to an Arista 7060X switch, which is in turn connected to another dual-socket Xeon node with a Mellanox CX4 25Gb NIC acting as our NVMe-oF initiator system.  Both nodes are running Ubuntu 16.10 x64 updated with 4.10.0-RC8 kernel.
>
> The problem seems to occur when we run high bandwidth read tests with FIO against the initiator devices.  Testing is limited, so I can't say this is the only place the problem occurs, but we seem much more likely to see the problem with a workload such as 1MB sequential reads than a smaller block higher IOPS load like 4KB random reads.  We've seen problems with one drive attached from target to initiator running four 1MB sequential read jobs of queue depth 32, and with five drives attached from target to initiator, running the same 1MB sequential read workload with only one job per disk.
>
> We can run these same workloads directly against the NVMe device on the target system without any issues, we only have trouble running the workload against the NVMe-oF device from the initiator.
>
> Are there fixes or tuning we can try to avoid this problem?  Any additional information we can try provide to help debug?
>
> This is the dmesg output we see on the target when we encounter the problem:
>
> [83143.126578] INFO: task kworker/37:65:9393 blocked for more than 120 seconds.
> [83143.140637]       Not tainted 4.10.0-041000rc8-generic #201702121731
> [83143.153312] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [83143.168943] kworker/37:65   D    0  9393      2 0x00000000
> [83143.168946] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
> [83143.168947] Call Trace:
> [83143.168948]  __schedule+0x233/0x6f0
> [83143.168950]  ? sched_clock+0x9/0x10
> [83143.168950]  schedule+0x36/0x80
> [83143.168952]  schedule_timeout+0x22a/0x3f0
> [83143.168954]  ? vprintk_emit+0x312/0x4a0
> [83143.168955]  ? __kfifo_to_user_r+0xb0/0xb0
> [83143.168956]  wait_for_completion+0xb4/0x140
> [83143.168957]  ? wake_up_q+0x80/0x80
> [83143.168959]  nvmet_sq_destroy+0x41/0xf0 [nvmet]
> [83143.168961]  nvmet_rdma_free_queue+0x28/0xa0 [nvmet_rdma]
> [83143.168962]  nvmet_rdma_release_queue_work+0x25/0x50 [nvmet_rdma]
> [83143.168964]  process_one_work+0x1fc/0x4b0
> [83143.168965]  worker_thread+0x4b/0x500
> [83143.168967]  kthread+0x101/0x140
> [83143.168968]  ? process_one_work+0x4b0/0x4b0
> [83143.168969]  ? kthread_create_on_node+0x60/0x60
> [83143.168971]  ret_from_fork+0x2c/0x40

Interesting, this means that the target is stuck waiting on some io to
complete before tearing down the queue. this was for large reads yes?

This trace indicates that the nvmet stack still has something pending
from the backend device(s)...

How does the log look like prior to this stack trace (which is not a
crash but a hung task).

>
> On the initator this seems to cause an error and a disconnect and reconnect, which seems reasonable if the target stack has gone down:
>
> [82913.698414] blk_update_request: 867 callbacks suppressed
> [82913.698417] blk_update_request: I/O error, dev nvme6n1, sector 2048
> [82913.710983] blk_update_request: I/O error, dev nvme6n1, sector 4096
> [82913.723514] blk_update_request: I/O error, dev nvme6n1, sector 6136
> [82913.730407] blk_update_request: I/O error, dev nvme3n1, sector 8184
> [82913.730410] blk_update_request: I/O error, dev nvme2n1, sector 2048
> [82913.730413] blk_update_request: I/O error, dev nvme3n1, sector 8192
> [82913.730421] blk_update_request: I/O error, dev nvme3n1, sector 10232
> [82913.730436] blk_update_request: I/O error, dev nvme2n1, sector 4096
> [82913.730443] blk_update_request: I/O error, dev nvme3n1, sector 10240
> [82913.730445] blk_update_request: I/O error, dev nvme2n1, sector 6136

I/O errors, out of nowhere? Any errors preceding these?

> Sometimes we also see a crash on the initiator node:
>
> [84344.339604] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [84344.355240] fio             D    0  8937   8880 0x00000000
> [84344.355243] Call Trace:
> [84344.355251]  __schedule+0x233/0x6f0
> [84344.355253]  schedule+0x36/0x80
> [84344.355255]  schedule_preempt_disabled+0xe/0x10
> [84344.355257]  __mutex_lock_slowpath+0x190/0x2a0
> [84344.355260]  mutex_lock+0x2f/0x40
> [84344.355264]  __blkdev_get+0x6d/0x400
> [84344.355267]  blkdev_get+0x12a/0x330
> [84344.355274]  blkdev_open+0x5b/0x70
> [84344.355281]  do_dentry_open+0x20a/0x310
> [84344.355287]  ? blkdev_get_by_dev+0x50/0x50
> [84344.355293]  vfs_open+0x4c/0x70
> [84344.355298]  ? may_open+0xc6/0x100
> [84344.355305]  path_openat+0x659/0x14f0
> [84344.355307]  do_filp_open+0x91/0x100
> [84344.355310]  ? __alloc_fd+0x46/0x170
> [84344.355313]  do_sys_open+0x130/0x220
> [84344.355316]  SyS_open+0x1e/0x20
> [84344.355319]  entry_SYSCALL_64_fastpath+0x1e/0xad
> [84344.355321] RIP: 0033:0x7fa597d0cd4d
> [84344.355322] RSP: 002b:00007ffc835b2cf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> [84344.355324] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa597d0cd4d
> [84344.355325] RDX: 0000000000000180 RSI: 0000000000044002 RDI: 00007fa5940a0e70
> [84344.355327] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000c0718259
> [84344.355328] R10: 0000000000044040 R11: 0000000000000293 R12: 0000011774196000
> [84344.355329] R13: 28f5c2

This looks to have nothing to do with nvmf...
Are there also other tasks that are hung and preventing this task
from completing?
