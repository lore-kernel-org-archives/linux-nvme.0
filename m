From: james.r.harris@intel.com (Harris, James R)
Date: Mon, 3 Jun 2019 19:12:51 +0000
Subject: Oops when disconnecting from inaccessible subsystem
Message-ID: <3332C781-D747-42FC-8B1F-B4748961253C@intel.com>

Hi,

I see a 100% reproducible kernel oops when trying to disconnect from an inaccessible subsystem.  This was tested with 5.2-rc2 + Sagi's "fix queue mapping when queue count is limited" patches.

Failure is seen when using either the kernel or SPDK fabrics target.  So far I've only tested with rdma.  Simply connect to a subsystem, remove the subsystem from the target, and then try to disconnect.

Thanks,

-Jim


[ 7011.990205] BUG: unable to handle page fault for address: ffffe82ad9725880
[ 7011.993043] #PF: supervisor instruction fetch in kernel mode
[ 7011.995377] #PF: error_code(0x0011) - permissions violation
[ 7011.997677] PGD 6681f8067 P4D 6681f8067 PUD 6681f7067 PMD 800000067f6000e3
[ 7012.000553] Oops: 0011 [#1] SMP PTI
[ 7012.001992] CPU: 21 PID: 4964 Comm: nvme Tainted: G          I       5.2.0-rc2+ #29
[ 7012.005152] Hardware name: Intel Corp. GRANTLEY/GRANTLEY, BIOS GRNDCRB1.86B.0048.R00.1503191102 03/19/2015
[ 7012.009143] RIP: 0010:0xffffe82ad9725880
[ 7012.010759] Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff 01 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 ff ff 02 00 01 00 00 00 00 ad de 00 02 00 00 00 00
[ 7012.018519] RSP: 0018:ffffad0c895e3db0 EFLAGS: 00010246
[ 7012.020676] RAX: ffffe82ad9725880 RBX: ffff983c48296000 RCX: 0000000000000001
[ 7012.023620] RDX: 0000000000000040 RSI: 0000000c48d1ca00 RDI: ffff983c44fa0880
[ 7012.026566] RBP: ffff984118778810 R08: 0000000000000000 R09: ffffffffac43e100
[ 7012.029511] R10: ffff984112c2c000 R11: 0000000000000001 R12: ffff98423d34a008
[ 7012.032457] R13: 0000000000000000 R14: 0000000000000024 R15: ffff9842639773a0
[ 7012.035404] FS:  00007f1536a1c780(0000) GS:ffff9842676c0000(0000) knlGS:0000000000000000
[ 7012.038744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7012.041115] CR2: ffffe82ad9725880 CR3: 0000000b19aac006 CR4: 00000000001606e0
[ 7012.044061] Call Trace:
[ 7012.045100]  ? nvme_rdma_exit_request+0x51/0xa0 [nvme_rdma]
[ 7012.047403]  ? blk_mq_exit_hctx+0x5a/0xe0
[ 7012.049056]  ? blk_mq_exit_queue+0xdc/0xf0
[ 7012.050746]  ? blk_cleanup_queue+0x9a/0xc0
[ 7012.052432]  ? nvme_rdma_destroy_io_queues+0x52/0x60 [nvme_rdma]
[ 7012.054911]  ? nvme_rdma_shutdown_ctrl+0x3e/0x80 [nvme_rdma]
[ 7012.135288]  ? nvme_do_delete_ctrl+0x4d/0x80 [nvme_core]
[ 7012.216535]  ? nvme_sysfs_delete+0x42/0x60 [nvme_core]
[ 7012.298498]  ? kernfs_fop_write+0xff/0x180
[ 7012.379378]  ? vfs_write+0xb0/0x190
[ 7012.458712]  ? ksys_write+0x5c/0xe0
[ 7012.537044]  ? do_syscall_64+0x4f/0x130
[ 7012.614310]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 7012.693035] Modules linked in: nvme_rdma nvme_fabrics nvmet_rdma nvmet null_blk mlx5_ib rdma_ucm rdma_cm configfs iw_cm ib_uverbs ib_umad ib_cm ib_core uio_pci_generic uio binfmt_misc intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif input_leds crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper mei_me mei lpc_ich ioatdma wmi ipmi_si ipmi_devintf ipmi_msghandler iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid ixgbe mlx5_core igb ahci mdio e1000e hid nvme libahci dca nvme_core i2c_algo_bit
[ 7013.340727] CR2: ffffe82ad9725880
[ 7013.444045] ---[ end trace 55a6d7f809307c7b ]---
[ 7013.549019] RIP: 0010:0xffffe82ad9725880
[ 7013.652818] Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff 01 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 ff ff 02 00 01 00 00 00 00 ad de 00 02 00 00 00 00
[ 7013.873038] RSP: 0018:ffffad0c895e3db0 EFLAGS: 00010246
[ 7013.984597] RAX: ffffe82ad9725880 RBX: ffff983c48296000 RCX: 0000000000000001
[ 7014.096667] RDX: 0000000000000040 RSI: 0000000c48d1ca00 RDI: ffff983c44fa0880
[ 7014.208045] RBP: ffff984118778810 R08: 0000000000000000 R09: ffffffffac43e100
[ 7014.318879] R10: ffff984112c2c000 R11: 0000000000000001 R12: ffff98423d34a008
[ 7014.429180] R13: 0000000000000000 R14: 0000000000000024 R15: ffff9842639773a0
[ 7014.538388] FS:  00007f1536a1c780(0000) GS:ffff9842676c0000(0000) knlGS:0000000000000000
[ 7014.648293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7014.757664] CR2: ffffe82ad9725880 CR3: 0000000b19aac006 CR4: 00000000001606e0
