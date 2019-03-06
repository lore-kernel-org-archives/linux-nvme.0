From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Wed, 6 Mar 2019 18:48:28 +0000
Subject: Interesting 'list _add double add' with nvme drives
Message-ID: <e15de0114ffc415899aadc2d0aae418b@ausx13mps317.AMER.DELL.COM>

Hi,

I'm seeing a list error when we take away, then add back a bunch of nvme 
drives. It's not very easy to repro, and the one surviving log is pasted 
below.

Alex


[  111.808900] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down
[  117.496424] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up
[  117.508144] pciehp 0000:3c:06.0:pcie204: Slot(180): Link Up
[  117.521525] pciehp 0000:b0:05.0:pcie204: Slot(179): Link Up
[  117.764856] pci 0000:3f:00.0: [144d:a822] type 00 class 0x010802
[  117.764897] pci 0000:3f:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  117.764948] pci 0000:3f:00.0: Max Payload Size set to 256 (was 128,
max 256)
[  117.765671] pcieport 0000:3c:06.0: bridge window [io  0x1000-0x0fff]
to [bus 3f] add_size 1000
[  117.765679] pcieport 0000:3c:06.0: BAR 13: no space for [io  size 0x1000]
[  117.765682] pcieport 0000:3c:06.0: BAR 13: failed to assign [io  size
0x1000]
[  117.765686] pcieport 0000:3c:06.0: BAR 13: no space for [io  size 0x1000]
[  117.765689] pcieport 0000:3c:06.0: BAR 13: failed to assign [io  size
0x1000]
[  117.765696] pci 0000:3f:00.0: BAR 0: assigned [mem
0xab500000-0xab503fff 64bit]
[  117.765710] pcieport 0000:3c:06.0: PCI bridge to [bus 3f]
[  117.765717] pcieport 0000:3c:06.0:   bridge window [mem
0xab500000-0xab5fffff]
[  117.765723] pcieport 0000:3c:06.0:   bridge window [mem
0x382000400000-0x3820005fffff 64bit pref]
[  117.766944] nvme nvme2: pci function 0000:3f:00.0
[  117.767060] nvme 0000:3f:00.0: enabling device (0000 -> 0002)
[  117.780851] pci 0000:b2:00.0: [144d:a822] type 00 class 0x010802
[  117.780889] pci 0000:b2:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  117.780938] pci 0000:b2:00.0: Max Payload Size set to 256 (was 128,
max 256)
[  117.781576] pcieport 0000:b0:05.0: bridge window [io  0x1000-0x0fff]
to [bus b2] add_size 1000
[  117.781583] pcieport 0000:b0:05.0: BAR 13: no space for [io  size 0x1000]
[  117.781586] pcieport 0000:b0:05.0: BAR 13: failed to assign [io  size
0x1000]
[  117.781590] pcieport 0000:b0:05.0: BAR 13: no space for [io  size 0x1000]
[  117.781593] pcieport 0000:b0:05.0: BAR 13: failed to assign [io  size
0x1000]
[  117.781600] pci 0000:b2:00.0: BAR 0: assigned [mem
0xe1400000-0xe1403fff 64bit]
[  117.781613] pcieport 0000:b0:05.0: PCI bridge to [bus b2]
[  117.781620] pcieport 0000:b0:05.0:   bridge window [mem
0xe1400000-0xe14fffff]
[  117.781626] pcieport 0000:b0:05.0:   bridge window [mem
0x386000200000-0x3860003fffff 64bit pref]
[  117.782498] nvme nvme3: pci function 0000:b2:00.0
[  117.782530] nvme 0000:b2:00.0: enabling device (0000 -> 0002)
[  117.800846] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802
[  117.800883] pci 0000:b1:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  117.800927] pci 0000:b1:00.0: Max Payload Size set to 256 (was 128,
max 512)
[  117.800932] pci 0000:b1:00.0: enabling Extended Tags
[  117.801564] pcieport 0000:b0:04.0: bridge window [io  0x1000-0x0fff]
to [bus b1] add_size 1000
[  117.801571] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000]
[  117.801574] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size
0x1000]
[  117.801577] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000]
[  117.801580] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size
0x1000]
[  117.801587] pci 0000:b1:00.0: BAR 0: assigned [mem
0xe1500000-0xe1503fff 64bit]
[  117.801599] pcieport 0000:b0:04.0: PCI bridge to [bus b1]
[  117.801606] pcieport 0000:b0:04.0:   bridge window [mem
0xe1500000-0xe15fffff]
[  117.801612] pcieport 0000:b0:04.0:   bridge window [mem
0x386000000000-0x3860001fffff 64bit pref]
[  117.802362] nvme nvme4: pci function 0000:b1:00.0
[  117.802390] nvme 0000:b1:00.0: enabling device (0000 -> 0002)
[  117.896666] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present
[  117.896844] pciehp 0000:b0:05.0:pcie204: Slot(179): Card not present
[  117.896944] pciehp 0000:3c:06.0:pcie204: Slot(180): Card not present
[  120.225239] nvme nvme2: Shutdown timeout set to 10 seconds
[  120.225299] nvme nvme3: Shutdown timeout set to 10 seconds
[  121.336917] nvme nvme4: failed to mark controller CONNECTING
[  121.336922] nvme nvme4: Removing after probe failure status: 0
[  121.353534] pciehp 0000:b0:04.0:pcie204: Slot(178): Card present
[  121.353538] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up
[  121.368290] list_add double add: new=ffff956b64c0c658,
prev=ffff956b64c0c658, next=ffff956f6f2ddfe0.
[  121.368310] ------------[ cut here ]------------
[  121.368312] kernel BUG at lib/list_debug.c:31!
[  121.372769] invalid opcode: 0000 [#1] SMP PTI
[  121.377132] CPU: 7 PID: 628 Comm: irq/45-pciehp Not tainted 5.0.0 #216
[  121.383662] Hardware name: Dell Inc. PowerEdge R740xd/07X9K0, BIOS
1.4.4 [Recoverable-Unmask] 03/09/2018
[  121.393137] RIP: 0010:__list_add_valid+0x41/0x50
[  121.397751] Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01
00 00 00 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 50 25 12 af e8 1d 2e c9
ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 07 48 8b 57 08
[  121.416495] RSP: 0018:ffffbe9708f9bbf0 EFLAGS: 00010046
[  121.421723] RAX: 0000000000000058 RBX: ffff956f6f2ddfe0 RCX:
0000000000000000
[  121.428854] RDX: 0000000000000000 RSI: ffff956f6f2d6908 RDI:
ffff956f6f2d6908
[  121.435986] RBP: ffff956b64c0c600 R08: 000000000000087c R09:
0000000000000003
[  121.443118] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff956b64c0c658
[  121.450250] R13: 0000000000000282 R14: ffff956b64c0c658 R15:
0000000000000000
[  121.457383] FS:  0000000000000000(0000) GS:ffff956f6f2c0000(0000)
knlGS:0000000000000000
[  121.465468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  121.471212] CR2: 00007f77870ba068 CR3: 000000083389e004 CR4:
00000000007606e0
[  121.478345] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  121.485477] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  121.492610] PKRU: 55555554
[  121.495320] Call Trace:
[  121.497780]  __blk_complete_request+0x74/0x110
[  121.502222]  blk_mq_complete_request+0xb6/0x100
[  121.506759]  nvme_cancel_request+0x27/0x70 [nvme_core]
[  121.511896]  blk_mq_tagset_busy_iter+0x203/0x270
[  121.516510]  ? nvme_complete_rq+0x210/0x210 [nvme_core]
[  121.521736]  ? nvme_complete_rq+0x210/0x210 [nvme_core]
[  121.526964]  nvme_dev_disable+0xfb/0x1d0 [nvme]
[  121.531493]  nvme_remove+0x12c/0x170 [nvme]
[  121.535681]  pci_device_remove+0x3b/0xc0
[  121.539608]  device_release_driver_internal+0x183/0x240
[  121.544834]  pci_stop_bus_device+0x69/0x90
[  121.548931]  pci_stop_and_remove_bus_device+0xe/0x20
[  121.553899]  pciehp_unconfigure_device+0x84/0x140
[  121.558608]  pciehp_disable_slot+0x67/0x110
[  121.562796]  pciehp_handle_presence_or_link_change+0x25f/0x400
[  121.568630]  ? __synchronize_hardirq+0x43/0x50
[  121.573074]  pciehp_ist+0x1bb/0x1c0
[  121.576567]  ? irq_finalize_oneshot.part.43+0xe0/0xe0
[  121.581617]  irq_thread_fn+0x1f/0x60
[  121.585198]  irq_thread+0xe7/0x170
[  121.588602]  ? irq_forced_thread_fn+0x70/0x70
[  121.592963]  ? irq_thread_check_affinity+0x90/0x90
[  121.597754]  kthread+0x112/0x130
[  121.600987]  ? kthread_create_on_node+0x60/0x60
[  121.605521]  ret_from_fork+0x35/0x40
[  121.609098] Modules linked in: xt_CHECKSUM ipt_MASQUERADE tun bridge
stp llc ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack
ebtable_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat_ipv4 nf_nat devlink iptable_mangle
iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
sunrpc f2fs vfat fat intel_rapl skx_edac nfit x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm ses enclosure irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate joydev
iTCO_wdt iTCO_vendor_support ipmi_ssif dcdbas intel_uncore
intel_rapl_perf mei_me pcspkr i2c_i801 mei ioatdma lpc_ich ipmi_si
ipmi_devintf ipmi_msghandler acpi_power_meter raid1 dm_raid raid456
libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq mgag200 drm_kms_helper ttm drm mpt3sas igb nvme crc32c_intel
raid_class nvme_core uas scsi_transport_sas usb_storage
[  121.609134]  dca i2c_algo_bit
[  121.699398] ---[ end trace 8704317f268b2403 ]---
[  121.743228] RIP: 0010:__list_add_valid+0x41/0x50
[  121.747858] Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01
00 00 00 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 50 25 12 af e8 1d 2e c9
ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 07 48 8b 57 08
[  121.766601] RSP: 0018:ffffbe9708f9bbf0 EFLAGS: 00010046
[  121.771827] RAX: 0000000000000058 RBX: ffff956f6f2ddfe0 RCX:
0000000000000000
[  121.778958] RDX: 0000000000000000 RSI: ffff956f6f2d6908 RDI:
ffff956f6f2d6908
[  121.786089] RBP: ffff956b64c0c600 R08: 000000000000087c R09:
0000000000000003
[  121.793222] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff956b64c0c658
[  121.800353] R13: 0000000000000282 R14: ffff956b64c0c658 R15:
0000000000000000
[  121.807487] FS:  0000000000000000(0000) GS:ffff956f6f2c0000(0000)
knlGS:0000000000000000
[  121.815573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  121.821319] CR2: 00007f77870ba068 CR3: 000000083389e004 CR4:
00000000007606e0
[  121.828448] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  121.835583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  121.842713] PKRU: 55555554
[  121.845506] nvme nvme3: IO queues not created
[  121.849891] nvme nvme3: failed to mark controller state 2
[  121.855298] nvme nvme3: Removing after probe failure status: 0
[  124.879721] md/raid1:md126: active with 1 out of 2 mirrors
[  124.885245] md126: failed to create bitmap (-5)
