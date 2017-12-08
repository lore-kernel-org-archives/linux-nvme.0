From: yi.zhang@redhat.com (Yi Zhang)
Date: Fri, 8 Dec 2017 02:24:29 -0500 (EST)
Subject: BUG: NULL pointer at IP: blk_mq_map_swqueue+0xbc/0x200 on 4.15.0-rc2
In-Reply-To: <799322399.34367785.1512659684033.JavaMail.zimbra@redhat.com>
Message-ID: <1443577037.35143768.1512717869183.JavaMail.zimbra@redhat.com>

Hi 
I found this issue during nvme blk-mq io scheduler test on 4.15.0-rc2, let me know if you need more info, thanks.

Reproduce steps
MQ_IOSCHEDS=`sed 's/[][]//g' /sys/block/nvme0n1/queue/scheduler
dd if=/dev/nvme0n1p1 of=/dev/null bs=4096 &
while kill -0 $! 2>/dev/null; do
	for SCHEDULER in $MQ_IOSCHEDS; do
		echo "INFO: BLK-MQ IO SCHEDULER:$SCHEDULER testing during IO"
		echo $SCHEDULER > /sys/block/nvme0n1/queue/scheduler
		echo 1 >/sys/bus/pci/devices/0000\:84\:00.0/reset
		sleep 0.5
	done
done

Kernel log:
[  101.202734] BUG: unable to handle kernel NULL pointer dereference at 0000000094d3013f
[  101.211487] IP: blk_mq_map_swqueue+0xbc/0x200
[  101.216346] PGD 0 P4D 0 
[  101.219171] Oops: 0000 [#1] SMP
[  101.222674] Modules linked in: sunrpc ipmi_ssif vfat fat intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore mxm_wmi intel_rapl_perf iTCO_wdt ipmi_si ipmi_devintf pcspkr iTCO_vendor_support sg dcdbas ipmi_msghandler wmi mei_me lpc_ich shpchp mei acpi_power_meter dm_multipath ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci crc32c_intel libata tg3 nvme nvme_core megaraid_sas ptp i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
[  101.284881] CPU: 0 PID: 504 Comm: kworker/u25:5 Not tainted 4.15.0-rc2 #1
[  101.292455] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
[  101.301001] Workqueue: nvme-wq nvme_reset_work [nvme]
[  101.306636] task: 00000000f2c53190 task.stack: 000000002da874f9
[  101.313241] RIP: 0010:blk_mq_map_swqueue+0xbc/0x200
[  101.318681] RSP: 0018:ffffc9000234fd70 EFLAGS: 00010282
[  101.324511] RAX: ffff88047ffc9480 RBX: ffff88047e130850 RCX: 0000000000000000
[  101.332471] RDX: ffffe8ffffd40580 RSI: ffff88047e509b40 RDI: ffff88046f37a008
[  101.340432] RBP: 000000000000000b R08: ffff88046f37a008 R09: 0000000011f94280
[  101.348392] R10: ffff88047ffd4d00 R11: 0000000000000000 R12: ffff88046f37a008
[  101.356353] R13: ffff88047e130f38 R14: 000000000000000b R15: ffff88046f37a558
[  101.364314] FS:  0000000000000000(0000) GS:ffff880277c00000(0000) knlGS:0000000000000000
[  101.373342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.379753] CR2: 0000000000000098 CR3: 000000047f409004 CR4: 00000000001606f0
[  101.387714] Call Trace:
[  101.390445]  blk_mq_update_nr_hw_queues+0xbf/0x130
[  101.395791]  nvme_reset_work+0x6f4/0xc06 [nvme]
[  101.400848]  ? pick_next_task_fair+0x290/0x5f0
[  101.405807]  ? __switch_to+0x1f5/0x430
[  101.409988]  ? put_prev_entity+0x2f/0xd0
[  101.414365]  process_one_work+0x141/0x340
[  101.418836]  worker_thread+0x47/0x3e0
[  101.422921]  kthread+0xf5/0x130
[  101.426424]  ? rescuer_thread+0x380/0x380
[  101.430896]  ? kthread_associate_blkcg+0x90/0x90
[  101.436048]  ret_from_fork+0x1f/0x30
[  101.440034] Code: 48 83 3c ca 00 0f 84 2b 01 00 00 48 63 cd 48 8b 93 10 01 00 00 8b 0c 88 48 8b 83 20 01 00 00 4a 03 14 f5 60 04 af 81 48 8b 0c c8 <48> 8b 81 98 00 00 00 f0 4c 0f ab 30 8b 81 f8 00 00 00 89 42 44 
[  101.461116] RIP: blk_mq_map_swqueue+0xbc/0x200 RSP: ffffc9000234fd70
[  101.468205] CR2: 0000000000000098
[  101.471907] ---[ end trace 5fe710f98228a3ca ]---
[  101.482489] Kernel panic - not syncing: Fatal exception
[  101.488505] Kernel Offset: disabled
[  101.497752] ---[ end Kernel panic - not syncing: Fatal exception
[  101.504491] ------------[ cut here ]------------
[  101.509641] sched: Unexpected reschedule of offline CPU#1!
[  101.515773] WARNING: CPU: 0 PID: 504 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x36/0x40
[  101.526157] Modules linked in: sunrpc ipmi_ssif vfat fat intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore mxm_wmi intel_rapl_perf iTCO_wdt ipmi_si ipmi_devintf pcspkr iTCO_vendor_support sg dcdbas ipmi_msghandler wmi mei_me lpc_ich shpchp mei acpi_power_meter dm_multipath ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci crc32c_intel libata tg3 nvme nvme_core megaraid_sas ptp i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
[  101.588366] CPU: 0 PID: 504 Comm: kworker/u25:5 Tainted: G      D          4.15.0-rc2 #1
[  101.597395] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
[  101.605942] Workqueue: nvme-wq nvme_reset_work [nvme]
[  101.611578] task: 00000000f2c53190 task.stack: 000000002da874f9
[  101.618182] RIP: 0010:native_smp_send_reschedule+0x36/0x40
[  101.624301] RSP: 0018:ffff880277c03ed0 EFLAGS: 00010086
[  101.630130] RAX: 0000000000000000 RBX: ffff880277c1b640 RCX: 0000000000000006
[  101.638091] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff880277c0e050
[  101.646051] RBP: ffff880277c1b640 R08: 0000000000000000 R09: 0000000000000637
[  101.654012] R10: 0000000000000000 R11: ffff880277c03c38 R12: 0000000000000000
[  101.661973] R13: ffff880271680000 R14: 0000000000000001 R15: ffff880277c14240
[  101.669934] FS:  0000000000000000(0000) GS:ffff880277c00000(0000) knlGS:0000000000000000
[  101.678962] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.685373] CR2: 0000000000000098 CR3: 000000047f409004 CR4: 00000000001606f0
[  101.693334] Call Trace:
[  101.696062]  <IRQ>
[  101.698307]  scheduler_tick+0xa4/0xd0
[  101.702390]  ? tick_sched_do_timer+0x60/0x60
[  101.707153]  update_process_times+0x40/0x50
[  101.711820]  tick_sched_handle+0x26/0x60
[  101.716196]  tick_sched_timer+0x34/0x70
[  101.720474]  __hrtimer_run_queues+0xdc/0x220
[  101.725237]  hrtimer_interrupt+0x99/0x190
[  101.729715]  smp_apic_timer_interrupt+0x56/0x120
[  101.734868]  apic_timer_interrupt+0x96/0xa0
[  101.739532]  </IRQ>
[  101.741872] RIP: 0010:panic+0x1fa/0x23c
[  101.746150] RSP: 0018:ffffc9000234fb30 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff11
[  101.754597] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000006
[  101.762558] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff880277c0e050
[  101.770518] RBP: ffffc9000234fba0 R08: 0000000000000000 R09: 0000000000000635
[  101.778479] R10: 0000000000000000 R11: ffffc9000234f8a0 R12: ffffffff81a3e998
[  101.786439] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[  101.794405]  oops_end+0xaf/0xc0
[  101.797911]  no_context+0x1a9/0x3f0
[  101.801793]  __do_page_fault+0x97/0x4d0
[  101.806073]  do_page_fault+0x33/0x120
[  101.810158]  page_fault+0x22/0x30
[  101.813859] RIP: 0010:blk_mq_map_swqueue+0xbc/0x200
[  101.819299] RSP: 0018:ffffc9000234fd70 EFLAGS: 00010282
[  101.825128] RAX: ffff88047ffc9480 RBX: ffff88047e130850 RCX: 0000000000000000
[  101.833089] RDX: ffffe8ffffd40580 RSI: ffff88047e509b40 RDI: ffff88046f37a008
[  101.841050] RBP: 000000000000000b R08: ffff88046f37a008 R09: 0000000011f94280
[  101.849010] R10: ffff88047ffd4d00 R11: 0000000000000000 R12: ffff88046f37a008
[  101.856971] R13: ffff88047e130f38 R14: 000000000000000b R15: ffff88046f37a558
[  101.864935]  blk_mq_update_nr_hw_queues+0xbf/0x130
[  101.870281]  nvme_reset_work+0x6f4/0xc06 [nvme]
[  101.875337]  ? pick_next_task_fair+0x290/0x5f0
[  101.880297]  ? __switch_to+0x1f5/0x430
[  101.884478]  ? put_prev_entity+0x2f/0xd0
[  101.888854]  process_one_work+0x141/0x340
[  101.893328]  worker_thread+0x47/0x3e0
[  101.897412]  kthread+0xf5/0x130
[  101.900915]  ? rescuer_thread+0x380/0x380
[  101.905387]  ? kthread_associate_blkcg+0x90/0x90
[  101.910538]  ret_from_fork+0x1f/0x30
[  101.914524] Code: d1 67 dc 00 0f 92 c0 84 c0 74 12 48 8b 05 63 a1 ab 00 be fd 00 00 00 48 8b 40 30 ff e0 89 fe 48 c7 c7 10 5a a4 81 e8 4a d5 05 00 <0f> ff c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 83 ec 20 65 48 
[  101.935597] ---[ end trace 5fe710f98228a3cb ]---

Best Regards,
  Yi Zhang
