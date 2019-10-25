Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09CACA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3C321655
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+cH5tPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3C321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N6/BacijshZACZ6U4YNYqcYWMI6Q14zwHLJ0d0sJbxY=; b=e+cH5tPe4KtzJU
	DjjGQ3jrFR0hPYhebzYV5JD0FutEkPYtThRxhvql7B0r+KKp0AmBd+pBkwir1z76+Pg/20uu8sFs6
	rGemFlXl4RfWkMXP0Jk0kv93mfAcbJBQJrrRulg/zbuAiWN86iw2gJ/UzBh624t6JknTny/F1PwNH
	XVAwR7rB7HKlGBv9B1dG7EAR5MGAh5tLRj6J3O6UKyJEUQUYegZMOj9mjGsY5GLZgu1BBYCiBFkrv
	Kv0VnV7P34R1hmXfBtKwlwIn7atEJCe3KNUNVIOqSRiTydl2GuKtzv9MDd+GDlfpytlSOot6goXWY
	T6sB7RckQmLbkHoE9LUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO6A2-000822-Mw; Fri, 25 Oct 2019 20:26:14 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO69U-0007YG-VW
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 20:25:43 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1iO69R-00078c-Ir; Fri, 25 Oct 2019 14:25:40 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1iO69Q-00038w-M8; Fri, 25 Oct 2019 14:25:36 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 25 Oct 2019 14:25:33 -0600
Message-Id: <20191025202535.12036-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025202535.12036-1-logang@deltatee.com>
References: <20191025202535.12036-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com,
 maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 1/3] nvme: Move nvme_passthru_[start|end]() calls to
 common code
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_132541_341813_9C2D9C62 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce a new nvme_execute_passthru_rq() helper which calls
nvme_passthru_[start|end]() around blk_execute_rq(). This ensures
all passthru calls (including nvme_submit_io()) will be
wrapped appropriatly.

nvme_execute_passthru_rq() will also be useful for the nvmet
passthru code.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 183 ++++++++++++++++++++-------------------
 1 file changed, 95 insertions(+), 88 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..c2bde988d1aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -886,6 +886,100 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
+static u32 nvme_known_admin_effects(u8 opcode)
+{
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+					NVME_CMD_EFFECTS_CSE_MASK;
+	case nvme_admin_sanitize_nvm:
+		return NVME_CMD_EFFECTS_CSE_MASK;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			       u8 opcode)
+{
+	u32 effects = 0;
+
+	if (ns) {
+		if (ctrl->effects)
+			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
+		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
+			dev_warn(ctrl->device,
+				 "IO command:%02x has unhandled effects:%08x\n",
+				 opcode, effects);
+		return 0;
+	}
+
+	if (ctrl->effects)
+		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
+	effects |= nvme_known_admin_effects(opcode);
+
+	/*
+	 * For simplicity, IO to all namespaces is quiesced even if the command
+	 * effects say only one namespace is affected.
+	 */
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+		mutex_lock(&ctrl->scan_lock);
+		mutex_lock(&ctrl->subsys->lock);
+		nvme_mpath_start_freeze(ctrl->subsys);
+		nvme_mpath_wait_freeze(ctrl->subsys);
+		nvme_start_freeze(ctrl);
+		nvme_wait_freeze(ctrl);
+	}
+	return effects;
+}
+
+static void nvme_update_formats(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		if (ns->disk && nvme_revalidate_disk(ns->disk))
+			nvme_set_queue_dying(ns);
+	up_read(&ctrl->namespaces_rwsem);
+}
+
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+{
+	/*
+	 * Revalidate LBA changes prior to unfreezing. This is necessary to
+	 * prevent memory corruption if a logical block size was changed by
+	 * this command.
+	 */
+	if (effects & NVME_CMD_EFFECTS_LBCC)
+		nvme_update_formats(ctrl);
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+		nvme_unfreeze(ctrl);
+		nvme_mpath_unfreeze(ctrl->subsys);
+		mutex_unlock(&ctrl->subsys->lock);
+		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
+		mutex_unlock(&ctrl->scan_lock);
+	}
+	if (effects & NVME_CMD_EFFECTS_CCC)
+		nvme_init_identify(ctrl);
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+		nvme_queue_scan(ctrl);
+}
+
+static void nvme_execute_passthru_rq(struct request *rq)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
+	struct gendisk *disk = ns ? ns->disk : NULL;
+	u32 effects;
+
+	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	blk_execute_rq(rq->q, disk, rq, 0);
+	nvme_passthru_end(ctrl, effects);
+}
+
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
@@ -924,7 +1018,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}
 
-	blk_execute_rq(req->q, disk, req, 0);
+	nvme_execute_passthru_rq(req);
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
@@ -1288,94 +1382,12 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
-					NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-								u8 opcode)
-{
-	u32 effects = 0;
-
-	if (ns) {
-		if (ctrl->effects)
-			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
-		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
-			dev_warn(ctrl->device,
-				 "IO command:%02x has unhandled effects:%08x\n",
-				 opcode, effects);
-		return 0;
-	}
-
-	if (ctrl->effects)
-		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	effects |= nvme_known_admin_effects(opcode);
-
-	/*
-	 * For simplicity, IO to all namespaces is quiesced even if the command
-	 * effects say only one namespace is affected.
-	 */
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
-		mutex_lock(&ctrl->scan_lock);
-		mutex_lock(&ctrl->subsys->lock);
-		nvme_mpath_start_freeze(ctrl->subsys);
-		nvme_mpath_wait_freeze(ctrl->subsys);
-		nvme_start_freeze(ctrl);
-		nvme_wait_freeze(ctrl);
-	}
-	return effects;
-}
-
-static void nvme_update_formats(struct nvme_ctrl *ctrl)
-{
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (ns->disk && nvme_revalidate_disk(ns->disk))
-			nvme_set_queue_dying(ns);
-	up_read(&ctrl->namespaces_rwsem);
-}
-
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
-{
-	/*
-	 * Revalidate LBA changes prior to unfreezing. This is necessary to
-	 * prevent memory corruption if a logical block size was changed by
-	 * this command.
-	 */
-	if (effects & NVME_CMD_EFFECTS_LBCC)
-		nvme_update_formats(ctrl);
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
-		nvme_unfreeze(ctrl);
-		nvme_mpath_unfreeze(ctrl->subsys);
-		mutex_unlock(&ctrl->subsys->lock);
-		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
-		mutex_unlock(&ctrl->scan_lock);
-	}
-	if (effects & NVME_CMD_EFFECTS_CCC)
-		nvme_init_identify(ctrl);
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
-		nvme_queue_scan(ctrl);
-}
-
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
-	u32 effects;
 	u64 result;
 	int status;
 
@@ -1402,12 +1414,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata,
 			cmd.metadata_len, 0, &result, timeout);
-	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -1423,7 +1433,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
-	u32 effects;
 	int status;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1449,12 +1458,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
 			0, &cmd.result, timeout);
-	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
