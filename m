From: rajur@chelsio.com (Raju  Rangoju)
Date: Fri, 13 Jan 2017 21:31:15 +0000
Subject: nvmef target login hangs
Message-ID: <CY1PR12MB07742E08D08352B7413B06F8BC780@CY1PR12MB0774.namprd12.prod.outlook.com>



Hello,


I have noticed that nvme target discover/login hangs with the?latest kernel(4.10-rc2). Target discover/login hangs for more than 120 seconds. This issue?is reproducible on both CXGB4 and MLX4.
I wonder if anyone has seen this already.



Bisecting the kernel shows the below changeset as the?culprit.


commit 36869cb93d36269f34800b3384ba7991060a69cf
Merge: 9439b37 7cd54aa
Author: Linus Torvalds <torvalds at linux-foundation.org>
Date: ? Tue Dec 13 10:19:16 2016 -0800


? ? Merge branch 'for-4.10/block' of git://git.kernel.dk/linux-block


I'm trying to isolate which commit inside the merge caused this issue.


Below is the trace observed at the initiator side.


INFO: task nvme:8027 blocked for more than 120 seconds.
? ? ? Tainted: G ? ? ? ? ? ?E ? 4.10.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
nvme ? ? ? ? ? ?D ? ?0 ?8027 ? 7977 0x10000080
Call Trace:
?? __schedule+0x258/0x580
?? chrdev_open+0xd9/0x1b0
?? cdev_alloc+0x60/0x60
?schedule+0x3a/0xa0
?? list_add_tail+0x29/0x50
?schedule_preempt_disabled+0xe/0x10
?__mutex_lock_slowpath+0x1de/0x2e0
?? terminate_walk+0x44/0x90
?? nvmf_dev_write+0x4f/0x100 [nvme_fabrics]
?mutex_lock+0x33/0x40
?nvmf_dev_write+0x66/0x100 [nvme_fabrics]
?__vfs_write+0x34/0x120
?? trace_event_buffer_commit+0x7b/0x110
?vfs_write+0xc1/0x130
?? __fdget+0x13/0x20
?SyS_write+0x56/0xc0
?do_syscall_64+0x6c/0x160
?? prepare_exit_to_usermode+0xa0/0xd0
?entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x3e162db650
RSP: 002b:00007ffee0bf62d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000003e162db650
RDX: 000000000000002e RSI: 00007ffee0bf7350 RDI: 0000000000000003
RBP: 000000000000002e R08: 0000000000000000 R09: 00007ffee0bf96f1
R10: 00007ffee0bf6060 R11: 0000000000000246 R12: 00007ffee0bf7350
R13: 0000000000000028 R14: 0000000000620640 R15: 0000000000000008
INFO: task nvme:8027 blocked for more than 120 seconds.
? ? ? Tainted: G ? ? ? ? ? ?E ? 4.10.0-rc2 #1



Details to reproduce:
?
---------------------------

TARGET:


1. Load iw_cxgb4 and rdma_ucm assign ip address to chelsio interface.
2. Load nvme and nvmet-rdma modules.
3. mount -t configfs none /sys/kernel/config
4. mkdir /sys/kernel/config/nvmet/subsystems/nvme-ssd
5. mkdir /sys/kernel/config/nvmet/subsystems/nvme-ssd/namespaces/1
6. echo -n /dev/ram0 >/sys/kernel/config/nvmet/subsystems/nvme-ssd/namespaces/1/device_path
7. echo 1 > /sys/kernel/config/nvmet/subsystems/nvme-ssd/attr_allow_any_host
8. echo 1 > /sys/kernel/config/nvmet/subsystems/nvme-ssd/namespaces/1/enable
9. mkdir /sys/kernel/config/nvmet/ports/1
10. echo "ipv4" > /sys/kernel/config/nvmet/ports/1/addr_adrfam
11. echo "rdma" > /sys/kernel/config/nvmet/ports/1/addr_trtype
12. echo 4420 > /sys/kernel/config/nvmet/ports/1/addr_trsvcid
13. echo 102.1.1.102 > /sys/kernel/config/nvmet/ports/1/addr_traddr
14. ln -s /sys/kernel/config/nvmet/subsystems/nvme-ssd/ /sys/kernel/config/nvmet/ports/1/subsystems/nvme-ssd


INITIATOR:
1. Load iw_cxgb4 and rdma_ucm assign ip address to chelsio interface.
2. Load nvme and nvme-rdma modules.


now run?the below command on initiator to discover targets
#nvme discover -t rdma -a 102.1.1.102
->discover command hangs
->trace is seen in demesg





Thanks,
Raju
