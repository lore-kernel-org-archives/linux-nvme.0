Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C848BC3ABB2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CNYhvMCuRl5IgqOGSWViMnBuAkmFY3iQducfihgxAS4=; b=cmqfJKun6mquP2edshU2Hwipuv
	UjORO8nFR/ahVZvf75m/pdX7XMdJzeIYls74ibd3lX6DHQa8R3XbLOplOPvC/Zdx2fII5ZwlFB6uE
	wyFefF6VZI8rk42/8zNFE9UA353YTQFpUC3rPCOQDKILHwSzK5eQx2zWDZa63AYneNmJ34stvULhf
	VLhtojb5Rx/1+q1lc1pwD/rEeBRRogYzW+lIJbuABDFArBW5bbAw++BKeIft7p4/KIC6Cq955G6J6
	/2cuFt3ytqqRXt7lNbyRkmCgyqVp+S9L7sCdXF6PkBALWAqtp2rTJ2cHHgI14ArCjm7RvuGSbXA8g
	tcJ9vRkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqDuB-00000004Nd7-1VGY;
	Mon, 16 Sep 2024 15:44:47 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqDu9-00000004Ncn-1IPX
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 15:44:46 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-205722ba00cso38420005ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2024 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726501484; x=1727106284; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNYhvMCuRl5IgqOGSWViMnBuAkmFY3iQducfihgxAS4=;
        b=MDQQfz1PTo7u0kRc8UaCLSf2p7CqH1WOJOmSc39Dp3xAVKEMxsHdZngVXr+6kuG93E
         cHDnIhFika/mzGCHtjSHkwpVA9N37Be/r00M4+6e8fSb41z0KQY06FTZu5hNVY3YfRkp
         ToUBjdsXYFttaimQaZAk8p+5lycyIa7a8IGHgqaBoAJutm8coaoFtV2RNcKPxGdbp77f
         vXC6DePj8Os+fvx5itk7FdDOkMkiC6u67hX/TGqId3QNTuSuuScTefrB54QuBUmvnUTu
         BWseHTADKXXqo1tyHSEWeFZZmlcTVXfy0/0hJNnJod5WjSTVh/rUg2OtAlO+1LFb5jKV
         HriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726501484; x=1727106284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNYhvMCuRl5IgqOGSWViMnBuAkmFY3iQducfihgxAS4=;
        b=dJFyLihq0+0epLnG9q9IVKQvYd5r/gmSR0gtMowX+RUUDB8muDTOyyu0PNUHphjCGD
         g9KHURWnoxT9GG799aYjJ2cyNLMZhwma2xtsWRjCiKFhKesKgrlaNXpFwliVJsPgjuxL
         u1DsHCZL5lWyosqKjIKz9t11qP1fR8Blmmqmt8baTJI9isR/rxxjbtF/XbItRcnU2wdh
         Jwg/tDKa9JrpEW/tGWny8kgjtxsZGcZFj6y7bgURout471BFh+CDhbvRfp1zMHYMdCX8
         3ZqwjSDf4fsE90tSdmQPzwH8TMO5Pe+EcnklYV99B+ibjVSfMfPYJh45Pe3Calj/0adR
         S0BA==
X-Gm-Message-State: AOJu0YxcCzXNmqwM02B0mKfsrFQbpdtD6Al8BYh5RseX6MJL+edvO2mH
	AuEcW0CF5Jb1Oyt2he53hwawqB9Qv+IK+nfkX3lQH7MtAko7/7lzh9RHvg==
X-Google-Smtp-Source: AGHT+IHmoJs0Ye4o8q0KWSOmfnZVZIgu+B7Pg/SVSu/sSKWPJNEe3bYx4Km5IwWfwNbwZKkROd4p3g==
X-Received: by 2002:a17:902:db06:b0:206:fd9b:f4f1 with SMTP id d9443c01a7336-2076e4a6ee1mr239032025ad.56.1726501483448;
        Mon, 16 Sep 2024 08:44:43 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:ea8:9d82:86f6:3ccc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472daafsm37314215ad.241.2024.09.16.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:44:43 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: convert little endian NVME definitions to native format
Date: Tue, 17 Sep 2024 00:42:36 +0900
Message-ID: <20240916154422.356691-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_084445_374300_1CAC8487 
X-CRM114-Status: GOOD (  15.24  )
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

This is to compare the definitions correctly with the converted values.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++----------
 drivers/nvme/host/nvme.h |  4 ++--
 drivers/nvme/host/pci.c  |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ca9959a8fb9e..5e26546e811a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1273,7 +1273,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 	 * command completion can postpone sending a keep alive command
 	 * by up to twice the delay between runs.
 	 */
-	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+	if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS))
 		delay /= 2;
 	return delay;
 }
@@ -1343,7 +1343,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 
 	ctrl->ka_last_check_time = jiffies;
 
-	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
+	if ((ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS)) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
@@ -1699,7 +1699,7 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
-	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
+	u32 result, supported_aens = ctrl->oaes & le32_to_cpu(NVME_AEN_SUPPORTED);
 	int status;
 
 	if (!supported_aens)
@@ -1829,7 +1829,7 @@ static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
 	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
 		lim->max_hw_discard_sectors =
 			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
-	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
+	else if (ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_DSM))
 		lim->max_hw_discard_sectors = UINT_MAX;
 	else
 		lim->max_hw_discard_sectors = 0;
@@ -1913,7 +1913,7 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return;
 
-	if (nvm && (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+	if (nvm && (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))) {
 		nvme_configure_pi_elbas(head, id, nvm);
 	} else {
 		head->pi_size = sizeof(struct t10_pi_tuple);
@@ -2137,7 +2137,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
+	if (ns->ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS)) {
 		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
 		if (ret < 0)
 			goto out;
@@ -2341,7 +2341,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
 {
-	if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
+	if (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_SEC_SUPP)) {
 		if (!ctrl->opal_dev)
 			ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
 		else if (was_suspended)
@@ -2520,7 +2520,7 @@ static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 	__le64 ts;
 	int ret;
 
-	if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
+	if (!(ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_TIMESTAMP)))
 		return 0;
 
 	ts = cpu_to_le64(ktime_to_ms(ktime_get_real()));
@@ -2541,7 +2541,7 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
 	/* Don't bother enabling the feature if retry delay is not reported */
 	if (ctrl->crdt[0])
 		acre = NVME_ENABLE_ACRE;
-	if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
+	if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))
 		lbafee = NVME_ENABLE_LBAFEE;
 
 	if (!acre && !lbafee)
@@ -3109,7 +3109,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	 * controllers max_hw_sectors value, which is based on the MDTS field
 	 * and possibly other limiting factors.
 	 */
-	if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
+	if ((ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_WRITE_ZEROES)) &&
 	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
 	else
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 313a4f978a2c..25886b9d2796 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -860,9 +860,9 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 		struct nvme_ns_head *head)
 {
 	return head->shared ||
-		(ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
+		(ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_NS_MNGT_SUPP)) ||
 		(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
-		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
+		(ctrl->ctratt & le32_to_cpu(NVME_CTRL_CTRATT_NVM_SETS));
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7990c3f22ecf..f8fa424fa952 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -249,7 +249,7 @@ static void nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev);
 
-	if (!(dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP))
+	if (!(dev->ctrl.oacs & le16_to_cpu(NVME_CTRL_OACS_DBBUF_SUPP)))
 		return;
 
 	if (dev->dbbuf_dbs) {
-- 
2.43.0


