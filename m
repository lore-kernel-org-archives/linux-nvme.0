From: keith.busch@intel.com (Keith Busch)
Date: Wed, 27 Jan 2016 00:37:28 +0000
Subject: kernel BUG at drivers/block/nvme-core.c:732!
In-Reply-To: <3490008B-7DD8-4CFE-97B3-ED7C37A2DFB0@clustered.net>
References: <3490008B-7DD8-4CFE-97B3-ED7C37A2DFB0@clustered.net>
Message-ID: <20160127003728.GC18103@localhost.localdomain>

On Mon, Dec 21, 2015@09:45:02AM +0000, John Morrison wrote:
> Hi,
> 
> We have a coupe of servers where we have 2 P3700?s in each.
> Neither doing and heavy IO and both have crashed with this error:-
> 
> Any ideas what?s going wrong ?

Just for the list's benefit ... This issue was fixed with stable commit
578270bfb,


  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=578270bfbd2803dc7b0b03fbc2ac119efbc73195


 
> 383368.216038] kernel BUG at drivers/block/nvme-core.c:732!
> [383368.478005] invalid opcode: 0000 [#1] SMP 
> [383368.680772] Modules linked in: ext4 mbcache jbd2 ebtable_broute ebtable_nat ebtable_filter ebt_ip ebtables vhost_net vhost macvtap macvlan tun nls_utf8 isofs loop ip6table_filter ip6_tables iptable_filter bridge stp llc bonding vfat fat x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul crc32c_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd kvm_intel sr_mod cdrom sb_edac ipmi_si ioatdma lpc_ich pcspkr edac_core mfd_core sg i2c_i801 hpwdt dca wmi ipmi_msghandler pcc_cpufreq acpi_power_meter acpi_cpufreq dm_mod nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc ip_tables mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm bnx2x sd_mod usb_storage tg3 mdio ptp nvme i2c_core hpsa pps_core [last unloaded: ebtables]
> [383372.108323] CPU: 2 PID: 8535 Comm: qemu-system-x86 Not tainted 4.3.0 #1
> [383372.434602] Hardware name: HP ProLiant DL360 Gen9, BIOS P89 11/10/2015
> [383372.757063] task: ffff88289b3dd600 ti: ffff88164c940000 task.ti: ffff88164c940000
> [383373.122056] RIP: 0010:[<ffffffffa0053b19>]  [<ffffffffa0053b19>] nvme_queue_rq+0xa19/0xa20 [nvme]
> [383373.558800] RSP: 0018:ffff88164c943ba8  EFLAGS: 00010286
> [383373.821345] RAX: 0000000000000000 RBX: ffff8827c0e664e0 RCX: 0000000000006800
> [383374.172143] RDX: 0000001c4db4da00 RSI: ffff881c4db4da00 RDI: 0000000000000246
> [383374.522798] RBP: ffff88164c943c90 R08: ffff8827c2ba7040 R09: 000000006ea2a000
> [383374.873771] R10: 00000000ffffe800 R11: 0000000000001000 R12: ffff8827bee8ef00
> [383375.224719] R13: 0000000000000001 R14: ffff8827c2ba7000 R15: ffff8828b16f1d40
> [383375.575317] FS:  00007fd3d75fe700(0000) GS:ffff8827df880000(0000) knlGS:0000000000000000
> [383375.972435] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [383376.255644] CR2: 00007f7838664000 CR3: 00000018cd96a000 CR4: 00000000001426e0
> [383376.606297] Stack:
> [383376.707729]  00008800c5902600 ffff8827c2ba7160 ffff8827c5a03b80 ffff88164c943be8
> [383377.071120]  ffff8827c2ba7040 00000000fffff800 000000006ea29000 ffff882700001000
> [383377.434496]  0000000000001000 ffffffff00000200 ffff8827c2ba7040 ffff881c4db4da00
> [383377.797841] Call Trace:
> [383377.920324]  [<ffffffff8139efb6>] __blk_mq_run_hw_queue+0x1d6/0x380
> [383378.228861]  [<ffffffff8139edc5>] blk_mq_run_hw_queue+0x95/0xb0
> [383378.520447]  [<ffffffff813a0353>] blk_mq_insert_requests+0xc3/0x110
> [383378.829014]  [<ffffffff813a0f91>] blk_mq_flush_plug_list+0x131/0x160
> [383379.141619]  [<ffffffff81396856>] blk_flush_plug_list+0xb6/0x200
> [383379.437374]  [<ffffffff81396d1c>] blk_finish_plug+0x2c/0x40
> [383379.707880]  [<ffffffff8126ca6c>] do_io_submit+0x2ec/0x520
> [383379.978319]  [<ffffffff8126ccb0>] SyS_io_submit+0x10/0x20
> [383380.244652]  [<ffffffff816fc0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
> [383380.561546] Code: 18 41 c7 46 08 ff ff ff ff 44 29 e8 44 01 d8 89 85 1c ff ff ff e9 35 fe ff ff e8 e3 1b 05 e1 4c 8b 2d 7c d1 a1 e1 e9 19 ff ff ff <0f> 0b 0f 0b 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 
> [383381.483308] RIP  [<ffffffffa0053b19>] nvme_queue_rq+0xa19/0xa20 [nvme]
> [383381.804620]  RSP <ffff88164c943ba8>
> [383381.980548] ---[ end trace f0dc9fdbddef44ce ]---
> [383382.209932] Kernel panic - not syncing: Fatal exception
> [383382.467930] Kernel Offset: disabled
> [383382.645644] ---[ end Kernel panic - not syncing: Fatal exception
