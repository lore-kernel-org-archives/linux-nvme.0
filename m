From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 9 Jul 2018 14:25:56 -0500
Subject: nvme-rdma and rdma comp vector affinity problem
Message-ID: <bf6b909e-b3b9-cc77-2837-c65302f7c22c@opengridcomputing.com>

Hey Sagi,

I'm adding cxgb4 support for ib_get_vector_affinity(), and I see an
error when connecting via nvme-rdma for certain affinity settings for my
comp vectors.? The error I see is:

[root at stevo1 linux]# nvme connect-all -t rdma -a 172.16.2.1
Failed to write to /dev/nvme-fabrics: Invalid cross-device link

And this gets logged:

[? 590.357506] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 590.364730] nvme nvme0: failed to connect queue: 2 ret=-18

The EXDEV error is being returned by blk_mq_alloc_request_hctx() because
blk_mq_queue_mapped() fails.? This only happens when I setup my vector
affinity such that there is overlap.? IE if 2 comp vectors are setup to
the same cpu then i see this failure.? If they are all mapped each to
their own cpu, then it works.? I added some debug in my cxgb4
get_comp_vector_affinity(), and a WARN_ONCE() in
blk_mq_alloc_request_hctx() and below is the output.

I would think that the vector affinity shouldn't cause connection
failures.? Any ideas?? Thanks!

Steve.

[? 433.528743] nvmet: creating controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:228c41cb-86c1-4aca-8a10-6e8d8c7998a0.
[? 433.545267] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 172.16.2.1:4420
[? 433.554972] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[? 433.604610] nvmet: creating controller 1 for subsystem nvme-nullb0
for NQN
nqn.2014-08.org.nvmexpress:uuid:228c41cb-86c1-4aca-8a10-6e8d8c7998a0.
[? 433.619048] nvme nvme0: creating 16 I/O queues.
[? 433.643746] iw_cxgb4: comp_vector 0, irq 217 mask 0x100
[? 433.649630] iw_cxgb4: comp_vector 1, irq 218 mask 0x200
[? 433.655501] iw_cxgb4: comp_vector 2, irq 219 mask 0x400
[? 433.661379] iw_cxgb4: comp_vector 3, irq 220 mask 0x800
[? 433.667243] iw_cxgb4: comp_vector 4, irq 221 mask 0x1000
[? 433.673179] iw_cxgb4: comp_vector 5, irq 222 mask 0x2000
[? 433.679110] iw_cxgb4: comp_vector 6, irq 223 mask 0x4000
[? 433.685020] iw_cxgb4: comp_vector 7, irq 224 mask 0x8000
[? 433.690928] iw_cxgb4: comp_vector 8, irq 225 mask 0x100
[? 433.696736] iw_cxgb4: comp_vector 9, irq 226 mask 0x200
[? 433.702531] iw_cxgb4: comp_vector 10, irq 227 mask 0x400
[? 433.708401] iw_cxgb4: comp_vector 11, irq 228 mask 0x800
[? 433.714277] iw_cxgb4: comp_vector 12, irq 229 mask 0x1000
[? 433.720208] iw_cxgb4: comp_vector 13, irq 230 mask 0x2000
[? 433.726138] iw_cxgb4: comp_vector 14, irq 231 mask 0x4000
[? 433.732051] iw_cxgb4: comp_vector 15, irq 232 mask 0x8000
[? 433.739894] ------------[ cut here ]------------
[? 433.745026] blk_mq_alloc_request_hctx hw_queue not mapped!
[? 433.751030] WARNING: CPU: 6 PID: 9950 at block/blk-mq.c:454
blk_mq_alloc_request_hctx+0x163/0x180
[? 433.760396] Modules linked in: nvmet_rdma nvmet null_blk nvme_rdma
nvme_fabrics nvme_core mlx5_ib mlx5_core mlxfw rdma_ucm ib_uverbs
iw_cxgb4 rdma_cm iw_cm ib_cm ib_core cxgb4 iscsi_target_mod libiscsi
scsi_transport_iscsi target_core_mod libcxgb vfat fat intel_rapl sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp kvm irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel
crypto_simd cryptd glue_helper iTCO_wdt iTCO_vendor_support mxm_wmi
pcspkr joydev mei_me devlink ipmi_si sg mei i2c_i801 ipmi_devintf
lpc_ich ioatdma ipmi_msghandler wmi nfsd auth_rpcgss nfs_acl lockd grace
sunrpc ip_tables ext4 mbcache jbd2 sd_mod mgag200 drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm isci libsas igb
ahci scsi_transport_sas libahci libata crc32c_intel dca i2c_algo_bit
[? 433.835278]? i2c_core [last unloaded: mlxfw]
[? 433.840150] CPU: 6 PID: 9950 Comm: nvme Kdump: loaded Tainted:
G??????? W???????? 4.18.0-rc1+ #131
[? 433.849714] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a
07/09/2015
[? 433.857301] RIP: 0010:blk_mq_alloc_request_hctx+0x163/0x180
[? 433.863493] Code: 0f 0b 48 c7 c0 ea ff ff ff e9 1a ff ff ff 48 c7 c6
e0 34 c8 bd 48 c7 c7 bb e4 ea bd 31 c0 c6 05 bc d1 e8 00 01 e8 bd 96 d1
ff <0f> 0b 48 c7 c0 ee ff ff ff e9 f0 fe ff ff 0f 1f 44 00 00 66 2e 0f
[? 433.883625] RSP: 0018:ffffab7f4790bba8 EFLAGS: 00010286
[? 433.889481] RAX: 0000000000000000 RBX: ffff918412ab9360 RCX:
0000000000000000
[? 433.897252] RDX: 0000000000000001 RSI: ffff91841fd96978 RDI:
ffff91841fd96978
[? 433.905014] RBP: 0000000000000001 R08: 0000000000000000 R09:
000000000000057d
[? 433.912782] R10: 00000000000003ff R11: 0000000000aaaaaa R12:
0000000000000023
[? 433.920555] R13: ffffab7f4790bc50 R14: 0000000000000400 R15:
0000000000000000
[? 433.928325] FS:? 00007f54566d6780(0000) GS:ffff91841fd80000(0000)
knlGS:0000000000000000
[? 433.937040] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[? 433.943418] CR2: 00007f5456000610 CR3: 0000000858f58003 CR4:
00000000000606e0
[? 433.951178] Call Trace:
[? 433.954241]? nvme_alloc_request+0x36/0x80 [nvme_core]
[? 433.959891]? __nvme_submit_sync_cmd+0x2b/0xd0 [nvme_core]
[? 433.965884]? nvmf_connect_io_queue+0x10e/0x170 [nvme_fabrics]
[? 433.972215]? nvme_rdma_start_queue+0x21/0x80 [nvme_rdma]
[? 433.978100]? nvme_rdma_configure_io_queues+0x196/0x280 [nvme_rdma]
[? 433.984846]? nvme_rdma_create_ctrl+0x4f9/0x640 [nvme_rdma]
[? 433.990901]? nvmf_dev_write+0x954/0xaf8 [nvme_fabrics]
[? 433.996614]? __vfs_write+0x33/0x190
[? 434.000681]? ? list_lru_add+0x97/0x140
[? 434.005015]? ? __audit_syscall_entry+0xd7/0x160
[? 434.010135]? vfs_write+0xad/0x1a0
[? 434.014039]? ksys_write+0x52/0xc0
[? 434.017959]? do_syscall_64+0x55/0x180
[? 434.022222]? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[? 434.027880] RIP: 0033:0x7f5455fda840
[? 434.032061] Code: 73 01 c3 48 8b 0d 48 26 2d 00 f7 d8 64 89 01 48 83
c8 ff c3 66 0f 1f 44 00 00 83 3d 3d 87 2d 00 00 75 10 b8 01 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce c6 01 00 48 89 04 24
[? 434.052217] RSP: 002b:00007ffc930111e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[? 434.060449] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f5455fda840
[? 434.068266] RDX: 000000000000003d RSI: 00007ffc93012260 RDI:
0000000000000003
[? 434.076088] RBP: 00007ffc93012260 R08: 00007f5455f39988 R09:
000000000000000d
[? 434.083911] R10: 0000000000000004 R11: 0000000000000246 R12:
000000000000003d
[? 434.091736] R13: 0000000000000003 R14: 0000000000000001 R15:
0000000000000001
[? 434.099555] ---[ end trace 9f5bec6eef77fae9 ]---
[? 434.104864] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
[? 434.112235] nvme nvme0: failed to connect queue: 2 ret=-18
