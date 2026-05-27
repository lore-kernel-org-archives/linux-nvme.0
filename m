Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D6DCD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 05:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bzTGn9hr6uH1iCygCUxbYWLObtb15WQO/tFO/Zj+W+8=; b=l3ejf1TL955VelnT5Z2tJ4Ud5a
	gnp/4hZJ91y6w6TGhV0Y2PTIbvGeo9AMxPwAK0r6njytnMsWvPHxWxa6SVUPpaVm//bIX+Q6Cbf4r
	hihcfbG67cXp6ml5R7KwWqAFQyeCvSReSKj/z1nhyeEMpsOpTPFgl/bHr1eoHDtQJyZaaabo+bz33
	48ZZF1PeY9L9BF53eF4fzCv5qJiKxypxlSyFP6ZEWZeW92j+uVIZsACattQUrj1umZVsRr7cFOh9R
	f8An7DH9fUQIx+3JM+0YrzayE7KHRh3lZRprwpAHe47JxEhOKSEVxqdCenrrn2oxjJ54BdTXgrh+C
	6dX+WpfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7If-00000003NWI-2krp;
	Wed, 27 May 2026 05:59:29 +0000
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7Id-00000003NVo-1RUB
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 05:59:29 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-6314c3818baso8867504137.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779861565; x=1780466365; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzTGn9hr6uH1iCygCUxbYWLObtb15WQO/tFO/Zj+W+8=;
        b=bVsGm9Zqu8ZnE1894CwbtTmcE+4w3708l0dLOL/i6Eo1pIzlWvppon4uDmAdz6tGcW
         WiEZ/d9qC+w3NbX0E1sSC07KwgTBp/c5EDUIMnUEeHiXDdYaPumK9yMa99toe85FDcCl
         GfU2pyw4GokOhtiCiZF3YEVZGPZxcYSIXW8jiEHmRuOxjB3SqR1erUYWQFuOydqQrSlU
         sjaJLXo8wkk7Kn4iiGBC7FIKaTFbpwhljS7AuIBvr/N/EBpAA8zTZkG4KEuzmkFTUYj3
         GPwyhDVuj1L4ggYYLKVJ5jbAl3cy/s944aDTfw+sZwUuioe2kMoZ7b1gGz0aXgH9R3x7
         Vz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861565; x=1780466365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzTGn9hr6uH1iCygCUxbYWLObtb15WQO/tFO/Zj+W+8=;
        b=aWC/27HtVx/bEbpUOqfaluCGZ5SEkd/omrxA+7G8TatLurwXowd1aM7G0eSt7yUO+q
         sq4+EOKlk7sPfezvcThQBfwCP+DOTOovDJUOVTEVSl5k405FmXTf01Cgh1fzh842XZSk
         EpNr9QKph/j9tqP5JK6vv3LVpTxk9yoxsEc0+RjFO/8KC4qVN/6vJrxOdOp2K59n+UB7
         4bBmDoiwO1QRMxRAoC4FPvn7nYLLCDbqDk1Di/i4kIJRJu3THDXZjhzXTjooHqnsiS2W
         vjx4x3EWI3yytRa6db82hLvSh0W5ESO3e2iWtrtW+EC+OrX2Ctw495mgOe9O4hAg2Xqm
         p4bw==
X-Forwarded-Encrypted: i=1; AFNElJ8F/GhN4gHbJOsu6FoiKdEvSFDJwcGkSoCCr8D5LWvXMxLJdZeB8sI2GsHct4uzx3b+LowzKfDuawhc@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2ZcN0ACL2vcM8DCq/T3tEZQs2LcX4+dEzuFz66ZvZq+YlB6PN
	syHydxn2c3OOwhwHp8uWb2TPKyCdLjZgI8KwSzhq1xm4RnWn0HU7U0RD
X-Gm-Gg: Acq92OG9aISp/JuB7NDMdS1Pg3KXpmPVvujfUbhAgmBYYZiM2/Sic1oqUYoFu3QywhO
	zxN4doD/pwAFAYJw5bQqjNocuKoTEFTBwWdVyUcsYP3lRhcfRUveh2ZBmIph1g71HrYAlRSxq0+
	2teQb5ca4K/MpWXvDT9OZA0BEcHYU8EThEhVzI0uFPeftqXhwjJ2meLFoVvVYkeaYzdsXqGT7ay
	xPTW9Ev6Tz38GnMLDSE10p9BDIc8oGOAMuelUXuluiPGZkME/7E4gvQLa7RQHlEgX/dnvWG02+v
	GnqWKGYIdqFBwolMUf3OEcLtJxHFVBIsULNiCiKSveEmcG7cKzyDzhnA7RUVqNmcXhAfl5Vi7Hm
	5ENaqPB3FiClrAyC+JRIUFhHNAiBOOlvnsYH32q785uevtC8Fi8SZD/DexnUjpQVU93iYulJLgR
	T/jF3i4iQSMg54y56T5eaosem9A1L9U0S/+5xv+NK4avtVVHmyNmdVbl4eAusTC14=
X-Received: by 2002:a05:6102:809f:b0:632:a084:c0f7 with SMTP id ada2fe7eead31-67c85b3e92dmr10373841137.17.1779861565438;
        Tue, 26 May 2026 22:59:25 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-961d388f339sm1537950241.12.2026.05.26.22.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:59:24 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH] nvme: bound the freeze drain in passthrough commands
Date: Wed, 27 May 2026 01:59:23 -0400
Message-ID: <20260527055923.456769-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_225927_399905_5E08B6E7 
X-CRM114-Status: GOOD (  18.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_passthru_start() drains in-flight I/O via the unbounded
nvme_wait_freeze() before submitting a command with command-set
effects (Format NVM, Sanitize, Namespace Management, vendor unique).
If a completion is silently dropped or the device hangs, the calling
task wedges with ctrl->scan_lock and ctrl->subsys->lock held, fanning
out into hung-task reports on any concurrent open/close/passthru on
the same controller:

  INFO: task syz-executor:NNNN blocked for more than 123 seconds.
   nvme_wait_freeze+0x82/0x100
   nvme_passthru_start drivers/nvme/host/core.c:1249 [inline]
   nvme_submit_user_cmd+0x1ee/0x3d0 drivers/nvme/host/ioctl.c:189

The other freeze-drain sites (pci shutdown, tcp/rdma reset) already
bound the wait with nvme_wait_freeze_timeout(NVME_IO_TIMEOUT).  Apply
it here too; on timeout, unwind the freeze and return -EBUSY (or
NVME_SC_INTERNAL on the nvmet path) instead of submitting the command.

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c       | 26 ++++++++++++++++++++------
 drivers/nvme/host/ioctl.c      |  7 ++++++-
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/nvme/target/passthru.c |  7 ++++++-
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001..575f98b9a6cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1232,23 +1232,37 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, "NVME_TARGET_PASSTHRU");
 
-u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
+int nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode,
+			u32 *effects)
 {
-	u32 effects = nvme_command_effects(ctrl, ns, opcode);
+	*effects = nvme_command_effects(ctrl, ns, opcode);
 
 	/*
 	 * For simplicity, IO to all namespaces is quiesced even if the command
-	 * effects say only one namespace is affected.
+	 * effects say only one namespace is affected.  Bound the drain wait so
+	 * a stuck I/O cannot wedge the passthrough caller (and any task on the
+	 * scan_lock or subsys lock) indefinitely; the other in-tree callers of
+	 * the freeze drain (pci shutdown, tcp/rdma reset) already use this same
+	 * NVME_IO_TIMEOUT bound.
 	 */
-	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
+	if (*effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		mutex_lock(&ctrl->scan_lock);
 		mutex_lock(&ctrl->subsys->lock);
 		nvme_mpath_start_freeze(ctrl->subsys);
 		nvme_mpath_wait_freeze(ctrl->subsys);
 		nvme_start_freeze(ctrl);
-		nvme_wait_freeze(ctrl);
+		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+			dev_warn(ctrl->device,
+				 "I/O did not drain in %u seconds; aborting passthrough\n",
+				 nvme_io_timeout);
+			nvme_unfreeze(ctrl);
+			nvme_mpath_unfreeze(ctrl->subsys);
+			mutex_unlock(&ctrl->subsys->lock);
+			mutex_unlock(&ctrl->scan_lock);
+			return -EBUSY;
+		}
 	}
-	return effects;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, "NVME_TARGET_PASSTHRU");
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a9c097dacad6..762458a23b38 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -186,7 +186,12 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
-	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	ret = nvme_passthru_start(ctrl, ns, cmd->common.opcode, &effects);
+	if (ret) {
+		if (bio)
+			blk_rq_unmap_user(bio);
+		goto out_free_req;
+	}
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..665d75de044e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1211,7 +1211,8 @@ static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
+int nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode,
+			u32 *effects);
 int nvme_execute_rq(struct request *rq, bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 67c423a8b052..7b97bfc1ace6 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -220,7 +220,12 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	u32 effects;
 	int status;
 
-	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
+	status = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode, &effects);
+	if (status) {
+		nvmet_req_complete(req, NVME_SC_INTERNAL);
+		blk_mq_free_request(rq);
+		return;
+	}
 	status = nvme_execute_rq(rq, false);
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
-- 
2.43.0


