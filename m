Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE95EE645D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YpSLgOGCydNEEqjgzZFepsEDW1OnCSmjNinCX9TLn4=; b=LywMyZAlTOGSUi0PG+Wpbr0sED
	FX1WNNexU0rztoTgJqRo1+DYO8J2n5Yr79ts/nyX+nU1lm2W02yYrsn7P4uvSoqX7IGU4VkidZU4f
	vOwMZSgeeV2UHMmIFb/GzHpiriU239ocnRlhiexgNDtfVsEYLG7cImhrA+XLpOlGUjUCbBgJgQbBE
	ddTzJ4GhZ805Ni2i/7ZG3fClhtz6Vtl8vgiT3r6ONb3KspdrvKKOCVAakZfvvkeAN4BUPn10JlRP2
	Am+L8IJE0h4RJzRhsPGrUk7hsG2Sq9ET12ncWNg9ezwdg/y3UAEUCUJ5gLuXlCMM/AnBKeH8Zt3y6
	9z/rw8mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1L-0000000CKrH-1it7;
	Thu, 12 Sep 2024 08:17:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soezK-0000000CKYW-362N
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:15:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726128937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YpSLgOGCydNEEqjgzZFepsEDW1OnCSmjNinCX9TLn4=;
	b=W7MvWFxQ+hQz2eJquWlVK4tBscyE2u9QV1KSpXZZU1GMp1pwG7OimwpHVb2HRUVy/O6IVo
	jocWorcsDTAjukH6DTpyTVdz8gTbUon3HnDQcameMv4yzriEYK8wrSb37+Bta9mzR2CZOs
	zGyg+8A8btCo8bXDdHQsc3Xfr4PZbIs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-YO9UJYdfPx2aldPVZpunKQ-1; Thu,
 12 Sep 2024 04:15:35 -0400
X-MC-Unique: YO9UJYdfPx2aldPVZpunKQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFBAE19560A3;
	Thu, 12 Sep 2024 08:15:33 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 252AC19560AA;
	Thu, 12 Sep 2024 08:15:30 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 7/7] nvmet: emulate basic support for cancel commands
Date: Thu, 12 Sep 2024 10:15:10 +0200
Message-ID: <20240912081510.171857-8-mlombard@redhat.com>
In-Reply-To: <20240912081510.171857-1-mlombard@redhat.com>
References: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011538_884251_07B6E8B7 
X-CRM114-Status: GOOD (  26.80  )
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

Add a module parameter that allows the user to enable a basic
cancel command emulation, this could be useful for testing the host
driver's cancel command implementation.

It just reports that no abort has been executed, it will however
do some basic sanity check on the command sent by the host and return
an error if the fields are invalid.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/Makefile        |  2 +-
 drivers/nvme/target/admin-cmd.c     |  4 +++
 drivers/nvme/target/core.c          | 11 ++++++
 drivers/nvme/target/io-cmd-cancel.c | 52 +++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h         |  4 +++
 5 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/io-cmd-cancel.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index c402c44350b2..f0f64394986c 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o io-cmd-cancel.o
 nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 85006b2df8ae..4214379bd4aa 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -177,6 +177,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	if (emulate_cancel_support) {
+		log->iocs[nvme_cmd_cancel] =
+			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	}
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..1bfd4a2cad26 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -27,6 +27,10 @@ static DEFINE_IDA(cntlid_ida);
 struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
 
+bool emulate_cancel_support;
+module_param(emulate_cancel_support, bool, 0644);
+MODULE_PARM_DESC(emulate_cancel_support, "Emulate the cancel command support. Default = false");
+
 /*
  * This read/write semaphore is used to synchronize access to configuration
  * information on a target system that will result in discovery log page
@@ -914,6 +918,13 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
+	if (emulate_cancel_support &&
+	    req->cmd->common.opcode == nvme_cmd_cancel) {
+		req->execute = nvmet_execute_cancel;
+		if (req->cmd->cancel.nsid == NVME_NSID_ALL)
+			return 0;
+	}
+
 	ret = nvmet_req_find_ns(req);
 	if (unlikely(ret))
 		return ret;
diff --git a/drivers/nvme/target/io-cmd-cancel.c b/drivers/nvme/target/io-cmd-cancel.c
new file mode 100644
index 000000000000..8f55458e646a
--- /dev/null
+++ b/drivers/nvme/target/io-cmd-cancel.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe I/O cancel command implementation.
+ * Copyright (c) 2023 Red Hat
+ */
+
+#include "nvmet.h"
+
+void nvmet_execute_cancel(struct nvmet_req *req)
+{
+	u16 cid;
+	__le16 sqid;
+	bool mult_cmds;
+	int ret = 0;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_sq *sq = req->sq;
+
+	if (!nvmet_check_transfer_len(req, 0))
+		return;
+
+	sqid = le16_to_cpu(req->cmd->cancel.sqid);
+	if (sqid > ctrl->subsys->max_qid) {
+		ret = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto exit;
+	}
+
+	mult_cmds = req->cmd->cancel.action & NVME_CANCEL_ACTION_MUL_CMD;
+	cid  = req->cmd->cancel.cid;
+
+	if (cid == req->cmd->cancel.command_id && !mult_cmds) {
+		/* If action is set to "single command" and cid is
+		 * set to the cid of this cancel command, then
+		 * the controller shall abort the command with
+		 * an "invalid cid" status code.
+		 */
+		ret = NVME_SC_INVALID_CID | NVME_STATUS_DNR;
+	} else if ((cid != 0xFFFF && mult_cmds) || sqid != sq->qid) {
+		/* if action is set to "multiple commands" and
+		 * cid isn't set to 0xFFFF, then abort the command
+		 * with an "invalid field" status.
+		 * if the sqid field doesn't match the sqid of
+		 * the queue to which the cancel command is submitted,
+		 * then abort the command with an "invalid field" status.
+		 */
+		ret = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+exit:
+	nvmet_set_result(req, 0);
+	nvmet_req_complete(req, ret);
+}
+
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..c0fc8dd81225 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -31,6 +31,8 @@
 #define NVMET_SN_MAX_SIZE		20
 #define NVMET_FR_MAX_SIZE		8
 
+extern bool emulate_cancel_support;
+
 /*
  * Supported optional AENs:
  */
@@ -610,6 +612,8 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+void nvmet_execute_cancel(struct nvmet_req *req);
+
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
-- 
2.43.5


