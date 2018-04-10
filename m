From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 10 Apr 2018 16:49:53 -0400
Subject: 'modprobe nvme_core multipath=N' crashes in face of multipath fabric
Message-ID: <20180410204953.GA17979@redhat.com>

This isn't new since the 4.17 merge or anything, I first noticed this
issue existed while using a 4.16-rc4 kernel.

modprobe nvme_core multipath=N

Using mptest's nvme_4port_create.sh

git clone git://github.com/snitm/mptest.git
cd mptest/lib/unittests
perl -pi -e 's|/dev/pmem0|/dev/some_test_device|' nvme_4port_create.sh
./nvme_4port_create.sh

[ 2309.845915] nvmet: adding nsid 1 to subsystem mptestnqn
[ 2310.019820] nvmet: creating controller 1 for subsystem mptestnqn for NQN nqn.2014-08.org.nvmexpress:uuid:71a69a69-edb9-4d51-8cbf-1c29778534ab.
[ 2310.034201] nvme nvme1: NVME-FC{0}: new ctrl: NQN "mptestnqn"
[ 2310.041705] nvmet: creating controller 2 for subsystem mptestnqn for NQN nqn.2014-08.org.nvmexpress:uuid:71a69a69-edb9-4d51-8cbf-1c29778534ab.
[ 2310.056005] nvme nvme2: NVME-FC{1}: new ctrl: NQN "mptestnqn"
[ 2310.056314] sysfs: cannot create duplicate filename '/class/block/nvme1n1'
[ 2310.063386] nvmet: creating controller 3 for subsystem mptestnqn for NQN nqn.2014-08.org.nvmexpress:uuid:71a69a69-edb9-4d51-8cbf-1c29778534ab.
[ 2310.068637] CPU: 3 PID: 1791 Comm: kworker/u497:1 Not tainted 4.16.0.snitm+ #13
[ 2310.088705] Hardware name: Supermicro SYS-1029P-WTR/X11DDW-L, BIOS 2.0a 12/06/2017
[ 2310.096274] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[ 2310.101669] Call Trace:
[ 2310.104129]  dump_stack+0x5a/0x73
[ 2310.107444]  sysfs_warn_dup+0x58/0x70
[ 2310.111109]  sysfs_do_create_link_sd.isra.2+0xa3/0xb0
[ 2310.116162]  device_add+0x2ac/0x5f0
[ 2310.119658]  __device_add_disk+0x19c/0x4a0
[ 2310.123754]  nvme_validate_ns+0x4d2/0x860 [nvme_core]
[ 2310.128807]  ? wake_up_q+0x70/0x70
[ 2310.132214]  nvme_scan_work+0x211/0x2d0 [nvme_core]
[ 2310.137095]  process_one_work+0x158/0x360
[ 2310.141103]  worker_thread+0x47/0x3e0
[ 2310.144772]  kthread+0xf8/0x130
[ 2310.147917]  ? max_active_store+0x80/0x80
[ 2310.151929]  ? kthread_bind+0x10/0x10
[ 2310.155595]  ? do_syscall_64+0x74/0x1a0
[ 2310.159435]  ? SyS_exit_group+0x10/0x10
[ 2310.163273]  ret_from_fork+0x35/0x40
[ 2310.166872] nvme nvme3: NVME-FC{2}: new ctrl: NQN "mptestnqn"
[ 2310.166875] ------------[ cut here ]------------
[ 2310.167189] sysfs: cannot create duplicate filename '/class/block/nvme1n1'
[ 2310.167190] CPU: 3 PID: 8111 Comm: kworker/u497:3 Not tainted 4.16.0.snitm+ #13
[ 2310.167191] Hardware name: Supermicro SYS-1029P-WTR/X11DDW-L, BIOS 2.0a 12/06/2017
[ 2310.167194] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[ 2310.167194] Call Trace:
[ 2310.167196]  dump_stack+0x5a/0x73
[ 2310.167198]  sysfs_warn_dup+0x58/0x70
[ 2310.167199]  sysfs_do_create_link_sd.isra.2+0xa3/0xb0
[ 2310.167200]  device_add+0x2ac/0x5f0
[ 2310.167202]  __device_add_disk+0x19c/0x4a0
[ 2310.167205]  nvme_validate_ns+0x4d2/0x860 [nvme_core]
[ 2310.167206]  ? wake_up_q+0x70/0x70
[ 2310.167208]  nvme_scan_work+0x211/0x2d0 [nvme_core]
[ 2310.167210]  process_one_work+0x158/0x360
[ 2310.167211]  worker_thread+0x47/0x3e0
[ 2310.167212]  kthread+0xf8/0x130
[ 2310.167213]  ? max_active_store+0x80/0x80
[ 2310.167214]  ? kthread_bind+0x10/0x10
[ 2310.167215]  ret_from_fork+0x35/0x40
[ 2310.167225] ------------[ cut here ]------------
[ 2310.167226] kernel BUG at fs/sysfs/group.c:111!
