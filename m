From: yizhan@redhat.com (Yi Zhang)
Date: Sun, 26 Mar 2017 20:41:36 -0400 (EDT)
Subject: [PATCH 0/3] Introduce fabrics controller loss timeout
In-Reply-To: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
Message-ID: <859829333.6134255.1490575296451.JavaMail.zimbra@redhat.com>

Hello Sagi
With these three patches, the reconnecting stopped after 60 times.

I restart another test that do fio testing on nvme0n1[1] on client before executing "nvmetclt clear" on target side. 
After that, I found another issue that the fio jobs cannot be stopped even I tried "Ctrl + C", and the device node also cannot be released[2].
Here is the kernel log[3].
Let me know if you need more info, thanks

[1]
fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60

[2]
# lsblk 
NAME                  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sr0                    11:0    1  1024M  0 rom  
sda                     8:0    0 279.4G  0 disk 
??sda2                  8:2    0 278.4G  0 part 
? ??rhelp_rdma04-swap 253:1    0  15.8G  0 lvm  [SWAP]
? ??rhelp_rdma04-home 253:2    0 212.6G  0 lvm  /home
? ??rhelp_rdma04-root 253:0    0    50G  0 lvm  /
??sda1                  8:1    0     1G  0 part /boot
nvme0n1               259:0    0   250G  0 disk 

[3]
[  356.812399] nvme nvme0: Reconnecting in 10 seconds...
[  366.965161] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  367.002048] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  367.029926] nvme nvme0: Failed reconnect attempt 21
[  367.051905] nvme nvme0: Reconnecting in 10 seconds...
[  371.444001] INFO: task kworker/u130:1:155 blocked for more than 120 seconds.
[  371.480773]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  371.505608] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  371.540918] kworker/u130:1  D    0   155      2 0x00000000
[  371.565584] Workqueue: writeback wb_workfn (flush-259:0)
[  371.590031] Call Trace:
[  371.600981]  __schedule+0x289/0x8f0
[  371.616644]  schedule+0x36/0x80
[  371.630693]  io_schedule+0x16/0x40
[  371.645565]  blk_mq_get_tag+0x16c/0x280
[  371.662929]  ? remove_wait_queue+0x60/0x60
[  371.680942]  __blk_mq_alloc_request+0x1b/0xe0
[  371.700508]  blk_mq_sched_get_request+0x1a0/0x240
[  371.721616]  blk_mq_make_request+0x113/0x620
[  371.741215]  generic_make_request+0x110/0x2c0
[  371.760755]  submit_bio+0x75/0x150
[  371.776138]  submit_bh_wbc+0x141/0x180
[  371.793106]  __block_write_full_page+0x13d/0x3b0
[  371.814573]  ? I_BDEV+0x20/0x20
[  371.828657]  ? I_BDEV+0x20/0x20
[  371.842717]  block_write_full_page+0xe5/0x110
[  371.862312]  blkdev_writepage+0x18/0x20
[  371.879727]  __writepage+0x13/0x40
[  371.894593]  write_cache_pages+0x26f/0x510
[  371.913039]  ? select_idle_sibling+0x29/0x3d0
[  371.932593]  ? compound_head+0x20/0x20
[  371.949404]  generic_writepages+0x51/0x80
[  371.967972]  blkdev_writepages+0x2f/0x40
[  371.989381]  do_writepages+0x1e/0x30
[  372.007479]  __writeback_single_inode+0x45/0x330
[  372.028326]  writeback_sb_inodes+0x280/0x570
[  372.047594]  __writeback_inodes_wb+0x8c/0xc0
[  372.066852]  wb_writeback+0x276/0x310
[  372.083247]  wb_workfn+0x19c/0x3b0
[  372.098577]  process_one_work+0x165/0x410
[  372.116679]  worker_thread+0x137/0x4c0
[  372.133644]  kthread+0x101/0x140
[  372.148257]  ? rescuer_thread+0x3b0/0x3b0
[  372.166253]  ? kthread_park+0x90/0x90
[  372.182689]  ret_from_fork+0x2c/0x40
[  372.198802] INFO: task systemd-udevd:788 blocked for more than 120 seconds.
[  372.230377]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  372.253129] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  372.288576] systemd-udevd   D    0   788      1 0x00000002
[  372.313244] Call Trace:
[  372.324208]  __schedule+0x289/0x8f0
[  372.339835]  schedule+0x36/0x80
[  372.354198]  io_schedule+0x16/0x40
[  372.369040]  blk_mq_get_tag+0x16c/0x280
[  372.385867]  ? remove_wait_queue+0x60/0x60
[  372.404276]  __blk_mq_alloc_request+0x1b/0xe0
[  372.423849]  blk_mq_sched_get_request+0x1a0/0x240
[  372.444945]  blk_mq_make_request+0x113/0x620
[  372.464123]  generic_make_request+0x110/0x2c0
[  372.484885]  submit_bio+0x75/0x150
[  372.502586]  submit_bh_wbc+0x141/0x180
[  372.521625]  __block_write_full_page+0x13d/0x3b0
[  372.542552]  ? I_BDEV+0x20/0x20
[  372.556646]  ? I_BDEV+0x20/0x20
[  372.570750]  block_write_full_page+0xe5/0x110
[  372.590507]  blkdev_writepage+0x18/0x20
[  372.608514]  __writepage+0x13/0x40
[  372.623729]  write_cache_pages+0x26f/0x510
[  372.642116]  ? compound_head+0x20/0x20
[  372.659046]  generic_writepages+0x51/0x80
[  372.677447]  blkdev_writepages+0x2f/0x40
[  372.695072]  do_writepages+0x1e/0x30
[  372.711155]  __filemap_fdatawrite_range+0xc6/0x100
[  372.732778]  filemap_write_and_wait+0x3d/0x80
[  372.752330]  __sync_blockdev+0x1f/0x40
[  372.769151]  fsync_bdev+0x44/0x50
[  372.784048]  invalidate_partition+0x24/0x50
[  372.802835]  rescan_partitions+0x52/0x3a0
[  372.821426]  ? selinux_capable+0x20/0x30
[  372.839444]  ? security_capable+0x48/0x60
[  372.857427]  __blkdev_reread_part+0x64/0x70
[  372.876214]  blkdev_reread_part+0x23/0x40
[  372.894178]  blkdev_ioctl+0x46c/0x900
[  372.910650]  block_ioctl+0x41/0x50
[  372.925899]  do_vfs_ioctl+0xa7/0x5e0
[  372.941931]  SyS_ioctl+0x79/0x90
[  372.956410]  ? SyS_flock+0x12c/0x1c0
[  372.972407]  entry_SYSCALL_64_fastpath+0x1a/0xa9
[  372.995057] RIP: 0033:0x7f2604a22507
[  373.013328] RSP: 002b:00007ffe3be8f228 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  373.049088] RAX: ffffffffffffffda RBX: 000056342ff88de0 RCX: 00007f2604a22507
[  373.081210] RDX: 0000000000000000 RSI: 000000000000125f RDI: 000000000000000c
[  373.113650] RBP: 0000000000000000 R08: 0000000000000001 R09: 00007f2605dbb8c0
[  373.145759] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  373.178107] R13: 00007ffe3be8b1d8 R14: 0000000000000008 R15: 0000000000010300
[  373.210167] INFO: task fio:3324 blocked for more than 120 seconds.
[  373.237948]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  373.260671] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  373.295605] fio             D    0  3324   3252 0x00000080
[  373.320234] Call Trace:
[  373.331152]  __schedule+0x289/0x8f0
[  373.346824]  schedule+0x36/0x80
[  373.360958]  schedule_preempt_disabled+0xe/0x10
[  373.381274]  __mutex_lock.isra.8+0x266/0x500
[  373.400423]  __mutex_lock_slowpath+0x13/0x20
[  373.419588]  mutex_lock+0x2f/0x40
[  373.434441]  blkdev_put+0x20/0x120
[  373.449748]  blkdev_close+0x25/0x30
[  373.466217]  __fput+0xe7/0x210
[  373.480691]  ____fput+0xe/0x10
[  373.495002]  task_work_run+0x83/0xb0
[  373.512914]  exit_to_usermode_loop+0x59/0x85
[  373.534017]  do_syscall_64+0x165/0x180
[  373.552724]  entry_SYSCALL64_slow_path+0x25/0x25
[  373.575867] RIP: 0033:0x2b89425194fd
[  373.591921] RSP: 002b:00002b895b083c40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  373.626630] RAX: 0000000000000000 RBX: 00002b89431806d0 RCX: 00002b89425194fd
[  373.658765] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 000000000000000f
[  373.690820] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000cfc
[  373.722842] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  373.755214] R13: 00002b894b403000 R14: 0000000000000000 R15: 00002b894b4104c0
[  373.787447] INFO: task fio:3325 blocked for more than 120 seconds.
[  373.815230]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  373.838263] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  373.874051] fio             D    0  3325   3252 0x00000080
[  373.898802] Call Trace:
[  373.909778]  __schedule+0x289/0x8f0
[  373.925415]  schedule+0x36/0x80
[  373.939503]  schedule_preempt_disabled+0xe/0x10
[  373.959802]  __mutex_lock.isra.8+0x266/0x500
[  373.979022]  __mutex_lock_slowpath+0x13/0x20
[  373.998230]  mutex_lock+0x2f/0x40
[  374.013611]  blkdev_put+0x20/0x120
[  374.031725]  blkdev_close+0x25/0x30
[  374.050176]  __fput+0xe7/0x210
[  374.064775]  ____fput+0xe/0x10
[  374.078489]  task_work_run+0x83/0xb0
[  374.094580]  exit_to_usermode_loop+0x59/0x85
[  374.113768]  do_syscall_64+0x165/0x180
[  374.130553]  entry_SYSCALL64_slow_path+0x25/0x25
[  374.151303] RIP: 0033:0x2b89425194fd
[  374.167387] RSP: 002b:00002b895ae82c40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  374.201599] RAX: 0000000000000000 RBX: 00002b8943180890 RCX: 00002b89425194fd
[  374.233708] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 0000000000000037
[  374.265519] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000cfd
[  374.297649] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  374.329729] R13: 00002b894b410c00 R14: 0000000000000000 R15: 00002b894b41e0c0
[  374.361865] INFO: task fio:3327 blocked for more than 120 seconds.
[  374.389636]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  374.412347] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  374.447748] fio             D    0  3327   3252 0x00000080
[  374.472345] Call Trace:
[  374.483370]  __schedule+0x289/0x8f0
[  374.499146]  schedule+0x36/0x80
[  374.513203]  schedule_preempt_disabled+0xe/0x10
[  374.534772]  __mutex_lock.isra.8+0x266/0x500
[  374.556953]  __mutex_lock_slowpath+0x13/0x20
[  374.577119]  mutex_lock+0x2f/0x40
[  374.591993]  blkdev_put+0x20/0x120
[  374.607965]  blkdev_close+0x25/0x30
[  374.623585]  __fput+0xe7/0x210
[  374.637293]  ____fput+0xe/0x10
[  374.650976]  task_work_run+0x83/0xb0
[  374.667176]  exit_to_usermode_loop+0x59/0x85
[  374.686332]  do_syscall_64+0x165/0x180
[  374.703150]  entry_SYSCALL64_slow_path+0x25/0x25
[  374.723902] RIP: 0033:0x2b89425194fd
[  374.740073] RSP: 002b:00002b895aa80c40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  374.774171] RAX: 0000000000000000 RBX: 00002b8943180c10 RCX: 00002b89425194fd
[  374.806303] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 000000000000000a
[  374.838350] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000cff
[  374.871310] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  374.903759] R13: 00002b894b42c400 R14: 0000000000000000 R15: 00002b894b4398c0
[  374.935769] INFO: task fio:3328 blocked for more than 120 seconds.
[  374.963535]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  374.986330] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  375.021111] fio             D    0  3328   3252 0x00000080
[  375.047092] Call Trace:
[  375.059404]  __schedule+0x289/0x8f0
[  375.076919]  schedule+0x36/0x80
[  375.091092]  schedule_preempt_disabled+0xe/0x10
[  375.111569]  __mutex_lock.isra.8+0x266/0x500
[  375.130372]  __mutex_lock_slowpath+0x13/0x20
[  375.149605]  mutex_lock+0x2f/0x40
[  375.164517]  blkdev_put+0x20/0x120
[  375.179741]  blkdev_close+0x25/0x30
[  375.195456]  __fput+0xe7/0x210
[  375.209262]  ____fput+0xe/0x10
[  375.222946]  task_work_run+0x83/0xb0
[  375.239113]  exit_to_usermode_loop+0x59/0x85
[  375.258416]  do_syscall_64+0x165/0x180
[  375.275285]  entry_SYSCALL64_slow_path+0x25/0x25
[  375.296039] RIP: 0033:0x2b89425194fd
[  375.312085] RSP: 002b:00002b895a87fc40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  375.346101] RAX: 0000000000000000 RBX: 00002b8943180dd0 RCX: 00002b89425194fd
[  375.378382] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 0000000000000033
[  375.411225] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000d00
[  375.443626] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  375.475713] R13: 00002b894b43a000 R14: 0000000000000000 R15: 00002b894b4474c0
[  375.507788] INFO: task fio:3329 blocked for more than 120 seconds.
[  375.535718]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  375.560678] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  375.600320] fio             D    0  3329   3252 0x00000080
[  375.626374] Call Trace:
[  375.638002]  __schedule+0x289/0x8f0
[  375.654503]  schedule+0x36/0x80
[  375.669362]  schedule_preempt_disabled+0xe/0x10
[  375.690733]  __mutex_lock.isra.8+0x266/0x500
[  375.710360]  __mutex_lock_slowpath+0x13/0x20
[  375.730588]  mutex_lock+0x2f/0x40
[  375.745960]  blkdev_put+0x20/0x120
[  375.761654]  blkdev_close+0x25/0x30
[  375.777527]  __fput+0xe7/0x210
[  375.791235]  ____fput+0xe/0x10
[  375.804915]  task_work_run+0x83/0xb0
[  375.820962]  exit_to_usermode_loop+0x59/0x85
[  375.840572]  do_syscall_64+0x165/0x180
[  375.857423]  entry_SYSCALL64_slow_path+0x25/0x25
[  375.877716] RIP: 0033:0x2b89425194fd
[  375.894374] RSP: 002b:00002b895a67ec40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  375.928733] RAX: 0000000000000000 RBX: 00002b8943180f90 RCX: 00002b89425194fd
[  375.960830] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 0000000000000012
[  375.992567] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000d01
[  376.024255] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  376.057209] R13: 00002b894b447c00 R14: 0000000000000000 R15: 00002b894b4550c0
[  376.094684] INFO: task fio:3330 blocked for more than 120 seconds.
[  376.122962]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  376.145629] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  376.180921] fio             D    0  3330   3252 0x00000080
[  376.205618] Call Trace:
[  376.216588]  __schedule+0x289/0x8f0
[  376.232522]  schedule+0x36/0x80
[  376.246584]  schedule_preempt_disabled+0xe/0x10
[  376.266981]  __mutex_lock.isra.8+0x266/0x500
[  376.286200]  __mutex_lock_slowpath+0x13/0x20
[  376.305350]  mutex_lock+0x2f/0x40
[  376.320234]  blkdev_put+0x20/0x120
[  376.335129]  blkdev_close+0x25/0x30
[  376.350811]  __fput+0xe7/0x210
[  376.364524]  ____fput+0xe/0x10
[  376.378272]  task_work_run+0x83/0xb0
[  376.394276]  exit_to_usermode_loop+0x59/0x85
[  376.413504]  do_syscall_64+0x165/0x180
[  376.430381]  entry_SYSCALL64_slow_path+0x25/0x25
[  376.451181] RIP: 0033:0x2b89425194fd
[  376.467187] RSP: 002b:00002b895a47dc40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  376.501281] RAX: 0000000000000000 RBX: 00002b8943181150 RCX: 00002b89425194fd
[  376.533460] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 000000000000001b
[  376.565546] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000d02
[  376.602073] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  376.634662] R13: 00002b894b455800 R14: 0000000000000000 R15: 00002b894b462cc0
[  376.666879] INFO: task fio:3331 blocked for more than 120 seconds.
[  376.694623]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  376.717318] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  376.752846] fio             D    0  3331   3252 0x00000080
[  376.777775] Call Trace:
[  376.788747]  __schedule+0x289/0x8f0
[  376.804426]  schedule+0x36/0x80
[  376.818548]  schedule_preempt_disabled+0xe/0x10
[  376.838867]  __mutex_lock.isra.8+0x266/0x500
[  376.858245]  __mutex_lock_slowpath+0x13/0x20
[  376.877437]  mutex_lock+0x2f/0x40
[  376.892312]  blkdev_put+0x20/0x120
[  376.907705]  blkdev_close+0x25/0x30
[  376.924015]  __fput+0xe7/0x210
[  376.937845]  ____fput+0xe/0x10
[  376.951535]  task_work_run+0x83/0xb0
[  376.967630]  exit_to_usermode_loop+0x59/0x85
[  376.986804]  do_syscall_64+0x165/0x180
[  377.003710]  entry_SYSCALL64_slow_path+0x25/0x25
[  377.024454] RIP: 0033:0x2b89425194fd
[  377.040191] RSP: 002b:00002b895a27cc40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  377.074447] RAX: 0000000000000000 RBX: 00002b8943181310 RCX: 00002b89425194fd
[  377.110910] RDX: 00002b89415c8000 RSI: 0000000000000080 RDI: 0000000000000004
[  377.143293] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000d03
[  377.175001] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  377.205372] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  377.205394] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  377.206229] nvme nvme0: Failed reconnect attempt 22
[  377.206231] nvme nvme0: Reconnecting in 10 seconds...
[  377.308015] R13: 00002b894b463400 R14: 0000000000000000 R15: 00002b894b4708c0
[  377.340061] INFO: task fio:3332 blocked for more than 120 seconds.
[  377.368235]       Not tainted 4.11.0-rc3.ctrl_tmo+ #1
[  377.390954] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  377.426117] fio             D    0  3332   3252 0x00000080
[  377.450821] Call Trace:
[  377.461740]  __schedule+0x289/0x8f0
[  377.477483]  ? bit_wait+0x50/0x50
[  377.492389]  schedule+0x36/0x80
[  377.506526]  io_schedule+0x16/0x40
[  377.521756]  bit_wait_io+0x11/0x50
[  377.537329]  __wait_on_bit+0x64/0x90
[  377.553385]  ? bit_wait+0x50/0x50
[  377.568312]  out_of_line_wait_on_bit+0x81/0xb0
[  377.588802]  ? autoremove_wake_function+0x60/0x60
[  377.614016]  __block_write_begin_int+0x3cf/0x6c0
[  377.637191]  ? I_BDEV+0x20/0x20
[  377.651456]  ? I_BDEV+0x20/0x20
[  377.665628]  block_write_begin+0x49/0x90
[  377.683410]  blkdev_write_begin+0x23/0x30
[  377.701436]  generic_perform_write+0xca/0x1c0
[  377.720995]  ? file_update_time+0x5e/0x110
[  377.740096]  __generic_file_write_iter+0x19b/0x1e0
[  377.762660]  blkdev_write_iter+0x8a/0x100
[  377.781780]  ? __inode_security_revalidate+0x4f/0x60
[  377.805212]  __vfs_write+0xe3/0x160
[  377.821172]  vfs_write+0xb2/0x1b0
[  377.836228]  ? syscall_trace_enter+0x1d0/0x2b0
[  377.856432]  SyS_pwrite64+0x87/0xb0
[  377.872541]  do_syscall_64+0x67/0x180
[  377.888976]  entry_SYSCALL64_slow_path+0x25/0x25
[  377.909777] RIP: 0033:0x2b8942519d63
[  377.925799] RSP: 002b:00002b895a07bc00 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
[  377.960704] RAX: ffffffffffffffda RBX: 00002b899000ad40 RCX: 00002b8942519d63
[  377.992782] RDX: 0000000000000400 RSI: 00002b8990002920 RDI: 0000000000000031
[  378.024525] RBP: 00002b894b471000 R08: 0000000000000000 R09: 0000000000000000
[  378.056661] R10: 00000000c6946000 R11: 0000000000000293 R12: 00002b894b471008
[  378.088923] R13: 0000000000000400 R14: 00002b899000ad68 R15: 00002b899000ad50
[  387.445743] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  387.481444] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  387.509486] nvme nvme0: Failed reconnect attempt 23
[  387.531502] nvme nvme0: Reconnecting in 10 seconds...
[  397.686098] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  397.719849] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  397.749892] nvme nvme0: Failed reconnect attempt 24
--snip--
[  756.182567] nvme nvme0: Reconnecting in 10 seconds...
[  766.336578] nvme nvme0: Connect rejected: status 8 (invalid service ID).
[  766.371583] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  766.400827] nvme nvme0: Failed reconnect attempt 60
[  766.423690] nvme nvme0: Removing controller...

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Sagi Grimberg" <sagi@grimberg.me>
To: linux-nvme at lists.infradead.org
Cc: "Christoph Hellwig" <hch at lst.de>, "Yi Zhang" <yizhan at redhat.com>
Sent: Sunday, March 19, 2017 6:42:18 AM
Subject: [PATCH 0/3] Introduce fabrics controller loss timeout

In case a host realize that it's controller session is
damaged it schedules periodic reconnects. In case the controller
is gone and will never return, we need a stop condition to give
up on this controller simply remove it.

We allow the user to configure a suitable ctrl_loss_tmo and
set a reasonable default of 10 minutes.

We'll need a complementary nvme-cli exposure that will follow.

Sagi Grimberg (3):
  nvme-rdma: get rid of local reconnect_delay
  nvme-fabrics: Allow ctrl loss timeout configuration
  nvme-rdma: Support ctrl_loss_tmo

 drivers/nvme/host/fabrics.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h | 10 ++++++++++
 drivers/nvme/host/rdma.c    | 43 ++++++++++++++++++++++++++++---------------
 3 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.7.4
