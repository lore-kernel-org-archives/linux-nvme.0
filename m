From: Giridhar Malavali <gmalavali@marvell.com>
Date: Fri, 17 May 2019 12:48:57 -0700
Subject: [PATCH 1/1] nvme-fc: Wait for all the nvme host controllers and it's
 resources to be freed before unloading the nvme-fc module.
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190517194857.TJn69z4aFMDG1yE3aRRnFU8DO403a8t_JNK7VXDZ12Q@z>

The unload thread can proceed and unload before the nvme-fc host controller are freed.
This fix synchronizes between these threads to ensure unload thread continues only when all the nvme
host controller and it's resources are relased.

3357 [  225.292572] BUG: unable to handle kernel paging request at ffffffffc06871a8
3358 [  225.292611] IP: [<ffffffff96d54c59>] blk_mq_exit_hctx+0x49/0xf0
3359 [  225.292642] PGD f54e14067 PUD f54e16067 PMD 10586e4067 PTE 0
3360 [  225.292669] Oops: 0000 [#1] SMP
3361 [  225.292686] Modules linked in: macsec tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag binfmt_misc xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun devlink ip6t_rpfilter ipt_REJECT
3362 [  225.293011]  gf128mul glue_helper ablk_helper cryptd pcspkr joydev ipmi_ssif i2c_i801 sg hpwdt hpilo lpc_ich ipmi_si ipmi_devintf ipmi_msghandler ioatdma pcc_cpufreq wmi dca acpi_power_meter dm_multipath
3363 [  225.293249] CPU: 3 PID: 188 Comm: kworker/u49:1 Kdump: loaded Tainted: G           OE  ------------ T 3.10.0-nvmemodprobe+ #2
3364 [  225.293286] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 01/22/2018
3365 [  225.294356] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
3366 [  225.295371] task: ffff8a881a7ed230 ti: ffff8a881a168000 task.ti: ffff8a881a168000
3367 [  225.296518] RIP: 0010:[<ffffffff96d54c59>]  [<ffffffff96d54c59>] blk_mq_exit_hctx+0x49/0xf0
3368 [  225.297601] RSP: 0018:ffff8a881a16bc90  EFLAGS: 00010246
3369 [  225.298568] RAX: ffffffffc0687180 RBX: ffff8a881edacc00 RCX: 0000000000000000
3370 [  225.299520] RDX: ffff8a881edacc00 RSI: ffff8a90175990c8 RDI: 0000000000000000
3371 [  225.300466] RBP: ffff8a881a16bcb0 R08: ffff8a881a16bc08 R09: 0000000000000001
3372 [  225.301444] R10: 00000000000003e3 R11: 0000000000000000 R12: ffff8a90175990c8
3373 [  225.302392] R13: 0000000000000000 R14: ffff8a9015818000 R15: ffff8a9017599100
3374 [  225.303349] FS:  0000000000000000(0000) GS:ffff8a881fac0000(0000) knlGS:0000000000000000
3375 [  225.304322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
3376 [  225.305259] CR2: ffffffffc06871a8 CR3: 0000000f54e10000 CR4: 00000000001607e0
3377 [  225.306210] Call Trace:
3378 [  225.307188]  [<ffffffff96d59081>] blk_mq_free_queue+0x101/0x170
3379 [  225.308135]  [<ffffffff96d4a236>] blk_cleanup_queue+0x136/0x1b0
3380 [  225.309084]  [<ffffffffc05b994c>] ? nvme_free_ctrl+0x9c/0x100 [nvme_core]
3381 [  225.310065]  [<ffffffff96ea9e45>] ? device_release+0x35/0xa0
3382 [  225.311002]  [<ffffffff96d7e0a1>] ? kobject_release+0x81/0x1b0
3383 [  225.311928]  [<ffffffff96d7df38>] ? kobject_put+0x28/0x60
3384 [  225.312883]  [<ffffffff96eaa1b7>] ? put_device+0x17/0x20
3385 [  225.313816]  [<ffffffffc05b9811>] ? nvme_delete_ctrl_work+0xa1/0xb0 [nvme_core]
3386 [  225.314726]  [<ffffffff96abbacf>] ? process_one_work+0x17f/0x440
3387 [  225.315642]  [<ffffffff96abc796>] ? worker_thread+0x126/0x3c0
3388 [  225.316543]  [<ffffffff96abc670>] ? manage_workers.isra.26+0x2a0/0x2a0
3389 [  225.317364]  [<ffffffff96ac3a71>] ? kthread+0xd1/0xe0
3390 [  225.318172]  [<ffffffff96ac39a0>] ? insert_kthread_work+0x40/0x40
3391 [  225.319025]  [<ffffffff9717ecf7>] ? ret_from_fork_nospec_begin+0x21/0x21
3392 [  225.319827]  [<ffffffff96ac39a0>] ? insert_kthread_work+0x40/0x40
3393 [  225.320624] Code: d3 e8 fc 5b 02 00 8b 83 e8 00 00 00 85 c0 74 17 48 83 bb 20 01 00 00 00 74 0d f6 83 c8 00 00 00 04 0f 85 9b 00 00 00 49 8b 04 24 <48> 8b 40 28 48 85 c0 74 16 48 8b 93 a8 02 00 00 4c 89
3394 [  225.322654] RIP  [<ffffffff96d54c59>] blk_mq_exit_hctx+0x49/0xf0
3395 [  225.323487]  RSP <ffff8a881a16bc90>
3396 [  225.324293] CR2: ffffffffc06871a8
---
 drivers/nvme/host/fc.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 06c6931..e11e4f7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -206,8 +206,7 @@ static DEFINE_SPINLOCK(nvme_fc_lock);
 static LIST_HEAD(nvme_fc_lport_list);
 static DEFINE_IDA(nvme_fc_local_port_cnt);
 static DEFINE_IDA(nvme_fc_ctrl_cnt);
-
-
+struct completion nvme_fc_unload_proceed;
 
 /*
  * These items are short-term. They will eventually be moved into
@@ -242,6 +241,12 @@ nvme_fc_free_lport(struct kref *ref)
 	put_device(lport->dev);
 
 	kfree(lport);
+
+	/* If no other lport present then allow unload thread to continue
+ 	 * in case it is waiting
+ 	 */
+	if (list_empty(&nvme_fc_lport_list))
+		complete(&nvme_fc_unload_proceed);
 }
 
 static void
@@ -3417,6 +3422,7 @@ static int __init nvme_fc_init_module(void)
 	if (ret)
 		goto out_destroy_device;
 
+	init_completion(&nvme_fc_unload_proceed);
 	return 0;
 
 out_destroy_device:
@@ -3429,9 +3435,22 @@ out_destroy_class:
 static void __exit nvme_fc_exit_module(void)
 {
 	/* sanity check - all lports should be removed */
-	if (!list_empty(&nvme_fc_lport_list))
-		pr_warn("%s: localport list not empty\n", __func__);
 
+	u32 wait_tmo;
+	int ret;
+
+#define NVME_FC_UNLOAD_WAIT_TMO 1
+	/* Wait unloading the module until all resources are released */
+	wait_tmo = msecs_to_jiffies(NVME_FC_UNLOAD_WAIT_TMO * 1000);
+	while (!list_empty(&nvme_fc_lport_list)) {
+		ret = wait_for_completion_timeout(&nvme_fc_unload_proceed,
+                                                  wait_tmo);
+		if (unlikely(!ret)) {
+			pr_warn("%s: localport list not empty. Renew timer\n", __func__);
+			continue;
+		}
+		break;
+	}
 	nvmf_unregister_transport(&nvme_fc_transport);
 
 	ida_destroy(&nvme_fc_local_port_cnt);
-- 
1.8.3.1
