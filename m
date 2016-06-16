From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 09:53:45 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics 
Message-ID: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>

Hey Christoph and Sagi, 

We have a setup using chelsio T580s and HGST SSDs, and they crash using
nvmf-all.3 under fio load.  Have either of you seen these signatures so far?  I
think this is a regression from the pre-public code base...

The target side gets a keep-alive timeout and then Oopes:

[11436.603807] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[11436.609866] BUG: unable to handle kernel NULL pointer dereference at
0000000000000050
[11436.617764] IP: [<ffffffffa09c6dff>] nvmet_rdma_delete_ctrl+0x6f/0x100
[nvmet_rdma]
[11436.625467] PGD 0
[11436.627509] Oops: 0000 [#1] SMP
[11436.630657] Modules linked in: oprofile nvme_loop nvme_fabrics brd null_blk
nvmet_rdma nvmet nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
nfs lockd grace fscache xt_CHECKSUM iptable_mangle ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4
iptable_filter ip_tables tun bridge stp llc intel_rapl iosf_mbi sb_edac
edac_core rpcrdma x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
sunrpc ib_isert iscsi_target_mod snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_intel snd_hda_codec ib_iser libiscsi scsi_transport_iscsi ib_srpt
eeepc_wmi target_core_mod asus_wmi irqbypass crct10dif_pclmul sparse_keymap
crc32_pclmul snd_hda_core crc32c_intel rfkill ib_srp ghash_clmulni_intel
scsi_transport_srp video snd_hwdep aesni_intel snd_seq lrw gf128mul glue_helper
ablk_helper ib_ipoib cryptd snd_seq_device snd_pcm iTCO_wdt mei_me rdma_ucm
acpi_pad iTCO_vendor_support pcspkr ipmi_si mxm_wmi ib_ucm acpi_power_meter
serio_raw ipmi_msghandler ib_uverbs mei snd_timer snd shpchp soundcore i2c_i801
ib_umad wmi rdma_cm lpc_ich mfd_core ib_cm iw_cm uinput xfs libcrc32c mlx4_ib
mlx4_en iw_cxgb4 ib_core usb_storage sd_mod sr_mod cdrom ast drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm igb mlx4_core ahci libahci
ptp cxgb4 libata nvme pps_core nvme_core dca i2c_algo_bit i2c_core dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: oprofile]
[11436.763684] CPU: 0 PID: 18956 Comm: kworker/0:0 Not tainted 4.7.0-rc2+ #1
[11436.770482] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16 WS,
BIOS 3101 11/04/2015
[11436.779296] Workqueue: events nvmet_keep_alive_timer [nvmet]
[11436.784986] task: ffff880853990000 ti: ffff880806aa0000 task.ti:
ffff880806aa0000
[11436.792479] RIP: 0010:[<ffffffffa09c6dff>]  [<ffffffffa09c6dff>]
nvmet_rdma_delete_ctrl+0x6f/0x100 [nvmet_rdma]
[11436.802615] RSP: 0018:ffff880806aa3de0  EFLAGS: 00010287
[11436.807944] RAX: 0000000000000000 RBX: ffff8808527d2e00 RCX: 0000000000000001
[11436.815090] RDX: ffff8808527d2e00 RSI: ffff880804d15120 RDI: ffff880804d14720
[11436.822977] RBP: ffff880806aa3df8 R08: ffffffffa09ca000 R09: 0000000000000000
[11436.830876] R10: 0000000000000005 R11: 00000000000005af R12: ffff8808527d1f20
[11436.838797] R13: ffff8807fb44c400 R14: ffff88085fc1c200 R15: 0000000000000000
[11436.846734] FS:  0000000000000000(0000) GS:ffff88085fc00000(0000)
knlGS:0000000000000000
[11436.855638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11436.862223] CR2: 0000000000000050 CR3: 0000000001c06000 CR4: 00000000001406f0
[11436.870207] Stack:
[11436.873079]  ffff8807fb44c4c8 ffff8807fdbeb180 ffff88085fc176c0
ffff880806aa3e10
[11436.881457]  ffffffffa0a8f0c3 ffff8807fb44c4c8 ffff880806aa3e58
ffffffff8109b842
[11436.889835]  00000000fdbeb1b0 0000000000000000 ffff88085fc176e0
ffff8807fdbeb1b0
[11436.898277] Call Trace:
[11436.901663]  [<ffffffffa0a8f0c3>] nvmet_keep_alive_timer+0x33/0x40 [nvmet]
[11436.909510]  [<ffffffff8109b842>] process_one_work+0x152/0x400
[11436.916314]  [<ffffffff8109c135>] worker_thread+0x125/0x4b0
[11436.922865]  [<ffffffff8109c010>] ? rescuer_thread+0x380/0x380
[11436.929691]  [<ffffffff810a1c68>] kthread+0xd8/0xf0
[11436.935583]  [<ffffffff816b013f>] ret_from_fork+0x1f/0x40


The host side is stuck here and maybe this triggers the target keepalive timer?
This stack doesn't look like it is in the NVMF path though.  CPUs  6 and 7 are
stuck:

[ 3211.677301] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery",
addr 20.0.0.34:4420
[ 3211.679215] nvme nvme0: creating 12 I/O queues.
[ 3211.709939] nvme nvme0: new ctrl: NQN "testnqn", addr 20.0.0.34:4420
...
[11209.649435] nvme nvme0: RECV for CQE 0xffff88083da56890 failed with status WR
flushed (5)
[11209.649467] nvme nvme0: reconnecting in 10 seconds
[11210.265801] NMI watchdog: BUG: soft lockup - CPU#6 stuck for 22s! [fio:708]
[11210.265806] Modules linked in: oprofile nfsv3 nfs_acl rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache nvme_rdma nvme_fabrics
nvme nvme_core xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4
iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
nf_conntrack ipt_REJECT nf_reject_ipv4 iptable_filter ip_tables tun bridge stp
llc rpcrdma sunrpc ib_isert iscsi_target_mod ib_iser libiscsi
scsi_transport_iscsi ib_srpt target_core_mod sb_edac edac_core
x86_pkg_temp_thermal intel_powerclamp coretemp ib_srp scsi_transport_srp
ib_ipoib kvm_intel kvm rdma_ucm ib_ucm ib_uverbs snd_hda_intel snd_hda_codec
ib_umad rdma_cm snd_hda_core ib_cm iw_cm irqbypass snd_hwdep crct10dif_pclmul
crc32_pclmul snd_seq crc32c_intel ghash_clmulni_intel snd_seq_device snd_pcm
[11210.265867]  aesni_intel iTCO_wdt lrw gf128mul iTCO_vendor_support snd_timer
glue_helper snd ablk_helper cryptd mei_me lpc_ich serio_raw pcspkr mei ipmi_si
shpchp i2c_i801 soundcore mfd_core wmi ipmi_msghandler tpm_infineon uinput xfs
libcrc32c mlx4_ib mlx4_en sd_mod iw_cxgb4 ib_core sr_mod cdrom usb_storage ast
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm isci drm libsas
mlx4_core igb ahci libahci scsi_transport_sas cxgb4 libata ptp pps_core dca
i2c_algo_bit i2c_core dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
oprofile]
[11210.265905] CPU: 6 PID: 708 Comm: fio Not tainted 4.7.0-rc2+ #1
[11210.265909] Hardware name: ASUSTeK COMPUTER INC. Z9PE-D16 Series/Z9PE-D16
Series, BIOS 5506 06/03/2015
[11210.265911] task: ffff88105267c140 ti: ffff881050314000 task.ti:
ffff881050314000
[11210.265912] RIP: 0010:[<ffffffff81103845>]  [<ffffffff81103845>]
smp_call_function_single+0xd5/0x120
[11210.265921] RSP: 0000:ffff881050317a30  EFLAGS: 00000202
[11210.265922] RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffff880805deed50
[11210.265923] RDX: ffff88107fc98f80 RSI: ffff881050317a40 RDI: ffff881050317a40
[11210.265925] RBP: ffff881050317a78 R08: 0000000000000100 R09: 0000000000000000
[11210.265926] R10: ffff881051285018 R11: 0000000000000000 R12: ffffffff810710d0
[11210.265927] R13: 0000000000000006 R14: 0000000000000008 R15: ffff8810520b0368
[11210.265929] FS:  00007f7281ca2740(0000) GS:ffff88107fc00000(0000)
knlGS:0000000000000000
[11210.265930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11210.265931] CR2: 000000000071d230 CR3: 000000104d5ef000 CR4: 00000000001406e0
[11210.265933] Stack:
[11210.265934]  0000000000000400 ffff8810158e9000 ffff880805deed50
ffffffff810710d0
[11210.265937]  ffff881050317ad8 0000000000000003 0000000041548ca1
ffffffff810710d0
[11210.265939]  ffff881050317ad8 ffff881050317ac0 ffffffff81103c5c
0000000000000006
[11210.265941] Call Trace:
[11210.265949]  [<ffffffff810710d0>] ? do_flush_tlb_all+0x50/0x50
[11210.265952]  [<ffffffff810710d0>] ? do_flush_tlb_all+0x50/0x50
[11210.265957]  [<ffffffff81103c5c>] smp_call_function_many+0x20c/0x250
[11210.265959]  [<ffffffff81071571>] native_flush_tlb_others+0x131/0x1a0
[11210.265962]  [<ffffffff81071834>] flush_tlb_page+0x54/0x90
[11210.265967]  [<ffffffff811ce548>] ptep_clear_flush+0x48/0x60
[11210.265971]  [<ffffffff811c95e7>] try_to_unmap_one+0x167/0x5f0
[11210.265973]  [<ffffffff811c80cf>] rmap_walk_anon+0xef/0x210
[11210.265976]  [<ffffffff811ca2c5>] rmap_walk+0x45/0x60
[11210.265978]  [<ffffffff811ca679>] try_to_unmap+0xb9/0x150
[11210.265981]  [<ffffffff811c9480>] ? page_remove_rmap+0x220/0x220
[11210.265983]  [<ffffffff811c7ea0>] ? invalid_page_referenced_vma+0x90/0x90
[11210.265986]  [<ffffffff811c9d20>] ? page_get_anon_vma+0x90/0x90
[11210.265988]  [<ffffffff811c7d00>] ? invalid_mkclean_vma+0x20/0x20
[11210.265993]  [<ffffffff811f2e1d>] migrate_pages+0x76d/0x8f0
[11210.265995]  [<ffffffff811f0ad0>] ? compound_head+0x20/0x20
[11210.265997]  [<ffffffff811f38a5>] migrate_misplaced_page+0x125/0x1b0
[11210.266009]  [<ffffffff811bc1b2>] handle_pte_fault+0x642/0x1760
[11210.266015]  [<ffffffff81310f46>] ? blk_flush_plug_list+0xb6/0x220
[11210.266017]  [<ffffffff8131147c>] ? blk_finish_plug+0x2c/0x40
[11210.266019]  [<ffffffff811be74b>] handle_mm_fault+0x2bb/0x660
[11210.266022]  [<ffffffff8106a3ae>] __do_page_fault+0x1ce/0x4a0
[11210.266025]  [<ffffffff8106a6b0>] do_page_fault+0x30/0x80
[11210.266031]  [<ffffffff81003bb2>] ? do_syscall_64+0x102/0x110
[11210.266035]  [<ffffffff816b2188>] page_fault+0x28/0x30
[11210.266036] Code: 00 00 00 75 68 48 83 c4 38 5b 41 5c 5d c3 48 8d 75 c8 48 89
d1 89 df 4c 89 e2 e8 17 fe ff ff f6 45 e0 01 74 08 f3 90 f6 45 e0 01 <75> f8 eb
c7 8b 05 71 55 ed 00 85 c0 75 8b 80 3d 4d ce c1 00 00
[11222.265928] NMI watchdog: BUG: soft lockup - CPU#7 stuck for 22s! [fio:705]
[11222.265932] Modules linked in: oprofile nfsv3 nfs_acl rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache nvme_rdma nvme_fabrics
nvme nvme_core xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4
iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
nf_conntrack ipt_REJECT nf_reject_ipv4 iptable_filter ip_tables tun bridge stp
llc rpcrdma sunrpc ib_isert iscsi_target_mod ib_iser libiscsi
scsi_transport_iscsi ib_srpt target_core_mod sb_edac edac_core
x86_pkg_temp_thermal intel_powerclamp coretemp ib_srp scsi_transport_srp
ib_ipoib kvm_intel kvm rdma_ucm ib_ucm ib_uverbs snd_hda_intel snd_hda_codec
ib_umad rdma_cm snd_hda_core ib_cm iw_cm irqbypass snd_hwdep crct10dif_pclmul
crc32_pclmul snd_seq crc32c_intel ghash_clmulni_intel snd_seq_device snd_pcm
[11222.265982]  aesni_intel iTCO_wdt lrw gf128mul iTCO_vendor_support snd_timer
glue_helper snd ablk_helper cryptd mei_me lpc_ich serio_raw pcspkr mei ipmi_si
shpchp i2c_i801 soundcore mfd_core wmi ipmi_msghandler tpm_infineon uinput xfs
libcrc32c mlx4_ib mlx4_en sd_mod iw_cxgb4 ib_core sr_mod cdrom usb_storage ast
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm isci drm libsas
mlx4_core igb ahci libahci scsi_transport_sas cxgb4 libata ptp pps_core dca
i2c_algo_bit i2c_core dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
oprofile]
[11222.266013] CPU: 7 PID: 705 Comm: fio Tainted: G             L  4.7.0-rc2+ #1
[11222.266015] Hardware name: ASUSTeK COMPUTER INC. Z9PE-D16 Series/Z9PE-D16
Series, BIOS 5506 06/03/2015
[11222.266018] task: ffff88085c320000 ti: ffff880806388000 task.ti:
ffff880806388000
[11222.266020] RIP: 0010:[<ffffffff810cc399>]  [<ffffffff810cc399>]
native_queued_spin_lock_slowpath+0x179/0x1a0
[11222.266026] RSP: 0000:ffff88080638bb18  EFLAGS: 00000202
[11222.266028] RAX: 0000000000000101 RBX: ffffea0020280580 RCX: 0000000000000001
[11222.266029] RDX: 0000000000000101 RSI: 0000000000000001 RDI: ffffea0041503af0
[11222.266030] RBP: ffff88080638bb18 R08: 0000000000000101 R09: 00000010540eb000
[11222.266032] R10: ffff881051285018 R11: 0000000000000000 R12: ffff88080638bba8
[11222.266033] R13: 0000000000000000 R14: ffff8810540eb8d0 R15: ffffea0041503af0
[11222.266035] FS:  00007f7281ca2740(0000) GS:ffff88107fc40000(0000)
knlGS:0000000000000000
[11222.266036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11222.266037] CR2: 000000000071a980 CR3: 0000000850d57000 CR4: 00000000001406e0
[11222.266039] Stack:
[11222.266040]  ffff88080638bb28 ffffffff81187380 ffff88080638bb38
ffffffff816afcc0
[11222.266042]  ffff88080638bb70 ffffffff811c87f4 0000000000000302
ffffea0020280580
[11222.266045]  ffff8810520b0000 000000000071a000 ffff88105181d450
ffff88080638bbe0
[11222.266047] Call Trace:
[11222.266055]  [<ffffffff81187380>] queued_spin_lock_slowpath+0xb/0xf
[11222.266060]  [<ffffffff816afcc0>] _raw_spin_lock+0x20/0x30
[11222.266066]  [<ffffffff811c87f4>] __page_check_address+0xe4/0x1d0
[11222.266069]  [<ffffffff811c951d>] try_to_unmap_one+0x9d/0x5f0
[11222.266072]  [<ffffffff811c80cf>] rmap_walk_anon+0xef/0x210
[11222.266074]  [<ffffffff811ca2c5>] rmap_walk+0x45/0x60
[11222.266077]  [<ffffffff811ca679>] try_to_unmap+0xb9/0x150
[11222.266079]  [<ffffffff811c9480>] ? page_remove_rmap+0x220/0x220
[11222.266082]  [<ffffffff811c7ea0>] ? invalid_page_referenced_vma+0x90/0x90
[11222.266084]  [<ffffffff811c9d20>] ? page_get_anon_vma+0x90/0x90
[11222.266087]  [<ffffffff811c7d00>] ? invalid_mkclean_vma+0x20/0x20
[11222.266090]  [<ffffffff811f2e1d>] migrate_pages+0x76d/0x8f0
[11222.266092]  [<ffffffff811f0ad0>] ? compound_head+0x20/0x20
[11222.266095]  [<ffffffff811f38a5>] migrate_misplaced_page+0x125/0x1b0
[11222.266097]  [<ffffffff811bc1b2>] handle_pte_fault+0x642/0x1760
[11222.266100]  [<ffffffff811be74b>] handle_mm_fault+0x2bb/0x660
[11222.266104]  [<ffffffff81212c53>] ? __fput+0x193/0x220
[11222.266108]  [<ffffffff8106a3ae>] __do_page_fault+0x1ce/0x4a0
[11222.266110]  [<ffffffff8106a6b0>] do_page_fault+0x30/0x80
[11222.266116]  [<ffffffff81003ba5>] ? do_syscall_64+0xf5/0x110
[11222.266118]  [<ffffffff816b2188>] page_fault+0x28/0x30
[11222.266120] Code: d0 66 31 c0 39 c1 74 e7 4d 85 c9 c6 07 01 74 2b 41 c7 41 08
01 00 00 00 e9 51 ff ff ff 83 fa 01 75 07 e9 ac fe ff ff f3 90 8b 07 <84> c0 75
f8 b8 01 00 00 00 66 89 07 5d c3 f3 90 4d 8b 08 4d 85
