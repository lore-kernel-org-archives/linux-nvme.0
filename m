From: emilne@redhat.com (Ewan D. Milne)
Date: Mon, 24 Apr 2017 13:24:15 -0400
Subject: [PATCH 0/1] Fix crash when failing to connect to FC NVMe target
Message-ID: <1493054656-18296-1-git-send-email-emilne@redhat.com>

From: "Ewan D. Milne" <emilne@redhat.com>

This patch fixes the following crash, caused because nvmf_create_ctrl()
calls nvmf_free_options() when an error is returned from nvme_fc_create_ctrl().

However, if we get as far as calling nvme_fc_create_assocation() and it returns
an error, we have an nvme_fc_ctrl kobject with a pointer to the nvmf_ctrl_options,
and nvmf_free_options() will be called upon object destruction.

Since the caller allocated the nvmf_ctrl_options, and frees it on error,
ensure that the kobject will not free the options unless a good status is
returned from the ops->create_ctrl() call.

[ 1175.863718] general protection fault: 0000 [#1] SMP
[ 1175.869157] Modules linked in: intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretep
[ 1175.929882] CPU: 2 PID: 11385 Comm: sh Not tainted 4.10.0-rc2+ #31
[ 1175.936776] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.3.4 11/08/2016
[ 1175.945123] task: ffff880840cc1880 task.stack: ffffc9000ea14000
[ 1175.951728] RIP: 0010:nvmf_free_options+0x16/0x70
[ 1175.956973] RSP: 0018:ffffc9000ea17d50 EFLAGS: 00010202
[ 1175.962800] RAX: 00000000fffffffb RBX: ffff88083cc3fb18 RCX: 0000000000000000
[ 1175.970761] RDX: ffff880840cc1880 RSI: ffffffff8151a3e0 RDI: 6b6b6b6b6b6b6b6b
[ 1175.978721] RBP: ffffc9000ea17d58 R08: ffff880843d09bf8 R09: fffffffffffffffb
[ 1175.986680] R10: ffff880843d08958 R11: ffff880843d09bf8 R12: fffffffffffffffb
[ 1175.994639] R13: ffff88084b3435a8 R14: ffff880843c07da8 R15: ffff88083cc3fb18
[ 1176.002598] FS:  00007f8bbce7a740(0000) GS:ffff88085f280000(0000) knlGS:0000000000000000
[ 1176.011634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1176.018044] CR2: 00007f8bbca3c090 CR3: 000000083a981000 CR4: 00000000003406e0
[ 1176.026004] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1176.033964] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1176.041937] Call Trace:
[ 1176.044663]  nvmf_dev_write+0x428/0x9a0
[ 1176.048946]  ? __slab_free+0x17d/0x2c0
[ 1176.053126]  __vfs_write+0x37/0x160
[ 1176.057015]  ? selinux_file_permission+0xe5/0x120
[ 1176.062262]  ? security_file_permission+0x3b/0xc0
[ 1176.067506]  vfs_write+0xb2/0x1b0
[ 1176.071203]  ? syscall_trace_enter+0x1d0/0x2b0
[ 1176.076157]  SyS_write+0x55/0xc0
[ 1176.079755]  do_syscall_64+0x67/0x180
[ 1176.083839]  entry_SYSCALL64_slow_path+0x25/0x25
[ 1176.088987] RIP: 0033:0x7f8bbc560c60
[ 1176.092971] RSP: 002b:00007ffeaf3d5f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1176.101415] RAX: ffffffffffffffda RBX: 0000000000000084 RCX: 00007f8bbc560c60
[ 1176.109374] RDX: 0000000000000084 RSI: 00007f8bbce7d000 RDI: 0000000000000001
[ 1176.117333] RBP: 00007f8bbce7d000 R08: 000000000000000a R09: 00007f8bbce7a740
[ 1176.125293] R10: 0000000000000083 R11: 0000000000000246 R12: 00007f8bbc833400
[ 1176.133252] R13: 0000000000000084 R14: 0000000000000001 R15: 0000000000000000
[ 1176.141213] Code: 89 1c 24 48 c7 c7 40 c5 d0 81 e8 86 fd 22 00 5b 41 5c 5d c3 90 0f 1f 44 00 00 55 48 89 
[ 1176.162277] RIP: nvmf_free_options+0x16/0x70 RSP: ffffc9000ea17d50
[ 1176.172046] ---[ end trace b6423bd8df867883 ]---
[ 1176.179704] Kernel panic - not syncing: Fatal exception
[ 1176.185570] Kernel Offset: disabled

Ewan D. Milne (1):
  nvme-fc: avoid memory corruption caused by calling nvmf_free_options()
    twice

 drivers/nvme/host/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.8.3.1
