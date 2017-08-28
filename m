From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Aug 2017 10:36:16 -0400
Subject: NVMe driver with kernel panic
In-Reply-To: <CADcj3=7aCwiOLyo9E+zUs2HqNzsED28GVLkBx5t0Sdx91cdZVA@mail.gmail.com>
References: <CADcj3=5oXJzsBO7eNPNbGM+W9qKwbVBmmokY9h7-qP8butZLTg@mail.gmail.com>
 <20170821200436.GF21397@localhost.localdomain>
 <CADcj3=7aCwiOLyo9E+zUs2HqNzsED28GVLkBx5t0Sdx91cdZVA@mail.gmail.com>
Message-ID: <20170828143616.GG1207@localhost.localdomain>

On Mon, Aug 21, 2017@05:51:10PM -0400, Felipe Arturo Polanco wrote:
> Hi Keith,
> 
> Thanks for the information, the server just dumped the new
> information, please find it below:
> 
> ```Aug 21 16:13:10 bhs1-vo5 kernel: ------------[ cut here ]------------
> Aug 21 16:13:10 bhs1-vo5 kernel: WARNING: at
> /home/builder/linux-src/drivers/nvme/host/pci.c:478
> nvme_queue_rq+0xad4/0xb7d [kpatch_PSBM_70321]()
> Aug 21 16:13:10 bhs1-vo5 kernel: Invalid SGL for payload:82944 nents:19
> Aug 21 16:13:10 bhs1-vo5 kernel: Modules linked in:
> kpatch_PSBM_70321(OE) vhost_net vhost macvtap macvlan ip6t_rpfilter
> xt_conntrack ip_set nfnetlink ip6table_nat nf_conntrack_ipv6
> nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw iptable_nat
>  nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat iptable_raw
> ebt_ip binfmt_misc xt_CHECKSUM iptable_mangle ip6t_REJECT
> nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 tun ip6table_filter
> ip6_tables iptable_filter 8021q garp mrp kpatch_cumulative_29_1_
> r1(O) kpatch(O) ebt_among dm_mirror dm_region_hash dm_log dm_mod
> iTCO_wdt iTCO_vendor_support vfat fat intel_powerclamp coretemp
> intel_rapl iosf_mbi kvm_intel kvm irqbypass crc32_pclmul
> ghash_clmulni_intel aesni_intel lrw gf128mul fuse glue_helper
> ablk_helper cryptd raid1 ses enclosure scsi_transport_sas mxm_wmi
> pcspkr sg mei_me sb_edac
> Aug 21 16:13:10 bhs1-vo5 kernel: mei shpchp i2c_i801 edac_core ioatdma
> lpc_ich ipmi_ssif ipmi_si ipmi_msghandler wmi acpi_pad
> acpi_power_meter nfsd ip_vs auth_rpcgss nfs_acl nf_conntrack lockd
> libcrc32c grace br_netfilter veth overlay ip6_vzprivnet
>  ip6_vznetstat pio_kaio pio_nfs pio_direct pfmt_raw pfmt_ploop1 ploop
> ip_vznetstat ip_vzprivnet vziolimit vzevent vzlist vzstat vznetstat
> vznetdev vzmon vzdev ebtable_filter ebtable_broute bridge stp llc
> sunrpc ebtable_nat ebtables ip_tables ext4 m
> bcache jbd2 sd_mod crc_t10dif crct10dif_generic ast crct10dif_pclmul
> crct10dif_common i2c_algo_bit crc32c_intel drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops ttm megaraid_sas ixgbe drm ahci mdio
> ptp libahci i2c_core pps_core libata n
> vme dca fjes
> Aug 21 16:13:10 bhs1-vo5 kernel: CPU: 19 PID: 6607 Comm: qemu-kvm ve:
> 0 Tainted: G           OE  ------------   3.10.0-514.26.1.vz7.33.22 #1
> 33.22
> Aug 21 16:13:10 bhs1-vo5 kernel: Hardware name: Supermicro
> X10DRH/X10DRH-iT, BIOS 2.0a 06/30/2016
> Aug 21 16:13:10 bhs1-vo5 kernel: 00000000000001de 00000000cbb48af3
> ffff887ecf633b70 ffffffff816832e3
> Aug 21 16:13:10 bhs1-vo5 kernel: ffff887ecf633ba8 ffffffff81085f10
> ffff883f77a260c0 ffff883f7baa2380
> Aug 21 16:13:10 bhs1-vo5 kernel: 00000000fffff400 ffff883f7ce78800
> ffff883f78fdc700 ffff887ecf633c10
> Aug 21 16:13:10 bhs1-vo5 kernel: Call Trace:
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff816832e3>] dump_stack+0x19/0x1b
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81085f10>]
> warn_slowpath_common+0x70/0xb0
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81085fac>]
> warn_slowpath_fmt+0x5c/0x80
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffffa07f6be4>]
> nvme_queue_rq+0xad4/0xb7d [kpatch_PSBM_70321]
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81150d5e>] ?
> ftrace_ops_list_func+0xee/0x110
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812f5352>]
> blk_mq_make_request+0x222/0x440
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812e9419>]
> generic_make_request+0x109/0x1e0
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffffa052c4be>]
> raid1_unplug+0x13e/0x1a0 [raid1]
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812eadc2>]
> blk_flush_plug_list+0xa2/0x230
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812eb314>] blk_finish_plug+0x14/0x40
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff8126b50b>] do_io_submit+0x28b/0x460
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff8126b6f0>] SyS_io_submit+0x10/0x20
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81693309>]
> system_call_fastpath+0x16/0x1b
> Aug 21 16:13:10 bhs1-vo5 kernel: ---[ end trace 3fbd525f4b190398 ]---
> Aug 21 16:13:10 bhs1-vo5 kernel: Tainting kernel with flag 0x9
> Aug 21 16:13:10 bhs1-vo5 kernel: CPU: 19 PID: 6607 Comm: qemu-kvm ve:
> 0 Tainted: G           OE  ------------   3.10.0-514.26.1.vz7.33.22 #1
> 33.22
> Aug 21 16:13:10 bhs1-vo5 kernel: Hardware name: Supermicro
> X10DRH/X10DRH-iT, BIOS 2.0a 06/30/2016
> Aug 21 16:13:10 bhs1-vo5 kernel: 00000000000001de 00000000cbb48af3
> ffff887ecf633b58 ffffffff816832e3
> Aug 21 16:13:10 bhs1-vo5 kernel: ffff887ecf633b70 ffffffff81085b12
> ffff887ecf633bb8 ffff887ecf633ba8
> Aug 21 16:13:10 bhs1-vo5 kernel: ffffffff81085f1f ffff883f77a260c0
> ffff883f7baa2380 00000000fffff400
> Aug 21 16:13:10 bhs1-vo5 kernel: Call Trace:
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff816832e3>] dump_stack+0x19/0x1b
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81085b12>] add_taint+0x32/0x70
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81085f1f>]
> warn_slowpath_common+0x7f/0xb0
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81085fac>]
> warn_slowpath_fmt+0x5c/0x80
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffffa07f6be4>]
> nvme_queue_rq+0xad4/0xb7d [kpatch_PSBM_70321]
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81150d5e>] ?
> ftrace_ops_list_func+0xee/0x110
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812f5352>]
> blk_mq_make_request+0x222/0x440
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812e9419>]
> generic_make_request+0x109/0x1e0
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffffa052c4be>]
> raid1_unplug+0x13e/0x1a0 [raid1]
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812eadc2>]
> blk_flush_plug_list+0xa2/0x230
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff812eb314>] blk_finish_plug+0x14/0x40
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff8126b50b>] do_io_submit+0x28b/0x460
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff8126b6f0>] SyS_io_submit+0x10/0x20
> Aug 21 16:13:10 bhs1-vo5 kernel: [<ffffffff81693309>]
> system_call_fastpath+0x16/0x1b
> Aug 21 16:13:10 bhs1-vo5 kernel: sg[0] phys_addr:0x0000007d86766000
> offset:0 length:4096 dma_address:0x0000007d86766000 dma_length:4096
> 
> Have you seen this before?

The code should have printed the entire SGL. The warn says there should
have been 82944 bytes in the payload, but your just showing the first 4k
entry. Did the rest simply not print or did you truncate the output?
