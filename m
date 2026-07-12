Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CBFC44508
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sz2oq2nGtu7NQfl5yPr0twovV2PO9NUtvXs1PzpDhTw=; b=GNpJFrUePlWbRgCobuZZ8zFuc1
	i/znKo431vPr4aqGXHdiPGAv/xzuNsJ6OrNceYS702RuqhDJoIiaO462111l2g7eXquaMZnmtRwQa
	yWVTAgZ7Dh5P1T7FeFQAYgKOyIT/IkMsErcA+4+o5dkklRV1/hX14ZL0SYCkJ670FAtH1pKP1B9vO
	qnaGhxKVLz9chrLUkG1xaGO8hhAIK+FYMoI97yQahpBDKtkR11K0jNQN1MfrvkQQ+pkFkF+xzQ0xU
	gh0HYCtNlh2bnX7WwO8XuwV24OowEi6vHKSx6oe888I1blSmUVJQGKnlh/0McqIJ6PEunFLjOAgi6
	/jPw0RGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsj-000000071Ni-28SH;
	Sun, 12 Jul 2026 02:25:25 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsg-000000071LR-2eHR
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:23 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-383adaa461fso1376959a91.3
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823122; x=1784427922; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sz2oq2nGtu7NQfl5yPr0twovV2PO9NUtvXs1PzpDhTw=;
        b=YBU0BdmZiD0Ipcl1VUELqX0gad51iE6C9k4HIk0IrUi6v3pqytdeLjKS69HV3/KnmC
         8DZLlNtT1JYwzmg9mkCJA1XYxM54eRzViPrZ2AGFpmagtRFAtU0pqHudtVCngdEFtKLT
         ao757ENs/95ouvjTG1SX9lcSuz+ZtYwPyjrkJBxi++sMiWzqnkUQb5dg+amzvroD1DQD
         NnJofh2/txVz8fuaKVh8kzbUIqkjvPNSui4ncDRYXEFprQwzxVTg8ZRPwVraODDHlXUP
         7DCw1Dst9R8zJ6RVx2953KnqUhPgBd+Yx+x4LrOsENZtUCUMx6gZZLmdsLVHxWtd7w0O
         JPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823122; x=1784427922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sz2oq2nGtu7NQfl5yPr0twovV2PO9NUtvXs1PzpDhTw=;
        b=KqJUGS0YufeJn67itjw8FUDUpX4cawAEYW1g6Gz8/iGG7Ik8V4KsqYB/wEblPPlaPt
         vWvQ+BcBtzGQAcBNGbjwNQhQUuoDGb7AeWZhbjwyl2xAiDbRTNL4oFL6odkgScPAZgqN
         G6z7pKEuxsjbapZkqpa51JJ0Q5ubKstN2uqxnN05SMlhv3VXLNAILUOAmRUQ8K+qSUdI
         +fHhDxaeFWvVt2tWMJxzhD18iL9ODK1SPW4YNTDkvmTaM4womE7Q/kfyNvy/ujs3Y4FD
         3rX9ZWhdfLd3ouoyavJThtgOCKUAyk8RroANXsUCNZ4+yXalx1tTTWqjH1VMHBRb8BnH
         rkrw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6mWer4q6Iyj4QLiWRec9Ur3zpUD40NlfCbHhgMlTvjgW1sfE4rxLL2x8c9pkVQ+pSoek/fnRiBq0N@lists.infradead.org
X-Gm-Message-State: AOJu0YxHiE3uS4O3euGjTKPL535AEBYtRoa8a08sDKM80I4KUQV/hqPO
	CxuuDlXqYFWlZz2k1x82CFlYFUUeYBznJs8N8hj2ZFv5TxjF92O3fi/PZL/oLdAqHjY=
X-Gm-Gg: AfdE7cn07dv1NZPnc+/peOpvVrCV6Y9nqruy55FpI5bG12GHdl5MF7z5cE/o9JPaURf
	odFVmk7E4ZcJ1jngNVweeBTKaLucjGGr8l0yDmGhsNOMMSRU6sbXrjY17zOZt9MfBl0/a46qiFI
	bxSVF9fQgIrBXNDxiMTOTFzJxoRy+oTlsWzXdhCTEt4kVUHbSX1FPaYdkM4PqKe/eh0BNXmTHTU
	/odjeaeL3eSCGUt2uowqQYb9ABmrBaN6zj4SRtupxpNx5TRyGtGHUveATrKD2OEDw+JEli6lYmW
	pxAqiZ+/Ldkk9SU3gCRgOaCfpXNfXwMG79eWrzxe1nIDzMmAZm8HPyb+HTpfhNNMKJTgYL6aBhQ
	9SV+OSUFgr0QFq0S59wV+0sXAxTTrwRJTwFBJHDtexuM3vUDx66TG3GlnygFxm1gxVNiMylPGa0
	H0Fs+d
X-Received: by 2002:a17:90b:4a4f:b0:387:e0db:bc2e with SMTP id 98e67ed59e1d1-38dc7ba6fa9mr4275528a91.36.1783823121315;
        Sat, 11 Jul 2026 19:25:21 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:20 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 03/16] nvmet: Implement CCR nvme command
Date: Sat, 11 Jul 2026 19:23:24 -0700
Message-ID: <20260712022437.3743117-4-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192522_679889_6A40D546 
X-CRM114-Status: GOOD (  20.10  )
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

Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
Reset) command is an nvme command issued to source controller by
initiator to reset impacted controller. Implement CCR command for linux
nvme target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c | 76 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 78 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 13 ++++++
 include/linux/nvme.h            | 23 ++++++++++
 4 files changed, 190 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 81988b40d5d5..1b97e1bafa30 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -376,6 +376,7 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
 	log->acs[nvme_admin_get_features] =
 	log->acs[nvme_admin_async_event] =
 	log->acs[nvme_admin_keep_alive] =
+	log->acs[nvme_admin_cross_ctrl_reset] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
 
@@ -1611,6 +1612,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	struct nvmet_ccr *ccr, *new_ccr;
+	int ccr_active, ccr_total;
+	u16 cntlid, status = NVME_SC_SUCCESS;
+
+	if (!nvmet_check_transfer_len(req, 0))
+		return;
+
+	cntlid = le16_to_cpu(cmd->ccr.icid);
+	if (sctrl->cntlid == cntlid) {
+		req->error_loc =
+			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	/* Find and get impacted controller */
+	ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
+					cmd->ccr.ciu, cntlid,
+					le64_to_cpu(cmd->ccr.cirn));
+	if (!ictrl) {
+		/* Immediate Reset Successful */
+		nvmet_set_result(req, 1);
+		status = NVME_SC_SUCCESS;
+		goto out;
+	}
+
+	ccr_total = ccr_active = 0;
+	mutex_lock(&sctrl->lock);
+	list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
+		if (ccr->ctrl == ictrl) {
+			status = NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_DNR;
+			goto out_unlock;
+		}
+
+		ccr_total++;
+		if (ccr->ctrl)
+			ccr_active++;
+	}
+
+	if (ccr_active >= NVMF_CCR_LIMIT) {
+		status = NVME_SC_CCR_LIMIT_EXCEEDED;
+		goto out_unlock;
+	}
+	if (ccr_total >= NVMF_CCR_PER_PAGE) {
+		status = NVME_SC_CCR_LOGPAGE_FULL;
+		goto out_unlock;
+	}
+
+	new_ccr = kmalloc_obj(*new_ccr, GFP_KERNEL);
+	if (!new_ccr) {
+		status = NVME_SC_INTERNAL;
+		goto out_unlock;
+	}
+
+	new_ccr->ciu = cmd->ccr.ciu;
+	new_ccr->icid = cntlid;
+	new_ccr->ctrl = ictrl;
+	list_add_tail(&new_ccr->entry, &sctrl->ccr_list);
+
+out_unlock:
+	mutex_unlock(&sctrl->lock);
+	if (status == NVME_SC_SUCCESS)
+		nvmet_ctrl_fatal_error(ictrl);
+	nvmet_ctrl_put(ictrl);
+out:
+	nvmet_req_complete(req, status);
+}
+
 u32 nvmet_admin_cmd_data_len(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -1688,6 +1761,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	case nvme_admin_keep_alive:
 		req->execute = nvmet_execute_keep_alive;
 		return 0;
+	case nvme_admin_cross_ctrl_reset:
+		req->execute = nvmet_execute_cross_ctrl_reset;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d42421420be6..5b4312227222 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -117,6 +117,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 	return 0;
 }
 
+void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all)
+{
+	struct nvmet_ccr *ccr, *tmp;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	list_for_each_entry_safe(ccr, tmp, &ctrl->ccr_list, entry) {
+		if (all || ccr->ctrl == NULL) {
+			list_del(&ccr->entry);
+			kfree(ccr);
+		}
+	}
+}
+
 static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ns *cur;
@@ -1409,6 +1423,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
 		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
 		ctrl->cirn = get_random_u64();
+		nvmet_ctrl_cleanup_ccrs(ctrl, false);
 	}
 	ctrl->csts = NVME_CSTS_RDY;
 
@@ -1514,6 +1529,37 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 	return ctrl;
 }
 
+struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
+					   const char *hostnqn, u8 ciu,
+					   u16 cntlid, u64 cirn)
+{
+	struct nvmet_ctrl *ctrl, *ictrl = NULL;
+	bool found = false;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid != cntlid)
+			continue;
+		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
+			continue;
+
+		/* Avoid racing with a controller that is becoming ready */
+		mutex_lock(&ctrl->lock);
+		if (ctrl->ciu == ciu && ctrl->cirn == cirn)
+			found = true;
+		mutex_unlock(&ctrl->lock);
+
+		if (found) {
+			if (kref_get_unless_zero(&ctrl->ref))
+				ictrl = ctrl;
+			break;
+		}
+	}
+	mutex_unlock(&subsys->lock);
+
+	return ictrl;
+}
+
 u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
@@ -1639,6 +1685,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		subsys->clear_ids = 1;
 #endif
 
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
@@ -1749,12 +1796,43 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 }
 EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
+static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_subsys *subsys = ctrl->subsys;
+	struct nvmet_ctrl *sctrl;
+	struct nvmet_ccr *ccr;
+
+	lockdep_assert_held(&subsys->lock);
+
+	/* Cleanup all CCRs issued by ctrl as source controller */
+	mutex_lock(&ctrl->lock);
+	nvmet_ctrl_cleanup_ccrs(ctrl, true);
+	mutex_unlock(&ctrl->lock);
+
+	/*
+	 * Find all CCRs targeting ctrl as impacted controller and
+	 * set ccr->ctrl to NULL. This tells the source controller
+	 * that CCR completed successfully.
+	 */
+	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
+		mutex_lock(&sctrl->lock);
+		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
+			if (ccr->ctrl == ctrl) {
+				ccr->ctrl = NULL;
+				break;
+			}
+		}
+		mutex_unlock(&sctrl->lock);
+	}
+}
+
 static void nvmet_ctrl_free(struct kref *ref)
 {
 	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
 	struct nvmet_subsys *subsys = ctrl->subsys;
 
 	mutex_lock(&subsys->lock);
+	nvmet_ctrl_complete_pending_ccr(ctrl);
 	nvmet_ctrl_destroy_pr(ctrl);
 	nvmet_release_p2p_ns_map(ctrl);
 	list_del(&ctrl->subsys_entry);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9c98833e8f3a..de088986cb4b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -272,6 +272,7 @@ struct nvmet_ctrl {
 	u32			kato;
 	u64			cirn;
 
+	struct list_head	ccr_list;
 	struct nvmet_port	*port;
 
 	u32			aen_enabled;
@@ -318,6 +319,13 @@ struct nvmet_ctrl {
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
 
+struct nvmet_ccr {
+	struct nvmet_ctrl	*ctrl;
+	struct list_head	entry;
+	u16			icid;
+	u8			ciu;
+};
+
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
 
@@ -583,6 +591,7 @@ void nvmet_req_free_sgls(struct nvmet_req *req);
 void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
+void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req);
 
 u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
 u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
@@ -625,6 +634,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req);
+struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
+					   const char *hostnqn, u8 ciu,
+					   u16 cntlid, u64 cirn);
+void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
 ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index cbaf02b0cf07..7e6150d9494a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -22,6 +22,7 @@
 #define NVMF_TSAS_SIZE		256
 
 #define NVMF_CCR_LIMIT		4
+#define NVMF_CCR_PER_PAGE	511
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
@@ -1233,6 +1234,22 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
 
+struct nvme_cross_ctrl_reset_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le16			icid;
+	__u8			ciu;
+	__u8			rsvd10;
+	__le32			cdw11;
+	__le64			cirn;
+	__le32			cdw14;
+	__le32			cdw15;
+};
+
 struct nvme_io_mgmt_recv_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1331,6 +1348,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cross_ctrl_reset	= 0x38,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1364,6 +1382,7 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
+		nvme_admin_opcode_name(nvme_admin_cross_ctrl_reset),	\
 		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
@@ -2022,6 +2041,7 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_cross_ctrl_reset_cmd ccr;
 	};
 };
 
@@ -2186,6 +2206,9 @@ enum {
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
 	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
 	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
+	NVME_SC_CCR_IN_PROGRESS		= 0x13f,
+	NVME_SC_CCR_LOGPAGE_FULL	= 0x140,
+	NVME_SC_CCR_LIMIT_EXCEEDED	= 0x141,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
-- 
2.54.0


