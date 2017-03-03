From: yizhan@redhat.com (Yi Zhang)
Date: Fri, 3 Mar 2017 06:07:45 -0500 (EST)
Subject: kernel NULL pointer on nvmet with stress
 rescan_controller/reset_controller test during I/O
In-Reply-To: <1812676221.31125946.1488532731118.JavaMail.zimbra@redhat.com>
Message-ID: <1855135937.31179102.1488539265795.JavaMail.zimbra@redhat.com>

Hi

I always can reproduce this issue during stress test on rescan_controller/reset_controller, could you help check it, thanks.

Reproduce steps on Initiator side:
#fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60 &
#num=0
while [ $num -lt 200 ]
do
        echo "-------------------------------$num"
        echo 1 >/sys/block/nvme0n1/device/rescan_controller || exit 1
        echo 1 >/sys/block/nvme0n1/device/reset_controller || exit 1
        ((num++))
done

Below is the target and initiator side log:
Target side:
[12371.564337] nvmet: creating controller 193 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:20617bbf-0d74-4f3f-9f24-1b67f70c55a7.
[12371.602790] nvmet: adding queue 1 to ctrl 193.
[12371.602950] nvmet: adding queue 2 to ctrl 193.
[12371.603103] nvmet: adding queue 3 to ctrl 193.
[12371.603257] nvmet: adding queue 4 to ctrl 193.
[12371.603406] nvmet: adding queue 5 to ctrl 193.
[12371.617946] nvmet: adding queue 6 to ctrl 193.
[12371.618190] nvmet: adding queue 7 to ctrl 193.
[12371.618310] nvmet: adding queue 8 to ctrl 193.
[12371.618498] nvmet: adding queue 9 to ctrl 193.
[12371.618680] nvmet: adding queue 10 to ctrl 193.
[12371.635947] nvmet: adding queue 11 to ctrl 193.
[12371.636170] nvmet: adding queue 12 to ctrl 193.
[12371.636424] nvmet: adding queue 13 to ctrl 193.
[12371.636652] nvmet: adding queue 14 to ctrl 193.
[12371.636865] nvmet: adding queue 15 to ctrl 193.
[12371.637075] nvmet: adding queue 16 to ctrl 193.
[12371.686241] BUG: unable to handle kernel NULL pointer dereference at 00000000000000b8
[12371.686247] IP: _raw_spin_lock_irqsave+0x22/0x40
[12371.686248] PGD 0 
[12371.686248] 
[12371.686250] Oops: 0002 [#1] SMP
[12371.686251] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter null_blk nvme_rdma nvme_fabrics nvme_core nvmet_rdma nvmet bridge stp llc rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm mlx4_ib dm_mirror dm_region_hash ib_core dm_log dm_mod intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate ipmi_si intel_uncore ipmi_devintf iTCO_wdt
[12371.686281]  intel_rapl_perf hpwdt iTCO_vendor_support ipmi_msghandler wmi pcspkr acpi_power_meter hpilo sg lpc_ich ioatdma shpchp pcc_cpufreq acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs mlx4_en sr_mod sd_mod cdrom mgag200 drm_kms_helper ata_generic syscopyarea sysfillrect pata_acpi sysimgblt igb fb_sys_fops bnx2x ttm ata_piix dca mdio ptp drm i2c_algo_bit mlx4_core libata serio_raw hpsa i2c_core pps_core devlink fjes libcrc32c scsi_transport_sas crc32c_intel
[12371.686310] CPU: 5 PID: 19629 Comm: kworker/u132:3 Not tainted 4.10.0 #2
[12371.686319] Hardware name: HP ProLiant DL388p Gen8, BIOS P70 12/20/2013
[12371.686332] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[12371.686333] task: ffff88042cca9680 task.stack: ffffc9002b11c000
[12371.686334] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
[12371.686335] RSP: 0018:ffffc9002b11fd98 EFLAGS: 00010046
[12371.686336] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000001
[12371.686336] RDX: 0000000000000001 RSI: ffff8806aa040238 RDI: 00000000000000b8
[12371.686337] RBP: ffffc9002b11fda0 R08: ffff8806aa040460 R09: ffff88017dd40000
[12371.686338] R10: 0000000000000007 R11: 0000000000030e54 R12: ffff8806b44cec00
[12371.686338] R13: ffff8806b44cec28 R14: ffff8806aa034080 R15: ffff8806b44cecb8
[12371.686339] FS:  0000000000000000(0000) GS:ffff88042f740000(0000) knlGS:0000000000000000
[12371.686340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12371.686340] CR2: 00000000000000b8 CR3: 0000000001c09000 CR4: 00000000000406e0
[12371.686341] Call Trace:
[12371.686345]  nvmet_rdma_recv_done+0x1a0/0x200 [nvmet_rdma]
[12371.686350]  __ib_process_cq+0x50/0xd0 [ib_core]
[12371.686353]  ib_cq_poll_work+0x20/0x60 [ib_core]
[12371.686355]  process_one_work+0x165/0x410
[12371.686356]  worker_thread+0x137/0x4c0
[12371.686357]  kthread+0x101/0x140
[12371.686359]  ? rescuer_thread+0x3b0/0x3b0
[12371.686359]  ? kthread_park+0x90/0x90
[12371.686361]  ret_from_fork+0x2c/0x40
[12371.686361] Code: 06 9a ff eb f3 0f 1f 40 00 66 66 66 66 90 55 48 89 e5 53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00 <f0> 0f b1 17 85 c0 75 06 48 89 d8 5b 5d c3 89 c6 e8 39 51 a6 ff 
[12371.686374] RIP: _raw_spin_lock_irqsave+0x22/0x40 RSP: ffffc9002b11fd98
[12371.686374] CR2: 00000000000000b8
[12371.689248] ---[ end trace 07b27de8a6c49569 ]---
[12371.708073] ERST: [Firmware Warn]: Firmware does not respond in time.
[12371.742894] Kernel panic - not syncing: Fatal exception
[12371.751233] Kernel Offset: disabled
[12438.114552] ---[ end Kernel panic - not syncing: Fatal exception
[12438.141480] ------------[ cut here ]------------
[12438.162224] WARNING: CPU: 5 PID: 19629 at arch/x86/kernel/smp.c:127 native_smp_send_reschedule+0x3f/0x50
[12438.204888] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter null_blk nvme_rdma nvme_fabrics nvme_core nvmet_rdma nvmet bridge stp llc rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm mlx4_ib dm_mirror dm_region_hash ib_core dm_log dm_mod intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate ipmi_si intel_uncore ipmi_devintf iTCO_wdt
[12438.529532]  intel_rapl_perf hpwdt iTCO_vendor_support ipmi_msghandler wmi pcspkr acpi_power_meter hpilo sg lpc_ich ioatdma shpchp pcc_cpufreq acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs mlx4_en sr_mod sd_mod cdrom mgag200 drm_kms_helper ata_generic syscopyarea sysfillrect pata_acpi sysimgblt igb fb_sys_fops bnx2x ttm ata_piix dca mdio ptp drm i2c_algo_bit mlx4_core libata serio_raw hpsa i2c_core pps_core devlink fjes libcrc32c scsi_transport_sas crc32c_intel
[12438.723453] CPU: 5 PID: 19629 Comm: kworker/u132:3 Tainted: G      D         4.10.0 #2
[12438.759616] Hardware name: HP ProLiant DL388p Gen8, BIOS P70 12/20/2013
[12438.791883] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[12438.819467] Call Trace:
[12438.830788]  <IRQ>
[12438.840287]  dump_stack+0x63/0x87
[12438.855816]  __warn+0xd1/0xf0
[12438.869671]  warn_slowpath_null+0x1d/0x20
[12438.888622]  native_smp_send_reschedule+0x3f/0x50
[12438.911055]  try_to_wake_up+0x328/0x3b0
[12438.929060]  default_wake_function+0x12/0x20
[12438.948584]  __wake_up_common+0x55/0x90
[12438.966966]  __wake_up_locked+0x13/0x20
[12438.984833]  ep_poll_callback+0xbb/0x240
[12439.003668]  __wake_up_common+0x55/0x90
[12439.023065]  __wake_up+0x39/0x50
[12439.040044]  wake_up_klogd_work_func+0x40/0x60
[12439.061090]  irq_work_run_list+0x4d/0x70
[12439.079370]  ? tick_sched_do_timer+0x70/0x70
[12439.099361]  irq_work_tick+0x40/0x50
[12439.116018]  update_process_times+0x42/0x60
[12439.135473]  tick_sched_handle.isra.18+0x25/0x60
[12439.157389]  tick_sched_timer+0x3d/0x70
[12439.176435]  __hrtimer_run_queues+0xf3/0x280
[12439.196709]  hrtimer_interrupt+0xa8/0x1a0
[12439.215624]  local_apic_timer_interrupt+0x35/0x60
[12439.237541]  smp_apic_timer_interrupt+0x38/0x50
[12439.258912]  apic_timer_interrupt+0x93/0xa0
[12439.278617] RIP: 0010:panic+0x1f5/0x239
[12439.296791] RSP: 0018:ffffc9002b11fae0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
[12439.332334] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000006
[12439.365124] RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffff88042f74e000
[12439.398652] RBP: ffffc9002b11fb50 R08: 00000000fffffffe R09: 0000000000018a62
[12439.432470] R10: 0000000000000005 R11: 0000000000018a61 R12: ffffffff81a0e2e1
[12439.466139] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[12439.500128]  </IRQ>
[12439.510297]  oops_end+0xb8/0xd0
[12439.526269]  no_context+0x19e/0x3f0
[12439.544015]  ? ttwu_do_activate+0x6f/0x80
[12439.564146]  __bad_area_nosemaphore+0xee/0x1d0
[12439.584925]  bad_area_nosemaphore+0x14/0x20
[12439.604484]  __do_page_fault+0x89/0x4a0
[12439.622314]  ? select_idle_sibling+0x2c/0x3d0
[12439.642611]  do_page_fault+0x30/0x80
[12439.659456]  page_fault+0x28/0x30
[12439.674637] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
[12439.698817] RSP: 0018:ffffc9002b11fd98 EFLAGS: 00010046
[12439.723316] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000001
[12439.756925] RDX: 0000000000000001 RSI: ffff8806aa040238 RDI: 00000000000000b8
[12439.790525] RBP: ffffc9002b11fda0 R08: ffff8806aa040460 R09: ffff88017dd40000
[12439.824069] R10: 0000000000000007 R11: 0000000000030e54 R12: ffff8806b44cec00
[12439.857738] R13: ffff8806b44cec28 R14: ffff8806aa034080 R15: ffff8806b44cecb8
[12439.891415]  nvmet_rdma_recv_done+0x1a0/0x200 [nvmet_rdma]
[12439.917301]  __ib_process_cq+0x50/0xd0 [ib_core]
[12439.939047]  ib_cq_poll_work+0x20/0x60 [ib_core]
[12439.960639]  process_one_work+0x165/0x410
[12439.979425]  worker_thread+0x137/0x4c0
[12439.997095]  kthread+0x101/0x140
[12440.012220]  ? rescuer_thread+0x3b0/0x3b0
[12440.032131]  ? kthread_park+0x90/0x90
[12440.051089]  ret_from_fork+0x2c/0x40
[12440.070058] ---[ end trace 07b27de8a6c4956a ]---
[12440.091660] ------------[ cut here ]------------

Initiator side:
[   49.556434] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.2.3:1023
[   49.682422] nvme nvme0: creating 16 I/O queues.
[   50.138898] nvme nvme0: new ctrl: NQN "nvme-subsystem-name", addr 172.31.2.3:1023
[   52.750778] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   52.889863] Ebtables v2.0 registered
[   53.559385] tun: Universal TUN/TAP device driver, 1.6
[   53.584985] tun: (C) 1999-2004 Max Krasnyansky <maxk at qualcomm.com>
[   53.759401] virbr0: port 1(virbr0-nic) entered blocking state
[   53.786547] virbr0: port 1(virbr0-nic) entered disabled state
[   53.813900] device virbr0-nic entered promiscuous mode
[   54.274843] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   54.510283] virbr0: port 1(virbr0-nic) entered blocking state
[   54.537437] virbr0: port 1(virbr0-nic) entered listening state
[   54.716241] virbr0: port 1(virbr0-nic) entered disabled state
[  367.712478] nvme nvme0: Property Set error: 7, offset 0x14
[  368.752506] nvme nvme0: rdma_resolve_addr wait failed (-104).
[  368.783162] nvme nvme0: Removing after reset failure





Best Regards,
  Yi Zhang
