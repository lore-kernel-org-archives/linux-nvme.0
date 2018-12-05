From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 05 Dec 2018 15:05:45 -0500
Subject: [PATCH 0/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181115122927.40431-1-hare@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
Message-ID: <c8b9f32080d2b1f203db6e594788f297ee2a92d8.camel@redhat.com>

On Thu, 2018-11-15@13:29 +0100, Hannes Reinecke wrote:
> Hi all,
> 
> after my NUMA path balancing patch hasn't met with universal approval,
> here's now my take on a 'real' round-robin I/O scheduler for NVMe multipathing.
> With this patch I'm able to boost I/O performance from 127k/127k randrw
> to 156k/156k randrw (as measured by fio).
> Testbed was two dual 32G FC HBAs connected back-to-back with nvmet
> against a 1G zram-backed namespace.
> 
> As usual, comments and reviews are welcome.
> 
> Hannes Reinecke (2):
>   nvme-multipath: add 'iopolicy' subsystem attribute
>   nvme-multipath: round-robin I/O policy
> 
>  drivers/nvme/host/core.c      |  6 +++
>  drivers/nvme/host/multipath.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h      |  8 ++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
> 

Tested this with dual-port  NVMe/FC 32Gb fabric to nvmet w/ 2TB NVMe PCI storage.

It works like you'd expect.  Path balancing was exact (within 1 I/O).
My storage configuration did not show a performance improvement from
using both paths, I'll try it again later with a higher performance
storage array.

However...

When I took both paths down, I get this, which does not happen if iopolicy
is set to "numa" rather than "round-robin".  (With "numa", I get the usual
"block nvme1n1: no path available - requeuing I/O" message.)  Restoring
both paths does not clear the lockup.  The hang looks like it is in the
nvme_find_path() or __nvme_next_path() inline.

-Ewan

 kernel:watchdog: BUG: soft lockup - CPU#7 stuck for 23s! [jbd2/nvme1n1-8:1800]
 kernel:watchdog: BUG: soft lockup - CPU#13 stuck for 23s! [fio:1866]
[  650.816208] watchdog: BUG: soft lockup - CPU#7 stuck for 23s! [jbd2/nvme1n1-8:1800]
[  650.824209] watchdog: BUG: soft lockup - CPU#13 stuck for 23s! [fio:1866]
[  650.824751] Modules linked in: ext4 mbcache jbd2 intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamd
[  650.832322] Modules linked in: ext4 mbcache jbd2 intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamd
[  650.897781] CPU: 7 PID: 1800 Comm: jbd2/nvme1n1-8 Tainted: G             L    4.20.0-rc1+ #3
[  650.963241] CPU: 13 PID: 1866 Comm: fio Tainted: G             L    4.20.0-rc1+ #3
[  650.972654] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.3.4 11/08/2016
[  650.972657] RIP: 0010:nvme_ns_head_make_request+0x1b4/0x2a0 [nvme_core]
[  650.981099] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.3.4 11/08/2016
[  650.981103] RIP: 0010:nvme_ns_head_make_request+0x1a0/0x2a0 [nvme_core]
[  650.989450] Code: 01 75 ce 48 89 0f e9 e8 fe ff ff 49 8b 16 4c 39 f2 48 89 54 24 08 0f 84 c3 fe ff ff 48f
[  650.996827] Code: 08 48 83 e9 30 74 18 48 8b 51 10 83 7a 04 01 75 d4 83 79 28 01 75 ce 48 89 0f e9 e8 fe5
[  651.005174] RSP: 0018:ffffb6a18485fbd0 EFLAGS: 00000283 ORIG_RAX: ffffffffffffff13
[  651.012552] RSP: 0018:ffffb6a18408f9d0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  651.033519] RAX: ffff95af620313f8 RBX: ffff95af736c34c0 RCX: ffff95af842b01d8
[  651.033521] RDX: ffff95af842b0208 RSI: 0000000000000000 RDI: ffff95af64a8c560
[  651.054491] RAX: ffff95af620313f8 RBX: ffff95af736c0540 RCX: ffff95af64a80000
[  651.054492] RDX: ffff95af842b0208 RSI: 0000000000000000 RDI: ffff95af64a8c560
[  651.062937] RBP: ffff95af64a80010 R08: 0000000000000000 R09: 0000000000000001
[  651.062938] R10: ffff95af9f4bd640 R11: ffff95af736c2340 R12: ffff95af81bb2f88
[  651.071383] RBP: ffff95af64a80010 R08: 0000000000000000 R09: 0000000000000001
[  651.071385] R10: ffff95af9f4bd640 R11: 0000000000000000 R12: ffff95af81bb2f88
[  651.079344] R13: ffff95af90aeefc8 R14: ffff95af64a80000 R15: 0000000000000000
[  651.079346] FS:  0000000000000000(0000) GS:ffff95af9f9c0000(0000) knlGS:0000000000000000
[  651.087303] R13: ffff95af90aeefc8 R14: ffff95af64a80000 R15: ffff95af64c98040
[  651.087306] FS:  00007f31c3686740(0000) GS:ffff95af9fb40000(0000) knlGS:0000000000000000
[  651.095265] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  651.095267] CR2: 00007f1cf6740000 CR3: 00000004d6c0a006 CR4: 00000000003606e0
[  651.103240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  651.103242] CR2: 00007f31a4296128 CR3: 0000000826c3a002 CR4: 00000000003606e0
[  651.111201] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  651.119160] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  651.127118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  651.127119] Call Trace:
[  651.135079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  651.135080] Call Trace:
[  651.143040]  generic_make_request+0x197/0x3c0
[  651.152066]  generic_make_request+0x197/0x3c0
[  651.160025]  submit_bio+0x6e/0x130
[  651.169052]  submit_bio+0x6e/0x130
[  651.175462]  ? guard_bio_eod+0x32/0xb0
[  651.183423]  ? bio_add_page+0x48/0x60
[  651.189832]  submit_bh_wbc+0x157/0x190
[  651.197792]  do_blockdev_direct_IO+0x224e/0x25c0
[  651.205754]  jbd2_journal_commit_transaction+0x636/0x1aa0 [jbd2]
[  651.213714]  ? jbd2_journal_stop+0x1e3/0x3f0 [jbd2]
[  651.221672]  ? __switch_to_asm+0x40/0x70
[  651.224405]  ? ext4_dio_get_block_unwritten_async+0x90/0x90 [ext4]
[  651.232358]  ? __switch_to_asm+0x34/0x70
[  651.235087]  ext4_direct_IO+0x302/0x6c0 [ext4]
[  651.239940]  ? __switch_to+0xee/0x470
[  651.244796]  generic_file_direct_write+0xcc/0x170
[  651.248587]  ? __switch_to_asm+0x34/0x70
[  651.252379]  __generic_file_write_iter+0xb7/0x1c0
[  651.256559]  ? try_to_del_timer_sync+0x4d/0x80
[  651.260645]  ext4_file_write_iter+0xc6/0x410 [ext4]
[  651.264821]  kjournald2+0xc1/0x260 [jbd2]
[  651.269967]  __vfs_write+0x112/0x1a0
[  651.276666]  ? remove_wait_queue+0x60/0x60
[  651.282105]  vfs_write+0xad/0x1a0
[  651.286477]  kthread+0xf8/0x130
[  651.293370]  ksys_pwrite64+0x62/0x90
[  651.297744]  ? commit_timeout+0x10/0x10 [jbd2]
[  651.302696]  do_syscall_64+0x5b/0x180
[  651.306778]  ? kthread_stop+0x110/0x110
[  651.312023]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  651.316396]  ret_from_fork+0x35/0x40
[  651.321640] RIP: 0033:0x7f31c2b48d63
[  651.383240] Code: 49 89 ca b8 12 00 00 00 0f 05 48 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 5b f3 ff ff 481
[  651.404193] RSP: 002b:00007ffd5347e0e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
[  651.412638] RAX: ffffffffffffffda RBX: 0000000000dc6500 RCX: 00007f31c2b48d63
[  651.420600] RDX: 0000000000000200 RSI: 00007f31c3674e00 RDI: 0000000000000003
[  651.428559] RBP: 00007f31a42916a0 R08: 0000000000000000 R09: 00007f31bee651f0
[  651.436520] R10: 000000000480fe00 R11: 0000000000000293 R12: 00007f31a42916a8
[  651.444515] R13: 0000000000000200 R14: 0000000000dc6528 R15: 0000000000dc6510
