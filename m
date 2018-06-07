From: yi.zhang@redhat.com (Yi Zhang)
Date: Thu, 7 Jun 2018 19:02:09 +0800
Subject: [BUG REPORT] reset_controller stress operation lead to kernel
 NULL pointer
In-Reply-To: <e7f5e507-88da-3bc9-afa8-8e46f57f8b07@grimberg.me>
References: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
 <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>
 <825ff884-26d5-e05a-3375-e1a644722ad6@mellanox.com>
 <1952603032.5635954.1528044389779.JavaMail.zimbra@redhat.com>
 <CACVXFVM4JAYd79EPMBNg_0NcMg+y2_6s+UcDBgt_8GsEXb-vWA@mail.gmail.com>
 <1dd52330-93db-a89a-e1d8-fbda9060d2bd@redhat.com>
 <be1b6056-1da6-9902-749e-fed9b1cc2fc1@mellanox.com>
 <61f70436-dc1c-2176-4f38-9b789e4d096b@redhat.com>
 <e7f5e507-88da-3bc9-afa8-8e46f57f8b07@grimberg.me>
Message-ID: <a47eca28-8b70-b6ce-ec38-20a51a16f03c@redhat.com>



On 06/07/2018 04:27 PM, Sagi Grimberg wrote:
>
>> Still can reproduce the target " keep-alive timer (15 seconds) 
>> expired" and host IO blocked issue.
>
> Looks like the revalidate_disk is stuck on mutex via ns scan work which
> prevents from the reset to start as we try to flush that work.
>
> It appears that it's bdev->bd_mutex that is blocked. Still trying to
> understand how it can get blocked.
>
> Yi, would it be possible to try and reproduce this with lockdep to
> help us?
>
Yes, here is the log on target/host side after enable lockdep:
Target:
[? 408.978728] nvmet: creating controller 1 for subsystem testnqn for 
NQN nqn.2014-08.org.nvmexpress:uuid:ca06e830-e1cf-47d4-bb2c-41d68ec6ac09.
[? 412.220261] nvmet: creating controller 1 for subsystem testnqn for 
NQN nqn.2014-08.org.nvmexpress:uuid:ca06e830-e1cf-47d4-bb2c-41d68ec6ac09.
[? 427.452231] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[? 427.478042] nvmet: ctrl 1 fatal error occurred!


Host:
[? 400.172594] nvme nvme0: creating 40 I/O queues.
[? 403.363435] nvme nvme0: Property Set error: 7, offset 0x14
[? 403.413914] nvme nvme0: creating 40 I/O queues.
[? 614.996955] INFO: task kworker/u81:8:672 blocked for more than 120 
seconds.
[? 615.005534]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 615.012276] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.021648] kworker/u81:8?? D??? 0?? 672????? 2 0x80000000
[? 615.028392] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[? 615.035050] Call Trace:
[? 615.038398]? ? __schedule+0x403/0xbd0
[? 615.043106]? ? __mutex_lock+0x2aa/0x900
[? 615.048004]? schedule+0x32/0x80
[? 615.052112]? schedule_preempt_disabled+0xa/0x10
[? 615.057778]? __mutex_lock+0x2af/0x900
[? 615.062475]? ? __mutex_lock+0xb4/0x900
[? 615.067253]? ? I_BDEV+0x10/0x10
[? 615.071356]? ? bdev_test+0x20/0x20
[? 615.075742]? ? revalidate_disk+0x49/0x90
[? 615.080726]? revalidate_disk+0x49/0x90
[? 615.085502]? nvme_validate_ns+0x49/0x8b0 [nvme_core]
[? 615.091646]? ? blk_queue_exit+0x67/0x110
[? 615.096615]? ? blk_queue_exit+0x7f/0x110
[? 615.101574]? ? blk_queue_exit+0x5/0x110
[? 615.106423]? nvme_scan_work+0x2fa/0x3c0 [nvme_core]
[? 615.112459]? process_one_work+0x1f9/0x5c0
[? 615.117506]? ? process_one_work+0x173/0x5c0
[? 615.122748]? worker_thread+0x44/0x3e0
[? 615.127408]? kthread+0xfb/0x130
[? 615.131466]? ? process_one_work+0x5c0/0x5c0
[? 615.136697]? ? kthread_bind+0x10/0x10
[? 615.141348]? ret_from_fork+0x3a/0x50
[? 615.145901] INFO: task kworker/u81:9:673 blocked for more than 120 
seconds.
[? 615.154251]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 615.160947] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.170276] kworker/u81:9?? D??? 0?? 673????? 2 0x80000000
[? 615.176992] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work 
[nvme_rdma]
[? 615.185275] Call Trace:
[? 615.188600]? ? __schedule+0x403/0xbd0
[? 615.193289]? schedule+0x32/0x80
[? 615.197383]? schedule_timeout+0x21e/0x460
[? 615.202453]? ? find_held_lock+0x38/0xa0
[? 615.207322]? ? mark_held_locks+0x6b/0x90
[? 615.212283]? ? _raw_spin_unlock_irq+0x29/0x40
[? 615.217727]? wait_for_completion+0x110/0x170
[? 615.223075]? ? wake_up_q+0x70/0x70
[? 615.227446]? flush_work+0x197/0x220
[? 615.231918]? ? flush_work+0x14e/0x220
[? 615.236569]? ? wake_up_worker+0x30/0x30
[? 615.241420]? ? wait_for_completion+0x36/0x170
[? 615.246851]? nvme_stop_ctrl+0x37/0x60 [nvme_core]
[? 615.252665]? nvme_rdma_reset_ctrl_work+0x22/0xb0 [nvme_rdma]
[? 615.259551]? process_one_work+0x1f9/0x5c0
[? 615.264574]? ? process_one_work+0x173/0x5c0
[? 615.269789]? worker_thread+0x1c3/0x3e0
[? 615.274497]? kthread+0xfb/0x130
[? 615.278521]? ? process_one_work+0x5c0/0x5c0
[? 615.283704]? ? kthread_bind+0x10/0x10
[? 615.288311]? ret_from_fork+0x3a/0x50
[? 615.292830] INFO: task systemd-udevd:996 blocked for more than 120 
seconds.
[? 615.301144]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 615.307806] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.317117] systemd-udevd?? D??? 0?? 996????? 1 0x00000000
[? 615.323805] Call Trace:
[? 615.327096]? ? __schedule+0x403/0xbd0
[? 615.331743]? ? blk_flush_plug_list+0xe7/0x240
[? 615.337181]? schedule+0x32/0x80
[? 615.341238]? io_schedule+0x12/0x40
[? 615.345598]? blk_mq_get_tag+0x15c/0x270
[? 615.350437]? ? remove_wait_queue+0x60/0x60
[? 615.355581]? blk_mq_get_request+0x13c/0x470
[? 615.360822]? ? blk_mq_get_request+0x5/0x470
[? 615.366062]? blk_mq_make_request+0x13d/0x700
[? 615.371398]? generic_make_request+0x338/0x570
[? 615.376834]? submit_bio+0x6e/0x130
[? 615.381193]? ? guard_bio_eod+0xa3/0x180
[? 615.386042]? ? guard_bio_eod+0x21/0x180
[? 615.390883]? submit_bh_wbc+0x15a/0x190
[? 615.395630]? __block_write_full_page+0x14b/0x400
[? 615.401352]? __writepage+0x1c/0x60
[? 615.405703]? write_cache_pages+0x243/0x530
[? 615.410819]? ? __wb_update_bandwidth+0x200/0x200
[? 615.416526]? generic_writepages+0x54/0x80
[? 615.421531]? do_writepages+0x1a/0x70
[? 615.426032]? __filemap_fdatawrite_range+0xc5/0x100
[? 615.431899]? filemap_write_and_wait+0x2c/0x70
[? 615.437283]? invalidate_partition+0x1e/0x40
[? 615.442458]? rescan_partitions+0x4f/0x370
[? 615.447460]? blkdev_reread_part+0x20/0x30
[? 615.452454]? blkdev_ioctl+0x4d6/0x9e0
[? 615.457067]? ? selinux_file_ioctl+0x13d/0x1f0
[? 615.462451]? block_ioctl+0x43/0x50
[? 615.466757]? do_vfs_ioctl+0xa9/0x6c0
[? 615.471266]? ksys_ioctl+0x60/0x90
[? 615.475484]? __x64_sys_ioctl+0x16/0x20
[? 615.480186]? do_syscall_64+0x60/0x210
[? 615.484794]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 615.490957] RIP: 0033:0x7fb829fc4567
[? 615.495467] RSP: 002b:00007ffcf18dd888 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[? 615.504462] RAX: ffffffffffffffda RBX: 000055975a9ad030 RCX: 
00007fb829fc4567
[? 615.512980] RDX: 0000000000000000 RSI: 000000000000125f RDI: 
000000000000000c
[? 615.521500] RBP: 000055975aa08d50 R08: 0000559758ee1142 R09: 
0000000000000003
[? 615.530024] R10: fffffffffffffd43 R11: 0000000000000246 R12: 
00007ffcf18dda80
[? 615.538550] R13: 0000000000000003 R14: 000000000000000c R15: 
0000000000000000
[? 615.547117] INFO: task fio:3715 blocked for more than 120 seconds.
[? 615.554585]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 615.561283] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.570608] fio???????????? D??? 0? 3715?? 3671 0x00000080
[? 615.577315] Call Trace:
[? 615.580602]? ? __schedule+0x403/0xbd0
[? 615.585242]? ? __mutex_lock+0x2aa/0x900
[? 615.590070]? schedule+0x32/0x80
[? 615.594114]? schedule_preempt_disabled+0xa/0x10
[? 615.599719]? __mutex_lock+0x2af/0x900
[? 615.604355]? ? __mutex_lock+0xb4/0x900
[? 615.609079]? ? find_held_lock+0x38/0xa0
[? 615.613922]? ? blkdev_put+0x1e/0x100
[? 615.618464]? blkdev_put+0x1e/0x100
[? 615.622803]? blkdev_close+0x24/0x30
[? 615.627242]? __fput+0xde/0x220
[? 615.631191]? task_work_run+0x89/0xa0
[? 615.635724]? exit_to_usermode_loop+0x7e/0xb1
[? 615.641032]? do_syscall_64+0x1e5/0x210
[? 615.645762]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 615.651955] RIP: 0033:0x14a7e810c80d
[? 615.656492] RSP: 002b:000014a7c9150b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 615.665510] RAX: 0000000000000000 RBX: 000014a7e4b3f6d0 RCX: 
000014a7e810c80d
[? 615.674059] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
0000000000000032
[? 615.682608] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 615.691160] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 615.699702] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cdd87398
[? 615.708261] INFO: task fio:3716 blocked for more than 120 seconds.
[? 615.715738]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 615.722445] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.731786] fio???????????? D??? 0? 3716?? 3671 0x00000080
[? 615.738535] Call Trace:
[? 615.741864]? ? __schedule+0x403/0xbd0
[? 615.746554]? ? __mutex_lock+0x2aa/0x900
[? 615.751438]? schedule+0x32/0x80
[? 615.755541]? schedule_preempt_disabled+0xa/0x10
[? 615.761200]? __mutex_lock+0x2af/0x900
[? 615.765897]? ? __mutex_lock+0xb4/0x900
[? 615.770682]? ? find_held_lock+0x38/0xa0
[? 615.775568]? ? blkdev_put+0x1e/0x100
[? 615.780163]? blkdev_put+0x1e/0x100
[? 615.784554]? blkdev_close+0x24/0x30
[? 615.789026]? __fput+0xde/0x220
[? 615.793007]? task_work_run+0x89/0xa0
[? 615.797560]? exit_to_usermode_loop+0x7e/0xb1
[? 615.802892]? do_syscall_64+0x1e5/0x210
[? 615.807630]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 615.813832] RIP: 0033:0x14a7e810c80d
[? 615.818367] RSP: 002b:000014a7c9351b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 615.827391] RAX: 0000000000000000 RBX: 000014a7e4b3f890 RCX: 
000014a7e810c80d
[? 615.835922] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
0000000000000020
[? 615.844446] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 615.852964] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 615.861483] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cdd96ee0
[? 615.870010] INFO: task fio:3717 blocked for more than 120 seconds.
[? 615.877468]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 615.884152] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 615.893477] fio???????????? D??? 0? 3717?? 3671 0x00000080
[? 615.900186] Call Trace:
[? 615.903499]? ? __schedule+0x403/0xbd0
[? 615.908171]? ? __mutex_lock+0x2aa/0x900
[? 615.913038]? schedule+0x32/0x80
[? 615.917123]? schedule_preempt_disabled+0xa/0x10
[? 615.922772]? __mutex_lock+0x2af/0x900
[? 615.927447]? ? __mutex_lock+0xb4/0x900
[? 615.932223]? ? find_held_lock+0x38/0xa0
[? 615.937090]? ? blkdev_put+0x1e/0x100
[? 615.941671]? blkdev_put+0x1e/0x100
[? 615.946037]? blkdev_close+0x24/0x30
[? 615.950498]? __fput+0xde/0x220
[? 615.954462]? task_work_run+0x89/0xa0
[? 615.959002]? exit_to_usermode_loop+0x7e/0xb1
[? 615.964322]? do_syscall_64+0x1e5/0x210
[? 615.969060]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 615.975257] RIP: 0033:0x14a7e810c80d
[? 615.979797] RSP: 002b:000014a7c9552b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 615.988816] RAX: 0000000000000000 RBX: 000014a7e4b3fa50 RCX: 
000014a7e810c80d
[? 615.997346] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
0000000000000012
[? 616.005867] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 616.014392] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 616.022906] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cdda6a28
[? 616.031435] INFO: task fio:3719 blocked for more than 120 seconds.
[? 616.038896]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 616.045597] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 616.054927] fio???????????? D??? 0? 3719?? 3671 0x00000080
[? 616.061640] Call Trace:
[? 616.064947]? ? __schedule+0x403/0xbd0
[? 616.069619]? ? __mutex_lock+0x2aa/0x900
[? 616.074486]? schedule+0x32/0x80
[? 616.078578]? schedule_preempt_disabled+0xa/0x10
[? 616.084224]? __mutex_lock+0x2af/0x900
[? 616.088902]? ? __mutex_lock+0xb4/0x900
[? 616.093661]? ? find_held_lock+0x38/0xa0
[? 616.098532]? ? blkdev_put+0x1e/0x100
[? 616.103106]? blkdev_put+0x1e/0x100
[? 616.107482]? blkdev_close+0x24/0x30
[? 616.111939]? __fput+0xde/0x220
[? 616.115903]? task_work_run+0x89/0xa0
[? 616.120443]? exit_to_usermode_loop+0x7e/0xb1
[? 616.125766]? do_syscall_64+0x1e5/0x210
[? 616.130500]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 616.136702] RIP: 0033:0x14a7e810c80d
[? 616.141239] RSP: 002b:000014a7c9954b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 616.150262] RAX: 0000000000000000 RBX: 000014a7e4b3fdd0 RCX: 
000014a7e810c80d
[? 616.158793] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
000000000000000f
[? 616.167317] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 616.175837] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 616.184359] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cddc60b8
[? 616.192887] INFO: task fio:3720 blocked for more than 120 seconds.
[? 616.200349]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 616.207032] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 616.216362] fio???????????? D??? 0? 3720?? 3671 0x00000080
[? 616.223060] Call Trace:
[? 616.226373]? ? __schedule+0x403/0xbd0
[? 616.231041]? ? __mutex_lock+0x2aa/0x900
[? 616.235910]? schedule+0x32/0x80
[? 616.239999]? schedule_preempt_disabled+0xa/0x10
[? 616.245646]? __mutex_lock+0x2af/0x900
[? 616.250322]? ? __mutex_lock+0xb4/0x900
[? 616.255087]? ? find_held_lock+0x38/0xa0
[? 616.259953]? ? blkdev_put+0x1e/0x100
[? 616.264536]? blkdev_put+0x1e/0x100
[? 616.268910]? blkdev_close+0x24/0x30
[? 616.273369]? __fput+0xde/0x220
[? 616.277325]? task_work_run+0x89/0xa0
[? 616.281857]? exit_to_usermode_loop+0x7e/0xb1
[? 616.287177]? do_syscall_64+0x1e5/0x210
[? 616.291915]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 616.298129] RIP: 0033:0x14a7e810c80d
[? 616.302668] RSP: 002b:000014a7c9b55b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 616.311692] RAX: 0000000000000000 RBX: 000014a7e4b3ff90 RCX: 
000014a7e810c80d
[? 616.320223] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
000000000000001e
[? 616.328751] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 616.337272] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 616.345792] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cddd5c00
[? 616.354322] INFO: task fio:3721 blocked for more than 120 seconds.
[? 616.361779]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 616.368464] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 616.377788] fio???????????? D??? 0? 3721?? 3671 0x00000080
[? 616.384501] Call Trace:
[? 616.387810]? ? __schedule+0x403/0xbd0
[? 616.392478]? ? __mutex_lock+0x2aa/0x900
[? 616.397347]? schedule+0x32/0x80
[? 616.401433]? schedule_preempt_disabled+0xa/0x10
[? 616.407079]? __mutex_lock+0x2af/0x900
[? 616.411750]? ? __mutex_lock+0xb4/0x900
[? 616.416524]? ? find_held_lock+0x38/0xa0
[? 616.421391]? ? blkdev_put+0x1e/0x100
[? 616.425976]? blkdev_put+0x1e/0x100
[? 616.430350]? blkdev_close+0x24/0x30
[? 616.434812]? __fput+0xde/0x220
[? 616.438774]? task_work_run+0x89/0xa0
[? 616.443313]? exit_to_usermode_loop+0x7e/0xb1
[? 616.448632]? do_syscall_64+0x1e5/0x210
[? 616.453373]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 616.459565] RIP: 0033:0x14a7e810c80d
[? 616.464111] RSP: 002b:000014a7c9d56b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 616.473132] RAX: 0000000000000000 RBX: 000014a7e4b40150 RCX: 
000014a7e810c80d
[? 616.481662] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
0000000000000017
[? 616.490178] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 616.498703] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 616.507217] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cdde5748
[? 616.515745] INFO: task fio:3722 blocked for more than 120 seconds.
[? 616.523197]?????? Not tainted 4.17.0-rc4.test2_lockdep+ #4
[? 616.529881] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[? 616.539202] fio???????????? D??? 0? 3722?? 3671 0x00000080
[? 616.545912] Call Trace:
[? 616.549218]? ? __schedule+0x403/0xbd0
[? 616.553888]? ? __mutex_lock+0x2aa/0x900
[? 616.558756]? schedule+0x32/0x80
[? 616.562843]? schedule_preempt_disabled+0xa/0x10
[? 616.568489]? __mutex_lock+0x2af/0x900
[? 616.573164]? ? __mutex_lock+0xb4/0x900
[? 616.577936]? ? find_held_lock+0x38/0xa0
[? 616.582805]? ? blkdev_put+0x1e/0x100
[? 616.587380]? blkdev_put+0x1e/0x100
[? 616.591754]? blkdev_close+0x24/0x30
[? 616.596211]? __fput+0xde/0x220
[? 616.600176]? task_work_run+0x89/0xa0
[? 616.604716]? exit_to_usermode_loop+0x7e/0xb1
[? 616.610041]? do_syscall_64+0x1e5/0x210
[? 616.614778]? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[? 616.620979] RIP: 0033:0x14a7e810c80d
[? 616.625514] RSP: 002b:000014a7c9f57b90 EFLAGS: 00000293 ORIG_RAX: 
0000000000000003
[? 616.634540] RAX: 0000000000000000 RBX: 000014a7e4b40310 RCX: 
000014a7e810c80d
[? 616.643067] RDX: 000014a7ee411000 RSI: 0000000000000080 RDI: 
0000000000000024
[? 616.651593] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[? 616.660115] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000000
[? 616.668635] R13: 0000000000000000 R14: 0000000000000000 R15: 
000014a7cddf5290
[? 616.677171]
[? 616.677171] Showing all locks held in the system:
[? 616.685157] 1 lock held by khungtaskd/257:
[? 616.690338]? #0: 000000000c4c8765 (tasklist_lock){.+.+}, at: 
debug_show_all_locks+0x39/0x1b0
[? 616.700367] 3 locks held by kworker/u81:8/672:
[? 616.705904]? #0: 00000000f7d83d28 ((wq_completion)"nvme-wq"){+.+.}, 
at: process_one_work+0x173/0x5c0
[? 616.716728]? #1: 00000000d602fcc3 
((work_completion)(&ctrl->scan_work)){+.+.}, at: 
process_one_work+0x173/0x5c0
[? 616.728635]? #2: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
revalidate_disk+0x49/0x90
[? 616.738326] 2 locks held by kworker/u81:9/673:
[? 616.743930]? #0: 00000000c6ce30ed 
((wq_completion)"nvme-reset-wq"){+.+.}, at: process_one_work+0x173/0x5c0
[? 616.755402]? #1: 000000002440c8c3 
((work_completion)(&ctrl->ctrl.reset_work)){+.+.}, at: 
process_one_work+0x173/0x5c0
[? 616.767958] 1 lock held by systemd-udevd/996:
[? 616.773511]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_reread_part+0x18/0x30
[? 616.783562] 2 locks held by agetty/1548:
[? 616.788649]? #0: 00000000dc70cd5c (&tty->ldisc_sem){++++}, at: 
tty_ldisc_ref_wait+0x24/0x50
[? 616.798714]? #1: 000000003ab79ae8 (&ldata->atomic_read_lock){+.+.}, 
at: n_tty_read+0xdb/0x8d0
[? 616.808973] 2 locks held by agetty/1549:
[? 616.814066]? #0: 00000000435ac06a (&tty->ldisc_sem){++++}, at: 
tty_ldisc_ref_wait+0x24/0x50
[? 616.824152]? #1: 000000002a9a768f (&ldata->atomic_read_lock){+.+.}, 
at: n_tty_read+0xdb/0x8d0
[? 616.834450] 1 lock held by fio/3715:
[? 616.839195]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.848624] 1 lock held by fio/3716:
[? 616.853373]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.862809] 1 lock held by fio/3717:
[? 616.867557]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.876996] 1 lock held by fio/3719:
[? 616.881761]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.891220] 1 lock held by fio/3720:
[? 616.896010]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.905492] 1 lock held by fio/3721:
[? 616.910305]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.919805] 1 lock held by fio/3722:
[? 616.924636]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.934161] 1 lock held by fio/3723:
[? 616.939012]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.948560] 1 lock held by fio/3724:
[? 616.953432]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.963000] 1 lock held by fio/3725:
[? 616.967899]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.977487] 1 lock held by fio/3726:
[? 616.982409]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 616.992015] 1 lock held by fio/3727:
[? 616.996939]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.006547] 1 lock held by fio/3728:
[? 617.011471]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.021094] 1 lock held by fio/3729:
[? 617.026051]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.035700] 1 lock held by fio/3730:
[? 617.040672]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.050333] 1 lock held by fio/3731:
[? 617.055318]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.064983] 1 lock held by fio/3732:
[? 617.069968]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.079628] 1 lock held by fio/3733:
[? 617.084608]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.094264] 1 lock held by fio/3734:
[? 617.099235]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.108883] 1 lock held by fio/3735:
[? 617.113841]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.123474] 1 lock held by fio/3736:
[? 617.128431]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.138062] 1 lock held by fio/3737:
[? 617.143009]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.152642] 1 lock held by fio/3738:
[? 617.157588]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.167211] 1 lock held by fio/3739:
[? 617.172157]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.181779] 1 lock held by fio/3740:
[? 617.186725]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.196350] 1 lock held by fio/3741:
[? 617.201291]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.210919] 1 lock held by fio/3742:
[? 617.215863]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.225485] 1 lock held by fio/3743:
[? 617.230429]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.240054] 1 lock held by fio/3744:
[? 617.244988]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.254616] 1 lock held by fio/3745:
[? 617.259557]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.269183] 1 lock held by fio/3746:
[? 617.274132]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.283757] 1 lock held by fio/3747:
[? 617.288696]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.298323] 1 lock held by fio/3748:
[? 617.303266]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.312894] 1 lock held by fio/3749:
[? 617.317843]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.327469] 1 lock held by fio/3751:
[? 617.332407]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.342032] 1 lock held by fio/3753:
[? 617.346970]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.356597] 1 lock held by fio/3754:
[? 617.361540]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.371163] 1 lock held by fio/3755:
[? 617.376108]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.385732] 1 lock held by fio/3756:
[? 617.390678]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.400304] 1 lock held by fio/3757:
[? 617.405237]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.414864] 1 lock held by fio/3758:
[? 617.419808]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.429431] 1 lock held by fio/3759:
[? 617.434377]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.444005] 1 lock held by fio/3760:
[? 617.448949]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.458576] 1 lock held by fio/3761:
[? 617.463518]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.473142] 1 lock held by fio/3762:
[? 617.478090]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.487714] 1 lock held by fio/3763:
[? 617.492653]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.502279] 1 lock held by fio/3764:
[? 617.507223]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.516848] 1 lock held by fio/3765:
[? 617.521790]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.531417] 1 lock held by fio/3766:
[? 617.536366]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.545993] 1 lock held by fio/3767:
[? 617.550943]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.560570] 1 lock held by fio/3768:
[? 617.565512]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.575136] 1 lock held by fio/3769:
[? 617.580081]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.589703] 1 lock held by fio/3770:
[? 617.594650]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.604275] 1 lock held by fio/3771:
[? 617.609213]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.618841] 1 lock held by fio/3772:
[? 617.623785]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.633412] 1 lock held by fio/3773:
[? 617.638361]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.647988] 1 lock held by fio/3774:
[? 617.652938]? #0: 00000000b47b635f (&bdev->bd_mutex){+.+.}, at: 
blkdev_put+0x1e/0x100
[? 617.662566] 3 locks held by kworker/u82:3/3784:
[? 617.668585]? #0: 000000004f345383 ((wq_completion)"writeback"){+.+.}, 
at: process_one_work+0x173/0x5c0
[? 617.679966]? #1: 0000000009b8ab6b 
((work_completion)(&(&wb->dwork)->work)){+.+.}, at: 
process_one_work+0x173/0x5c0
[? 617.692524]? #2: 00000000f5c92b1e (&type->s_umount_key#33){.+.+}, at: 
trylock_super+0x16/0x50
[? 617.703034] 3 locks held by main.sh/4525:
[? 617.708474]? #0: 00000000e900c5b8 (sb_writers#4){.+.+}, at: 
vfs_write+0x17e/0x1b0
[? 617.717821]? #1: 0000000012a57c73 (&of->mutex){+.+.}, at: 
kernfs_fop_write+0xe3/0x1a0
[? 617.727558]? #2: 00000000efd0bad4 (kn->count#240){++++}, at: 
kernfs_fop_write+0xeb/0x1a0
[? 617.737585]
[? 617.740204] =============================================
[? 617.740204]
