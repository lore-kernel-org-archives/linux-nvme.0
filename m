From: yizhan@redhat.com (Yi Zhang)
Date: Tue, 26 Sep 2017 03:18:38 -0400 (EDT)
Subject: nvme_fc: nvme disconnect -n lead to kernel NULL pointer
In-Reply-To: <1772232658.9746292.1506407665826.JavaMail.zimbra@redhat.com>
Message-ID: <1545275004.9749092.1506410318764.JavaMail.zimbra@redhat.com>

Hello

Does nvme disconnect support for nvme_fc? I tried the cmd[1] on host after setup the nvme fc, NULL pointer observed.

[1]
nvme disconnect -n fctest1

Environment:
HW:
# lspci | grep -i emulex
04:00.0 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
04:00.1 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
Topology: Point to Point
Firmware version:
# cat /sys/class/scsi_host/host11/fwrev 
11.2.216.9, sli-4:2:c

Host side log:
[  749.408489] nvme nvme0: NVME-FC{0}: new ctrl: NQN "fctest1"
[ 1172.863401] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 1172.863851] lpfc 0000:04:00.0: 0:(0):6072 NVME Completion Error: xri 115 status x3 result x2100016 placed x0
[ 1172.883123] IP: __list_add_valid+0x4/0x80
[ 1172.887593] PGD 0 P4D 0 
[ 1172.890417] Oops: 0000 [#1] SMP
[ 1172.893916] Modules linked in: ipmi_ssif intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate mei_me intel_uncore id
[ 1172.957741] CPU: 9 PID: 557 Comm: kworker/u32:7 Not tainted 4.14.0-rc2 #1
[ 1172.965312] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
[ 1172.973663] Workqueue: nvme-wq nvme_fc_delete_ctrl_work [nvme_fc]
[ 1172.980459] task: ffff8808551e0000 task.stack: ffffc90003bec000
[ 1172.987062] RIP: 0010:__list_add_valid+0x4/0x80
[ 1172.992113] RSP: 0018:ffffc90003befd88 EFLAGS: 00010046
[ 1172.997942] RAX: 0000000000000000 RBX: ffff88085579f1b8 RCX: 0000000000000000
[ 1173.005901] RDX: 0000000000000000 RSI: ffff88085579f1c0 RDI: ffffc90003befe00
[ 1173.013861] RBP: ffffc90003befdd8 R08: ffff88085579f1c0 R09: ffff880850099380
[ 1173.021822] R10: 0000000000000068 R11: 0000000000000246 R12: ffffc90003befde8
[ 1173.029782] R13: ffffc90003befe00 R14: 0000000000000092 R15: 0000000000000002
[ 1173.037743] FS:  0000000000000000(0000) GS:ffff88085f440000(0000) knlGS:0000000000000000
[ 1173.046769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1173.053178] CR2: 0000000000000008 CR3: 0000000855d1b006 CR4: 00000000003606e0
[ 1173.061139] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1173.069099] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1173.077058] Call Trace:
[ 1173.079785]  ? prepare_to_wait_event+0xf2/0x150
[ 1173.084837]  nvme_fc_delete_association+0x1b6/0x280 [nvme_fc]
[ 1173.091247]  ? remove_wait_queue+0x60/0x60
[ 1173.095814]  nvme_fc_delete_ctrl_work+0x4a/0x60 [nvme_fc]
[ 1173.101838]  process_one_work+0x149/0x360
[ 1173.106309]  worker_thread+0x4d/0x3c0
[ 1173.110391]  kthread+0x109/0x140
[ 1173.113989]  ? rescuer_thread+0x380/0x380
[ 1173.118458]  ? kthread_park+0x60/0x60
[ 1173.122540]  ret_from_fork+0x25/0x30
[ 1173.126525] Code: 63 e7 ff ff 48 89 df e8 6b 8d e7 ff b8 f4 ff ff ff e9 3b ff ff ff b8 f4 ff ff ff e9 31 ff ff ff 90 90 90 90 90 90 90 55 48 89 d0 <48> 8b 52 08 48 89 e5 48 39 f2 75 19 48 8b 32 48 39 f0 75 4 
[ 1173.147593] RIP: __list_add_valid+0x4/0x80 RSP: ffffc90003befd88
[ 1173.154291] CR2: 0000000000000008
[ 1173.157989] ---[ end trace 34a1c0a64a72faf4 ]---
[ 1173.166300] Kernel panic - not syncing: Fatal exception
[ 1174.213366] Shutting down cpus with NMI
[ 1174.217651] Kernel Offset: disabled
[ 1174.225058] ---[ end Kernel panic - not syncing: Fatal exception
[ 1174.231770] ------------[ cut here ]------------
[ 1174.236922] WARNING: CPU: 9 PID: 557 at kernel/sched/core.c:1179 set_task_cpu+0x191/0x1a0
[ 1174.246045] Modules linked in: ipmi_ssif intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate mei_me intel_uncore id
[ 1174.309886] CPU: 9 PID: 557 Comm: kworker/u32:7 Tainted: G      D         4.14.0-rc2 #1
[ 1174.318817] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
[ 1174.327168] Workqueue: nvme-wq nvme_fc_delete_ctrl_work [nvme_fc]
[ 1174.333965] task: ffff8808551e0000 task.stack: ffffc90003bec000
[ 1174.340569] RIP: 0010:set_task_cpu+0x191/0x1a0
[ 1174.345524] RSP: 0018:ffff88085f443c38 EFLAGS: 00010046
[ 1174.351353] RAX: 0000000000000100 RBX: ffff88018bdd8000 RCX: 0000000000000001
[ 1174.359313] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88018bdd8000
[ 1174.367273] RBP: ffff88085f443c58 R08: 0000000000000000 R09: 0000000000000000
[ 1174.375233] R10: 0000000000000005 R11: 0000000000000559 R12: ffff88018bdd8bac
[ 1174.383193] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000001b900
[ 1174.391153] FS:  0000000000000000(0000) GS:ffff88085f440000(0000) knlGS:0000000000000000
[ 1174.400181] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1174.406589] CR2: 0000000000000008 CR3: 0000000855d1b006 CR4: 00000000003606e0
[ 1174.414549] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1174.422509] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1174.430469] Call Trace:
[ 1174.433195]  <IRQ>
[ 1174.435435]  try_to_wake_up+0x166/0x470
[ 1174.439714]  ? account_entity_enqueue+0xd8/0x100
[ 1174.444862]  default_wake_function+0x12/0x20
[ 1174.449625]  __wake_up_common+0x8a/0x160
[ 1174.453998]  __wake_up_locked+0x16/0x20
[ 1174.458276]  ep_poll_callback+0xd0/0x300
[ 1174.462651]  ? check_preempt_curr+0x79/0x90
[ 1174.467315]  __wake_up_common+0x8a/0x160
[ 1174.471687]  __wake_up_common_lock+0x7e/0xc0
[ 1174.476448]  __wake_up+0x13/0x20
[ 1174.480046]  wake_up_klogd_work_func+0x40/0x60
[ 1174.485003]  irq_work_run_list+0x4d/0x70
[ 1174.489378]  ? tick_sched_do_timer+0x70/0x70
[ 1174.494139]  irq_work_tick+0x40/0x50
[ 1174.498127]  update_process_times+0x42/0x60
[ 1174.502791]  tick_sched_handle+0x2d/0x60
[ 1174.507164]  tick_sched_timer+0x39/0x70
[ 1174.511440]  __hrtimer_run_queues+0xe5/0x230
[ 1174.516202]  hrtimer_interrupt+0xa8/0x1a0
[ 1174.520675]  smp_apic_timer_interrupt+0x5f/0x130
[ 1174.525824]  apic_timer_interrupt+0x9d/0xb0
[ 1174.530487]  </IRQ>
[ 1174.532828] RIP: 0010:panic+0x1fd/0x245
[ 1174.537104] RSP: 0018:ffffc90003befac8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
[ 1174.545548] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000006
[ 1174.553508] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff88085f44e030
[ 1174.561468] RBP: ffffc90003befb38 R08: 00000000fffffffe R09: 000000000000055a
[ 1174.569428] R10: 0000000000000005 R11: 0000000000000559 R12: ffffffff81a39e28
[ 1174.577388] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[ 1174.585349]  ? panic+0x1f6/0x245
[ 1174.588950]  oops_end+0xb8/0xd0
[ 1174.592451]  no_context+0x19e/0x3f0
[ 1174.596340]  __bad_area_nosemaphore+0xee/0x1d0
[ 1174.601296]  bad_area_nosemaphore+0x14/0x20
[ 1174.605961]  __do_page_fault+0x89/0x4a0
[ 1174.610237]  ? schedule_timeout+0x1dd/0x300
[ 1174.614900]  ? wake_up_process+0x15/0x20
[ 1174.619274]  do_page_fault+0x38/0x130
[ 1174.623355]  page_fault+0x22/0x30
[ 1174.627051] RIP: 0010:__list_add_valid+0x4/0x80
[ 1174.632103] RSP: 0018:ffffc90003befd88 EFLAGS: 00010046
[ 1174.637931] RAX: 0000000000000000 RBX: ffff88085579f1b8 RCX: 0000000000000000
[ 1174.645891] RDX: 0000000000000000 RSI: ffff88085579f1c0 RDI: ffffc90003befe00
[ 1174.653851] RBP: ffffc90003befdd8 R08: ffff88085579f1c0 R09: ffff880850099380
[ 1174.661810] R10: 0000000000000068 R11: 0000000000000246 R12: ffffc90003befde8
[ 1174.669770] R13: ffffc90003befe00 R14: 0000000000000092 R15: 0000000000000002
[ 1174.677732]  ? prepare_to_wait_event+0xf2/0x150
[ 1174.682785]  nvme_fc_delete_association+0x1b6/0x280 [nvme_fc]
[ 1174.689194]  ? remove_wait_queue+0x60/0x60
[ 1174.693762]  nvme_fc_delete_ctrl_work+0x4a/0x60 [nvme_fc]
[ 1174.699784]  process_one_work+0x149/0x360
[ 1174.704253]  worker_thread+0x4d/0x3c0
[ 1174.708338]  kthread+0x109/0x140
[ 1174.711936]  ? rescuer_thread+0x380/0x380
[ 1174.716406]  ? kthread_park+0x60/0x60
[ 1174.720489]  ret_from_fork+0x25/0x30
[ 1174.724476] Code: ff 80 8b ac 08 00 00 04 e9 23 ff ff ff 0f ff e9 bf fe ff ff f7 83 84 00 00 00 fd ff ff ff 0f 84 c9 fe ff ff 0f ff e9 c2 fe ff ff <0f> ff e9 d1 fe ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 0 
[ 1174.745549] ---[ end trace 34a1c0a64a72faf5 ]---
[ 1174.750701] sched: Unexpected reschedule of offline CPU#0!
[ 1174.756821] ------------[ cut here ]------------
[ 1174.761971] WARNING: CPU: 9 PID: 557 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x3c/0x40
[ 1174.772354] Modules linked in: ipmi_ssif intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate mei_me intel_uncore id
[ 1174.836184] CPU: 9 PID: 557 Comm: kworker/u32:7 Tainted: G      D W       4.14.0-rc2 #1
[ 1174.845113] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
[ 1174.853461] Workqueue: nvme-wq nvme_fc_delete_ctrl_work [nvme_fc]
[ 1174.860258] task: ffff8808551e0000 task.stack: ffffc90003bec000
[ 1174.866863] RIP: 0010:native_smp_send_reschedule+0x3c/0x40
[ 1174.872979] RSP: 0018:ffff88085f443bc0 EFLAGS: 00010046
[ 1174.878807] RAX: 000000000000002e RBX: 0000000000000000 RCX: 0000000000000006
[ 1174.886767] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff88085f44e030
[ 1174.894727] RBP: ffff88085f443bc0 R08: 00000000fffffffe R09: 00000000000005aa
[ 1174.902687] R10: 0000000000000005 R11: 00000000000005a9 R12: ffff88085f21b900
[ 1174.910647] R13: ffff88018bdd8000 R14: ffff88085f443c78 R15: ffff88085f21b900
[ 1174.918607] FS:  0000000000000000(0000) GS:ffff88085f440000(0000) knlGS:0000000000000000
[ 1174.927634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1174.934042] CR2: 0000000000000008 CR3: 0000000855d1b006 CR4: 00000000003606e0
[ 1174.942002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1174.949961] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1174.957921] Call Trace:
[ 1174.960645]  <IRQ>
[ 1174.962887]  resched_curr+0xa1/0xc0
[ 1174.966776]  check_preempt_curr+0x79/0x90
[ 1174.971247]  ttwu_do_wakeup+0x1e/0x160
[ 1174.975428]  ttwu_do_activate+0x7a/0x90
[ 1174.979704]  try_to_wake_up+0x1e1/0x470
[ 1174.983981]  default_wake_function+0x12/0x20
[ 1174.988743]  __wake_up_common+0x8a/0x160
[ 1174.993116]  __wake_up_locked+0x16/0x20
[ 1174.997393]  ep_poll_callback+0xd0/0x300
[ 1175.001767]  ? check_preempt_curr+0x79/0x90
[ 1175.006432]  __wake_up_common+0x8a/0x160
[ 1175.010806]  __wake_up_common_lock+0x7e/0xc0
[ 1175.015567]  __wake_up+0x13/0x20
[ 1175.019165]  wake_up_klogd_work_func+0x40/0x60
[ 1175.024121]  irq_work_run_list+0x4d/0x70
[ 1175.028495]  ? tick_sched_do_timer+0x70/0x70
[ 1175.033256]  irq_work_tick+0x40/0x50
[ 1175.037242]  update_process_times+0x42/0x60
[ 1175.041907]  tick_sched_handle+0x2d/0x60
[ 1175.046280]  tick_sched_timer+0x39/0x70
[ 1175.050557]  __hrtimer_run_queues+0xe5/0x230
[ 1175.055319]  hrtimer_interrupt+0xa8/0x1a0
[ 1175.059789]  smp_apic_timer_interrupt+0x5f/0x130
[ 1175.064938]  apic_timer_interrupt+0x9d/0xb0
[ 1175.069602]  </IRQ>
[ 1175.071940] RIP: 0010:panic+0x1fd/0x245
[ 1175.076216] RSP: 0018:ffffc90003befac8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
[ 1175.084660] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000006
[ 1175.092620] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff88085f44e030
[ 1175.100580] RBP: ffffc90003befb38 R08: 00000000fffffffe R09: 000000000000055a
[ 1175.108539] R10: 0000000000000005 R11: 0000000000000559 R12: ffffffff81a39e28
[ 1175.116499] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[ 1175.124461]  ? panic+0x1f6/0x245
[ 1175.128059]  oops_end+0xb8/0xd0
[ 1175.131560]  no_context+0x19e/0x3f0
[ 1175.135450]  __bad_area_nosemaphore+0xee/0x1d0
[ 1175.140407]  bad_area_nosemaphore+0x14/0x20
[ 1175.145072]  __do_page_fault+0x89/0x4a0
[ 1175.149348]  ? schedule_timeout+0x1dd/0x300
[ 1175.154012]  ? wake_up_process+0x15/0x20
[ 1175.158386]  do_page_fault+0x38/0x130
[ 1175.162468]  page_fault+0x22/0x30
[ 1175.166161] RIP: 0010:__list_add_valid+0x4/0x80
[ 1175.171213] RSP: 0018:ffffc90003befd88 EFLAGS: 00010046
[ 1175.177041] RAX: 0000000000000000 RBX: ffff88085579f1b8 RCX: 0000000000000000
[ 1175.185000] RDX: 0000000000000000 RSI: ffff88085579f1c0 RDI: ffffc90003befe00
[ 1175.192960] RBP: ffffc90003befdd8 R08: ffff88085579f1c0 R09: ffff880850099380
[ 1175.200920] R10: 0000000000000068 R11: 0000000000000246 R12: ffffc90003befde8
[ 1175.208880] R13: ffffc90003befe00 R14: 0000000000000092 R15: 0000000000000002
[ 1175.216842]  ? prepare_to_wait_event+0xf2/0x150
[ 1175.221895]  nvme_fc_delete_association+0x1b6/0x280 [nvme_fc]
[ 1175.228304]  ? remove_wait_queue+0x60/0x60
[ 1175.232870]  nvme_fc_delete_ctrl_work+0x4a/0x60 [nvme_fc]
[ 1175.238891]  process_one_work+0x149/0x360
[ 1175.243361]  worker_thread+0x4d/0x3c0
[ 1175.247443]  kthread+0x109/0x140
[ 1175.251040]  ? rescuer_thread+0x380/0x380
[ 1175.255510]  ? kthread_park+0x60/0x60
[ 1175.259592]  ret_from_fork+0x25/0x30
[ 1175.263576] Code: dc 00 0f 92 c0 84 c0 74 14 48 8b 05 2f 29 ab 00 be fd 00 00 00 ff 90 a0 00 00 00 5d c3 89 fe 48 c7 c7 a8 0d a4 81 e8 47 fc 0b 00 <0f> ff 5d c3 0f 1f 44 00 00 55 48 89 e5 48 83 ec 20 65 48 8 
[ 1175.284641] ---[ end trace 34a1c0a64a72faf6 ]---


gdb /lib/modules/4.14.0-rc2/kernel/drivers/nvme/host/nvme-fc.ko 
GNU gdb (GDB) Red Hat Enterprise Linux 7.6.1-100.el7
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /usr/lib/modules/4.14.0-rc2/kernel/drivers/nvme/host/nvme-fc.ko...done.
(gdb) l *(nvme_fc_delete_association+0x1b6)
0x2956 is in nvme_fc_delete_association (drivers/nvme/host/fc.c:2548).
2543		/* kill the aens as they are a separate path */
2544		nvme_fc_abort_aen_ops(ctrl);
2545	
2546		/* wait for all io that had to be aborted */
2547		spin_lock_irqsave(&ctrl->lock, flags);
2548		wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
2549		ctrl->flags &= ~FCCTRL_TERMIO;
2550		spin_unlock_irqrestore(&ctrl->lock, flags);
2551	
2552		nvme_fc_term_aen_ops(ctrl);
(gdb) 

Best Regards,
  Yi Zhang
