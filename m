From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 May 2019 09:03:38 -0700
Subject: Using host fabrics drivers with a target with limited queues
In-Reply-To: <1CBC7E3F-7BE5-47DD-8A98-178BBEC8FB8F@intel.com>
References: <1CBC7E3F-7BE5-47DD-8A98-178BBEC8FB8F@intel.com>
Message-ID: <20190516160338.GA21777@infradead.org>

Adding the nvme-tcp maintainer for increased visibility..

On Tue, May 14, 2019@09:32:34PM +0000, Harris, James R wrote:
> Hi,
> 
> I?ve been running some tests with the Linux nvme driver against the SPDK nvme fabrics target.  Some of the tests cap the number of queues returned by NVME_FEAT_NUM_QUEUES and result in a 100% reproducible NULL pointer dereference.  See stack trace below.  The exact same call stack happens on rdma as well (just swap nvme_tcp_create/setup_ctrl with nvme_rdma_create/setup_ctrl).
> 
> nvme_tcp_alloc_io_queues and nvme_rdma_alloc_io_queues seem to be the culprits.  The ctrl->io_queues[] array gets set up assuming that all of the desired io queues will be available.  If nvme_set_queue_count() reduces nr_io_queues, the maps still get set up with the bigger values even though we have fewer I/O queues.
> 
> Note that reducing the max number of queues in the kernel nvme fabrics target from 128 to a much smaller number results in the exact same issue.
> 
> It seems like the ctrl->io_queues array needs to be setup after we know how many IO queues can be created.  But it's not clear to me exactly how it should handle the case where nr_write_queues or nr_poll_queues > 0.
> 
> (The ctrl->io_queues[HCTX_TYPE_READ] assignment also seems incorrect when nr_write_queues > 0.  We've already incremented nr_io_queues at this point, so I think this results in too many io queues getting allocated and possibly some incorrect queue_offsets in the map_queues functions.  But I may not be understanding this part of the code correctly.)
> 
> Any advice would be appreciated on fixing this issue.  I'd also be happy to test any patches if someone with a better understanding of this part of the code would like to throw something together.
> 
> Thanks,
> 
> -Jim
> 
> 5555.593973] BUG: unable to handle kernel NULL pointer dereference at 0000000000000198
> [ 5555.595285] #PF error: [normal kernel read fault]
> [ 5555.596550] PGD 0 P4D 0
> [ 5555.597805] Oops: 0000 [#1] SMP
> [ 5555.599048] CPU: 89 PID: 6766 Comm: bash Not tainted 5.1.0 #2
> [ 5555.600328] Hardware name: Supermicro Super Server/X11DPU, BIOS 2.0b 02/24/2018
> [ 5555.601658] RIP: 0010:blk_mq_init_allocated_queue+0x2d6/0x440
> [ 5555.603001] Code: c1 e6 02 31 d2 4c 63 c0 41 83 ff 01 76 37 89 d1 48 c1 e1 04 48 03 8b 98 05 00 00 48 8b 09 44 8b 0c 31 48 8b 4b 58 4a 8b 0c c9 <83> b9 98 01 00 00 ff 75 12 4e 8b 14 c7 4d 89 e9 47 8b 0c 0a 44 89
> [ 5555.605880] RSP: 0018:ffffaf950cc3fcd0 EFLAGS: 00010282
> [ 5555.607360] RAX: 0000000000000008 RBX: ffff93832b650790 RCX: 0000000000000000
> [ 5555.608878] RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffffffffbacd8820
> [ 5555.610401] RBP: ffffaf950cc3fcf8 R08: 0000000000000008 R09: 0000000000000008
> [ 5555.611945] R10: ffffaf950cc3fbe0 R11: 0000000000000000 R12: ffff93831ecb2008
> [ 5555.613497] R13: 000000000001c968 R14: ffff93831ecb2008 R15: 0000000000000008
> [ 5555.615074] FS:  00007feb90a1b740(0000) GS:ffff93855f640000(0000) knlGS:0000000000000000
> [ 5555.616677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5555.618262] CR2: 0000000000000198 CR3: 0000002da655b001 CR4: 00000000007606e0
> [ 5555.619863] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5555.621449] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5555.623042] PKRU: 55555554
> [ 5555.624638] Call Trace:
> [ 5555.626211]  blk_mq_init_queue+0x35/0x60
> [ 5555.627777]  nvme_tcp_setup_ctrl+0x28d/0x550 [nvme_tcp]
> [ 5555.629369]  nvme_tcp_create_ctrl+0x330/0x3ed [nvme_tcp]
> [ 5555.630945]  nvmf_dev_write+0xa79/0xc34 [nvme_fabrics]
> [ 5555.632505]  __vfs_write+0x16/0x30
> [ 5555.634035]  ? __vfs_write+0x16/0x30
> [ 5555.635548]  vfs_write+0xac/0x1a0
> [ 5555.637044]  ksys_write+0x57/0xd0
> [ 5555.638517]  __x64_sys_write+0x15/0x20
> [ 5555.639976]  do_syscall_64+0x4f/0x100
> [ 5555.641421]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 5555.642893] RIP: 0033:0x7feb900fd154
> [ 5555.644340] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 b1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
> [ 5555.647368] RSP: 002b:00007ffdf1d121c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 5555.648872] RAX: ffffffffffffffda RBX: 0000000000000086 RCX: 00007feb900fd154
> [ 5555.650344] RDX: 0000000000000086 RSI: 000055b89cf83750 RDI: 0000000000000001
> [ 5555.651803] RBP: 000055b89cf83750 R08: 000000000000000a R09: 0000000000000085
> [ 5555.653245] R10: 000000000000000a R11: 0000000000000246 R12: 00007feb903d9760
> [ 5555.654696] R13: 0000000000000086 R14: 00007feb903d52a0 R15: 00007feb903d4760
> [ 5555.656157] Modules linked in: nvme_tcp nvme_fabrics iscsi_target_mod target_core_mod xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter binfmt_misc intel_rapl skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass intel_cstate intel_rapl_perf ipmi_si ioatdma joydev input_leds ipmi_devintf mac_hid lpc_ich ipmi_msghandler acpi_power_meter acpi_pad mei_me mei sch_fq_codel ib_iser rdma_cm iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_decompress zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mlx5_ib ib_uverbs ast crct10dif_pclmul i2c_algo_bit ttm crc32_pclmul ghash_clmulni_intel drm_kms_helper aesni_intel ib_core aes_x86_64
> [ 5555.656225]  syscopyarea sysfillrect hid_generic mlx5_core ixgbe sysimgblt crypto_simd usbhid nvme fb_sys_fops xfrm_algo cryptd hid mlxfw drm nvme_core glue_helper dca ahci mdio libahci wmi
> [ 5555.673493] CR2: 0000000000000198
> [ 5555.675348] ---[ end trace 0fe32ea3b082ed3c ]---
> [ 5555.690129] RIP: 0010:blk_mq_init_allocated_queue+0x2d6/0x440
> [ 5555.691969] Code: c1 e6 02 31 d2 4c 63 c0 41 83 ff 01 76 37 89 d1 48 c1 e1 04 48 03 8b 98 05 00 00 48 8b 09 44 8b 0c 31 48 8b 4b 58 4a 8b 0c c9 <83> b9 98 01 00 00 ff 75 12 4e 8b 14 c7 4d 89 e9 47 8b 0c 0a 44 89
> [ 5555.695677] RSP: 0018:ffffaf950cc3fcd0 EFLAGS: 00010282
> [ 5555.697526] RAX: 0000000000000008 RBX: ffff93832b650790 RCX: 0000000000000000
> [ 5555.699397] RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffffffffbacd8820
> [ 5555.701264] RBP: ffffaf950cc3fcf8 R08: 0000000000000008 R09: 0000000000000008
> [ 5555.703142] R10: ffffaf950cc3fbe0 R11: 0000000000000000 R12: ffff93831ecb2008
> [ 5555.705005] R13: 000000000001c968 R14: ffff93831ecb2008 R15: 0000000000000008
> [ 5555.706863] FS:  00007feb90a1b740(0000) GS:ffff93855f640000(0000) knlGS:0000000000000000
> [ 5555.708724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5555.710578] CR2: 0000000000000198 CR3: 0000002da655b001 CR4: 00000000007606e0
> [ 5555.712454] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5555.714338] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5555.716196] PKRU: 55555554
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
