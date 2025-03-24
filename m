Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3184C36011
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqICkJFLz3oqh3EZRC0OJCdJKoxIvfhE/DlFUcNzFLg=; b=CfmtqNPzrWwroyQL5HA5CZ4M/9
	TwtAUzlGHnjKQE9VVDgmc3uonlv7A53cueEyNVgPIQ7VF+H4wRdL4Mk1betlivYYFdTjhrnoyDOzW
	BSRqBXvAfiMm3sA6yUNSAC8pfuGWFroWGImnwvimfloeddxxoMIbfGeobvhtcMT2nbYuhDBqrXr9J
	Od2Cwfep8BK5RYAjoWP5MZLOIdBHqodHwb8gqHR9vu53+pzTOdEF3Ua7Fr+NRj4bHf5vxnMW8PPqB
	EIE7+mY2+v/21fQGSfqoZPWFUGQ0+eE47HabQM2MXIY3VMRtKoJhq8YfMcqgXCo/G4H4lnuAONaaH
	swE9NRDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyx-00000002oQ1-00Lt;
	Mon, 24 Mar 2025 10:24:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twey7-00000002oE5-1I4X
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqICkJFLz3oqh3EZRC0OJCdJKoxIvfhE/DlFUcNzFLg=;
	b=XKgLZcVtc6cSuFaJSdo9KXGJDY0x16RrFbhYHI7Z+Jk2Fo9xmU/EMokEeMC9jhvUg+KXVw
	7V3Xtvydt10F06UXWPPHL/owbC1aiIQO0toCJoR/aZZy0XFx4ugvqXNkn+2kdwH0MTilXO
	KHGkoVTiXsTs37odf6obVv/9VWiBIwM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-Tn-p_qfKOxyja2GdqawLOg-1; Mon,
 24 Mar 2025 06:23:39 -0400
X-MC-Unique: Tn-p_qfKOxyja2GdqawLOg-1
X-Mimecast-MFC-AGG-ID: Tn-p_qfKOxyja2GdqawLOg_1742811818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E0BB180899B;
	Mon, 24 Mar 2025 10:23:38 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8E62180A801;
	Mon, 24 Mar 2025 10:23:34 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 06/11] nvmet: emulate basic support for cancel commands
Date: Mon, 24 Mar 2025 11:23:05 +0100
Message-ID: <20250324102310.658007-7-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Vr6gBdBUE2eGt65MLBsZ6dutV-p1aSrrFd95qyfx18_1742811818
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032343_415687_FD968A94 
X-CRM114-Status: GOOD (  26.40  )
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
index ed8522911d1f..a533357e9be4 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 obj-$(CONFIG_NVME_TARGET_PCI_EPF)	+= nvmet-pci-epf.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o io-cmd-cancel.o
 nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index acc138bbf8f2..57b90263a7cb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -398,6 +398,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_resv_release] =
 	log->iocs[nvme_cmd_resv_report] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	if (emulate_cancel_support) {
+		log->iocs[nvme_cmd_cancel] =
+			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	}
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a2b5319c37f3..3e22dacddd76 100644
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
@@ -1057,6 +1061,13 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
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
index 33fac9151b5b..8778fbe82e74 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -40,6 +40,8 @@
 #define nvmet_for_each_enabled_ns(xa, index, entry) \
 	xa_for_each_marked(xa, index, entry, NVMET_NS_ENABLED)
 
+extern bool emulate_cancel_support;
+
 /*
  * Supported optional AENs:
  */
@@ -714,6 +716,8 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+void nvmet_execute_cancel(struct nvmet_req *req);
+
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
-- 
2.43.5


