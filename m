From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 16 Oct 2017 22:23:09 +0000
Subject: v4.14-rc5 NVMeOF regression?
Message-ID: <1508192588.2493.60.camel@wdc.com>

Hello,

It has been a while since I ran any NVMeOF tests. But when I tried to test
the v4.14-rc5 NVMeOF drivers the output shown below appeared. Is this a
known issue? The following test triggered these call stacks:

# srp-test/run_tests -n -f xfs -e deadline -r 60

Thanks,

Bart.

======================================================
======================================================
WARNING: possible circular locking dependency detected
WARNING: possible circular locking dependency detected
4.14.0-rc5-dbg+ #3 Not tainted
4.14.0-rc5-dbg+ #3 Not tainted
------------------------------------------------------
------------------------------------------------------
modprobe/2272 is trying to acquire lock:
modprobe/2272 is trying to acquire lock:
 ("events"){+.+.}, at: [<ffffffff81084185>] flush_workqueue+0x75/0x520
 ("events"){+.+.}, at: [<ffffffff81084185>] flush_workqueue+0x75/0x520

but task is already holding lock:

but task is already holding lock:
 (device_mutex){+.+.}, at: [<ffffffffa05d6bf7>] ib_unregister_client+0x27/0x200 [ib_core]
 (device_mutex){+.+.}, at: [<ffffffffa05d6bf7>] ib_unregister_client+0x27/0x200 [ib_core]

which lock already depends on the new lock.


which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

the existing dependency chain (in reverse order) is:

-> #3 (device_mutex){+.+.}:

-> #3 (device_mutex){+.+.}:
       lock_acquire+0xdc/0x1d0
       lock_acquire+0xdc/0x1d0
       __mutex_lock+0x86/0x990
       __mutex_lock+0x86/0x990
       mutex_lock_nested+0x1b/0x20
       mutex_lock_nested+0x1b/0x20
       ib_register_device+0xa3/0x650 [ib_core]
       ib_register_device+0xa3/0x650 [ib_core]
       mlx4_ib_add+0xcfd/0x1440 [mlx4_ib]
       mlx4_ib_add+0xcfd/0x1440 [mlx4_ib]
       mlx4_add_device+0x45/0xe0 [mlx4_core]
       mlx4_add_device+0x45/0xe0 [mlx4_core]
       mlx4_register_interface+0xa8/0x120 [mlx4_core]
       mlx4_register_interface+0xa8/0x120 [mlx4_core]
       0xffffffffa05b2051
       0xffffffffa05b2051
       do_one_initcall+0x43/0x166
       do_one_initcall+0x43/0x166
       do_init_module+0x5f/0x206
       do_init_module+0x5f/0x206
       load_module+0x26fe/0x2db0
       load_module+0x26fe/0x2db0
       SYSC_finit_module+0xbc/0xf0
       SYSC_finit_module+0xbc/0xf0
       SyS_finit_module+0xe/0x10
       SyS_finit_module+0xe/0x10
       entry_SYSCALL_64_fastpath+0x18/0xad
       entry_SYSCALL_64_fastpath+0x18/0xad

-> #2 (intf_mutex){+.+.}:

-> #2 (intf_mutex){+.+.}:
       lock_acquire+0xdc/0x1d0
       lock_acquire+0xdc/0x1d0
       __mutex_lock+0x86/0x990
       __mutex_lock+0x86/0x990
       mutex_lock_nested+0x1b/0x20
       mutex_lock_nested+0x1b/0x20
       mlx4_register_device+0x30/0xc0 [mlx4_core]
       mlx4_register_device+0x30/0xc0 [mlx4_core]
       mlx4_load_one+0x15f4/0x16f0 [mlx4_core]
       mlx4_load_one+0x15f4/0x16f0 [mlx4_core]
       mlx4_init_one+0x4b9/0x700 [mlx4_core]
       mlx4_init_one+0x4b9/0x700 [mlx4_core]
       local_pci_probe+0x42/0xa0
       local_pci_probe+0x42/0xa0
       work_for_cpu_fn+0x14/0x20
       work_for_cpu_fn+0x14/0x20
       process_one_work+0x1fd/0x630
       process_one_work+0x1fd/0x630
       worker_thread+0x1db/0x3b0
       worker_thread+0x1db/0x3b0
       kthread+0x11e/0x150
       kthread+0x11e/0x150
       ret_from_fork+0x27/0x40
       ret_from_fork+0x27/0x40

-> #1 ((&wfc.work)){+.+.}:

-> #1 ((&wfc.work)){+.+.}:
       lock_acquire+0xdc/0x1d0
       lock_acquire+0xdc/0x1d0
       process_one_work+0x1da/0x630
       process_one_work+0x1da/0x630
       worker_thread+0x4e/0x3b0
       worker_thread+0x4e/0x3b0
       kthread+0x11e/0x150
       kthread+0x11e/0x150
       ret_from_fork+0x27/0x40
       ret_from_fork+0x27/0x40

-> #0 ("events"){+.+.}:

-> #0 ("events"){+.+.}:
       __lock_acquire+0x13b5/0x13f0
       __lock_acquire+0x13b5/0x13f0
       lock_acquire+0xdc/0x1d0
       lock_acquire+0xdc/0x1d0
       flush_workqueue+0x98/0x520
       flush_workqueue+0x98/0x520
       nvmet_rdma_remove_one+0x73/0xa0 [nvmet_rdma]
       nvmet_rdma_remove_one+0x73/0xa0 [nvmet_rdma]
       ib_unregister_client+0x18f/0x200 [ib_core]
       ib_unregister_client+0x18f/0x200 [ib_core]
       nvmet_rdma_exit+0xb3/0x856 [nvmet_rdma]
       nvmet_rdma_exit+0xb3/0x856 [nvmet_rdma]
       SyS_delete_module+0x18c/0x1e0
       SyS_delete_module+0x18c/0x1e0
       entry_SYSCALL_64_fastpath+0x18/0xad
       entry_SYSCALL_64_fastpath+0x18/0xad

other info that might help us debug this:


other info that might help us debug this:

Chain exists of:
  "events" --> intf_mutex --> device_mutex

Chain exists of:
  "events" --> intf_mutex --> device_mutex

 Possible unsafe locking scenario:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       CPU0                    CPU1
       ----                    ----
       ----                    ----
  lock(device_mutex);
  lock(device_mutex);
                               lock(intf_mutex);
                               lock(intf_mutex);
                               lock(device_mutex);
                               lock(device_mutex);
  lock("events");
  lock("events");

 *** DEADLOCK ***


 *** DEADLOCK ***

1 lock held by modprobe/2272:
1 lock held by modprobe/2272:
 #0:  (device_mutex){+.+.}, at: [<ffffffffa05d6bf7>] ib_unregister_client+0x27/0x200 [ib_core]
 #0:  (device_mutex){+.+.}, at: [<ffffffffa05d6bf7>] ib_unregister_client+0x27/0x200 [ib_core]

stack backtrace:

stack backtrace:
CPU: 9 PID: 2272 Comm: modprobe Not tainted 4.14.0-rc5-dbg+ #3
CPU: 9 PID: 2272 Comm: modprobe Not tainted 4.14.0-rc5-dbg+ #3
Hardware name: Dell Inc. PowerEdge R720/0VWT90, BIOS 1.3.6 09/11/2012
Hardware name: Dell Inc. PowerEdge R720/0VWT90, BIOS 1.3.6 09/11/2012
Call Trace:
Call Trace:
 dump_stack+0x68/0x9f
 dump_stack+0x68/0x9f
 print_circular_bug.isra.38+0x1d8/0x1e6
 print_circular_bug.isra.38+0x1d8/0x1e6
 __lock_acquire+0x13b5/0x13f0
 __lock_acquire+0x13b5/0x13f0
 lock_acquire+0xdc/0x1d0
 lock_acquire+0xdc/0x1d0
 ? lock_acquire+0xdc/0x1d0
 ? lock_acquire+0xdc/0x1d0
 ? flush_workqueue+0x75/0x520
 ? flush_workqueue+0x75/0x520
 flush_workqueue+0x98/0x520
 flush_workqueue+0x98/0x520
 ? flush_workqueue+0x75/0x520
 ? flush_workqueue+0x75/0x520
 nvmet_rdma_remove_one+0x73/0xa0 [nvmet_rdma]
 nvmet_rdma_remove_one+0x73/0xa0 [nvmet_rdma]
 ? nvmet_rdma_remove_one+0x73/0xa0 [nvmet_rdma]
 ? nvmet_rdma_remove_one+0x73/0xa0 [nvmet_rdma]
 ib_unregister_client+0x18f/0x200 [ib_core]
 ib_unregister_client+0x18f/0x200 [ib_core]
 nvmet_rdma_exit+0xb3/0x856 [nvmet_rdma]
 nvmet_rdma_exit+0xb3/0x856 [nvmet_rdma]
 SyS_delete_module+0x18c/0x1e0
 SyS_delete_module+0x18c/0x1e0
 entry_SYSCALL_64_fastpath+0x18/0xad
 entry_SYSCALL_64_fastpath+0x18/0xad
