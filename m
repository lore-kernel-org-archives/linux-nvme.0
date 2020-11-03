Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FFDC55178
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 01:27:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86BB22264
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 01:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UvkiU/eo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUkidwhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86BB22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=crWqBmEP9i5jVCuve9bnpquAJUQ8wIKAUPuY65oNIB8=; b=UvkiU/eoboYvNnfORfckv7X/e
	83h5FlTt6BhefvHzcENQV/dCuYQuqE0sVlfaNXQLX0IptmFF2YIX7t6fK78KHB/ZnnqK3pAsRuj7x
	aDBcNH1oJ9mpzB9fzfr4ZbMFBbwETAZ9ejH2fQE9BX6wjkjBas+/wD+wkTeZZMacuTnaWgfZWP2/j
	Z788zlQ0l/nFgShKz2866mWCwUiQ7LKUOV1YRptvwxJzo0t0CHS8RBeHDPEP/ftOgrJeF8z8mtqaN
	oII5yDYsMykVuKsIugJT9rBl8T1w3VK35FazW6oW2XC1B+j8RBVH29vrQBkX7JOe7HX/DvLrcnVXu
	WbdWJszmg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZl6G-0000Nt-4A; Tue, 03 Nov 2020 01:27:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZkzR-0005LU-1D
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 01:20:03 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 70D6B22400;
 Tue,  3 Nov 2020 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604366399;
 bh=Ge5MJppyxV5a3/5OLlzv8A3mRmtLPO8CE+rJqoggSxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WUkidwhVK+NIL7Xu9adn68ir3eKYF6yAnbIyKwM5IQbITcXmIQtVGVF6HF8K45UpO
 Qi8QRZaHXOmnRJbY3x3/4uRbsaEZ8BqFVoOKYUocAhuGL4cRvGEqnRdopXHcQKM6id
 vKhFxv3CcM76leO8w6c3iYdLYsToMBdm7lHT+5z4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 23/29] nvmet: fix a NULL pointer dereference when
 tracing the flush command
Date: Mon,  2 Nov 2020 20:19:22 -0500
Message-Id: <20201103011928.183145-23-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103011928.183145-1-sashal@kernel.org>
References: <20201103011928.183145-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_202001_356383_D7C383AC 
X-CRM114-Status: GOOD (  18.56  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 3c3751f2daf6675f6b5bee83b792354c272f5bd2 ]

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
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c  |  4 ++--
 drivers/nvme/target/trace.h | 21 +++++++--------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 75ed95a250fb5..74f15e265389c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -923,8 +923,6 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
-	trace_nvmet_req_init(req, req->cmd);
-
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
@@ -954,6 +952,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (status)
 		goto fail;
 
+	trace_nvmet_req_init(req, req->cmd);
+
 	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 0458046d65017..c14e3249a14dc 100644
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
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
