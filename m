Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73489C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Apr 2024 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZIPvjsINSBR4+GnLojAQen1sOb37N5r1du95uHFm3zU=; b=JE7rnghMtvh64ocJKyqPNxLiUO
	0zvH0otWDOn/cKpvR5c96Vrzp9EgM8XXiHOCDIU0Ms+7IV4rgjfIY4SsWckkYUtH+ayLMDT7oOgix
	26sWrJn9uDVHZ38YP3IOn0RQ9cnaHrTsTKk+pJ8L/ZH01ZW6GFH7Lm7f2TqxzFq1utGyPgTOm5mhn
	j2U3Ss0DjKKAa0zT2eGMdQHJqlNJGk4zjxfVEwkUjd+t+H6Qfa1Vct4riLau2ZJtRl67JaBRrbJRW
	cJGJvGuztITb3GnwAvsz/KsHM6ZRvuiQnjGqn1CV1l8XNh9ova8pE22lzW+O88blXn3cRlcejWQCA
	RaFS4vWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0JET-0000000CFCj-3xiU;
	Fri, 26 Apr 2024 10:55:09 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0JEQ-0000000CFBJ-3pYr
	for linux-nvme@lists.infradead.org;
	Fri, 26 Apr 2024 10:55:08 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1e9320c2ef6so14292945ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 26 Apr 2024 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1714128902; x=1714733702; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIPvjsINSBR4+GnLojAQen1sOb37N5r1du95uHFm3zU=;
        b=caLQnowvs8kMz8BfdX1WaTrOUtetOjSIDkEmMGOgiW/lR5ZODb7OQf8MpcGFW+bdtv
         m9lrBeRMMu2B37hH7yWMCeNNZKt7Oj591SOZkJKgyR4zDEgphQLgAksBnP62AXWLvvgU
         LzSSlUGCWKDJLHdvaURWV31UTMqET5pHhqeKOvl7UKvX+8L1mEFwZC9zoxjwLAOGgQAW
         lluu+mEORwzyNAp/gVsLBqI9MXZcuX3QKZyhBCxzeWvjm+Co0GXw3EzIRSKhlYmRZbWz
         zBp4UPcqdwwoyYApKhflnP7qwHfTHjU9uTOVW1ciflllF9ynd0FypRAcXcMRtZLJ++nW
         CE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128902; x=1714733702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIPvjsINSBR4+GnLojAQen1sOb37N5r1du95uHFm3zU=;
        b=svQviPgoBm4Vc/e4k/nBGyYromDee69coDWfkFeGfS4BDgEpMMwbf5r0uaes4ZtIqj
         UYML9PZzSKrymHoWQxwqbGRkFykd7H1Ez9UkIc0LTXLL+SBZjtbuR6G4WrNjh8VGa6jS
         s8e/i6YejPW67uY971ArDMYYNsPD71kgrzOOqjL7ZwVhyZ43kOJXH8kf5J3fZE3xoZxt
         d+LDjBzTVvJSdlZVh2uNHQCERu5f8xf917LxMqVkG/Qgv/LlXoKYefIjkPpDS7T+kfcG
         6DDAYnKcwN0f/dfTgBBsYbl4hUcEG8GWSp6ZW03KLds+l30+w5/LfzlH9sJWPBZcwhgf
         s3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlxJ8qgVRWOgGlp0cETPf6pK17E8/s6/58swHglzO+CN59+WEn7L8l3HHF48ZSJ5zTgQV1wA+UMgdlA413ixP9Avx36XVaPD2+/jMbMII=
X-Gm-Message-State: AOJu0YylghmWbO3X13lIwrp1+Aj+l2fNC1w7Jem8tV9PDl29V/V9IBer
	DenUuwIYP31RPdia7tBULtJyGHdpohtOAuDJOJI9TK4Q4EHLs0Gt9TtHlc0Xby8=
X-Google-Smtp-Source: AGHT+IF75xEpmSgYV7C2NBI+XZY3exPaVuwD2x0nM4G8d6CqOcWQfIgC9jOmgAt2AmQDdycZnmW26g==
X-Received: by 2002:a17:902:d883:b0:1e6:3577:1912 with SMTP id b3-20020a170902d88300b001e635771912mr2454417plz.25.1714128902468;
        Fri, 26 Apr 2024 03:55:02 -0700 (PDT)
Received: from C02FRH0UMD6M.cn.corp.seagroup.com (static-ip-250-9-104-152.rev.dyxnet.com. [152.104.9.250])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm15178914plb.307.2024.04.26.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:55:01 -0700 (PDT)
From: kwb <wangbing.kuang@shopee.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: chunguang.xu@shopee.com,
	kwb <wangbing.kuang@shopee.com>
Subject: [PATCH] bug-fix: nvme connect deadlock, bug report: https://bugzilla.kernel.org/show_bug.cgi?id=218777
Date: Fri, 26 Apr 2024 18:54:51 +0800
Message-Id: <20240426105451.78935-1-wangbing.kuang@shopee.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_035507_074667_6D0939C8 
X-CRM114-Status: GOOD (  20.19  )
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

---
 drivers/nvme/host/core.c    | 16 ++++++++--------
 drivers/nvme/host/fabrics.c | 12 ++++++------
 drivers/nvme/host/fabrics.h | 16 +++++++---------
 drivers/nvme/host/fc.c      |  4 ++--
 drivers/nvme/host/nvme.h    |  8 ++++----
 drivers/nvme/host/pci.c     |  6 +++---
 drivers/nvme/host/rdma.c    |  4 ++--
 drivers/nvme/host/tcp.c     |  4 ++--
 drivers/nvme/target/loop.c  |  4 ++--
 9 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6aaecf2ecf97..761bc44527a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2138,7 +2138,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
 	int ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, BLK_MQ_REQ_RESERVED)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
 		if ((csts & NVME_CSTS_RDY) == bit)
@@ -2171,7 +2171,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 
@@ -2187,7 +2187,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	unsigned dev_page_min;
 	int ret;
 
-	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap, BLK_MQ_REQ_RESERVED);
 	if (ret) {
 		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
 		return ret;
@@ -2210,7 +2210,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 	return nvme_wait_ready(ctrl, ctrl->cap, true);
@@ -2226,11 +2226,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, BLK_MQ_REQ_RESERVED)) == 0) {
 		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
 			break;
 
@@ -3070,7 +3070,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
+	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs, 0);
 	if (ret) {
 		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
 		return ret;
@@ -4331,7 +4331,7 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 
 	u32 csts;
 
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, 0))
 		return false;
 
 	if (csts == ~0)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567..5d18822edd0a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd;
 	union nvme_result res;
@@ -154,7 +154,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -188,7 +188,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd = { };
 	union nvme_result res;
@@ -200,7 +200,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd = { };
 	int ret;
@@ -245,7 +245,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 561c2abd3892..3f9ed5392e36 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,12 +18,10 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
+/* Reserved for connect */
+#define NVMF_IO_RESERVED_TAGS		1
+/* Reserved for connect and keep alive and reset/delete */
+#define NVMF_ADMIN_RESERVED_TAGS	3
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
@@ -179,9 +177,9 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	return true;
 }
 
-int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
-int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
-int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
+int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags);
+int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t falgs);
+int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..36834408caf0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_fc_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->tag_set.reserved_tags = NVMF_IO_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size =
@@ -3510,7 +3510,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->admin_tag_set.reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d94774cc52bc..b7577156ed80 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,9 +493,9 @@ struct nvme_ctrl_ops {
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_PCI_P2PDMA		(1 << 2)
-	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
-	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
-	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
+	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags);
+	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags);
+	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
@@ -566,7 +566,7 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
 		return -ENOTTY;
-	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65, BLK_MQ_REQ_RESERVED);
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d820131d39b2..b614273029fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2850,19 +2850,19 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags)
 {
 	writel(val, to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags)
 {
 	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a49061f2afce..20fedf17166b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -801,7 +801,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
@@ -814,7 +814,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2d81db71aaa1..df7acb44b20c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1667,7 +1667,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
@@ -1679,7 +1679,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 2553f487c9f2..9a591ab4c810 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -353,7 +353,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->admin_tag_set.reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
@@ -527,7 +527,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_loop_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->tag_set.reserved_tags = NVMF_IO_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-- 
2.36.0


