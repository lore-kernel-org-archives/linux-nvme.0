Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C176C61DD3
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 07:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qKSJjPThNwpwygyrNfu67CrvjL8KUZ9FpcP64R6mLFU=; b=VkxpPPkAUHJoTcdlituuS26cqq
	JHhpTpzBNrR8v2zKptPQ08tFSBoxdLcM1YykpWcLzzKufrSSJuJgS0b0ZpYqXYJ18OSbN1+YhRt2S
	Z6yKtm05pA+mWPkWgTMQM74+3w9rnAZTXO7NmPDI7g7Os/r63FFVfyQkveNQ/bZOY9OHNN3W6AThZ
	yWLSkKMjE60BaJyCigZ98IqLQW1AmajHxRKsKGMxz5SBOPKJOIaCVXURMlPeIFxJzDjP/4RUPThxF
	GP3NIEJIw3vHVfB/OG9xPKGhNPDsNF3Ya56tx9r1WmGnr8SgbCXqRf0c/XLUxkDHJygNECUGTYEOx
	dMr+WYkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wtm-00000008lyE-43H5;
	Mon, 31 Aug 2026 07:57:46 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wtc-00000008lwQ-1jBR
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 07:57:45 +0000
X-UUID: 9801e70ca51111f19a56ed5b684f684d-20260831
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8dd859c7-28dc-4396-b2c3-df54634c909d,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:8dd859c7-28dc-4396-b2c3-df54634c909d,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:a1220a5d055e5004221db0421e62e59b,BulkI
	D:260831155725FDYQNWYX,BulkQuantity:0,SF:10|66|78|102|127|850|865|898,TC:n
	il,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9801e70ca51111f19a56ed5b684f684d-20260831
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 25069223; Mon, 31 Aug 2026 15:57:20 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2] nvme: fix command effects log lifetime for multipath heads
Date: Mon, 31 Aug 2026 15:57:16 +0800
Message-Id: <20260831075716.41711-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_005736_751613_238AEB10 
X-CRM114-Status: GOOD (  18.11  )
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

KASAN reported a use-after-free when an I/O passthrough command was sent
through a multipath namespace head after the controller path that first
created the head had been removed:

  BUG: KASAN: slab-use-after-free in nvme_command_effects+0x192/0x200 [nvme_core]
  Read of size 4 at addr ffff888141b14400 by task nvme/19811
  nvme_command_effects+0x192/0x200 [nvme_core]
  nvme_cmd_allowed+0x7e/0x1b0 [nvme_core]
  nvme_user_cmd.constprop.0+0x1b5/0x450 [nvme_core]
  nvme_ns_head_chr_ioctl+0xf4/0x2a0 [nvme_core]

Move the log cache to the subsystem, with one entry per command set. This
keeps controller and namespace head pointers valid until subsystem release.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 127 ++++++++++++++++++++-------------------
 drivers/nvme/host/nvme.h |   4 +-
 2 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758245c799a1..c3988cbce5d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3196,9 +3196,16 @@ static void nvme_release_subsystem(struct device *dev)
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
+	struct nvme_effects_log *cel;
+	unsigned long i;
 
 	if (subsys->instance >= 0)
 		ida_free(&nvme_instance_ida, subsys->instance);
+	xa_for_each(&subsys->cels, i, cel) {
+		xa_erase(&subsys->cels, i);
+		kfree(cel);
+	}
+	xa_destroy(&subsys->cels);
 	kfree(subsys);
 }
 
@@ -3312,6 +3319,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->nsheads);
+	xa_init(&subsys->cels);
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
@@ -3411,15 +3419,12 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 			offset, 0);
 }
 
-static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
-				struct nvme_effects_log **log)
+static int nvme_read_effects_log(struct nvme_ctrl *ctrl, u8 csi,
+				 struct nvme_effects_log **log)
 {
-	struct nvme_effects_log *old, *cel = xa_load(&ctrl->cels, csi);
+	struct nvme_effects_log *cel;
 	int ret;
 
-	if (cel)
-		goto out;
-
 	cel = kzalloc_obj(*cel);
 	if (!cel)
 		return -ENOMEM;
@@ -3431,12 +3436,31 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 		return ret;
 	}
 
-	old = xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
-	if (xa_is_err(old)) {
+	*log = cel;
+	return 0;
+}
+
+static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
+				struct nvme_effects_log **log)
+{
+	struct nvme_effects_log *cel = xa_load(&ctrl->subsys->cels, csi);
+	int ret;
+
+	if (cel) {
+		*log = cel;
+		return 0;
+	}
+
+	ret = nvme_read_effects_log(ctrl, csi, &cel);
+	if (ret)
+		return ret;
+
+	ret = xa_insert(&ctrl->subsys->cels, csi, cel, GFP_KERNEL);
+	if (ret) {
 		kfree(cel);
-		return xa_err(old);
+		return ret;
 	}
-out:
+
 	*log = cel;
 	return 0;
 }
@@ -3497,29 +3521,8 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
-		u8 csi, struct nvme_effects_log **log)
+static void nvme_init_known_nvm_effects(struct nvme_effects_log *log)
 {
-	struct nvme_effects_log *effects, *old;
-
-	effects = kzalloc_obj(*effects);
-	if (!effects)
-		return -ENOMEM;
-
-	old = xa_store(&ctrl->cels, csi, effects, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		kfree(effects);
-		return xa_err(old);
-	}
-
-	*log = effects;
-	return 0;
-}
-
-static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
-{
-	struct nvme_effects_log	*log = ctrl->effects;
-
 	log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
 						NVME_CMD_EFFECTS_NCC |
 						NVME_CMD_EFFECTS_CSE_MASK);
@@ -3550,25 +3553,41 @@ static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 
 static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
+	struct nvme_effects_log *cel;
 	int ret = 0;
 
-	if (ctrl->effects)
-		return 0;
+	mutex_lock(&ctrl->subsys->lock);
+	cel = xa_load(&ctrl->subsys->cels, NVME_CSI_NVM);
+	if (cel)
+		goto out_set_effects;
 
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
+		ret = nvme_read_effects_log(ctrl, NVME_CSI_NVM, &cel);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 	}
 
-	if (!ctrl->effects) {
-		ret = nvme_init_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
-		if (ret < 0)
-			return ret;
+	if (!cel) {
+		cel = kzalloc_obj(*cel);
+		if (!cel) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+		ret = 0;
 	}
 
-	nvme_init_known_nvm_effects(ctrl);
-	return 0;
+	nvme_init_known_nvm_effects(cel);
+	ret = xa_insert(&ctrl->subsys->cels, NVME_CSI_NVM, cel, GFP_KERNEL);
+	if (ret) {
+		kfree(cel);
+		goto out_unlock;
+	}
+
+out_set_effects:
+	ctrl->effects = cel;
+out_unlock:
+	mutex_unlock(&ctrl->subsys->lock);
+	return ret;
 }
 
 static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
@@ -4034,12 +4053,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 	kref_init(&head->ref);
 	ns->head = head;
 
-	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
-		if (ret)
-			goto out_cleanup_srcu;
-	} else
-		head->effects = ctrl->effects;
+	ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
+	if (ret)
+		goto out_cleanup_srcu;
 
 	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
 		ret = nvme_query_fdp_info(ns, info);
@@ -5156,19 +5172,6 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
-static void nvme_free_cels(struct nvme_ctrl *ctrl)
-{
-	struct nvme_effects_log	*cel;
-	unsigned long i;
-
-	xa_for_each(&ctrl->cels, i, cel) {
-		xa_erase(&ctrl->cels, i);
-		kfree(cel);
-	}
-
-	xa_destroy(&ctrl->cels);
-}
-
 static void nvme_free_ctrl(struct device *dev)
 {
 	struct nvme_ctrl *ctrl =
@@ -5181,7 +5184,6 @@ static void nvme_free_ctrl(struct device *dev)
 		blk_put_queue(ctrl->fabrics_q);
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	cleanup_srcu_struct(&ctrl->srcu);
 	nvme_auth_stop(ctrl);
@@ -5227,7 +5229,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
-	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..25bdafa5b193 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -415,7 +415,6 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
-	struct xarray cels;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
@@ -509,6 +508,9 @@ struct nvme_subsystem {
 		__guarded_by(&nvme_subsystems_lock);
 	struct list_head	nsheads
 		__guarded_by(&lock);
+	/* Command effects logs indexed by Command Set Identifier. */
+	struct xarray		cels
+		__guarded_by(&lock);
 	char			subnqn[NVMF_NQN_SIZE];
 	char			serial[20];
 	char			model[40];
-- 
2.25.1


