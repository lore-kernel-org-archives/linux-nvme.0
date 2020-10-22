Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC8C388F7
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 23:58:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BC520848
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 23:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CDleLCxf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BGCl4IH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BC520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AAuRE/9CvX7kw+Xnd7jkEej3JPMdZuFboADl4fS5I5o=; b=CDleLCxfagheNwe3OeOKqkEuZ8
	5HZkFxpA+Gz+9OIWo3Au4CIHn/sZ7HjHeWBQVkGl2HSKVgdkKnfzwvimM8JedWH4svG1b6UkUhZCK
	sdke64KcMmONeKCYjd6dtA0tKaHj61KUog1muK8gqD/954qe3sxwbmPfmtv2zfliUsj3vBhlMU8d7
	SQ05TP8jA2h8rr4M1CCutNk78Ftu/H/KIemGee8I6UimO+1aRqVpoqrmAoRe0/x7/RFkIjoLsNR5W
	o8s1e3ry8kw8NRcuXjyLPj+vqk3QWFFF1+rSnL6QTvUTysw4j0zJ6MxMtEBkuxNU+fluK//TF5n0I
	67EUkWfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVkTY-0007eo-Ta; Thu, 22 Oct 2020 23:58:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVkTS-0007cR-9F
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 23:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603411106; x=1634947106;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RFEv097lEjrEM7zAa6XesuhYwEuYXCed3RaGpm7NlYM=;
 b=BGCl4IH64bfmtTzvV7WbT693/0ERVC4YCIy8Tb6aanrTbhgt/qNTdXen
 YY8lemer0ojYufDgDOPKsuVdNUcBEdM5LXVEHxHFVwVbU+DJCq8EzD26i
 42NvMVIbyff4B/5MXF8hc5KH9H7AEWGcV8Gwbm6qtZ9wD/Q1/h2BX6s/k
 mLZXB5763/llRRQCPl+ryKwmzfwXeAtVeGZrJbr3fld9Y3Mic3aINV1ND
 dcaxxJyMgeFN9Ik0oCTJ0lK1A7ZZLACPMZ1wpEgLuyZvcqrxNBjdjIo4h
 hwBJDcnVCK21xsL66sW4njfkbyFjMuYlo5w/9lVM0zW5Aq4TnhhAxwsCi w==;
IronPort-SDR: bS016/Xjnnmon4+aVjYVXHwAslf84UqYUbe/UIIk3/xPKHnqG+s45LlRc0cUhA+LK3RK3oWJzw
 PzPAg6zAFfOA5LdgdQi51bFtnABehxUQiC4uIccggnEwA1Ae1RsCRNzeHnAyrzuBVgWsJjGa4Z
 xyrp13oF0U8kaOyc9r2HaL1VBGQdWkO3k8apEdEoyyU0EuaVAFlkIDAS36pwqwOkjsXs5zwbrn
 /ptFMiDbFAvt5eA4eA0CZGLGnJA9fsOJYENuzWAiiJoGH8zuFmFYBtqsB5mLbZXaKKHsDh66hF
 Rtg=
X-IronPort-AV: E=Sophos;i="5.77,404,1596470400"; d="scan'208";a="260569272"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 07:58:23 +0800
IronPort-SDR: MpE3fwww9hqd+3ikDpefvXA3cGHjwd0GGs3krTeUWgkOmo+H+wGpoDPQeSZLnDCA9dJy3LZncp
 tyRmKQR8Ews3dDAxXdIqOyqkzS/21SVWvTi1DRbGsbTtctZbyMvdaiW6wOIKKJK/UloTrUEGB5
 S1MblAE/33YW9cA3TyGRd9ktsZGH9UATb+k2kQP1XpYoYT2XHr85lHf3jmmgWKpTmvfBqHUh3Y
 L9CJZgyvnaPJdE8G3plgKr3qo2ATts90ns3I9eHmTuL8T9uEQ8ApXbjn8GptWMAd31lrzIFW5J
 3C0fqbIM+zWhdSHmWJKFKx4c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2020 16:44:47 -0700
IronPort-SDR: UKDsooKp9Pq+U6UMewAZpQXZeEre3lGomEfwdu5HILHeHdFKJLpw3j3ZLsX5qNv7wGlyBDdZ68
 cF+DwTPBomHX31WWqW/23eyQFNR0aomv0/WBiA0fa2PczBGQRtOSowQ7vIM9QGkdeeEEVy8VjG
 aIhC2pZeK/3S4H8LF0VvOSUVh0l0+AtlI+GzqgQTSc6Rphm5/fDJgdxyRk7CNX5g4TLNtlqspk
 JjLsCISxPI2GtEVAN3F+hbilEt/S7AmJ+YVPVEXLLCbAwUpAP6NJazoVQB8tnYPrpkPuly8tXA
 cAw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2020 16:58:24 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvmet: fix the Oops in the tracing for flush cmd
Date: Thu, 22 Oct 2020 16:58:21 -0700
Message-Id: <20201022235821.6760-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_195826_552995_8BCD251C 
X-CRM114-Status: GOOD (  17.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When target side trace in turned on and flush command is issued from the
host it results in the following Oops.

[  856.789724] BUG: kernel NULL pointer dereference, address: 0000000000000068
[  856.790686] #PF: supervisor read access in kernel mode
[  856.791262] #PF: error_code(0x0000) - not-present page
[  856.791863] PGD 6d7110067 P4D 6d7110067 PUD 66f0ad067 PMD 0
[  856.792527] Oops: 0000 [#1] SMP NOPTI
[  856.792950] CPU: 15 PID: 7034 Comm: nvme Tainted: G           OE     5.9.0nvme-5.9+ #71
[  856.793790] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e3214
[  856.794956] RIP: 0010:trace_event_raw_event_nvmet_req_init+0x13e/0x170 [nvmet]
[  856.795734] Code: 41 5c 41 5d c3 31 d2 31 f6 e8 4e 9b b8 e0 e9 0e ff ff ff 49 8b 55 00 48 8b 38 8b 0
[  856.797740] RSP: 0018:ffffc90001be3a60 EFLAGS: 00010246
[  856.798375] RAX: 0000000000000000 RBX: ffff8887e7d2c01c RCX: 0000000000000000
[  856.799234] RDX: 0000000000000020 RSI: 0000000057e70ea2 RDI: ffff8887e7d2c034
[  856.800088] RBP: ffff88869f710578 R08: ffff888807500d40 R09: 00000000fffffffe
[  856.800951] R10: 0000000064c66670 R11: 00000000ef955201 R12: ffff8887e7d2c034
[  856.801807] R13: ffff88869f7105c8 R14: 0000000000000040 R15: ffff88869f710440
[  856.802667] FS:  00007f6a22bd8780(0000) GS:ffff888813a00000(0000) knlGS:0000000000000000
[  856.803635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  856.804367] CR2: 0000000000000068 CR3: 00000006d73e0000 CR4: 00000000003506e0
[  856.805283] Call Trace:
[  856.805613]  nvmet_req_init+0x27c/0x480 [nvmet]
[  856.806200]  nvme_loop_queue_rq+0xcb/0x1d0 [nvme_loop]
[  856.806862]  blk_mq_dispatch_rq_list+0x123/0x7b0
[  856.807459]  ? kvm_sched_clock_read+0x14/0x30
[  856.808025]  __blk_mq_sched_dispatch_requests+0xc7/0x170
[  856.808708]  blk_mq_sched_dispatch_requests+0x30/0x60
[  856.809372]  __blk_mq_run_hw_queue+0x70/0x100
[  856.809935]  __blk_mq_delay_run_hw_queue+0x156/0x170
[  856.810574]  blk_mq_run_hw_queue+0x86/0xe0
[  856.811104]  blk_mq_sched_insert_request+0xef/0x160
[  856.811733]  blk_execute_rq+0x69/0xc0
[  856.812212]  ? blk_mq_rq_ctx_init+0xd0/0x230
[  856.812784]  nvme_execute_passthru_rq+0x57/0x130 [nvme_core]
[  856.813461]  nvme_submit_user_cmd+0xeb/0x300 [nvme_core]
[  856.814099]  nvme_user_cmd.isra.82+0x11e/0x1a0 [nvme_core]
[  856.814752]  blkdev_ioctl+0x1dc/0x2c0
[  856.815197]  block_ioctl+0x3f/0x50
[  856.815606]  __x64_sys_ioctl+0x84/0xc0
[  856.816074]  do_syscall_64+0x33/0x40
[  856.816533]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  856.817168] RIP: 0033:0x7f6a222ed107
[  856.817617] Code: 44 00 00 48 8b 05 81 cd 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 8
[  856.819901] RSP: 002b:00007ffca848f058 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  856.820846] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f6a222ed107
[  856.821726] RDX: 00007ffca848f060 RSI: 00000000c0484e43 RDI: 0000000000000003
[  856.822603] RBP: 0000000000000003 R08: 000000000000003f R09: 0000000000000005
[  856.823478] R10: 00007ffca848ece0 R11: 0000000000000202 R12: 00007ffca84912d3
[  856.824359] R13: 00007ffca848f4d0 R14: 0000000000000002 R15: 000000000067e900
[  856.825236] Modules linked in: nvme_loop(OE) nvmet(OE) nvme_fabrics(OE) null_blk nvme(OE) nvme_corel

Move the nvmet_req_init() tracepoint after we parse the command in
nvmet_req_init() so that we can get rid of the duplicate
nvmet_find_namespace() call.
Rename __assign_disk_name() ->  __assign_req_name(). Now that we call
tracepoint after parsing the command simplify the newly added
__assign_req_name() which fixes this bug.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-

1. Move the nvmet_req_init() tracepoint after we parse the command in
   nvmet_req_init().
2. Rename __assign_disk_name() -> __assign_req_name().
3. Simplify the newly added __assign_req_name() which fixes this bug.
4. Update the commit log.

---
 drivers/nvme/target/core.c  |  4 ++--
 drivers/nvme/target/trace.h | 21 +++++++--------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index aafcbc424b7a..957b39a82431 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -907,8 +907,6 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
-	trace_nvmet_req_init(req, req->cmd);
-
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
@@ -938,6 +936,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (status)
 		goto fail;
 
+	trace_nvmet_req_init(req, req->cmd);
+
 	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 0458046d6501..c14e3249a14d 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -46,19 +46,12 @@ static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
 	return req->sq->ctrl;
 }
 
-static inline void __assign_disk_name(char *name, struct nvmet_req *req,
-		bool init)
+static inline void __assign_req_name(char *name, struct nvmet_req *req)
 {
-	struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
-	struct nvmet_ns *ns;
-
-	if ((init && req->sq->qid) || (!init && req->cq->qid)) {
-		ns = nvmet_find_namespace(ctrl, req->cmd->rw.nsid);
-		strncpy(name, ns->device_path, DISK_NAME_LEN);
-		return;
-	}
-
-	memset(name, 0, DISK_NAME_LEN);
+	if (req->ns)
+		strncpy(name, req->ns->device_path, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
 }
 #endif
 
@@ -81,7 +74,7 @@ TRACE_EVENT(nvmet_req_init,
 	TP_fast_assign(
 		__entry->cmd = cmd;
 		__entry->ctrl = nvmet_req_to_ctrl(req);
-		__assign_disk_name(__entry->disk, req, true);
+		__assign_req_name(__entry->disk, req);
 		__entry->qid = req->sq->qid;
 		__entry->cid = cmd->common.command_id;
 		__entry->opcode = cmd->common.opcode;
@@ -121,7 +114,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__entry->cid = req->cqe->command_id;
 		__entry->result = le64_to_cpu(req->cqe->result.u64);
 		__entry->status = le16_to_cpu(req->cqe->status) >> 1;
-		__assign_disk_name(__entry->disk, req, false);
+		__assign_req_name(__entry->disk, req);
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
 		__print_ctrl_name(__entry->ctrl),
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
