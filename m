From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Wed, 21 Nov 2018 18:21:49 +0000
Subject: Should I submit bugs against RC kernels?
Message-ID: <af0de79e5ac94be7ad4594fdace103d7@ausx13mps321.AMER.DELL.COM>

Hi,

I'm not sure if submitting bugs against RC is a good idea. I am seeing 
more issues with SURPRISE!!! removal of drives under v4.20-rc3.

Alex

APPENDIX A: Example issue

[ 1042.415286] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down
[ 1042.415346] pciehp 0000:b0:05.0:pcie204: Slot(179): Link Down
[ 1042.415431] pciehp 0000:3c:07.0:pcie204: Slot(181): Link Down
[ 1042.447734] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000000
[ 1042.455586] PGD 0 P4D 0
[ 1042.458135] Oops: 0000 [#1] SMP PTI
[ 1042.461625] CPU: 5 PID: 622 Comm: irq/44-pciehp Not tainted 
4.20.0-rc3+ #66
[ 1042.468582] Hardware name: Dell Inc. PowerEdge R740xd/07X9K0, BIOS 
1.4.5 [HPX test BIOS 2] 03/30/2018
[ 1042.477801] RIP: 0010:sbitmap_any_bit_set+0xb/0x40
[ 1042.482586] Code: c8 83 c2 01 45 89 ca 4c 89 54 01 08 48 8b 4f 10 2b 
74 01 08 39 57 08 77 d8 c3 0f 1f 44 00 00 8b 57 08 85 d2 74 2a 48 8b 47 
10 <48> 83 38 00 75 23 83 ea 01 48 83 c0 40 48 c1 e2 06 48 01 c2 eb 0b
[ 1042.501341] RSP: 0018:ffffbb1ec8f6bc90 EFLAGS: 00010206
[ 1042.506566] RAX: 0000000000000000 RBX: ffff94409e924000 RCX: 
0000000000000000
[ 1042.513696] RDX: 000000000000000a RSI: 0000000000000000 RDI: 
ffff94409e9240d8
[ 1042.520839] RBP: 0000000000000001 R08: ffff9440aec00b68 R09: 
ffff9440aec00ca0
[ 1042.527971] R10: 0000000000000000 R11: ffffffffb624a418 R12: 
0000000000000001
[ 1042.535102] R13: ffffffffc00f60d0 R14: 0000000000000060 R15: 
ffff9440a2deca80
[ 1042.542236] FS:  0000000000000000(0000) GS:ffff9444af280000(0000) 
knlGS:0000000000000000
[ 1042.550318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1042.556066] CR2: 0000000000000000 CR3: 00000005f420a003 CR4: 
00000000007606e0
[ 1042.563199] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1042.570329] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1042.577462] PKRU: 55555554
[ 1042.580176] Call Trace:
[ 1042.582631]  blk_mq_run_hw_queue+0xdd/0x120
[ 1042.586815]  blk_mq_run_hw_queues+0x3a/0x50
[ 1042.591006]  nvme_kill_queues+0x26/0x50 [nvme_core]
[ 1042.595888]  nvme_remove_namespaces+0xbf/0xd0 [nvme_core]
[ 1042.601295]  nvme_remove+0x60/0x170 [nvme]
[ 1042.605395]  pci_device_remove+0x3b/0xc0
[ 1042.609329]  device_release_driver_internal+0x180/0x240
[ 1042.614555]  pci_stop_bus_device+0x69/0x90
[ 1042.618652]  pci_stop_and_remove_bus_device+0xe/0x20
[ 1042.623620]  pciehp_unconfigure_device+0x84/0x140
[ 1042.628324]  pciehp_disable_slot+0x67/0x110
[ 1042.632512]  pciehp_handle_presence_or_link_change+0xd8/0x400
[ 1042.638264]  ? __synchronize_hardirq+0x43/0x50
[ 1042.642709]  pciehp_ist+0x1bb/0x1c0
[ 1042.646201]  ? irq_forced_thread_fn+0x70/0x70
[ 1042.650559]  irq_thread_fn+0x1f/0x60
[ 1042.654140]  irq_thread+0xf3/0x190
[ 1042.657554]  ? irq_thread_fn+0x60/0x60
[ 1042.661306]  ? irq_thread_check_affinity.part.45+0x80/0x80
[ 1042.666802]  kthread+0x112/0x130
[ 1042.670036]  ? kthread_park+0x80/0x80
[ 1042.673709]  ret_from_fork+0x35/0x40
[ 1042.677286] Modules linked in: xt_CHECKSUM ipt_MASQUERADE tun 
ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink 
ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 
nf_nat nf_conntrack devlink nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle 
iptable_raw iptable_security ebtable_filter ebtables ip6table_filter 
ip6_tables vfat fat sunrpc intel_rapl skx_edac nfit x86_pkg_temp_thermal 
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore 
intel_rapl_perf iTCO_wdt iTCO_vendor_support dcdbas pcc_cpufreq ses 
joydev enclosure pcspkr mei_me ioatdma mei dca lpc_ich i2c_i801 
ipmi_si(+) ipmi_devintf ipmi_msghandler acpi_power_meter raid1 dm_raid 
raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor 
async_tx raid6_pq mgag200 i2c_algo_bit drm_kms_helper mpt3sas ttm nvme 
raid_class drm crc32c_intel nvme_core uas
[ 1042.677321]  scsi_transport_sas usb_storage tg3
[ 1042.768888] CR2: 0000000000000000
[ 1042.772207] ---[ end trace fba458b21588ceca ]---
[ 1042.820816] RIP: 0010:sbitmap_any_bit_set+0xb/0x40
[ 1042.825613] Code: c8 83 c2 01 45 89 ca 4c 89 54 01 08 48 8b 4f 10 2b 
74 01 08 39 57 08 77 d8 c3 0f 1f 44 00 00 8b 57 08 85 d2 74 2a 48 8b 47 
10 <48> 83 38 00 75 23 83 ea 01 48 83 c0 40 48 c1 e2 06 48 01 c2 eb 0b
[ 1042.844358] RSP: 0018:ffffbb1ec8f6bc90 EFLAGS: 00010206
[ 1042.849608] RAX: 0000000000000000 RBX: ffff94409e924000 RCX: 
0000000000000000
[ 1042.856739] RDX: 000000000000000a RSI: 0000000000000000 RDI: 
ffff94409e9240d8
[ 1042.863872] RBP: 0000000000000001 R08: ffff9440aec00b68 R09: 
ffff9440aec00ca0
[ 1042.871003] R10: 0000000000000000 R11: ffffffffb624a418 R12: 
0000000000000001
[ 1042.878136] R13: ffffffffc00f60d0 R14: 0000000000000060 R15: 
ffff9440a2deca80
[ 1042.885269] FS:  0000000000000000(0000) GS:ffff9444af280000(0000) 
knlGS:0000000000000000
[ 1042.893352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1042.899102] CR2: 0000000000000000 CR3: 00000005f420a003 CR4: 
00000000007606e0
[ 1042.906241] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1042.913372] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1042.920505] PKRU: 55555554
