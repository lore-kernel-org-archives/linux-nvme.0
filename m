From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 24 May 2018 11:23:07 +0800
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <20180523161614.GE11037@localhost.localdomain>
References: <20180522220332.9244-1-keith.busch@intel.com>
 <20180523030057.GF31196@ming.t460p>
 <20180523161614.GE11037@localhost.localdomain>
Message-ID: <20180524032257.GB15354@ming.t460p>

On Wed, May 23, 2018@10:16:14AM -0600, Keith Busch wrote:
> On Wed, May 23, 2018@11:00:59AM +0800, Ming Lei wrote:
> > Looks V2 still may trigger IO hang warning:
> 
> Anything in particular that triggered this?

I am running the modified block 011:

diff --git a/tests/block/011 b/tests/block/011
index 62e89f758ef1..5f71f8b9aca0 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -44,10 +44,10 @@ test_device() {
                        --ignore_error=EIO,ENXIO,ENODEV &
 
        while kill -0 $! 2>/dev/null; do
-               echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
-               sleep .2
-               echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
-               sleep .2
+               setpci -s "${pdev}" 4.w=00:04
+               sleep .01
+               setpci -s "${pdev}" 4.w=04:04
+               sleep .01

> 
> I'm running IO with io-timeout fault injection, with resets and rescans
> randomly running in the background, so I'm guessing that's not enough.

io-timeout can't trigger admin IO timeout, just found that yesterday's hang
follows warning of 'Trying to free already-free', so it should be related
with admin queue, and not take a close look at your V2 yet, but seems
you don't address the issues handled by the following patches:

https://marc.info/?l=linux-block&m=152644343805986&w=2
https://marc.info/?l=linux-block&m=152644344805995&w=2
https://marc.info/?l=linux-block&m=152644346006002&w=2


Also today I tried to reproduce yesterday's report, looks not succeed
yet, since the following two oops can be triggered, and the 1st one is
a bit easier to trigger.

[1] kernfs oops
[ming at VM]$sudo ./check block/011
block/011 => nvme0n1 (disable PCI device while doing I/O)   
    runtime  ...
[  348.175967] BUG: unable to handle kernel paging request at 0000000001000000
[  348.176645] PGD 8000000269378067 P4D 8000000269378067 PUD 25b8b8067 PMD 0 
[  348.177274] Oops: 0000 [#1] PREEMPT SMP PTI
[  348.177674] Dumping ftrace buffer:
[  348.178010]    (ftrace buffer empty)
[  348.178363] Modules linked in: ebtable_filter ebtables ip6table_filter ip6_tables target_core_mod xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c bridge stp llc iptable_filter fuse ip_tables nbd linear sd_mod sg crc32c_intel usb_storage ahci nvme shpchp libahci libata lpc_ich nvme_core virtio_scsi mfd_core binfmt_misc qemu_fw_cfg dm_mod iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi null_blk configs
[  348.182224] CPU: 0 PID: 8912 Comm: setpci Tainted: G        W         4.17.0-rc5.nvme_timeout_keith_V2+ #515
[  348.183103] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.9.3-1.fc25 04/01/2014
[  348.183867] RIP: 0010:prefetch_freepointer.isra.11+0xc/0x14
[  348.184388] RSP: 0018:ffffc900079f3c88 EFLAGS: 00010206
[  348.184877] RAX: 0000000000000000 RBX: 0000000001000000 RCX: 0000000203178000
[  348.185528] RDX: 0000000203176000 RSI: 0000000001000000 RDI: ffff880107c02c20
[  348.186281] RBP: ffff880107c02c00 R08: 00000000000260c0 R09: ffff880274489035
[  348.187182] R10: ffff8802728661b8 R11: 8080808080808080 R12: 00000000014080c0
[  348.188265] R13: 0000000000001000 R14: ffff8802624dc000 R15: ffff880107c02c00
[  348.189260] FS:  00007fab8d40d740(0000) GS:ffff88027fc00000(0000) knlGS:0000000000000000
[  348.190561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  348.191404] CR2: 0000000001000000 CR3: 00000002770e2003 CR4: 00000000003606f0
[  348.192425] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  348.193432] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  348.194489] Call Trace:
[  348.195012]  kmem_cache_alloc_trace+0xd7/0x173
[  348.195782]  ? kernfs_iop_get_link+0x3d/0x18c
[  348.196455]  ? __kernfs_create_file+0xa0/0xa0
[  348.197241]  kernfs_iop_get_link+0x3d/0x18c
[  348.198241]  ? __kernfs_create_file+0xa0/0xa0
[  348.199088]  link_path_walk+0x352/0x42e
[  348.199768]  ? path_init+0x116/0x29c
[  348.200607]  path_openat+0x214/0x286
[  348.201475]  ? memcg_kmem_put_cache+0x4e/0x60
[  348.202672]  do_filp_open+0x5c/0xc6
[  348.203734]  ? do_sys_open+0x14c/0x1e8
[  348.204417]  do_sys_open+0x14c/0x1e8
[  348.205088]  do_syscall_64+0x7e/0x139
[  348.205805]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  348.206623] RIP: 0033:0x7fab8cd40790
[  348.207251] RSP: 002b:00007fffde4b3008 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[  348.208535] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fab8cd40790
[  348.209489] RDX: 00007fffde4b3048 RSI: 0000000000000000 RDI: 00007fffde4b3020
[  348.210519] RBP: 0000000000943140 R08: 0000000000000000 R09: 0000000000000028
[  348.211564] R10: 0000000000000006 R11: 0000000000000246 R12: 00007fffde4b3020
[  348.212691] R13: 00007fffde4b3460 R14: 000000000093a010 R15: 000000000093a010
[  348.213787] Code: 89 fb 31 c9 ba 01 00 00 00 e8 b2 f6 ff ff 48 89 ee 48 89 df 31 c9 5b 5d 31 d2 e9 a1 f6 ff ff 0f 1f 44 00 00 48 85 f6 74 09 8b 07 <48> 8b 04 06 0f 18 08 c3 0f 1f 44 00 00 31 c0 c3 0f 1f 44 00 00 
[  348.217009] RIP: prefetch_freepointer.isra.11+0xc/0x14 RSP: ffffc900079f3c88
[  348.218418] CR2: 0000000001000000
[  348.219386] ---[ end trace 344142f7875d69d0 ]---


[2]
[ming at VM]$sudo ./check block/011
[sudo] password for ming:
block/011 => nvme0n1 (disable PCI device while doing I/O)
    runtime  ...
[  172.667675] kernel BUG at drivers/pci/msi.c:352!
[  172.669332] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  172.678379] Dumping ftrace buffer:
[  172.679644]    (ftrace buffer empty)
[  172.682009] Modules linked in: ebtable_filter ebtables ip6table_filter ip6_tables target_core_mod xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c bridge stp llc iptable_filter ip_tables fuse nbd linear sd_mod sg usb_storage crc32c_intel ahci libahci shpchp libata lpc_ich mfd_core nvme virtio_scsi nvme_core binfmt_misc qemu_fw_cfg dm_mod iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi null_blk configs
[  172.701034] CPU: 0 PID: 99 Comm: kworker/0:1H Tainted: G        W         4.17.0-rc5.nvme_timeout_keith_V2+ #515
[  172.703785] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.9.3-1.fc25 04/01/2014
[  172.706073] Workqueue: kblockd blk_mq_timeout_work
[  172.709777] RIP: 0010:free_msi_irqs+0x4c/0x155
[  172.711275] RSP: 0018:ffffc90001a73be8 EFLAGS: 00010282
[  172.712635] RAX: ffff88025b755800 RBX: ffff88024c118a20 RCX: 0000000000000000
[  172.713904] RDX: ffff88025b755800 RSI: ffffc90001a73bb0 RDI: ffff880107800248
[  172.715160] RBP: ffff88027700a000 R08: ffff8801078003e8 R09: ffff880107800248
[  172.719793] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  172.721568] R13: ffff88027700a298 R14: 0000000000000000 R15: ffff880276842000
[  172.723004] FS:  0000000000000000(0000) GS:ffff88027fc00000(0000) knlGS:0000000000000000
[  172.725161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.731642] CR2: 00007fe1071b1c90 CR3: 000000000200a001 CR4: 00000000003606f0
[  172.734676] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  172.738747] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  172.740079] Call Trace:
[  172.740727]  pci_disable_msix+0xda/0xf8
[  172.742008]  pci_free_irq_vectors+0xe/0x17
[  172.742910]  nvme_dev_disable+0x3b2/0x434 [nvme]
[  172.743899]  ? dev_warn+0x64/0x80
[  172.744760]  nvme_timeout+0x13c/0x2c9 [nvme]
[  172.745733]  ? _raw_spin_unlock_irq+0x1d/0x2e
[  172.746733]  ? wait_for_common+0x120/0x187
[  172.747745]  ? wake_up_q+0x4d/0x4d
[  172.748625]  blk_mq_terminate_expired+0x45/0x84
[  172.749540]  bt_for_each+0xcb/0xfd
[  172.750308]  ? blk_mq_requeue_request+0x53/0x53
[  172.753817]  ? blk_mq_requeue_request+0x53/0x53
[  172.754723]  blk_mq_queue_tag_busy_iter+0x80/0x8d
[  172.755771]  blk_mq_timeout_work+0x132/0x1d2
[  172.757335]  process_one_work+0x18f/0x2e6
[  172.758182]  worker_thread+0x1e3/0x2ab
[  172.758855]  ? rescuer_thread+0x293/0x293
[  172.759528]  kthread+0x113/0x11b
[  172.760131]  ? kthread_create_on_node+0x62/0x62
[  172.760852]  ret_from_fork+0x35/0x40


Thanks,
Ming
