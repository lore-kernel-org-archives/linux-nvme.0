From: Berck.Nash@wdc.com (Berck Nash)
Date: Wed, 7 Feb 2018 20:54:16 +0000
Subject: NVMEoF oops on reset
References: <CO2PR04MB21987F3848378AB2A7BA21B582FD0@CO2PR04MB2198.namprd04.prod.outlook.com>
 <d443433f-5456-a86d-84ce-49afa10f8eb8@mellanox.com>
Message-ID: <CO2PR04MB2198B265C1EBD138187E1A1D82FC0@CO2PR04MB2198.namprd04.prod.outlook.com>

On 02/06/2018 06:06 PM, Max Gurtovoy wrote:
> On 2/7/2018 12:04 AM, Berck Nash wrote:
>> We're experiencing an oops whenever we issue an "nvme reset" via the
>> nvme cli on fabric setups.  Appears to be in the nvme_rdma code.  The
>> problem occurs on mainline 4.15, as well as on 4.16-nvme (commit
>> ca5554a696dce37852f6d6721520b4f13fc295c3).
> 
> please try me patches for fixing the state machine (attached).
> These should apply over nvme-4.16 but still there is a missing commit
> from Sagi the I mentioned in the cover letter. So with these 4 patches
> your test should pass...

Thanks, but that doesn't seem to be any better.  Loaded all 4 patches 
against nvme-4.16, and got a slightly different crash.  Entire log attached.

[  478.836005] general protection fault: 0000 [#1] SMP
[  478.836039] Modules linked in: mlx5_ib msdos xfs dm_mod fuse ib_iser 
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi nvme_rdma 
nvme_fabrics nvme nvme_core ib_umad ib_ucm rdma_ucm ib_uverbs rdma_cm 
iw_cm ib_cm qedr qede qed ib_core sr_mod ses cdrom enclosure vfat fat 
intel_rapl sb_edac ftdi_sio x86_pkg_temp_thermal intel_powerclamp sg 
coretemp mei_me ioatdma mei lpc_ich ipmi_ssif shpchp ipmi_si 
ipmi_devintf ipmi_msghandler acpi_power_meter kvm_intel acpi_pad kvm 
irqbypass nfsd auth_rpcgss nfs_acl netconsole lockd grace sunrpc ext4 
mbcache jbd2 btrfs zstd_decompress zstd_compress xxhash raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c raid1 raid0 linear uas usb_storage sd_mod ast ttm 
crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel syscopyarea
[  478.836519]  ghash_clmulni_intel sysfillrect pcbc sysimgblt ahci 
fb_sys_fops aesni_intel libahci mlx5_core igb crypto_simd mpt3sas 
glue_helper drm cryptd devlink dca raid_class ptp i2c_algo_bit libata 
pps_core scsi_transport_sas wmi i2c_core sha512_ssse3(E) sha512_generic(E)
[  478.836688] CPU: 1 PID: 3027 Comm: kworker/u40:3 Tainted: G 
  E    4.15.0-rc4+ #1
[  478.836742] Hardware name: Supermicro 
SSG-5028R-E1CR12L-CE010/X10SRH-CLN4F, BIOS 1.0c 10/02/2015
[  478.836804] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work 
[nvme_rdma]
[  478.836855] RIP: 0010:rdma_destroy_id+0x192/0x300 [rdma_cm]
[  478.836892] RSP: 0018:ffffbac5062afdf8 EFLAGS: 00010286
[  478.836929] RAX: dead000000000100 RBX: ffffa063766df6e0 RCX: 
0000000000000000
[  478.836976] RDX: dead000000000200 RSI: 000000000000000a RDI: 
ffffffffc0d4c320
[  478.837023] RBP: ffffa063571f6000 R08: 0000000000000550 R09: 
0000000000000000
[  478.838841] R10: ffffbac5062afd20 R11: 000000002b300071 R12: 
ffffffff86db29c0
[  478.840661] R13: 0000000000000020 R14: ffffa06353a39658 R15: 
ffffa06353a39660
[  478.842492] FS:  0000000000000000(0000) GS:ffffa0637f040000(0000) 
knlGS:0000000000000000
[  478.844309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  478.846114] CR2: 00007fcc02001040 CR3: 0000001e0ec09001 CR4: 
00000000001606e0
[  478.847926] Call Trace:
[  478.849727]  nvme_rdma_alloc_queue+0x118/0x180 [nvme_rdma]
[  478.851562]  nvme_rdma_configure_admin_queue+0x1d/0x2c0 [nvme_rdma]
[  478.853388]  nvme_rdma_reset_ctrl_work+0x36/0xc0 [nvme_rdma]
[  478.855202]  process_one_work+0x198/0x370
[  478.856989]  worker_thread+0x1cd/0x390
[  478.858756]  ? process_one_work+0x370/0x370
[  478.860518]  kthread+0x111/0x130
[  478.862261]  ? kthread_create_worker_on_cpu+0x70/0x70
[  478.864024]  ret_from_fork+0x1f/0x30
[  478.865754] Code: 00 00 48 85 db 74 64 48 c7 c7 20 c3 d4 c0 4c 8b a5 
90 01 00 00 e8 2f 6e a0 c5 48 8b 85 c8 01 00 00 48 8b 95 d0 01 00 00 48 
85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 89
[  478.869358] RIP: rdma_destroy_id+0x192/0x300 [rdma_cm] RSP: 
ffffbac5062afdf8
[  478.871197] ---[ end trace 509c59825297d9a1 ]---
[  478.873914] systemd-journald[631]: Compressed data object 809 -> 584 
using XZ
[  478.874342] Kernel panic - not syncing: Fatal exception
[  478.877826] Kernel Offset: 0x5000000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  478.882651] ---[ end Kernel panic - not syncing: Fatal exception
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: nvme_reset_with_patches.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180207/33ea15a1/attachment-0001.txt>
