From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 26 Mar 2018 11:39:37 +0800
Subject: [PATCH] nvme-loop: fix kernel oops in case of unhandled command
Message-ID: <20180326033937.7866-1-ming.lei@redhat.com>

When nvmet_req_init() fails, __nvmet_req_complete() is called
to handle the target request via .queue_response(), so
nvme_loop_queue_response() shouldn't be called again for
handling the failure.

This patch fixes this case by the following way:

- move blk_mq_start_request() before nvmet_req_init(), so
nvme_loop_queue_response() may work well to complete this
host request

- don't call nvme_cleanup_cmd() which is done in nvme_loop_complete_rq()

- don't call nvme_loop_queue_response() which is done via
.queue_response()

The following oops is fixed by this patch:

[ 6510.011692] nvmet: unhandled cmd 6 on qid 0
[ 6510.013110] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 6510.014114] IP: _raw_spin_lock_irqsave+0x2c/0x46
[ 6510.014766] PGD 162f8d067 P4D 162f8d067 PUD 15d990067 PMD 0
[ 6510.015770] Oops: 0002 [#1] PREEMPT SMP NOPTI
[ 6510.016554] Dumping ftrace buffer:
[ 6510.016763] systemd-journald[208]: Compressed data object 708 -> 468 using XZ
[ 6510.017114]    (ftrace buffer empty)
[ 6510.017115] Modules linked in: nvme_loop nvme_rdma nvme_fabrics nvmet_rdma nvmet ib_srpt tcm_loop ebtable_filter ebtables iscsi_target_mod ip6table_filter ip6_tables target_core_file target_core_iblock target_core_pscsi target_core_mod xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c bridge fuse stp llc iptable_filter ip_tables raid1 sd_mod sg ahci libahci sdhci_pci cqhci crc32c_intel sdhci lpc_ich libata mmc_core mfd_core shpchp nvme nvme_core virtio_scsi binfmt_misc qemu_fw_cfg dm_mod ib_iser rdma_cm iw_cm usb_storage ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi null_blk configs
[ 6510.027685] CPU: 0 PID: 2165 Comm: nvme Tainted: G        W        4.16.0-rc4+ #365
[ 6510.028867] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.9.3-1.fc25 04/01/2014
[ 6510.030602] RIP: 0010:_raw_spin_lock_irqsave+0x2c/0x46
[ 6510.031516] RSP: 0018:ffffc90001c77aa0 EFLAGS: 00010046
[ 6510.032481] RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffff88017b800000
[ 6510.033652] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000001
[ 6510.034861] RBP: 0000000000000246 R08: 00000000000003e8 R09: 0000000000000001
[ 6510.036207] R10: ffff88015e0d61c0 R11: ffffffff826f1ba8 R12: 0000000000000000
[ 6510.037715] R13: ffff880279975000 R14: ffff8801726e5c78 R15: ffffe8fefb846240
[ 6510.039232] FS:  00007f729f5ec780(0000) GS:ffff88017b800000(0000) knlGS:0000000000000000
[ 6510.041278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6510.042465] CR2: 0000000000000008 CR3: 0000000171646001 CR4: 00000000003606f0
[ 6510.043736] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6510.044992] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6510.046250] Call Trace:
[ 6510.046824]  complete+0x18/0x49
[ 6510.047551]  __blk_mq_complete_request+0x139/0x158
[ 6510.048497]  blk_mq_complete_request+0x63/0x8b
[ 6510.049383]  nvme_loop_queue_rq+0x12c/0x1ed [nvme_loop]
[ 6510.050480]  blk_mq_dispatch_rq_list+0x2e4/0x491
[ 6510.052160]  blk_mq_sched_dispatch_requests+0x156/0x178
[ 6510.053487]  __blk_mq_run_hw_queue+0xa4/0xcc
[ 6510.054472]  __blk_mq_delay_run_hw_queue+0x6a/0xe5
[ 6510.055483]  blk_mq_run_hw_queue+0x9a/0xd2
[ 6510.056295]  blk_mq_sched_insert_request+0xc4/0x138
[ 6510.057206]  blk_execute_rq+0x4b/0x93
[ 6510.057963]  nvme_submit_user_cmd+0x1e8/0x27e [nvme_core]
[ 6510.058840]  nvme_user_cmd+0x1b8/0x2ce [nvme_core]
[ 6510.059646]  ? _raw_spin_unlock+0x16/0x27
[ 6510.060509]  ? do_anonymous_page+0x3bf/0x470
[ 6510.061394]  nvme_dev_ioctl+0x5b/0x150 [nvme_core]
[ 6510.062264]  vfs_ioctl+0x1b/0x28
[ 6510.062923]  do_vfs_ioctl+0x4bc/0x542
[ 6510.063747]  ? __do_page_fault+0x458/0x509
[ 6510.064645]  SyS_ioctl+0x3e/0x5a
[ 6510.065539]  do_syscall_64+0x97/0x158
[ 6510.066365]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[ 6510.067472] RIP: 0033:0x7f729ef0a687
[ 6510.068411] RSP: 002b:00007ffdd4aaade8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[ 6510.070284] RAX: ffffffffffffffda RBX: 00007ffdd4aaadf0 RCX: 00007f729ef0a687
[ 6510.071405] RDX: 00007ffdd4aaadf0 RSI: 00000000c0484e41 RDI: 0000000000000003
[ 6510.072306] RBP: 0000000000000000 R08: 0000000000000001 R09: 00007ffdd4aaae40
[ 6510.073287] R10: 000000000000053f R11: 0000000000000206 R12: 000000000063ea40
[ 6510.074254] R13: 00007ffdd4aaf8e5 R14: 000000000063ea40 R15: 00007ffdd4aaf2e0
[ 6510.075305] Code: 1f 44 00 00 55 53 48 89 fb 9c 58 0f 1f 44 00 00 48 89 c5 fa 66 0f 1f 44 00 00 bf 01 00 00 00 e8 0d ff a6 ff 31 c0 ba 01 00 00 00 <f0> 0f b1 13 85 c0 74 0c 89 c6 48 89 df e8 e4 37 a9 ff 66 90 48
[ 6510.078069] RIP: _raw_spin_lock_irqsave+0x2c/0x46 RSP: ffffc90001c77aa0
[ 6510.079044] CR2: 0000000000000008
[ 6510.079721] ---[ end trace f8c1251f997256fd ]---
[ 6510.080567] Kernel panic - not syncing: Fatal exception
[ 6510.081549] Dumping ftrace buffer:
[ 6510.082161]    (ftrace buffer empty)
[ 6510.082812] Kernel Offset: disabled
[ 6510.083550] ---[ end Kernel panic - not syncing: Fatal exception

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/loop.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 861d1509b22b..76150d87e4f8 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -174,15 +174,12 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
+	blk_mq_start_request(req);
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = nvmet_loop_port;
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvme_loop_ops)) {
-		nvme_cleanup_cmd(req);
-		blk_mq_start_request(req);
-		nvme_loop_queue_response(&iod->req);
+			&queue->nvme_sq, &nvme_loop_ops))
 		return BLK_STS_OK;
-	}
 
 	if (blk_rq_payload_bytes(req)) {
 		iod->sg_table.sgl = iod->first_sgl;
@@ -196,8 +193,6 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		iod->req.transfer_len = blk_rq_payload_bytes(req);
 	}
 
-	blk_mq_start_request(req);
-
 	schedule_work(&iod->work);
 	return BLK_STS_OK;
 }
-- 
2.9.5
