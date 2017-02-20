From: yizhan@redhat.com (Yi Zhang)
Date: Mon, 20 Feb 2017 01:33:56 -0500 (EST)
Subject: NVMe issues with NVMe rescan/reset/remove operation
In-Reply-To: <1607299454.26128419.1487559924230.JavaMail.zimbra@redhat.com>
Message-ID: <1953565943.26260263.1487572436764.JavaMail.zimbra@redhat.com>

Hi 

I found several issues during NVMe rescan/reset/remove with IO on 4.10.0-rc8, could you help check it, thanks.

Steps I used:
#fio -filename=/dev/nvme0n1p1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60 &
#lspci | grep -i nvme
84:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01)
#sleep 35
#echo 1 > /sys/bus/pci/devices/0000:84:00.0/rescan
#echo 1 > /sys/bus/pci/devices/0000:84:00.0/reset
#echo 1 > /sys/bus/pci/devices/0000:84:00.0/remove

1. kernel BUG at block/blk-mq.c:374!
   Full log: http://pastebin.com/fymFAxjP

[  129.974989] kernel BUG at block/blk-mq.c:374!
[  129.979849] invalid opcode: 0000 [#1] SMP
[  129.984318] Modules linked in: ipmi_ssif vfat fat intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iTCO_wdt iTCO_vendor_support intel_cstate mei_me mei intel_uncore mxm_wmi ipmi_si dcdbas intel_rapl_perf lpc_ich ipmi_devintf pcspkr sg ipmi_msghandler shpchp acpi_power_meter wmi nfsd auth_rpcgss nfs_acl lockd grace dm_multipath sunrpc ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm nvme crc32c_intel nvme_core ahci i2c_core libahci libata tg3 megaraid_sas ptp pps_core fjes dm_mirror dm_region_hash dm_log dm_mod
[  130.051563] CPU: 2 PID: 1287 Comm: kworker/2:1H Not tainted 4.10.0-rc8 #1
[  130.059139] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.2.5 09/06/2016
[  130.067689] Workqueue: kblockd blk_mq_timeout_work
[  130.073033] task: ffff88027373ad00 task.stack: ffffc900028c0000
[  130.079639] RIP: 0010:blk_mq_end_request+0x58/0x70
[  130.084982] RSP: 0018:ffffc900028c3d50 EFLAGS: 00010202
[  130.090810] RAX: 0000000000000001 RBX: ffff8804712260c0 RCX: ffff880167377d88
[  130.098771] RDX: 0000000000001000 RSI: 0000000000001000 RDI: 0000000000000000
[  130.106732] RBP: ffffc900028c3d60 R08: 0000000000000006 R09: ffff880167377d00
[  130.114694] R10: 0000000000001000 R11: 0000000000000001 R12: 00000000fffffffb
[  130.122656] R13: ffff8804709be300 R14: 0000000000000002 R15: ffff880471bccb40
[  130.130619] FS:  0000000000000000(0000) GS:ffff880277c40000(0000) knlGS:0000000000000000
[  130.139647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  130.146058] CR2: 00007f77f827ef78 CR3: 0000000384a19000 CR4: 00000000001406e0
[  130.154018] Call Trace:
[  130.156750]  blk_mq_check_expired+0x76/0x80
[  130.161417]  bt_iter+0x45/0x50
[  130.164823]  blk_mq_queue_tag_busy_iter+0xdd/0x1f0
[  130.170170]  ? blk_mq_rq_timed_out+0x70/0x70
[  130.174933]  ? blk_mq_rq_timed_out+0x70/0x70
[  130.179698]  ? __switch_to+0x140/0x450
[  130.183879]  blk_mq_timeout_work+0x88/0x170
[  130.188549]  process_one_work+0x165/0x410
[  130.193014]  worker_thread+0x137/0x4c0
[  130.197195]  kthread+0x101/0x140
[  130.200794]  ? rescuer_thread+0x3b0/0x3b0
[  130.205265]  ? kthread_park+0x90/0x90
[  130.209353]  ret_from_fork+0x2c/0x40
[  130.213340] Code: 48 85 c0 74 0d 44 89 e6 48 89 df ff d0 5b 41 5c 5d c3 48 8b bb 70 01 00 00 48 85 ff 75 0f 48 89 df e8 5d f0 ff ff 5b 41 5c 5d c3 <0f> 0b e8 51 f0 ff ff 90 eb e9 0f 1f 40 00 66 2e 0f 1f 84 00 00
[  130.234425] RIP: blk_mq_end_request+0x58/0x70 RSP: ffffc900028c3d50
[  130.241453] ---[ end trace 735162105b943c01 ]---


2. BUG: unable to handle kernel NULL pointer
   Full log: http://pastebin.com/FAPL4tH4

[  311.069298] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[  311.078048] IP: nvme_queue_rq+0x6e6/0x8cd [nvme]
[  311.083197] PGD 4720a9067
[  311.083198] PUD 470e88067
[  311.086213] PMD 0
[  311.089230]
[  311.093132] Oops: 0000 [#1] SMP
[  311.096634] Modules linked in: vfat fat intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp ipmi_ssif coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore iTCO_wdt iTCO_vendor_support mxm_wmi intel_rapl_perf dcdbas pcspkr mei_me sg ipmi_si lpc_ich ipmi_devintf mei ipmi_msghandler shpchp acpi_power_meter wmi nfsd auth_rpcgss nfs_acl lockd dm_multipath grace sunrpc ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci libata tg3 nvme crc32c_intel nvme_core megaraid_sas i2c_core ptp fjes pps_core dm_mirror dm_region_hash dm_log dm_mod
[  311.163881] CPU: 8 PID: 3569 Comm: fio Not tainted 4.10.0-rc8 #1
[  311.170582] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.2.5 09/06/2016
[  311.179125] task: ffff88027134ad00 task.stack: ffffc90003ce8000
[  311.185730] RIP: 0010:nvme_queue_rq+0x6e6/0x8cd [nvme]
[  311.191462] RSP: 0018:ffffc90003ceb7e0 EFLAGS: 00010246
[  311.197291] RAX: 0000000000000000 RBX: ffff880472847680 RCX: 0000000000001000
[  311.205252] RDX: 0000000000000fff RSI: 00000003ca676000 RDI: ffff8804714d01d0
[  311.213212] RBP: ffffc90003ceb8c0 R08: 0000000000002000 R09: 0000000000001000
[  311.221173] R10: 0000000000001000 R11: 0000000000000000 R12: ffff88047298f800
[  311.229134] R13: 0000000000000040 R14: ffff880471864f80 R15: ffff8804714d0000
[  311.237096] FS:  00007f9b83453700(0000) GS:ffff880277d00000(0000) knlGS:0000000000000000
[  311.246125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  311.252536] CR2: 0000000000000010 CR3: 000000047182b000 CR4: 00000000001406e0
[  311.260497] Call Trace:
[  311.263229]  ? __sbitmap_queue_get+0x2b/0xa0
[  311.267995]  ? remove_wait_queue+0x60/0x60
[  311.272564]  blk_mq_try_issue_directly+0x7e/0x100
[  311.277811]  blk_mq_make_request+0x39b/0x430
[  311.282574]  generic_make_request+0x103/0x1d0
[  311.287433]  submit_bio+0x75/0x150
[  311.291230]  submit_bh_wbc+0x141/0x180
[  311.295411]  __block_write_full_page+0x13d/0x3b0
[  311.300563]  ? I_BDEV+0x20/0x20
[  311.304065]  ? I_BDEV+0x20/0x20
[  311.307567]  block_write_full_page+0xe5/0x110
[  311.312427]  blkdev_writepage+0x18/0x20
[  311.316708]  __writepage+0x13/0x40
[  311.320504]  write_cache_pages+0x26f/0x510
[  311.325072]  ? compound_head+0x20/0x20
[  311.329254]  generic_writepages+0x51/0x80
[  311.333728]  blkdev_writepages+0x2f/0x40
[  311.338104]  do_writepages+0x1e/0x30
[  311.342090]  __filemap_fdatawrite_range+0xc6/0x100
[  311.347434]  filemap_write_and_wait+0x3d/0x80
[  311.352295]  __sync_blockdev+0x1f/0x40
[  311.356476]  __blkdev_put+0x74/0x290
[  311.360463]  blkdev_put+0x4c/0x120
[  311.364257]  blkdev_close+0x25/0x30
[  311.368149]  __fput+0xe7/0x210
[  311.371555]  ____fput+0xe/0x10
[  311.374963]  task_work_run+0x83/0xb0
[  311.378952]  exit_to_usermode_loop+0x66/0x92
[  311.383716]  do_syscall_64+0x165/0x180
[  311.387899]  entry_SYSCALL64_slow_path+0x25/0x25
[  311.393050] RIP: 0033:0x7f9b9e4a54fd
[  311.397035] RSP: 002b:00007f9b83452c40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  311.405482] RAX: 0000000000000000 RBX: 00007f9b9ccb1890 RCX: 00007f9b9e4a54fd
[  311.413443] RDX: 00007f9b9f3ee000 RSI: 0000000000000080 RDI: 0000000000000034
[  311.421404] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000df1
[  311.429365] R10: 6e493d726f727265 R11: 0000000000000293 R12: 0000000000000000
[  311.437326] R13: 00007f9b87e3fc00 R14: 0000000000000000 R15: 00007f9b87e4d0c0
[  311.445287] Code: 8b bd 70 ff ff ff 89 95 50 ff ff ff 89 8d 58 ff ff ff 44 89 95 60 ff ff ff e8 c7 f6 2c e1 8b 95 50 ff ff ff 48 89 85 68 ff ff ff <4c> 8b 48 10 44 8b 58 18 8b 8d 58 ff ff ff 44 8b 95 60 ff ff ff
[  311.466366] RIP: nvme_queue_rq+0x6e6/0x8cd [nvme] RSP: ffffc90003ceb7e0
[  311.473745] CR2: 0000000000000010
[  311.477466] ---[ end trace e734cece2a2f4159 ]---

3. WARNING: CPU: 8 PID: 3565 at lib/list_debug.c:28 __list_add_valid+0x91/0xa0
   Full log: http://pastebin.com/9Tn59pLh

[  391.631349] WARNING: CPU: 8 PID: 3565 at lib/list_debug.c:28 __list_add_valid+0x91/0xa0
[  391.640294] list_add corruption. prev->next should be next (ffffc90003bb7ab0), but was ffff880471c84800. (prev=ffff880471c84800).
[  391.653304] Modules linked in: vfat fat intel_rapl sb_edac edac_core ipmi_ssif x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mei_me iTCO_wdt intel_cstate iTCO_vendor_support intel_uncore mei mxm_wmi dcdbas intel_rapl_perf lpc_ich sg pcspkr ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter shpchp wmi nfsd auth_rpcgss nfs_acl lockd grace sunrpc dm_multipath ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci libata tg3 crc32c_intel nvme nvme_core megaraid_sas ptp i2c_core fjes pps_core dm_mirror dm_region_hash dm_log dm_mod
[  391.720572] CPU: 8 PID: 3565 Comm: main.sh Not tainted 4.10.0-rc8 #1
[  391.727660] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.2.5 09/06/2016
[  391.736203] Call Trace:
[  391.738933]  dump_stack+0x63/0x87
[  391.742622]  __warn+0xd1/0xf0
[  391.745929]  warn_slowpath_fmt+0x5f/0x80
[  391.750306]  __list_add_valid+0x91/0xa0
[  391.754585]  blk_mq_make_request+0x36a/0x430
[  391.759348]  generic_make_request+0x103/0x1d0
[  391.764207]  submit_bio+0x75/0x150
[  391.768001]  submit_bh_wbc+0x141/0x180
[  391.772182]  __block_write_full_page+0x13d/0x3b0
[  391.777332]  ? I_BDEV+0x20/0x20
[  391.780834]  ? I_BDEV+0x20/0x20
[  391.784336]  block_write_full_page+0xe5/0x110
[  391.789197]  blkdev_writepage+0x18/0x20
[  391.793478]  __writepage+0x13/0x40
[  391.797271]  write_cache_pages+0x26f/0x510
[  391.801838]  ? compound_head+0x20/0x20
[  391.806021]  generic_writepages+0x51/0x80
[  391.810492]  blkdev_writepages+0x2f/0x40
[  391.814868]  do_writepages+0x1e/0x30
[  391.818854]  __filemap_fdatawrite_range+0xc6/0x100
[  391.824198]  filemap_write_and_wait+0x3d/0x80
[  391.829058]  __sync_blockdev+0x1f/0x40
[  391.833239]  fsync_bdev+0x44/0x50
[  391.836938]  invalidate_partition+0x24/0x50
[  391.841603]  del_gendisk+0xce/0x290
[  391.845496]  nvme_ns_remove+0x6a/0xd0 [nvme_core]
[  391.850744]  nvme_remove_namespaces+0x32/0x50 [nvme_core]
[  391.856768]  nvme_uninit_ctrl+0x2d/0xa0 [nvme_core]
[  391.862211]  nvme_remove+0x5d/0x130 [nvme]
[  391.866782]  pci_device_remove+0x39/0xc0
[  391.871161]  device_release_driver_internal+0x141/0x1f0
[  391.876989]  device_release_driver+0x12/0x20
[  391.881751]  pci_stop_bus_device+0x8c/0xa0
[  391.886319]  pci_stop_and_remove_bus_device_locked+0x1a/0x30
[  391.892634]  remove_store+0x7c/0x90
[  391.896524]  dev_attr_store+0x18/0x30
[  391.900610]  sysfs_kf_write+0x3a/0x50
[  391.904693]  kernfs_fop_write+0xfc/0x180
[  391.909071]  __vfs_write+0x37/0x160
[  391.912962]  ? selinux_file_permission+0xe5/0x120
[  391.918209]  ? security_file_permission+0x3b/0xc0
[  391.923457]  vfs_write+0xb2/0x1b0
[  391.927155]  ? syscall_trace_enter+0x1d0/0x2b0
[  391.932113]  SyS_write+0x55/0xc0
[  391.935712]  do_syscall_64+0x67/0x180
[  391.939799]  entry_SYSCALL64_slow_path+0x25/0x25
[  391.944948] RIP: 0033:0x7fc64e087c60
[  391.948933] RSP: 002b:00007ffdc3b8c6b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  391.957378] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc64e087c60
[  391.965339] RDX: 0000000000000002 RSI: 00007fc64e9a4000 RDI: 0000000000000001
[  391.973299] RBP: 00007fc64e9a4000 R08: 000000000000000a R09: 00007fc64e99f740
[  391.981260] R10: 0000000000000001 R11: 0000000000000246 R12: 00007fc64e35a400
[  391.989220] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[  391.997191] ---[ end trace 14051aa2857ac86e ]---

4. WARNING: CPU: 9 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x103/0x130
   Full log: http://pastebin.com/sLmaVMcN

[  558.703723] WARNING: CPU: 9 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x103/0x130
[  558.714618] percpu ref (blk_queue_usage_counter_release) <= 0 (-1) after switching to atomic
[  558.714619] Modules linked in: vfat fat ipmi_ssif intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass iTCO_wdt crct10dif_pclmul crc32_pclmul iTCO_vendor_support ghash_clmulni_intel mxm_wmi mei_me dcdbas intel_cstate mei ipmi_si pcspkr intel_uncore intel_rapl_perf sg ipmi_devintf lpc_ich ipmi_msghandler wmi acpi_power_meter shpchp nfsd auth_rpcgss nfs_acl lockd dm_multipath grace sunrpc ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm crc32c_intel ahci libahci nvme libata nvme_core tg3 megaraid_sas i2c_core ptp fjes pps_core dm_mirror dm_region_hash dm_log dm_mod
[  558.791297] CPU: 9 PID: 0 Comm: swapper/9 Not tainted 4.10.0-rc8 #1
[  558.798291] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.2.5 09/06/2016
[  558.806835] Call Trace:
[  558.809563]  <IRQ>
[  558.811814]  dump_stack+0x63/0x87
[  558.815514]  __warn+0xd1/0xf0
[  558.818825]  warn_slowpath_fmt+0x5f/0x80
[  558.823208]  ? blk_put_queue+0x20/0x20
[  558.827395]  percpu_ref_switch_to_atomic_rcu+0x103/0x130
[  558.833332]  rcu_process_callbacks+0x20b/0x5d0
[  558.838297]  __do_softirq+0xd1/0x2a2
[  558.842293]  irq_exit+0xe9/0x100
[  558.845896]  smp_apic_timer_interrupt+0x3d/0x50
[  558.850954]  apic_timer_interrupt+0x93/0xa0
[  558.855618] RIP: 0010:cpuidle_enter_state+0xe4/0x260
[  558.861159] RSP: 0018:ffffc9000014fe68 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
[  558.869600] RAX: ffff88047fd18f80 RBX: ffff88047fd21200 RCX: 000000000000001f
[  558.877564] RDX: 0000000000000000 RSI: ffff88047fd16658 RDI: 0000000000000000
[  558.885528] RBP: ffffc9000014fea0 R08: 0000000000000001 R09: cccccccccccccccd
[  558.893491] R10: 0000000000002686 R11: 0000000000000008 R12: 0000000000000004
[  558.901456] R13: 0000000000000009 R14: ffffffff81ce2a20 R15: 00000082146f083e
[  558.909422]  </IRQ>
[  558.911764]  ? cpuidle_enter_state+0xc0/0x260
[  558.916626]  cpuidle_enter+0x17/0x20
[  558.920617]  call_cpuidle+0x23/0x40
[  558.924510]  do_idle+0x172/0x200
[  558.928110]  cpu_startup_entry+0x71/0x80
[  558.932491]  start_secondary+0x154/0x190
[  558.936869]  start_cpu+0x14/0x14
[  558.940477] ---[ end trace 52811962d031d1f1 ]---

Best Regards,
  Yi Zhang
