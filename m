From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 20 Jul 2018 11:33:21 -0700
Subject: [PATCH] nvme: use ns head lock for lockdep
Message-ID: <1532111601-9123-1-git-send-email-chaitanya.kulkarni@wdc.com>

This patch uses ns->head->lock as instead of to ns->head->subsys->lock
in the function nvme_mpath_add_disk() when checking for the lockdep and
fixes the following warning :-

[ 5029.575931] WARNING: CPU: 6 PID: 414 at drivers/nvme//host/multipath.c:275 nvme_mpath_set_live.isra.3+0x53/0xb0 [nvme_core]
[ 5029.575948] Modules linked in: nvme(OE) nvme_core(OE) xt_CHECKSUM ipt_MASQUERADE tun ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter btrfs ppdev sb_edac crct10dif_pclmul crc32_pclmul xor ghash_clmulni_intel zstd_decompress zstd_compress pcbc xxhash raid6_pq aesni_intel crypto_simd cryptd glue_helper sg parport_pc joydev parport i2c_piix4 pcspkr nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ata_generic
[ 5029.576249]  pata_acpi virtio_net net_failover failover bochs_drm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm crc32c_intel ata_piix libata virtio_pci virtio_ring i2c_core serio_raw virtio floppy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: nvme_core]
[ 5029.576360] CPU: 6 PID: 414 Comm: kworker/u24:2 Tainted: G        W  OE     4.17.0NVME-ANA-MPATH-231396-g1b46497 #1
[ 5029.576365] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
[ 5029.576375] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[ 5029.576388] RIP: 0010:nvme_mpath_set_live.isra.3+0x53/0xb0 [nvme_core]
[ 5029.576392] Code: 48 8b 3b 5b 5d 48 83 c7 68 e9 d9 5c 0c ca 48 8b 85 d8 4a 01 00 be ff ff ff ff 48 8d b8 50 05 00 00 e8 41 d4 dd c9 85 c0 75 c4 <0f> 0b 48 8b 75 00 48 85 f6 75 c2 5b 5d c3 48 8b 85 d8 4a 01 00 48
[ 5029.576650] RSP: 0018:ffffbcf4844ebc78 EFLAGS: 00010246
[ 5029.576659] RAX: 0000000000000000 RBX: ffff992dc0edb6b8 RCX: 0000000000000000
[ 5029.576664] RDX: 0000000000000000 RSI: ffff992da7824688 RDI: 0000000000000246
[ 5029.576669] RBP: ffff992c748c0000 R08: 0000000000000001 R09: 0000000000000000
[ 5029.576674] R10: ffff992dcba70d90 R11: 0000000000000001 R12: ffff992dbd9bc548
[ 5029.576679] R13: ffff992dcbd7c688 R14: ffff992dcbd7c678 R15: ffff992dc0edb668
[ 5029.576685] FS:  0000000000000000(0000) GS:ffff992ddf200000(0000) knlGS:0000000000000000
[ 5029.576690] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5029.576695] CR2: 00007f41a1781000 CR3: 0000000021c12006 CR4: 0000000000060ee0
[ 5029.576705] Call Trace:
[ 5029.576720]  nvme_mpath_add_disk+0x85/0xa0 [nvme_core]
[ 5029.576732]  nvme_validate_ns+0x52e/0x8e0 [nvme_core]
[ 5029.576774]  nvme_scan_work+0xd6/0x370 [nvme_core]
[ 5029.576802]  ? process_one_work+0x18c/0x640
[ 5029.576822]  process_one_work+0x21b/0x640
[ 5029.576828]  ? process_one_work+0x18c/0x640
[ 5029.576864]  worker_thread+0x46/0x3e0
[ 5029.576884]  kthread+0xf8/0x130
[ 5029.576890]  ? process_one_work+0x640/0x640
[ 5029.576895]  ? kthread_bind+0x10/0x10
[ 5029.576909]  ret_from_fork+0x3a/0x50
[ 5029.576942] irq event stamp: 2598702
[ 5029.576950] hardirqs last  enabled at (2598701): [<ffffffff8a886cb7>] __slab_alloc+0x62/0x7b
[ 5029.576957] hardirqs last disabled at (2598702): [<ffffffff8b001389>] error_entry+0x89/0x110
[ 5029.576964] softirqs last  enabled at (2597984): [<ffffffff8b200369>] __do_softirq+0x369/0x485
[ 5029.576972] softirqs last disabled at (2597977): [<ffffffff8a6a1e67>] irq_exit+0xe7/0x100
[ 5029.576977] ---[ end trace d6ab0742207e997a ]---

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---

Hi,

I am not sure if this is alredy reported or fixed.

This patch is generated against :-
Repo :- git://git.infradead.org/users/hch/block.git
Branch :- nvme-ana
Commit :- nvmet: support configuring ANA groups
          (1b464972552ddbd1e47d43b641a31add4770830b).

In case I'm using wrong tree please let me know.

Regards,
Chaitanya
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8980b01..35ce96f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -272,7 +272,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
-	lockdep_assert_held(&ns->head->subsys->lock);
+	lockdep_assert_held(&ns->head->lock);
 
 	if (!head->disk)
 		return;
-- 
1.8.3.1
