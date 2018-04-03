From: mr.nuke.me@gmail.com (Alex G.)
Date: Tue, 3 Apr 2018 12:46:34 -0500
Subject: nvme_free_ns_head: ida_remove called for id=1 which is not allocated
Message-ID: <6fe0bfff-0ca3-a752-6faa-3d36796977e0@gmail.com>

Hi Keith,

I noticed a new and interesting error. While it's ominous, it doesn't
seem to cause any ill side-effects. This is reproduced with
firmware-first error handling, so I'm not sure if it's even an issue of
concern to nvme_core. Log files attached

Alex
-------------- next part --------------
log-20180403-1225.log-:: Tue Apr  3 12:30:24 2018 :: <function wait at 0x7f9c92a75950>
log-20180403-1225.log-[  526.819882] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Up
log-20180403-1225.log-[  526.819960] pciehp 0000:b0:06.0:pcie204: Slot(176): No adapter
log-20180403-1225.log-[  526.837514] pciehp 0000:b0:05.0:pcie204: Slot(179): Link Up
log-20180403-1225.log-[  526.837594] pciehp 0000:b0:05.0:pcie204: Slot(179): No adapter
log-20180403-1225.log-[  527.219918] pciehp 0000:b0:05.0:pcie204: Slot(179): Card present
log-20180403-1225.log-[  527.220079] pciehp 0000:b0:06.0:pcie204: Slot(176): Card present
log-20180403-1225.log-[  527.323064] pci 0000:b3:00.0: [8086:0a55] type 00 class 0x010802
log-20180403-1225.log-[  527.323106] pci 0000:b3:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
log-20180403-1225.log-[  527.323152] pci 0000:b3:00.0: Max Payload Size set to 256 (was 128, max 512)
log-20180403-1225.log-[  527.323158] pci 0000:b3:00.0: enabling Extended Tags
log-20180403-1225.log-[  527.323702] pcieport 0000:b0:06.0: bridge window [io  0x1000-0x0fff] to [bus b3] add_size 1000
log-20180403-1225.log-[  527.323711] pcieport 0000:b0:06.0: BAR 13: no space for [io  size 0x1000]
log-20180403-1225.log-[  527.323714] pcieport 0000:b0:06.0: BAR 13: failed to assign [io  size 0x1000]
log-20180403-1225.log-[  527.323718] pcieport 0000:b0:06.0: BAR 13: no space for [io  size 0x1000]
log-20180403-1225.log-[  527.323721] pcieport 0000:b0:06.0: BAR 13: failed to assign [io  size 0x1000]
log-20180403-1225.log-[  527.323728] pci 0000:b3:00.0: BAR 0: assigned [mem 0xe1200000-0xe1203fff 64bit]
log-20180403-1225.log-[  527.323742] pcieport 0000:b0:06.0: PCI bridge to [bus b3]
log-20180403-1225.log-[  527.323749] pcieport 0000:b0:06.0:   bridge window [mem 0xe1200000-0xe12fffff]
log-20180403-1225.log-[  527.323755] pcieport 0000:b0:06.0:   bridge window [mem 0x386000400000-0x3860005fffff 64bit pref]
log-20180403-1225.log-[  527.324761] nvme nvme2: pci function 0000:b3:00.0
log-20180403-1225.log-[  527.324838] nvme 0000:b3:00.0: enabling device (0000 -> 0002)
log-20180403-1225.log-[  527.324904] pci 0000:b2:00.0: [144d:a822] type 00 class 0x010802
log-20180403-1225.log-[  527.324954] pci 0000:b2:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
log-20180403-1225.log-[  527.325020] pci 0000:b2:00.0: Max Payload Size set to 256 (was 128, max 256)
log-20180403-1225.log-[  527.325587] pcieport 0000:b0:05.0: bridge window [io  0x1000-0x0fff] to [bus b2] add_size 1000
--
log-20180403-1225.log-[  568.675052] print_req_error: I/O error, dev nvme0n1, sector 2634112
log-20180403-1225.log-[  568.675112] md/raid1:mdX: Disk failure on dm-4, disabling device.
log-20180403-1225.log-               md/raid1:mdX: Operation continuing on 1 devices.
log-20180403-1225.log-[  568.675153] md: mdX: recovery interrupted.
log-20180403-1225.log-[  568.681330] print_req_error: I/O error, dev nvme0n1, sector 2628096
log-20180403-1225.log-[  568.687616] print_req_error: I/O error, dev nvme0n1, sector 2634240
log-20180403-1225.log-[  568.693860] print_req_error: I/O error, dev nvme0n1, sector 2628608
log-20180403-1225.log-[  568.698133] pciehp 0000:b0:06.0:pcie204: Slot(176): Link Up
log-20180403-1225.log-[  568.705594] print_req_error: I/O error, dev nvme0n1, sector 2634496
log-20180403-1225.log-[  568.711858] print_req_error: I/O error, dev nvme0n1, sector 2629760
log-20180403-1225.log-[  568.718139] print_req_error: I/O error, dev nvme0n1, sector 2634624
log-20180403-1225.log-[  568.724415] print_req_error: I/O error, dev nvme0n1, sector 2629632
log-20180403-1225.log-[  569.037621] block nvme2n1: no path available - requeuing I/O
log-20180403-1225.log-[  569.077516] block nvme2n1: no path - failing I/O
log-20180403-1225.log-[  569.077604] block nvme2n1: no path - failing I/O
log-20180403-1225.log-[  569.077625] block nvme2n1: no path - failing I/O
log-20180403-1225.log-[  569.077642] block nvme2n1: no path - failing I/O
log-20180403-1225.log-[  569.096601] ------------[ cut here ]------------
log-20180403-1225.log-[  569.096603] ida_remove called for id=1 which is not allocated.
log-20180403-1225.log-[  569.096642] WARNING: CPU: 19 PID: 3519 at lib/idr.c:521 ida_remove+0x7d/0x120
log-20180403-1225.log-[  569.096644] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables sunrpc dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor vfat fat raid6_pq libcrc32c intel_rapl skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore intel_rapl_perf joydev ipmi_ssif raid1 iTCO_wdt iTCO_vendor_support ipmi_si dcdbas pcspkr mei_me lpc_ich
log-20180403-1225.log-[  569.096722]  mei shpchp i2c_i801 ipmi_devintf ipmi_msghandler acpi_power_meter mgag200 i2c_algo_bit drm_kms_helper ttm tg3 nvme ptp drm crc32c_intel nvme_core megaraid_sas pps_core
log-20180403-1225.log-[  569.096747] CPU: 19 PID: 3519 Comm: dmeventd Tainted: G        W        4.16.0-rc7+ #29
log-20180403-1225.log-[  569.096749] Hardware name: Dell Inc. PowerEdge R740xd/07X9K0, BIOS 1.4.4 03/09/2018
log-20180403-1225.log-[  569.096755] RIP: 0010:ida_remove+0x7d/0x120
log-20180403-1225.log-[  569.096757] RSP: 0018:ffffa4e286ccbd88 EFLAGS: 00010086
log-20180403-1225.log-[  569.096760] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000006
log-20180403-1225.log-[  569.096762] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff936e2f0568f0
log-20180403-1225.log-[  569.096764] RBP: 0000000000000001 R08: 0000000000000bfd R09: 0000000000000004
log-20180403-1225.log-[  569.096766] R10: 0000000000000100 R11: 0000000000000001 R12: ffff936e25de6c60
log-20180403-1225.log-[  569.096768] R13: ffff936e247b3dd8 R14: ffff936e25de3800 R15: ffff936e2500cb80
log-20180403-1225.log-[  569.096771] FS:  00007f36fc182700(0000) GS:ffff936e2f040000(0000) knlGS:0000000000000000
log-20180403-1225.log-[  569.096773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
log-20180403-1225.log-[  569.096776] CR2: 00005613bd1123f0 CR3: 000000045ef08002 CR4: 00000000007606e0
log-20180403-1225.log-[  569.096778] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
log-20180403-1225.log-[  569.096780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
log-20180403-1225.log-[  569.096781] PKRU: 55555554
log-20180403-1225.log-[  569.096783] Call Trace:
log-20180403-1225.log-[  569.096794]  ida_simple_remove+0x26/0x40
log-20180403-1225.log-[  569.096806]  ls+0x35/0x70 [nvme_core]
log-20180403-1225.log-[  569.096817]  __blkdev_put+0x180/0x1d0
log-20180403-1225.log-[  569.096822]  blkdev_close+0x21/0x30
log-20180403-1225.log-[  569.096829]  __fput+0xd0/0x1e0
log-20180403-1225.log-[  569.096837]  task_work_run+0x84/0xa0
log-20180403-1225.log-[  569.096845]  exit_to_usermode_loop+0x9e/0xa0
log-20180403-1225.log-[  569.096851]  do_syscall_64+0x173/0x180
log-20180403-1225.log-[  569.096858]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
log-20180403-1225.log-[  569.096862] RIP: 0033:0x7f36fb85870c
log-20180403-1225.log-[  569.096864] RSP: 002b:00007f36fc181150 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
log-20180403-1225.log-[  569.096867] RAX: 0000000000000000 RBX: 00007f36f401e778 RCX: 00007f36fb85870c
log-20180403-1225.log-[  569.096869] RDX: 0000000000000000 RSI: 00007f36fc181120 RDI: 0000000000000008
log-20180403-1225.log-[  569.096871] RBP: 0000000000001000 R08: 0000000000000000 R09: 00007f36fa17d34b
log-20180403-1225.log-[  569.096873] R10: 00007f36fbaa4080 R11: 0000000000000293 R12: 0000000000000003
log-20180403-1225.log-[  569.096875] R13: 0000000000000000 R14: 0000000000000000 R15: 00007f36fc1811ac
log-20180403-1225.log-[  569.096877] Code: 74 1b 4c 8b 28 49 89 c6 4c 89 e8 4d 89 ef 83 e0 03 0f 85 88 00 00 00 49 0f a3 1f 72 33 89 ee 48 c7 c7 90 eb 14 9d e8 a3 83 81 ff <0f> 0b 48 8b 44 24 30 65 48 33 04 25 28 00 00 00 0f 85 81 00 00
log-20180403-1225.log-[  569.096942] ---[ end trace a64ed6e35d883d67 ]---
log-20180403-1225.log-[  569.119629] pci 0000:b3:00.0: [8086:0a55] type 00 class 0x010802
log-20180403-1225.log-[  569.119672] pci 0000:b3:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
log-20180403-1225.log-[  569.119704] pci 0000:b3:00.0: Max Payload Size set to 256 (was 128, max 512)
log-20180403-1225.log-[  569.119707] pci 0000:b3:00.0: enabling Extended Tags
log-20180403-1225.log-[  569.120030] pcieport 0000:b0:06.0: bridge window [io  0x1000-0x0fff] to [bus b3] add_size 1000
log-20180403-1225.log-[  569.120034] pcieport 0000:b0:06.0: BAR 13: no space for [io  size 0x1000]
log-20180403-1225.log-[  569.120036] pcieport 0000:b0:06.0: BAR 13: failed to assign [io  size 0x1000]
log-20180403-1225.log-[  569.120038] pcieport 0000:b0:06.0: BAR 13: no space for [io  size 0x1000]
log-20180403-1225.log-[  569.120039] pcieport 0000:b0:06.0: BAR 13: failed to assign [io  size 0x1000]
log-20180403-1225.log-[  569.120043] pci 0000:b3:00.0: BAR 0: assigned [mem 0xe1200000-0xe1203fff 64bit]
log-20180403-1225.log-[  569.120052] pcieport 0000:b0:06.0: PCI bridge to [bus b3]
log-20180403-1225.log-[  569.120055] pcieport 0000:b0:06.0:   bridge window [mem 0xe1200000-0xe12fffff]
log-20180403-1225.log-[  569.120058] pcieport 0000:b0:06.0:   bridge window [mem 0x386000400000-0x3860005fffff 64bit pref]
log-20180403-1225.log-[  569.120765] nvme nvme1: pci function 0000:b3:00.0
log-20180403-1225.log-[  569.120787] nvme 0000:b3:00.0: enabling device (0400 -> 0402)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: log-20180403-1225.log
Type: text/x-log
Size: 226443 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180403/10186f62/attachment-0001.bin>
